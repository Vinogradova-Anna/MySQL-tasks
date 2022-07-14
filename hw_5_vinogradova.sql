/*Практическое задание теме «Агрегация данных»
*/

-- 1. Подсчитайте средний возраст пользователей в таблице users.
USE shop;
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS age_avg FROM users;

-- timestampdiff (YEAR, birthday_at, NOW()) посчитали возраст каждого пользователя
-- добавили функцию AVG, чтобы вывести среднийй возраст
-- ROUND - округлили

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
/*как я поняла задание, нужно посчитать в текущем году, сколько дней рождений приходится 
на понедельник, сколько на вторник и тд*/

SELECT DATE(concat_ws('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS y_m_day FROM users;
-- вывела даты дни рождений в 2022 году
-- concat_ws - сложила строки с использованием разделителя '-'

SELECT date_format(date(concat_ws('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS week_day FROM users GROUP BY week_day;
-- преобразуем дату в день недели и сгруппируем по нему(week_day), чтобы значения дней недели не повторялись

SELECT date_format(date(concat_ws('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS week_day, count(*) AS total FROM users GROUP BY week_day ORDER BY total DESC;
-- Добавлю количество понедельников, вторников и тд в колонку total, чтобы смотрелось красиво, отсортировала по убыванию значений столбца total


-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.
-- создала таблицу, наполнила данными
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

-- св-во логарифмов: логарифм произведения равен сумме логарифмов
-- т.е. ln(1,2,3,4,5) = ln(1)+ln(2)+ln(3)+ln(4)+ln(5)
-- применю обратную логарифму функцию экспоненты exp
-- т.е. exp(ln(1*2*3*4*5)) = 1*2*3*4*5 = exp(ln(1) + ln(2) + ln(3) + ln(4) + ln(5))
SELECT exp(SUM(log(value))) AS resultt FROM value1;

/* Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
*/
-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
SELECT * FROM users;
UPDATE users 
SET created_at = NOW(), updated_at = NOW();
SELECT * FROM users;

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Александр', '1985-05-20', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Сергей', '1988-02-14', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Иван', '1998-01-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Мария', '1992-08-29', '20.10.2017 8:10', '20.10.2017 8:10');
 
-- функция str_to_date принимает календарное значение и его формат, который соответствует данному календарному значению,
-- заданный формат повторяет тот, которы находится сейчас в таблице, => получим стандартные календарные значения
SELECT STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') FROM users;

-- заменим старый формат данных на новый
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), 
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

SELECT * FROM users;

-- 3. В таблице складских запасов storehouses_products в поле value 
-- могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
-- если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. 
-- Однако нулевые запасы должны выводиться в конце, после всех записей.

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

-- отсортируем содержимое по значению value
SELECT * FROM storehouses_products ORDER BY value;

-- ввели столбец sort, в котором нулевые значения помечаются цифрой 1, а все остальные 0.
SELECT id, value, IF(value > 0, 0, 1) AS sort FROM storehouses_products ORDER BY value;

-- отсортируем записи по двум столбцам, по полю sort, потом по полю value.
SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
SELECT * FROM users;
-- извлекли месяц рождения пользователей с помощью date_format
SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users;

SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('august', 'may');


-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs;
SELECT * FROM catalogs WHERE id IN (5, 2, 1);

-- пометим каждую запись так, чтоб значение уменьшалось или увеличивалось,
-- FIELD сравнивает первый аргумент со всеми остальными, и возвращает 0, если аргумент не вошел в список.
-- если аргумент входит в список, то field возвращает его позицию в списке
SELECT id, name, FIELD(id, 5, 1, 2) AS place FROM catalogs WHERE id IN (5, 2, 1);
-- 5 элемент помещается первым
-- 1 элемент - вторым, а 2-й элемент - третьим.
-- отсортировали таблицу по полю place, чтобы получить нужный порядок следования записей
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
