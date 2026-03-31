{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 0,
   "metadata": {
    "application/vnd.databricks.v1+cell": {
     "cellMetadata": {},
     "inputWidgets": {},
     "nuid": "eed801b8-13d8-49d5-958d-974a8f982102",
     "showTitle": false,
     "tableResultSettingsMap": {},
     "title": ""
    }
   },
   "outputs": [],
   "source": [
    "select store_location,product_category,product_type,(transaction_qty*unit_price) as total_revenue,transaction_qty as total_products_sold,\n",
    "--- USE CASE STATEMENT\n",
    "Dayname(transaction_date) as day_name,\n",
    "Monthname(transaction_date) as month_name,\n",
    "dayofmonth(transaction_date) as day_of_the_month,\n",
    "CASE\n",
    " when dayname(transaction_date) in ('Sun','Sat') then 'weekend' else 'weekday'\n",
    " end as day_classification,\n",
    " case\n",
    " when date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:00:00' then 'morning'\n",
    " when date_format(transaction_time, 'HH:mm:ss') between '11:00:01' and '17:00:00' then 'afternoon'\n",
    " when date_format(transaction_time, 'HH:mm:ss') between '17:00:01' and '23:00:00' then 'night'\n",
    " end as time_classification,\n",
    " ---- USE CASE TO SEE DIFFERENT SPENDERS\n",
    " case \n",
    " when(transaction_qty*unit_price) >=100 then 'low spender'\n",
    " when(transaction_qty*unit_price) between 101 and 300 then 'medium spender'\n",
    " else 'high spend'\n",
    " end as revenue_bucket\n",
    " from `workspace`.`default`.`bright_coffee_shop_sales`"
   ]
  }
 ],
 "metadata": {
  "application/vnd.databricks.v1+notebook": {
   "computePreferences": null,
   "dashboards": [],
   "environmentMetadata": null,
   "inputWidgetPreferences": null,
   "language": "sql",
   "notebookMetadata": {
    "sqlQueryOptions": {
     "applyAutoLimit": true,
     "catalog": "workspace",
     "schema": "default"
    }
   },
   "notebookName": "New Query 2026-03-26 18:35:23.dbquery.ipynb",
   "widgets": {}
  },
  "language_info": {
   "name": "sql"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 0
}
