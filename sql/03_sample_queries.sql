-- 03_sample_queries.sql
-- Useful sample SQL for validating the e-commerce warehouse and executive dashboard.

SELECT *
FROM analytics.vw_sales_profitability
LIMIT 50;

SELECT
    year,
    month_name,
    SUM(total_revenue) AS total_revenue,
    SUM(gross_profit) AS gross_profit,
    SUM(total_logistics_cost) AS total_logistics_cost
FROM analytics.vw_profitability_summary
GROUP BY year, month_name
ORDER BY year, month_name;

SELECT
    region_name,
    SUM(total_revenue) AS total_revenue,
    SUM(gross_profit) AS gross_profit,
    SUM(total_logistics_cost) AS logistics_cost
FROM analytics.vw_profitability_summary
GROUP BY region_name
ORDER BY gross_profit DESC;

SELECT
    category,
    AVG(gross_margin_pct) AS avg_margin_pct,
    SUM(total_logistics_cost) AS total_logistics_cost
FROM analytics.vw_profitability_summary
GROUP BY category
ORDER BY avg_margin_pct DESC;

SELECT
    ship_mode_name,
    AVG(logistics_cost_ratio) AS avg_cost_ratio,
    SUM(shipping_cost) AS shipping_cost
FROM analytics.vw_logistics_performance
GROUP BY ship_mode_name
ORDER BY avg_cost_ratio DESC;
