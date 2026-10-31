# Architecture Overview

This project follows a classic modern analytics architecture for a growing e-commerce business.

## 1. Source Layer

The source layer contains operational data from:

- Sales transactions
- Product catalogs
- Customer master data
- Logistics and shipping events
- Regional and channel performance files

## 2. Staging and Transformation Layer

The transformation layer consolidates source files, normalizes values, and standardizes keys before loading into the warehouse.

Typical actions include:

- standardizing date formats
- deduplicating records
- resolving dimension keys
- mapping product and region dimensions
- validating customer and order references
- calculating derived financial metrics

## 3. Analytical Warehouse Layer

The warehouse layer is built as a star schema in PostgreSQL with fact tables and supporting dimensions.

This enables fast aggregation for:

- sales performance
- product profitability
- shipment cost assessment
- customer segmentation analysis
- logistics leakage analysis

## 4. Presentation Layer

The reporting layer uses Power BI to build executive dashboards with interactive visuals and business KPI cards.

Power BI is used to:

- connect directly to PostgreSQL tables
- create relationships across dimensions and facts
- implement DAX measures
- create executive visuals and slicers
- publish and share the dashboard

## 5. Business Outcome

The final architecture creates a single source of truth for the business and removes dependence on manual spreadsheets and slow reporting cycles.
