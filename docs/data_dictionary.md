# Data Dictionary

This document provides a concise guide to the analytical warehouse tables used in the executive dashboard project.

## Fact Tables

### `analytics.fact_sales`

Purpose: central revenue and sales transaction fact table.

Fields:
- `sales_id`: surrogate key
- `date_id`: foreign key to dim_date
- `customer_id`: foreign key to dim_customer
- `product_id`: foreign key to dim_product
- `region_id`: foreign key to dim_region
- `channel_id`: foreign key to dim_channel
- `order_id`: order reference
- `quantity`: number of units ordered
- `unit_price`: per-unit price
- `revenue`: sales price before cost adjustments
- `cost_of_goods_sold`: product cost basis
- `discount_amount`: customer or promotion discounts
- `net_revenue`: post-discount revenue

### `analytics.fact_logistics`

Purpose: fulfillment and shipping cost analytics.

Fields:
- `logistics_id`: surrogate key
- `date_id`: delivery date dimension linkage
- `order_id`: order identifier
- `shipment_id`: shipment reference
- `ship_mode_id`: shipping method linkage
- `region_id`: geographic impact
- `shipping_cost`: total logistics spend
- `delivery_days`: transit duration
- `expedited_flag`: indicator for premium shipping

### `analytics.fact_returns`

Purpose: returns and customer reversal analysis.

Fields:
- `return_id`: surrogate key
- `date_id`: return date
- `order_id`: original order reference
- `customer_id`: customer
- `product_id`: product
- `return_quantity`: units returned
- `return_amount`: financial value returned
- `return_reason`: reason for return

### `analytics.fact_inventory`

Purpose: inventory availability and planning insights.

Fields:
- `inventory_id`: surrogate key
- `date_id`: reporting date
- `product_id`: product
- `region_id`: region or warehouse
- `stock_on_hand`: available inventory
- `reorder_point`: threshold for replenishment
- `inventory_value`: inventory valuation

## Dimension Tables

### `analytics.dim_date`

Purpose: temporal analysis and period-based metrics.

Fields:
- `date_id`
- `full_date`
- `year`
- `quarter`
- `month`
- `month_name`
- `day`
- `weekday_name`

### `analytics.dim_customer`

Purpose: customer segmentation and behavior analysis.

### `analytics.dim_product`

Purpose: product hierarchy, brand, category, and pricing analysis.

### `analytics.dim_region`

Purpose: geography across country, state, and city for regional reporting.

### `analytics.dim_channel`

Purpose: sales channel attribution.

### `analytics.dim_ship_mode`

Purpose: logistics mode analysis for shipping cost and service-level evaluation.

## Usage Notes

- This model is intentionally star schema optimized for compatibility with Power BI.
- Fact tables are wide and numeric-heavy for aggregation.
- Dimension tables are denormalized to support simplified and fast filtering.
- The warehouse supports executive reporting, profitability analysis, and logistics leak identification.
