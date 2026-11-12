CREATE TABLE IF NOT EXISTS dwh.dim_customer (
    customer_key   BIGSERIAL PRIMARY KEY,
    customer_id    INTEGER      NOT NULL,
    customer_name  VARCHAR(200) NOT NULL,
    country        VARCHAR(100),
    updated_at     TIMESTAMP    NOT NULL DEFAULT now()
);
