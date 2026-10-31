# Power BI Measures

This document provides example DAX measures for the executive dashboard.

```DAX
Total Revenue = SUM(fact_sales[revenue])

Total Net Revenue = SUM(fact_sales[net_revenue])

Total Cost of Goods Sold = SUM(fact_sales[cost_of_goods_sold])

Total Logistics Cost = SUM(fact_logistics[shipping_cost])

Gross Profit = [Total Net Revenue] - [Total Cost of Goods Sold]

Net Margin % = DIVIDE([Gross Profit], [Total Net Revenue])

Logistics Cost % = DIVIDE([Total Logistics Cost], [Total Net Revenue])

Margin Leak % = DIVIDE([Total Logistics Cost], [Total Net Revenue])

Average Order Value = DIVIDE([Total Revenue], DISTINCTCOUNT(fact_sales[order_id]))

Return Rate % = DIVIDE(SUM(fact_returns[return_amount]), [Total Revenue])

Regional Profit Margin =
DIVIDE(
    CALCULATE([Gross Profit], ALLEXCEPT(dim_region, dim_region[region_name])),
    CALCULATE([Total Net Revenue], ALLEXCEPT(dim_region, dim_region[region_name]))
)
```

## Recommended KPIs for Executive Cards

- Total Revenue
- Gross Profit
- Net Margin %
- Logistics Cost %
- Margin Leak %
- Average Order Value
