SELECT * FROM products;


SELECT a.nickname || ' ' || a.last_name AS cook, 
w.nickname || ' ' || w.last_name AS worker
FROM workers a
INNER JOIN workers w ON w.worker_id = a.cook_id
ORDER BY cook;


ALTER TABLE products
RENAME price TO money;


ALTER TABLE products
ADD COLUMN product_company text;


UPDATE workers
SET last_name = 'Scam' WHERE worker_id = 4;


UPDATE products
SET stand_id = NULL WHERE product_id = 201;