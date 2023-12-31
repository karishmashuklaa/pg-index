CREATE TABLE customers(first_name VARCHAR(50), last_name VARCHAR(50), mobile_no INTEGER, country VARCHAR(50))

INSERT INTO customers (first_name, last_name, mobile_no, country)
SELECT substr(md5(random()::text), 1, 10),
	   substr(md5(random()::text), 1, 10),
       (random() * 70 + 10)::integer,
	   (CASE WHEN random() < 0.5 THEN 'India' ELSE 'United Kingdom' END)
FROM generate_series(1, 50000000);

EXPLAIN ANALYZE
SELECT * FROM customers WHERE country='United Kingdom';

CREATE INDEX idx_partial_country ON customers (country) WHERE country IN ('India', 'United Kingdom')

EXPLAIN ANALYZE
SELECT * FROM customers WHERE country='United Kingdom';
