-- ТРАНЗАКЦИИ
/*1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
 * Используйте транзакции*/

SELECT * FROM shop.users;
SELECT * FROM sample.users;

START TRANSACTION; -- начали транзакцию
INSERT INTO sample.users(id, name) SELECT id, name FROM shop.users WHERE id = 1; -- переносим только id, name, так как в sample.users есть только эти колонки
DELETE FROM shop.users WHERE id=1; -- удаляем из shop.users запись id=1, тк в условии перенос, а не копирование записи
COMMIT; -- сохранили транзакцию

/* 2. Создайте представление, которое выводит название name товарной позиции 
из таблицы products и соответствующее название каталога name из таблицы catalogs.
*/
USE shop;
CREATE OR REPLACE VIEW new_table AS 
SELECT 
	p.name AS pn,
	c.name AS cn
FROM products p 
JOIN catalogs c ON p.catalog_id =c.id;

SELECT * FROM new_table ;

-- “Хранимые процедуры и функции, триггеры"

/*1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция 
должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

SET GLOBAL log_bin_trust_function_creators = 1;
-- Вылезала ошибка, описанная ниже, на stackowerflow нашла решение, что нужно ослабить проверку на наличие недетерминированных функций
/*1418 (HY000) at line 10185: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA 
 * in its declaration and binary logging is enabled 
 * (you *might* want to use the less safe log_bin_trust_function_creators variable)*/
DROP FUNCTION IF EXISTS hel_lo;
delimiter //
CREATE FUNCTION hel_lo()
RETURNS TEXT NOT DETERMINISTIC -- возвращаемое значение будет зависеть от текущего времени
BEGIN 
	DECLARE tme INT; -- объявили локальную переменную
	SET tme = HOUR(NOW()); -- в переменной будет текущее время
	CASE 
		WHEN tme BETWEEN 6 AND 11 THEN 
			RETURN 'Доброе утро!';
		WHEN tme BETWEEN 12 AND 17 THEN 
			RETURN 'Добрый день!';
		WHEN tme BETWEEN 18 AND 23 THEN 
			RETURN 'Добрый вечер!';
		WHEN tme BETWEEN 0 AND 5 THEN 
			RETURN 'Доброй ночи';
	END CASE;
END//
delimiter ;

SELECT hel_lo();

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

USE shop;
SELECT name, description FROM products;
DROP TRIGGER IF EXISTS not_null;
delimiter //
CREATE TRIGGER not_null BEFORE INSERT ON products 
FOR EACH ROW BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'both values cannot be NULL' ; 
	END IF;
END //
delimiter ;

INSERT INTO products (name, description, price) -- будет ошибка
VALUES (NULL, NULL, 2000);

INSERT INTO products (name, description, price) -- не будет ошибки
VALUES ('Acer', 'Notebook', 5000);

INSERT INTO products (name, description, price) -- не будет ошибки
VALUES ('acer500', NULL, 3000);



