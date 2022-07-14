/* ������ 2
  * �������� ���� ������ example, ���������� � ��� ������� users, 
  * ��������� �� ���� ��������, ��������� id � ���������� name.
  */

CREATE DATABASE example;
SHOW DATABASES;
USE example;

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);
DESCRIBE users;
#SERIAL �������� ����� ����� BIGINT � �������� AUTO_INCREMENT, ����� ������������� ������������ id

/*������ 3
 *�������� ���� ���� ������ example �� ����������� �������, 
 *���������� ���������� ����� � ����� ���� ������ sample.
*/

-- �������� �� ���� ������ �� ���������� ������, �������������� �������� ���� 

exit
-- ����� �� ������� �� exit, �������� ���� ��� �� example 
mydumpsql example > example.sql 
-- ��������� ���� � ���� example.sql , ����� ������� � ������� mysql(�� ���� my.cnf � windows, 
-- �� ������ ������ �������� mysql)
mysql 
create database sample;
-- ������� �� sample, � ������� ����� ��������� example, ������ �� �������, 
-- �� � ������ � �������� �� ��������� ������, � �� �� ������� mysql 
exit 
mysql sample < example.sql 
-- ����������� �������� ��������� example � ����� ���� ������ sample,
-- ��������, ��� ���� ��������, ������ � �������
mysql 
use sample;
show tables;

/*������ 4
 * �������� ���� ������������ ������� help_keyword ���� ������ mysql. 
 * ������ ��������� ����, ����� ���� �������� ������ ������ 100 ����� �������.
 */

-- ����������� �� stackowerflow �������:
SHOW DATABASES;
CREATE DATABASE help;
CREATE TABLE help.help_keyword -- ��� � ������, ������� ������� � �� help 
	SELECT *
	FROM mysql.help_keyword 
	LIMIT 100;
-- ������� ��� ��� ������� help_keyword �� �� mysql �� ������� help_keyword c ������������ LIMIT 100
SELECT * FROM help.help_keyword;
-- � ���� �������� ������ ���������� ������� help_keyword �� �� help
-- ��� � ������, help.help_keyword - ��� ��������� � ������� h_p �� �� help ?