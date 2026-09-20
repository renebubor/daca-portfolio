import pandas as pd

from data_loader import (
    load_sales,
    load_sales_with_details
)


print("=== 1. SALES ALGANDMED ===")

sales = load_sales()

sales["total_price"] = pd.to_numeric(
    sales["total_price"],
    errors="coerce"
)

print("Ridu:", len(sales))
print("Unikaalseid sale_id:", sales["sale_id"].nunique())
print("Puuduvaid total_price väärtusi:", sales["total_price"].isna().sum())
print("Kogukäive:", sales["total_price"].sum())


print("\n=== 2. SALES + DETAILS ===")

details = load_sales_with_details()

details["total_price"] = pd.to_numeric(
    details["total_price"],
    errors="coerce"
)

print("Ridu:", len(details))
print("Unikaalseid sale_id:", details["sale_id"].nunique())
print("Puuduvaid total_price väärtusi:", details["total_price"].isna().sum())
print("Kogukäive:", details["total_price"].sum())


print("\n=== 3. JOIN KONTROLL ===")

print(
    "Puuduva tootega müügiread:",
    details["product_name"].isna().sum()
)

print(
    "Puuduva linnaga müügiread:",
    details["city"].isna().sum()
)


print("\n=== 4. DUPLIKAATIDE KONTROLL ===")

print(
    "Duplikaatsed sale_id read:",
    details["sale_id"].duplicated().sum()
)
