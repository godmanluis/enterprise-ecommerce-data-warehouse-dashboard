-- 01_create_schema.sql
-- Creates the foundation for the e-commerce analytics data warehouse.

CREATE SCHEMA IF NOT EXISTS analytics;

CREATE TABLE IF NOT EXISTS analytics.dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    day INT NOT NULL,
    weekday_name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS analytics.dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_key VARCHAR(50) UNIQUE NOT NULL,
    customer_name VARCHAR(200),
    customer_segment VARCHAR(100),
    customer_country VARCHAR(100),
    customer_city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE IF NOT EXISTS analytics.dim_product (
    product_id SERIAL PRIMARY KEY,
    product_key VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(200),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    brand VARCHAR(100),
    unit_price NUMERIC(12,2)
);

CREATE TABLE IF NOT EXISTS analytics.dim_region (
    region_id SERIAL PRIMARY KEY,
    region_key VARCHAR(50) UNIQUE NOT NULL,
    country VARCHAR(100),
    state_province VARCHAR(100),
    city VARCHAR(100),
    region_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS analytics.dim_channel (
    channel_id SERIAL PRIMARY KEY,
    channel_key VARCHAR(50) UNIQUE NOT NULL,
    channel_name VARCHAR(100),
    channel_type VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS analytics.dim_ship_mode (
    ship_mode_id SERIAL PRIMARY KEY,
    ship_mode_key VARCHAR(50) UNIQUE NOT NULL,
    ship_mode_name VARCHAR(100),
    shipping_tier VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS analytics.fact_sales (
    sales_id SERIAL PRIMARY KEY,
    date_id INT NOT NULL REFERENCES analytics.dim_date(date_id),
    customer_id INT NOT NULL REFERENCES analytics.dim_customer(customer_id),
    product_id INT NOT NULL REFERENCES analytics.dim_product(product_id),
    region_id INT NOT NULL REFERENCES analytics.dim_region(region_id),
    channel_id INT NOT NULL REFERENCES analytics.dim_channel(channel_id),
    order_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    revenue NUMERIC(14,2) NOT NULL,
    cost_of_goods_sold NUMERIC(14,2) NOT NULL,
    discount_amount NUMERIC(12,2) DEFAULT 0,
    net_revenue NUMERIC(14,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS analytics.fact_logistics (
    logistics_id SERIAL PRIMARY KEY,
    date_id INT NOT NULL REFERENCES analytics.dim_date(date_id),
    order_id VARCHAR(50) NOT NULL,
    shipment_id VARCHAR(50),
    ship_mode_id INT REFERENCES analytics.dim_ship_mode(ship_mode_id),
    region_id INT REFERENCES analytics.dim_region(region_id),
    shipping_cost NUMERIC(14,2) NOT NULL,
    delivery_days INT,
    expedited_flag BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS analytics.fact_returns (
    return_id SERIAL PRIMARY KEY,
    date_id INT NOT NULL REFERENCES analytics.dim_date(date_id),
    order_id VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL REFERENCES analytics.dim_customer(customer_id),
    product_id INT NOT NULL REFERENCES analytics.dim_product(product_id),
    return_quantity INT NOT NULL,
    return_amount NUMERIC(14,2) NOT NULL,
    return_reason VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS analytics.fact_inventory (
    inventory_id SERIAL PRIMARY KEY,
    date_id INT NOT NULL REFERENCES analytics.dim_date(date_id),
    product_id INT NOT NULL REFERENCES analytics.dim_product(product_id),
    region_id INT NOT NULL REFERENCES analytics.dim_region(region_id),
    stock_on_hand INT NOT NULL,
    reorder_point INT NOT NULL,
    inventory_value NUMERIC(14,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_fact_sales_date
    ON analytics.fact_sales(date_id);

CREATE INDEX IF NOT EXISTS idx_fact_sales_customer
    ON analytics.fact_sales(customer_id);

CREATE INDEX IF NOT EXISTS idx_fact_sales_product
    ON analytics.fact_sales(product_id);

CREATE INDEX IF NOT EXISTS idx_fact_logistics_order
    ON analytics.fact_logistics(order_id);

CREATE INDEX IF NOT EXISTS idx_fact_returns_order
    ON analytics.fact_returns(order_id);

CREATE INDEX IF NOT EXISTS idx_fact_inventory_product
    ON analytics.fact_inventory(product_id);
