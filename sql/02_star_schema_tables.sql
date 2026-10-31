-- 02_star_schema_tables.sql
-- Example transformation logic and load preparation patterns.
-- This file shows the star schema structure commonly used for Power BI analysis.

CREATE OR REPLACE VIEW analytics.vw_sales_profitability AS
SELECT
    s.sales_id,
    d.full_date,
    c.customer_name,
    c.customer_segment,
    p.product_name,
    p.category,
    r.country,
    r.region_name,
    ch.channel_name,
    s.order_id,
    s.quantity,
    s.revenue,
    s.cost_of_goods_sold,
    s.discount_amount,
    s.net_revenue,
    ROUND(s.net_revenue - s.cost_of_goods_sold, 2) AS gross_profit,
    ROUND((s.net_revenue - s.cost_of_goods_sold) / NULLIF(s.net_revenue, 0), 4) AS gross_margin_pct
FROM analytics.fact_sales s
LEFT JOIN analytics.dim_date d ON s.date_id = d.date_id
LEFT JOIN analytics.dim_customer c ON s.customer_id = c.customer_id
LEFT JOIN analytics.dim_product p ON s.product_id = p.product_id
LEFT JOIN analytics.dim_region r ON s.region_id = r.region_id
LEFT JOIN analytics.dim_channel ch ON s.channel_id = ch.channel_id;

CREATE OR REPLACE VIEW analytics.vw_logistics_performance AS
SELECT
    l.logistics_id,
    d.full_date,
    l.order_id,
    sm.ship_mode_name,
    r.country,
    r.region_name,
    l.shipping_cost,
    l.delivery_days,
    l.expedited_flag,
    ROUND(l.shipping_cost / NULLIF(s.net_revenue, 0), 4) AS logistics_cost_ratio
FROM analytics.fact_logistics l
LEFT JOIN analytics.dim_date d ON l.date_id = d.date_id
LEFT JOIN analytics.dim_ship_mode sm ON l.ship_mode_id = sm.ship_mode_id
LEFT JOIN analytics.dim_region r ON l.region_id = r.region_id
LEFT JOIN analytics.fact_sales s ON l.order_id = s.order_id;

CREATE OR REPLACE VIEW analytics.vw_profitability_summary AS
SELECT
    d.year,
    d.month_name,
    r.region_name,
    p.category,
    SUM(s.revenue) AS total_revenue,
    SUM(s.cost_of_goods_sold) AS cogs,
    SUM(s.net_revenue - s.cost_of_goods_sold) AS gross_profit,
    SUM(l.shipping_cost) AS total_logistics_cost
FROM analytics.fact_sales s
LEFT JOIN analytics.dim_date d ON s.date_id = d.date_id
LEFT JOIN analytics.dim_region r ON s.region_id = r.region_id
LEFT JOIN analytics.dim_product p ON s.product_id = p.product_id
LEFT JOIN analytics.fact_logistics l ON s.order_id = l.order_id
GROUP BY d.year, d.month_name, r.region_name, p.category;
