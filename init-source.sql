ALTER SYSTEM SET log_statement = 'ddl';

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    product VARCHAR(100),
    quantity INTEGER
);

INSERT INTO customers (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

INSERT INTO orders (customer_id, product, quantity) VALUES 
(1, 'Laptop', 1),
(2, 'Mouse', 2);


CREATE USER debezium WITH REPLICATION LOGIN PASSWORD 'debezium';
DROP PUBLICATION IF EXISTS debezium_pub;
CREATE PUBLICATION debezium_pub FOR ALL TABLES;
ALTER USER debezium WITH REPLICATION;
GRANT CONNECT ON DATABASE source_db TO debezium;
GRANT USAGE ON SCHEMA public TO debezium;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO debezium;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO debezium;