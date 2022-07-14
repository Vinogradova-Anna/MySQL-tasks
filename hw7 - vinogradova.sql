/* 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
интернет магазине.*/

USE shop;
--  осмотрела таблицы, они пустые. 
SELECT * FROM orders ;
SELECT * FROM orders_products;

SELECT * FROM users;
SELECT * FROM products;
-- заполню недостающими данными некоторых пользователей
INSERT INTO orders(user_id)
SELECT id FROM users WHERE name IN ('Александр', 'Наталья');

INSERT INTO orders_products (order_id, product_id, total)
SELECT last_insert_id(), id, 2 FROM products -- last_insert_id() вернет последний id, назначенный в таблице orders, id - идентификатор товара, total - количество товара
WHERE name = 'Intel Core i3-8100';

INSERT INTO orders_products (order_id, product_id, total)
SELECT last_insert_id(), id, 1 FROM products 
WHERE name = 'AMD FX-8320';

-- Вложенный
SELECT id, name FROM users WHERE id in(SELECT DISTINCT user_id FROM orders); -- вложенным запросом

-- JOIN
SELECT u.id, u.name 
FROM users AS u JOIN orders AS o 
ON u.id = o.user_id;


/* 2. Выведите список товаров products и разделов catalogs, который соответствует товару.*/

SELECT p.name, c.name 
FROM products AS p LEFT JOIN catalogs AS c 
ON c.id = p.catalog_id;

-- В ON-фильтрации id из таблицы catalogs соответствует catalog_id в таблице products;

/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
name). Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.*/

DROP TABLE IF EXISTS cities;
CREATE TABLE cities  (
  label VARCHAR(255) PRIMARY KEY, -- первичным ключом таблицы cities будет label
  name VARCHAR(255) NOT NULL
) COMMENT = 'Города';

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255) NOT NULL,
  `to` VARCHAR(255) NOT NULL,
  
  FOREIGN KEY (`from`) REFERENCES cities (label) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (`to`) REFERENCES cities (label) ON UPDATE CASCADE ON DELETE CASCADE 
) COMMENT = 'Рейсы';

INSERT INTO cities (label, name) VALUES 
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

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

