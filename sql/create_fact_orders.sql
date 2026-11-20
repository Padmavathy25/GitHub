CREATE TABLE IF NOT EXISTS dwh.fact_orders (
    order_id     INTEGER       PRIMARY KEY,
    customer_id  INTEGER       NOT NULL,
    order_date   DATE          NOT NULL,
    amount       NUMERIC(12,2) NOT NULL
);
