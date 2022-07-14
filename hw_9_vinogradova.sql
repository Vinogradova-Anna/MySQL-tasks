-- ����������
/*1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
 * ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. 
 * ����������� ����������*/

SELECT * FROM shop.users;
SELECT * FROM sample.users;

START TRANSACTION; -- ������ ����������
INSERT INTO sample.users(id, name) SELECT id, name FROM shop.users WHERE id = 1; -- ��������� ������ id, name, ��� ��� � sample.users ���� ������ ��� �������
DELETE FROM shop.users WHERE id=1; -- ������� �� shop.users ������ id=1, �� � ������� �������, � �� ����������� ������
COMMIT; -- ��������� ����������

/* 2. �������� �������������, ������� ������� �������� name �������� ������� 
�� ������� products � ��������������� �������� �������� name �� ������� catalogs.
*/
USE shop;
CREATE OR REPLACE VIEW new_table AS 
SELECT 
	p.name AS pn,
	c.name AS cn
FROM products p 
JOIN catalogs c ON p.catalog_id =c.id;

SELECT * FROM new_table ;

-- ��������� ��������� � �������, ��������"

/*1. �������� �������� ������� hello(), ������� ����� ���������� �����������, 
� ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� 
������ ���������� ����� "������ ����", 
� 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
� 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
*/

SET GLOBAL log_bin_trust_function_creators = 1;
-- �������� ������, ��������� ����, �� stackowerflow ����� �������, ��� ����� �������� �������� �� ������� ������������������� �������
/*1418 (HY000) at line 10185: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA 
 * in its declaration and binary logging is enabled 
 * (you *might* want to use the less safe log_bin_trust_function_creators variable)*/
DROP FUNCTION IF EXISTS hel_lo;
delimiter //
CREATE FUNCTION hel_lo()
RETURNS TEXT NOT DETERMINISTIC -- ������������ �������� ����� �������� �� �������� �������
BEGIN 
	DECLARE tme INT; -- �������� ��������� ����������
	SET tme = HOUR(NOW()); -- � ���������� ����� ������� �����
	CASE 
		WHEN tme BETWEEN 6 AND 11 THEN 
			RETURN '������ ����!';
		WHEN tme BETWEEN 12 AND 17 THEN 
			RETURN '������ ����!';
		WHEN tme BETWEEN 18 AND 23 THEN 
			RETURN '������ �����!';
		WHEN tme BETWEEN 0 AND 5 THEN 
			RETURN '������ ����';
	END CASE;
END//
delimiter ;

SELECT hel_lo();

/* 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
 * ��������� ����������� ����� ����� ��� ���� �� ���. 
 * ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
 * ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
 * ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
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

INSERT INTO products (name, description, price) -- ����� ������
VALUES (NULL, NULL, 2000);

INSERT INTO products (name, description, price) -- �� ����� ������
VALUES ('Acer', 'Notebook', 5000);

INSERT INTO products (name, description, price) -- �� ����� ������
VALUES ('acer500', NULL, 3000);



