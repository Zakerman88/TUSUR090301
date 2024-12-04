CREATE TABLE typeofproducts
(
typeofproduct_id integer PRIMARY KEY, titletop text NOT NULL
);


INSERT INTO typeofproducts
VALUES
(1, 'Bakerys'), 
(2, 'Drinks'), 
(3, 'Candys');


CREATE TABLE stands
(
stand_id integer PRIMARY KEY, 
stand_title text, 
refresh_time integer, 
typeofproduct_id integer REFERENCES typeofproducts(typeofproduct_id)
);


INSERT INTO stands
VALUES
(1, 'Bakerys_1', 120, 1), 
(2, 'Bakerys_2', 120, 1), 
(3, 'Bakerys_3', 120, 1),
(4, 'Freezer_1', 60, 2), 
(5, 'Freezer_1', 60, 2), 
(6, 'Candys_1', 240, 3);


CREATE TABLE products
(
product_id integer PRIMARY KEY, 
product_title text NOT NULL, 
price integer NOT NULL, 
timeforcook integer NOT NULL, 
typeofproduct_id integer REFERENCES typeofproducts(typeofproduct_id), 
stand_id integer REFERENCES stands(stand_id)
);


INSERT INTO products
VALUES
(100, 'Puncake', 299, 30, 1, 1), 
(101, 'Cupcake', 249, 40, 1, 1), 
(102, 'Homemade Sunflower', 400, 120, 1, 2), 
(103, 'Rainday', 59, 15, 1, 2), 
(104, 'Cookie', 19, 45, 1, 3), 
(200, 'Coca-Cola', 199, 0, 2, 4), 
(201, 'Sprite', 199, 0, 2, 4), 
(202, 'Orange Juice', 189, 0, 2, 5), 
(300, 'RotFront', 79, 0, 3, 6);


CREATE TABLE workers
(
worker_id integer PRIMARY KEY, 
nickname text, 
last_name text, 
cook_id integer
);


INSERT INTO workers
VALUES
(1, 'Father', 'Luke', null), 
(2, 'Son', 'Anakin', 1), 
(3, 'Son', 'Lavr', 1), 
(4, 'Padavan', 'Scam', 2), 
(5, 'Padavan', 'Srum', 2), 
(6, 'Padavan', 'Max', 3), 
(7, 'Creep', 'Dotl', 2);


CREATE TABLE customers
(
customer_id integer PRIMARY KEY, 
customer_nickname varchar, 
phonenumber varchar(12)
);


INSERT INTO customers
VALUES
(1, 'Batman', '89144889464'), 
(2, 'Robin', '89144999565'), 
(3, 'Bobin', '89249950102'), 
(4, 'Kassandra', '89569569565'),
(5, 'Doono', 'unknown'), 
(6, 'Emptyello', 'unknown');


CREATE TABLE orders
(
order_id integer PRIMARY KEY, 
customer_id integer REFERENCES customers(customer_id), 
product_id integer REFERENCES products(product_id), 
worker_id integer REFERENCES workers(worker_id), 
ordercount integer
);


INSERT INTO orders
VALUES
(1, 1, 100, 4, 2), 
(2, 1, 200, 4, 1), 
(3, 3, 103, 5, 4), 
(4, 4, 300, 6, 1);


CREATE OR REPLACE VIEW view_orders_orderers AS
SELECT order_id, workers.nickname, workers.last_name, 
product_title, ordercount, customer_nickname, 
phonenumber, products.price * ordercount AS totalprice
FROM orders
JOIN products USING(product_id)
JOIN workers USING(worker_id)
JOIN customers USING(customer_id)
ORDER BY order_id ASC;


CREATE OR REPLACE VIEW view_products_place AS
SELECT products.product_id, typeofproducts.titletop, 
products.product_title, products.price, stands.stand_title
FROM products
JOIN typeofproducts USING(typeofproduct_id)
JOIN stands USING(stand_id)
ORDER BY product_id;


CREATE OR REPLACE FUNCTION
get_product_price(OUTproduct_title text) RETURNS int AS $$
SELECT price FROM products WHERE OUTproduct_title =
product_title
$$ LANGUAGE SQL;