/*1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
 в таблицу logs помещается время и дата создания записи, название таблицы, 
 идентификатор первичного ключа и содержимое поля name.*/

USE shop;
CREATE TABLE logs (
	name_t VARCHAR(255), -- название таблицы
	name_t_id INT, -- id таблицы
	name VARCHAR(255), -- название поля таблицы
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=Archive;

-- создадим таблицы logs для users, catalogs и products
DROP TRIGGER IF EXISTS log_users;
delimiter // 
CREATE TRIGGER log_users AFTER INSERT ON users 
FOR EACH ROW BEGIN 
	INSERT INTO logs (name_t, name_t_id, name)
	VALUES('users', NEW.id, NEW.name);
END //
delimiter ;


DROP TRIGGER IF EXISTS log_catalogs;
delimiter // 
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs 
FOR EACH ROW BEGIN 
	INSERT INTO logs (name_t, name_t_id, name) VALUES('catalogs', NEW.id, NEW.name);
END //
delimiter ;


DROP TRIGGER IF EXISTS log_products;
delimiter //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW BEGIN 
	INSERT INTO logs (name_t, name_t_id, name) VALUES('products', NEW.id, NEW.name);
END //
delimiter ;


-- проверка 
INSERT INTO users(name, birthday_at) VALUES('Федор', '2000-11-05');
SELECT * FROM logs;
SELECT * FROM users;

INSERT INTO catalogs(name) VALUES('Компьютерные мыши');
SELECT * FROM logs;
SELECT * FROM catalogs;

INSERT INTO products (name, description, price, catalog_id) VALUES('logitech m310', 'компьютерная blutoothe-мышь', 2000, 6);
SELECT * FROM logs;
SELECT * FROM products;


/*2) Создайте SQL-запрос, который помещает в таблицу users миллион записей.*/
-- решение подсмотрела у кого-то в домашке на гитхабе
DROP TABLE IF EXISTS test_users; -- создали тестовую таблицу
CREATE TABLE test_users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at date,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

INSERT INTO test_users(name, birthday_at) VALUES -- наполнили ее 10-ю значениями
('Анна', '2000-09-06'),
('Иван', '2001-09-06'),
('Павел', '2000-09-10'),
('Татьяна', '2003-09-06'),
('Андрей', '2000-09-17'),
('Александр', '1990-09-06'),
('Мария', '2000-04-06'),
('Ольга', '2000-05-06'),
('Светлана', '2000-01-06'),
('Алиса', '2000-09-25');

SELECT count(*) FROM -- кол-во записей будет 1.000.000
test_users AS one,
test_users AS two,
test_users AS three,
test_users AS four,
test_users AS five,
test_users AS six;

INSERT INTO users(name, birthday_at) -- вставляем данные записи в нашу таблицу users 
SELECT one.name, one.birthday_at 
FROM 
	test_users AS one,
	test_users AS two,
	test_users AS three,
	test_users AS four,
	test_users AS five,
	test_users AS six;
	
-- select * from users;