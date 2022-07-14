-- представления (минимум 2);

/* Создали представление, которое выводит название name книги из таблицы books 
 * и соответсвующее название жанра name из каталога genre
 */

USE library_2;
CREATE OR REPLACE VIEW view_table1 AS 
SELECT 
	b.book_name AS bn,
	g.name AS gn
FROM books b 
JOIN genre g ON g.genre_id=b.genre_id;
SELECT * FROM view_table1;

/* Создали представление, которое выводит название name книги из таблицы books
 * и соответсвующий коменнтарий к ней comment из таблицы comments
 */
USE library_2;
CREATE OR REPLACE VIEW view_table2 AS 
SELECT 
	b.book_name AS bn,
	c.comment AS cm 
FROM books b 
JOIN comments c ON c.books_id=b.id;
SELECT * FROM view_table2;
