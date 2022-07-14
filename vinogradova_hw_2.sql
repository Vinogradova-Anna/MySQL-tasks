/* Задача 2
  * Создайте базу данных example, разместите в ней таблицу users, 
  * состоящую из двух столбцов, числового id и строкового name.
  */

CREATE DATABASE example;
SHOW DATABASES;
USE example;

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);
DESCRIBE users;
#SERIAL включает сразу числа BIGINT и свойство AUTO_INCREMENT, чтобы автоматически увеличивался id

/*Задача 3
 *Создайте дамп базы данных example из предыдущего задания, 
 *разверните содержимое дампа в новую базу данных sample.
*/

-- работала по этой задаче из коммандной строки, продублировала действия сюда 

exit
-- вышли из консоли по exit, создадим дамп для бд example 
mydumpsql example > example.sql 
-- сохранили дамп в файл example.sql , затем заходим в консоль mysql(тк есть my.cnf в windows, 
-- то захожу просто командой mysql)
mysql 
create database sample;
-- создала бд sample, в которую можем загрузить example, выхожу из консоли, 
-- тк с дампом я работала из командной строки, а не из клиента mysql 
exit 
mysql sample < example.sql 
-- воссоздадим исходную структуру example в новой базе данных sample,
-- проверим, что дамп загружен, зайдем в консоль
mysql 
use sample;
show tables;

/*Задача 4
 * Создайте дамп единственной таблицы help_keyword базы данных mysql. 
 * Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
 */

-- подсмотрела на stackowerflow решение:
SHOW DATABASES;
CREATE DATABASE help;
CREATE TABLE help.help_keyword -- как я поняла, создали таблицу в Бд help 
	SELECT *
	FROM mysql.help_keyword 
	LIMIT 100;
-- выбираю все для таблицы help_keyword из бд mysql из таблицы help_keyword c ограничением LIMIT 100
SELECT * FROM help.help_keyword;
-- и этой командой смотрю содержимое таблицы help_keyword из БД help
-- как я поняла, help.help_keyword - это обращение к таблице h_p из БД help ?