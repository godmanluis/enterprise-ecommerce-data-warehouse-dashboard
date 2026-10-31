# Setup Guide

This guide walks through the repository setup for the Data Warehouse and Executive Dashboard project.

## Prerequisites

- PostgreSQL 14+
- Power BI Desktop
- SQL client such as psql or pgAdmin
- Access to source data files or a data import workflow

## 1. Create the Database

```sql
CREATE DATABASE ecommerce_dw;
```

## 2. Run the SQL Files

```bash
psql -U postgres -d ecommerce_dw -f sql/01_create_schema.sql
psql -U postgres -d ecommerce_dw -f sql/02_star_schema_tables.sql
psql -U postgres -d ecommerce_dw -f sql/03_sample_queries.sql
psql -U postgres -d ecommerce_dw -f sql/04_kpi_views.sql
```

## 3. Load Source Data

Use your ingestion workflow, ETL process, or CSV import process to populate the fact and dimension tables.

Recommended sequence:

1. Load dim_date
2. Load dim_customer
3. Load dim_product
4. Load dim_region
5. Load dim_channel
6. Load dim_ship_mode
7. Load fact_sales
8. Load fact_logistics
9. Load fact_returns
10. Load fact_inventory

## 4. Validate the Warehouse

Run the provided sample queries in `sql/03_sample_queries.sql` to validate relationships and metric logic.

## 5. Connect to Power BI

Open Power BI Desktop and connect to the PostgreSQL database. Import the warehouse tables and build the dashboard using the documented DAX measures.

## 6. Publish Dashboard

Once the visuals are complete, publish the file to Power BI Service and share the public or secure report link as needed.
