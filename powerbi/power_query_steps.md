# Power Query Notes

Power Query is used to clean, transform, and harmonize incoming source data before loading into the PostgreSQL warehouse.

## Typical Power Query Steps

- Remove blank rows and duplicate records
- Standardize column names
- Convert date strings to proper Date type
- Replace null values with business defaults
- Trim text values and standardize casing
- Normalize category labels
- Split or merge columns when needed
- Validate key fields before upload

## Example Pattern

```powerquery
let
    Source = Excel.Workbook(File.Contents("sales_source.xlsx"), null, true),
    SalesTable = Source{[Item="Sales",Kind="Table"]}[Data],
    PromotedHeaders = Table.PromoteHeaders(SalesTable, [PromoteAllScalars=true]),
    CleanedColumns = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"Order ID", type text},
            {"Order Date", type date},
            {"Revenue", Currency.Type},
            {"Shipping Cost", Currency.Type}
        }
    )
in
    CleanedColumns
```

## Why Power Query Matters

Power Query makes the data preparation process repeatable, transparent, and manageable while reducing the chance of bad data entering the warehouse.
