"""
Roll D: Automation Script (Automatiseerimisskript)

Ühendab andmete pärimise, töötlemise, visualiseerimise
ja eksportimise üheks pipeline'iks.
"""

from visualize_export import (
    create_weekly_chart,
    create_kpi_summary,
    export_results,
    export_pipeline_notification
)
from transform import (
    clean_data,
    calculate_weekly_aggregates,
    calculate_kpis,
    merge_datasets
)
from data_fetcher import fetch_sales, fetch_customers, fetch_products
import os
from datetime import datetime
import logging
import time
import yaml
from pathlib import Path

base_dir = Path(__file__).resolve().parent
config_path = base_dir / "config.yaml"

with open(config_path, "r", encoding="utf-8") as file:
    config = yaml.safe_load(file)


# Logimise seadistus
log_dir = config["log_dir"]
os.makedirs(
    log_dir,
    exist_ok=True
)

date_str = datetime.now().strftime("%Y%m%d")

log_file = os.path.join(
    log_dir,
    f"pipeline_{date_str}.log"
)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(
            log_file,
            encoding="utf-8"
        ),
        logging.StreamHandler()
    ]
)


def run_pipeline(start_date, end_date):
    """
    Käivitab kogu UrbanStyle pipeline'i:
    extract -> transform -> visualize -> export.
    """

    try:
        logging.info("Pipeline käivitus.")

        # -----------------------------------------
        # 1. EXTRACT
        # -----------------------------------------

        logging.info("Extract etapp algas.")

        max_attempts = config["retry"]["max_attempts"]
        initial_delay = config["retry"]["initial_delay"]

        sales_data = fetch_sales(
            start_date,
            end_date,
            max_attempts,
            initial_delay
        )
        customers_data = fetch_customers(max_attempts, initial_delay)
        products_data = fetch_products(max_attempts, initial_delay)

        logging.info(
            "Extract valmis: müük %s rida, kliendid %s rida, tooted %s rida.",
            len(sales_data),
            len(customers_data),
            len(products_data)
        )

        # -----------------------------------------
        # 2. TRANSFORM
        # -----------------------------------------

        logging.info("Transform etapp algas.")

        sales_clean = clean_data(
            sales_data
        )

        weekly_result = calculate_weekly_aggregates(
            sales_clean
        )

        kpi_result = calculate_kpis(
            sales_clean
        )

        merged_result = merge_datasets(
            sales_clean,
            customers_data
        )

        logging.info(
            "Transform valmis: puhastatud müük %s rida, "
            "nädalaid %s, liidetud andmestik %s rida.",
            len(sales_clean),
            len(weekly_result),
            len(merged_result)
        )

        # -----------------------------------------
        # 3. VISUALIZE
        # -----------------------------------------

        logging.info("Visualiseerimise etapp algas.")

        weekly_chart = create_weekly_chart(
            weekly_result
        )

        kpi_chart = create_kpi_summary(
            kpi_result
        )

        logging.info("Visualiseerimise etapp valmis.")

        # -----------------------------------------
        # 4. EXPORT
        # -----------------------------------------

        logging.info("Ekspordi etapp algas.")

        export_results(
            weekly_result,
            config["output_dir"],
            weekly_chart,
            kpi_chart
        )

        logging.info("Ekspordi etapp valmis.")

        # -----------------------------------------
        # 5. KOKKUVÕTE
        # -----------------------------------------
        export_pipeline_notification(
            config["output_dir"],
            status="ÕNNESTUS",
            kpis=kpi_result
        )
        logging.info("Pipeline lõpetatud edukalt.")

        print("\n--- PIPELINE KOKKUVÕTE ---")
        print(f"Puhastatud müügiridu: {len(sales_clean)}")
        print(f"Nädalaid kokku: {len(weekly_result)}")
        print(f"Unikaalseid kliente: {kpi_result['unique_customers']}")
        print(f"Kogukäive: {kpi_result['total_revenue']:.2f} €")
        print(
            f"Keskmine tellimuse väärtus: "
            f"{kpi_result['avg_order_value']:.2f} €"
        )

    except Exception as error:  # pylint: disable=broad-exception-caught
        logging.error(
            "Pipeline ebaõnnestus: %s",
            error
        )
        export_pipeline_notification(
            config["output_dir"],
            status="EBAÕNNESTUS",
            error_message=str(error)
        )

        raise


if __name__ == "__main__":

    start_time = time.time()

    run_pipeline(config["start_date"], config["end_date"])

    elapsed_time = time.time() - start_time

    print(
        f"\nPipeline tööaeg: {elapsed_time:.2f} sekundit"
    )
