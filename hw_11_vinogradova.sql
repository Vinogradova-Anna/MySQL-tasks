/*1) �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, catalogs � products 
 � ������� logs ���������� ����� � ���� �������� ������, �������� �������, 
 ������������� ���������� ����� � ���������� ���� name.*/

USE shop;
CREATE TABLE logs (
	name_t VARCHAR(255), -- �������� �������
	name_t_id INT, -- id �������
	name VARCHAR(255), -- �������� ���� �������
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=Archive;

-- �������� ������� logs ��� users, catalogs � products
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


-- �������� 
INSERT INTO users(name, birthday_at) VALUES('�����', '2000-11-05');
SELECT * FROM logs;
SELECT * FROM users;

INSERT INTO catalogs(name) VALUES('������������ ����');
SELECT * FROM logs;
SELECT * FROM catalogs;

INSERT INTO products (name, description, price, catalog_id) VALUES('logitech m310', '������������ blutoothe-����', 2000, 6);
SELECT * FROM logs;
SELECT * FROM products;


/*2) �������� SQL-������, ������� �������� � ������� users ������� �������.*/
-- ������� ����������� � ����-�� � ������� �� �������
DROP TABLE IF EXISTS test_users; -- ������� �������� �������
CREATE TABLE test_users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at date,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

INSERT INTO test_users(name, birthday_at) VALUES -- ��������� �� 10-� ����������
('����', '2000-09-06'),
('����', '2001-09-06'),
('�����', '2000-09-10'),
('�������', '2003-09-06'),
('������', '2000-09-17'),
('���������', '1990-09-06'),
('�����', '2000-04-06'),
('�����', '2000-05-06'),
('��������', '2000-01-06'),
('�����', '2000-09-25');

SELECT count(*) FROM -- ���-�� ������� ����� 1.000.000
test_users AS one,
test_users AS two,
test_users AS three,
test_users AS four,
test_users AS five,
test_users AS six;

INSERT INTO users(name, birthday_at) -- ��������� ������ ������ � ���� ������� users 
SELECT one.name, one.birthday_at 
FROM 
	test_users AS one,
	test_users AS two,
	test_users AS three,
	test_users AS four,
	test_users AS five,
	test_users AS six;
	
-- select * from users;