-- 04_kpi_views.sql
-- KPI-oriented views to support executive analysis and BI layering.

CREATE OR REPLACE VIEW analytics.vw_exec_kpis AS
SELECT
    d.year,
    d.month_name,
    SUM(s.revenue) AS total_revenue,
    SUM(s.net_revenue) AS net_revenue,
    SUM(s.cost_of_goods_sold) AS total_cogs,
    SUM(s.net_revenue - s.cost_of_goods_sold) AS gross_profit,
    SUM(l.shipping_cost) AS total_logistics_cost,
    ROUND(
        (SUM(s.net_revenue - s.cost_of_goods_sold) / NULLIF(SUM(s.net_revenue), 0)) * 100,
        2
    ) AS gross_margin_pct,
    ROUND(
        (SUM(l.shipping_cost) / NULLIF(SUM(s.net_revenue), 0)) * 100,
        2
    ) AS logistics_cost_pct
FROM analytics.fact_sales s
LEFT JOIN analytics.fact_logistics l ON s.order_id = l.order_id
LEFT JOIN analytics.dim_date d ON s.date_id = d.date_id
GROUP BY d.year, d.month_name
ORDER BY d.year, d.month_name;

CREATE OR REPLACE VIEW analytics.vw_margin_leak_analysis AS
SELECT
    r.region_name,
    p.category,
    SUM(s.revenue) AS total_revenue,
    SUM(s.net_revenue - s.cost_of_goods_sold) AS gross_profit,
    SUM(l.shipping_cost) AS logistics_cost,
    ROUND(
        (SUM(l.shipping_cost) / NULLIF(SUM(s.revenue), 0)) * 100,
        2
    ) AS margin_leak_pct
FROM analytics.fact_sales s
LEFT JOIN analytics.fact_logistics l ON s.order_id = l.order_id
LEFT JOIN analytics.dim_region r ON s.region_id = r.region_id
LEFT JOIN analytics.dim_product p ON s.product_id = p.product_id
GROUP BY r.region_name, p.category
ORDER BY margin_leak_pct DESC;
