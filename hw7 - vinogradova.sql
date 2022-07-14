/* 1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders �
�������� ��������.*/

USE shop;
--  ��������� �������, ��� ������. 
SELECT * FROM orders ;
SELECT * FROM orders_products;

SELECT * FROM users;
SELECT * FROM products;
-- ������� ������������ ������� ��������� �������������
INSERT INTO orders(user_id)
SELECT id FROM users WHERE name IN ('���������', '�������');

INSERT INTO orders_products (order_id, product_id, total)
SELECT last_insert_id(), id, 2 FROM products -- last_insert_id() ������ ��������� id, ����������� � ������� orders, id - ������������� ������, total - ���������� ������
WHERE name = 'Intel Core i3-8100';

INSERT INTO orders_products (order_id, product_id, total)
SELECT last_insert_id(), id, 1 FROM products 
WHERE name = 'AMD FX-8320';

-- ���������
SELECT id, name FROM users WHERE id in(SELECT DISTINCT user_id FROM orders); -- ��������� ��������

-- JOIN
SELECT u.id, u.name 
FROM users AS u JOIN orders AS o 
ON u.id = o.user_id;


/* 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.*/

SELECT p.name, c.name 
FROM products AS p LEFT JOIN catalogs AS c 
ON c.id = p.catalog_id;

-- � ON-���������� id �� ������� catalogs ������������� catalog_id � ������� products;

/*����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label,
name). ���� from, to � label �������� ���������� �������� �������, ���� name � �������.
�������� ������ ������ flights � �������� ���������� �������.*/

DROP TABLE IF EXISTS cities;
CREATE TABLE cities  (
  label VARCHAR(255) PRIMARY KEY, -- ��������� ������ ������� cities ����� label
  name VARCHAR(255) NOT NULL
) COMMENT = '������';

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255) NOT NULL,
  `to` VARCHAR(255) NOT NULL,
  
  FOREIGN KEY (`from`) REFERENCES cities (label) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (`to`) REFERENCES cities (label) ON UPDATE CASCADE ON DELETE CASCADE 
) COMMENT = '�����';

INSERT INTO cities (label, name) VALUES 
	('moscow', '������'),
	('irkutsk', '�������'),
	('novgorod', '��������'),
	('kazan', '������'),
	('omsk', '����');

INSERT INTO flights(`from`, `to`) VALUES 
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');
SELECT * FROM flights;
SELECT * FROM cities;

SELECT `from`.name AS `from`, `to`.name AS `to`
FROM flights 
JOIN cities AS `from` ON flights.`from` = `from`.label 
JOIN cities AS `to` ON flights.`to` = `to`.label 
ORDER BY id;

