/*������������ ������� ���� ���������� �������
*/

-- 1. ����������� ������� ������� ������������� � ������� users.
USE shop;
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS age_avg FROM users;

-- timestampdiff (YEAR, birthday_at, NOW()) ��������� ������� ������� ������������
-- �������� ������� AVG, ����� ������� �������� �������
-- ROUND - ���������

-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
/*��� � ������ �������, ����� ��������� � ������� ����, ������� ���� �������� ���������� 
�� �����������, ������� �� ������� � ��*/

SELECT DATE(concat_ws('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS y_m_day FROM users;
-- ������ ���� ��� �������� � 2022 ����
-- concat_ws - ������� ������ � �������������� ����������� '-'

SELECT date_format(date(concat_ws('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS week_day FROM users GROUP BY week_day;
-- ����������� ���� � ���� ������ � ����������� �� ����(week_day), ����� �������� ���� ������ �� �����������

SELECT date_format(date(concat_ws('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS week_day, count(*) AS total FROM users GROUP BY week_day ORDER BY total DESC;
-- ������� ���������� �������������, ��������� � �� � ������� total, ����� ���������� �������, ������������� �� �������� �������� ������� total


-- 3. (�� �������) ����������� ������������ ����� � ������� �������.
-- ������� �������, ��������� �������
CREATE TABLE value1 ( 
	id SERIAL PRIMARY KEY,
	value INT NOT NULL
);

INSERT INTO value1 (value) 
VALUES 
(1),
(2),
(3),
(4),
(5);

SELECT * FROM value1;

-- ��-�� ����������: �������� ������������ ����� ����� ����������
-- �.�. ln(1,2,3,4,5) = ln(1)+ln(2)+ln(3)+ln(4)+ln(5)
-- ������� �������� ��������� ������� ���������� exp
-- �.�. exp(ln(1*2*3*4*5)) = 1*2*3*4*5 = exp(ln(1) + ln(2) + ln(3) + ln(4) + ln(5))
SELECT exp(SUM(log(value))) AS resultt FROM value1;

/* ������������ ������� �� ���� ����������, ����������, ���������� � �����������
*/
-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
SELECT * FROM users;
UPDATE users 
SET created_at = NOW(), updated_at = NOW();
SELECT * FROM users;

-- 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR 
-- � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. 
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = '����������';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('��������', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('�������', '1984-11-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('���������', '1985-05-20', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('������', '1988-02-14', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('����', '1998-01-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('�����', '1992-08-29', '20.10.2017 8:10', '20.10.2017 8:10');
 
-- ������� str_to_date ��������� ����������� �������� � ��� ������, ������� ������������� ������� ������������ ��������,
-- �������� ������ ��������� ���, ������ ��������� ������ � �������, => ������� ����������� ����������� ��������
SELECT STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') FROM users;

-- ������� ������ ������ ������ �� �����
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), 
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

SELECT * FROM users;

-- 3. � ������� ��������� ������� storehouses_products � ���� value 
-- ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, 
-- ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
-- ����� ��� ���������� � ������� ���������� �������� value. 
-- ������ ������� ������ ������ ���������� � �����, ����� ���� �������.

SELECT * FROM storehouses_products;
INSERT INTO storehouses_products (value)
VALUES
(0),
(2500),
(0),
(30),
(500),
(1);

SELECT id, value FROM storehouses_products;

-- ����������� ���������� �� �������� value
SELECT * FROM storehouses_products ORDER BY value;

-- ����� ������� sort, � ������� ������� �������� ���������� ������ 1, � ��� ��������� 0.
SELECT id, value, IF(value > 0, 0, 1) AS sort FROM storehouses_products ORDER BY value;

-- ����������� ������ �� ���� ��������, �� ���� sort, ����� �� ���� value.
SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;

-- 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� (may, august)
SELECT * FROM users;
-- �������� ����� �������� ������������� � ������� date_format
SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users;

SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('august', 'may');


-- 5. (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- ������������ ������ � �������, �������� � ������ IN.

SELECT * FROM catalogs;
SELECT * FROM catalogs WHERE id IN (5, 2, 1);

-- ������� ������ ������ ���, ���� �������� ����������� ��� �������������,
-- FIELD ���������� ������ �������� �� ����� ����������, � ���������� 0, ���� �������� �� ����� � ������.
-- ���� �������� ������ � ������, �� field ���������� ��� ������� � ������
SELECT id, name, FIELD(id, 5, 1, 2) AS place FROM catalogs WHERE id IN (5, 2, 1);
-- 5 ������� ���������� ������
-- 1 ������� - ������, � 2-� ������� - �������.
-- ������������� ������� �� ���� place, ����� �������� ������ ������� ���������� �������
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
