"""
Roll A: API Query (Andmete pärimine)
"""
import os
import pandas as pd
from dotenv import load_dotenv
from supabase import create_client

load_dotenv()

supabase_url = os.getenv("SUPABASE_URL")
supabase_key = os.getenv("SUPABASE_KEY")

supabase = create_client(supabase_url, supabase_key)


def fetch_sales(start_date, end_date):
    """
    Pärib müügiandmed Supabase'ist antud kuupäevade vahemikus.
    """
    try:
        all_data = []
        page = 0
        page_size = 1000

        while True:
            response = supabase.table("sales").select("*") \
                .gte("sale_date", start_date) \
                .lte("sale_date", end_date) \
                .range(page * page_size, (page + 1) * page_size - 1) \
                .execute()

            data = response.data

            if not data:
                break

            all_data.extend(data)
            page += 1

        df = pd.DataFrame(all_data)

        return df

    except Exception as e:  # pylint: disable=broad-exception-caught
        print(f"Viga müügiandmete pärimisel: {e}")
        return pd.DataFrame()


def fetch_customers():
    """
    Pärib kliendiandmed Supabase'ist.
    """
    try:
        all_data = []
        page = 0
        page_size = 1000

        while True:
            response = supabase.table("customers_py").select("*") \
                .range(page * page_size, (page + 1) * page_size - 1) \
                .execute()

            data = response.data

            if not data:
                break

            all_data.extend(data)
            page += 1

        df = pd.DataFrame(all_data)

        return df

    except Exception as e:  # pylint: disable=broad-exception-caught
        print(f"Viga kliendiandmete pärimisel: {e}")
        return pd.DataFrame()


def fetch_products():
    """
    Pärib tooteandmed Supabase'ist.
    """
    try:
        all_data = []
        page = 0
        page_size = 1000

        while True:
            response = supabase.table("products").select("*") \
                .range(page * page_size, (page + 1) * page_size - 1) \
                .execute()

            data = response.data

            if not data:
                break

            all_data.extend(data)
            page += 1

        df = pd.DataFrame(all_data)

        return df

    except Exception as e:  # pylint: disable=broad-exception-caught
        print(f"Viga tooteandmete pärimisel: {e}")
        return pd.DataFrame()


if __name__ == "__main__":
    # Testimise osa ajalise filtriga
    sales_data = fetch_sales(
        "2023-01-01",
        "2026-12-31"
    )

    customers_data = fetch_customers()
    products_data = fetch_products()

    print(
        f"Tellimusi: {len(sales_data)},"
        f" Kliente: {len(customers_data)},"
        f" Tooted: {len(products_data)}"
    )
