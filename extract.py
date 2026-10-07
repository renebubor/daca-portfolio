from dotenv import load_dotenv
import os
from supabase import create_client
import pandas as pd

# Supabase keskkonna ligipääsuvõtmete laadimine .env failist
load_dotenv()

supabase = create_client(
    os.getenv("SUPABASE_URL"),
    os.getenv("SUPABASE_KEY")
)


def get_data(table_name):
    try:
        data = []
        page_size = 1000
        page = 0

        while True:
            response = (
                supabase.table(table_name)
                .select("*")
                .range(page * page_size, (page + 1) * page_size - 1)
                .execute()
            )

            data.extend(response.data)

            if len(response.data) < page_size:
                break

            page += 1

        return pd.DataFrame(data)
    except Exception as e:
        print(
            f"Error occurred while fetching data from table '{table_name}': {e}")
        # Fallback to reading from a local CSV file
        return pd.read_csv(f"week-7/individual/{table_name}.csv")
