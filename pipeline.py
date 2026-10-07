import pandas as pd
from extract import get_data
import logging

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

logger.info("Starting data extraction")
sales_df = get_data('sales')

logger.info("Data extraction completed")
logger.info(sales_df.head())
