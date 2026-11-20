CREATE TABLE IF NOT EXISTS dwh.dim_region (
    region_key   BIGSERIAL PRIMARY KEY,
    region_id    INTEGER      NOT NULL,
    region_name  VARCHAR(100) NOT NULL,
    country      VARCHAR(100) NOT NULL
);
