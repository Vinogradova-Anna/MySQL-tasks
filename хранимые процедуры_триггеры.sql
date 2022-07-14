-- триггеры;

/* В таблицу authors допустимо присутствие одного из полей: firstname или lastname
Неприемлемо, когда одно или оба принимают неопределенное значение.
Используем триггеры, чтобы эти поля были заполнены*/

USE library_2;
SELECT firstname, lastname FROM authors;
DROP TRIGGER IF EXISTS not_null;
delimiter // 
CREATE TRIGGER not_null BEFORE INSERT ON authors 
FOR EACH ROW BEGIN 
	IF NEW.firstname IS NULL OR NEW.lastname IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'both values cannot be NULL one of the values cannot be NULL' ;
	END IF;
END //
delimiter ;

INSERT INTO authors (firstname, lastname)
VALUES (NULL, NULL);

INSERT INTO authors (firstname, lastname)
VALUES ('Diego', 'Pollin');

INSERT INTO authors (firstname, lastname)
VALUES (NULL, 'Stark');


-- хранимые процедуры 
/* напишем процедуру, которая будет принимать на вход id книги и возвращает к ней название name
комментарии*/

USE library_2;
DROP PROCEDURE IF EXISTS comment_for_book;
delimiter // 
CREATE PROCEDURE comment_for_book(IN for_book_id BIGINT)
BEGIN 
	SELECT b.book_name, c.books_id, c.comment 
	FROM comments c 
	JOIN books b ON c.books_id = b.id 
	WHERE c.books_id  = for_book_id;
END //
delimiter ;

CALL comment_for_book(17); 


