"""
Roll C: Visualization + Saving (Visualiseerimine ja salvestamine)

Andmed päritakse data_fetcher.py-st ja transform.py-st
Loob töödeldud andmetest Plotly diagrammid ja salvestab tulemused CSV- ning HTML-failidena.
"""

import os
from datetime import datetime
import pandas as pd

import plotly.express as px
import plotly.graph_objects as go

from data_fetcher import fetch_sales, fetch_customers
from transform import (
    clean_data,
    calculate_weekly_aggregates,
    calculate_kpis,
    merge_datasets
)


def create_weekly_chart(df_weekly):
    """
    Loon nädalase käibe joondiagrammi
    """

    print("Loon nädalase käibe diagrammi...")

    fig = px.line(
        df_weekly,
        x="sale_date",
        y="revenue",
        title="Nädalane käive",
        markers=True
    )

    fig.update_layout(
        xaxis_title="Nädal",
        yaxis_title="Käive (€)"
    )

    return fig


def create_kpi_summary(kpis):
    """
    Loon KPI-dest Plotly tabeli.
    """

    print("Loon KPI kokkuvõtte...")

    fig = go.Figure(
        data=[
            go.Table(
                header=dict(
                    values=["KPI", "Väärtus"]
                ),
                cells=dict(
                    values=[
                        [
                            "Kogukäive",
                            "Unikaalsed kliendid",
                            "Keskmine tellimus"
                        ],
                        [
                            f"{kpis['total_revenue']:.2f} €",
                            f"{kpis['unique_customers']}",
                            f"{kpis['avg_order_value']:.2f} €"
                        ]
                    ]
                )
            )
        ]
    )

    fig.update_layout(
        title="Peamised KPI-d"
    )

    return fig


def export_results(
    df,
    output_dir,
    weekly_fig=None,
    kpi_fig=None
):
    """
    Salvestab DataFrame'i CSV-failina
    ja diagrammid HTML-failidena.
    """

    print("Ekspordin tulemused...")

    # Output kausta loomine
    os.makedirs(
        output_dir,
        exist_ok=True
    )

    # Tänane kuupäev failinime jaoks
    date_str = datetime.now().strftime("%Y%m%d")

    # CSV faili nimi
    csv_path = os.path.join(
        output_dir,
        f"weekly_results_{date_str}.csv"
    )

    # DataFrame CSV-sse
    df.to_csv(
        csv_path,
        index=False
    )

    print("CSV salvestatud:", csv_path)

    # Nädalase käibe diagramm
    if weekly_fig is not None:
        weekly_path = os.path.join(
            output_dir,
            f"weekly_revenue_{date_str}.html"
        )

        weekly_fig.write_html(weekly_path)

        print(
            "Nädalase käibe diagramm salvestatud:",
            weekly_path
        )

    # KPI diagramm
    if kpi_fig is not None:
        kpi_path = os.path.join(
            output_dir,
            f"kpi_summary_{date_str}.html"
        )

        kpi_fig.write_html(kpi_path)

        print(
            "KPI kokkuvõte salvestatud:",
            kpi_path
        )


def export_pipeline_notification(
    output_dir,
    status,
    kpis=None,
    error_message=None,
    elapsed_time=None
):
    """
    Salvestab pipeline'i tulemuse Exceli teavitusraportina.
    """

    os.makedirs(output_dir, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    notification_path = os.path.join(
        output_dir,
        f"pipeline_notification_{timestamp}.xlsx"
    )

    report_data = {
        "Aeg": [datetime.now().strftime("%Y-%m-%d %H:%M:%S")],
        "Staatus": [status],
        "Kogukäive": [
            kpis.get("total_revenue") if kpis else None
        ],
        "Unikaalsed kliendid": [
            kpis.get("unique_customers") if kpis else None
        ],
        "Keskmine tellimus": [
            kpis.get("avg_order_value") if kpis else None
        ],
        "Tööaeg sekundites": [elapsed_time],
        "Veateade": [error_message]
    }

    report_df = pd.DataFrame(report_data)

    report_df.to_excel(
        notification_path,
        index=False
    )

    print(
        "Pipeline teavitusraport salvestatud:",
        notification_path
    )

    return notification_path


if __name__ == "__main__":

    # ---------------------------------------------
    # 1. Andmete pärimine antud failis testimiseks
    # ---------------------------------------------

    sales_data = fetch_sales(
        "2023-01-01",
        "2026-12-31"
    )

    customers_data = fetch_customers()

    print("\n--- PÄRITUD ANDMED ---")
    print("Müük:", sales_data.shape)
    print("Kliendid:", customers_data.shape)

    # ---------------------------------------------
    # 2. Andmete töötlemine
    # ---------------------------------------------

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

    print("\nLiidetud andmestik:", merged_result.shape)

    # ---------------------------------------------
    # 3. Diagrammide loomine
    # ---------------------------------------------

    weekly_chart = create_weekly_chart(
        weekly_result
    )

    kpi_chart = create_kpi_summary(
        kpi_result
    )

    # ---------------------------------------------
    # 4. Tulemuste eksport
    # ---------------------------------------------

    export_results(
        weekly_result,
        "output",
        weekly_chart,
        kpi_chart
    )

    # ---------------------------------------------
    # 5. Diagrammide kuvamine
    # ---------------------------------------------

    weekly_chart.show()
    kpi_chart.show()
