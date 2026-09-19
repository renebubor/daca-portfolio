"""
UrbanStyle Dashboard — Andmelaadimine Supabase'ist
===================================================

See moodul laadib UrbanStyle andmed Supabase'ist
ja tagastab need pandas DataFrame'idena.

Moodul sisaldab funktsioone järgmiste tabelite laadimiseks:
- sales
- customers
- products

Lisaks ühendatakse müügiandmed toote- ja kliendiinfoga,
et saada dashboardi jaoks detailsem andmestik.

HILJEM LISATUD / MUUDETUD:
--------------------------
Supabase API tagastab vaikimisi ühe päringuga maksimaalselt
1000 rida. Kuna sales ja customers tabelites on rohkem kui
1000 rida, lisati funktsioon load_all_rows(), mis laadib
andmed 1000 rea kaupa ning ühendab kõik osad üheks
pandas DataFrame'iks.

Muudatuse tulemusena laaditakse nüüd tabelitest kõik read,
mitte ainult esimesed 1000.
"""

import os
from dotenv import load_dotenv
from supabase import create_client
import pandas as pd


# ---------------------------------------------------------
# Supabase ühenduse loomine
# ---------------------------------------------------------

# Laadi keskkonna muutujad .env failist
load_dotenv()

# Loo Supabase klient
# SUPABASE_URL ja SUPABASE_KEY väärtused asuvad .env failis
supabase = create_client(
    os.getenv("SUPABASE_URL"),
    os.getenv("SUPABASE_KEY")
)


# =========================================================
# HILJEM LISATUD
# Kõigi tabeliridade laadimine Supabase'ist
# =========================================================

def load_all_rows(table_name, order_column):
    """
    HILJEM LISATUD:
    Laadib Supabase tabelist kõik read 1000 rea kaupa.

    Miks seda funktsiooni vaja on?
    -----------------------------
    Supabase API tagastab vaikimisi ühe päringuga kuni
    1000 rida. Kui tabel sisaldab rohkem andmeid, tuleb
    andmeid laadida osade ehk batch'ide kaupa.

    Funktsioon:
    1. Laadib korraga kuni 1000 rida.
    2. Lisab saadud read ühisesse nimekirja.
    3. Liigub järgmise 1000 rea juurde.
    4. Lõpetab, kui saadud ridade arv on väiksem kui 1000.
    5. Tagastab kõik read ühe pandas DataFrame'ina.

    Parameetrid:
    -----------
    table_name : str
        Supabase tabeli nimi.

    order_column : str
        Veerg, mille järgi read järjestatakse.
        See aitab tagada, et lehekülgede kaupa laadimisel
        oleks ridade järjekord stabiilne.

    Tagastab:
    ---------
    pandas.DataFrame
        Kõik tabeli read.
    """

    all_data = []

    # Ühe päringu maksimaalne ridade arv
    batch_size = 1000

    # Esimese päringu alguskoht
    start = 0

    while True:

        # range() puhul on nii algus kui ka lõpp kaasa arvatud,
        # seega 0–999 tähendab 1000 rida.
        end = start + batch_size - 1

        response = (
            supabase
            .table(table_name)
            .select("*")
            .order(order_column)
            .range(start, end)
            .execute()
        )

        data = response.data

        # Lisa saadud read juba varem laaditud andmetele
        all_data.extend(data)

        # Kui saime vähem kui 1000 rida,
        # siis oleme jõudnud tabeli lõppu.
        if len(data) < batch_size:
            break

        # Liigu järgmise 1000 rea juurde
        start += batch_size

    # Muuda kõik saadud read pandas DataFrame'iks
    return pd.DataFrame(all_data)


# =========================================================
# SALES tabel
# =========================================================

def load_sales():
    """
    Laadi müügitabel (sales) Supabase'ist.

    Tagastab:
    pandas DataFrame müügiandmetega.

    Veerud:
    sale_id, invoice_id, sale_date, customer_id,
    product_id, quantity, unit_price, total_price,
    channel, store_location, payment_method

    HILJEM MUUDETUD:
    ----------------
    Algne versioon kasutas:

        supabase.table("sales").select("*").execute()

    See tagastas maksimaalselt 1000 rida.

    Nüüd kasutatakse load_all_rows() funktsiooni,
    et laadida sales tabelist kõik read.
    """

    return load_all_rows(
        "sales",
        "sale_id"
    )


# =========================================================
# CUSTOMERS tabel
# =========================================================

def load_customers():
    """
    Laadi klienditabel (customers) Supabase'ist.

    Tagastab:
    pandas DataFrame kliendiandmetega.

    Veerud:
    customer_id, first_name, last_name, email,
    phone, city, registration_date,
    loyalty_tier, birth_year

    HILJEM MUUDETUD:
    ----------------
    Algne versioon laadis ühe päringuga ainult kuni
    1000 rida.

    Nüüd kasutatakse load_all_rows() funktsiooni,
    et laadida customers tabelist kõik kliendid.
    """

    return load_all_rows(
        "customers",
        "customer_id"
    )


# =========================================================
# PRODUCTS tabel
# =========================================================

def load_products():
    """
    Laadi tootetabel (products) Supabase'ist.

    Tagastab:
    pandas DataFrame tooteandmetega.

    Veerud:
    product_id, product_name, category, subcategory,
    unit_price, supplier, ...

    HILJEM MUUDETUD:
    ----------------
    Ka products tabel kasutab nüüd ühtse loogika huvides
    load_all_rows() funktsiooni.

    Products tabelis oli ridu alla 1000 ning seetõttu
    töötas ka algne lahendus korrektselt, kuid nüüd
    kasutatakse kõigi tabelite puhul sama laadimisloogikat.
    """

    return load_all_rows(
        "products",
        "product_id"
    )


# =========================================================
# SALES + PRODUCTS + CUSTOMERS
# =========================================================

def load_sales_with_details():
    """
    Laadi müügiandmed koos toote- ja kliendiinfoga.

    Funktsioon ühendab:
    - sales
    - products
    - customers

    tabelid üheks DataFrame'iks.

    Ühendamine toimub sarnaselt SQL LEFT JOIN päringule,
    mida kasutati varasemates SQL ülesannetes.

    Müügitabelile lisatakse:
    - product_name
    - category
    - city
    - first_name
    - last_name

    HILJEM MUUDETUD:
    ----------------
    Funktsiooni JOIN-loogikat ei olnud vaja muuta.

    Kuna load_sales(), load_products() ja load_customers()
    kasutavad nüüd load_all_rows() funktsiooni, saab ka
    see funktsioon automaatselt kätte tabelite kõik read.
    """

    # Laadi kõik vajalikud tabelid
    df_sales = load_sales()
    df_products = load_products()
    df_customers = load_customers()

    # -----------------------------------------------------
    # JOIN 1:
    # Lisa müügitabelile tootenimi ja kategooria
    # -----------------------------------------------------

    df = df_sales.merge(
        df_products[
            [
                "product_id",
                "product_name",
                "category"
            ]
        ],
        on="product_id",
        how="left"
    )

    # -----------------------------------------------------
    # JOIN 2:
    # Lisa müügitabelile kliendi linn ja nimi
    # -----------------------------------------------------

    df = df.merge(
        df_customers[
            [
                "customer_id",
                "city",
                "first_name",
                "last_name"
            ]
        ],
        on="customer_id",
        how="left"
    )

    return df
