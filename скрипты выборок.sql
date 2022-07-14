USE library_2;

-- � ������� ���������� ������� ������� ��� � ������� ������ �����, � ����, �������� ��� ����� � id=1
SELECT 
	id,
	book_name,
	concat(
		(SELECT firstname FROM authors WHERE author_id = books.author_id), ' ',
	    (SELECT lastname FROM authors WHERE author_id = books.author_id)) AS 'authors name',
	(SELECT name FROM genre WHERE genre_id = books.genre_id ) AS 'genre'
FROM books 
WHERE id = 1;

-- � ������� ���������� ������� ������� ���������� ������ � ����, ����������� �� book_id(�.�. �� ����� ����� ������� ����), � ������� � ������� ��������
-- ������� ������ �� �����, � ������� ������ ������ 1
SELECT 
	books_id,
	count(*) AS likes_count,
	(SELECT book_name FROM books WHERE id = likes.books_id) AS 'name'
FROM likes 
GROUP BY books_id
HAVING likes_count > 1
ORDER BY count(*) DESC;


-- ������� ����� ���������� ��� ��� ������ 
SELECT 
	count(*) AS popular_room,
	rr.name 
FROM  book_placemant bp 
JOIN reading_room rr ON rr.id = bp.reading_room_id
GROUP BY bp.reading_room_id 
ORDER BY popular_room DESC;
LIMIT 1; 

-- ������ �����, ������� ����� ����� � ���������� � 2020 ����, � ���������, ����� ������������ ������ ��� �������
SELECT 
	u.id AS user_id,
	concat(u.firstname, ' ', u.lastname) AS library_user, 
	b.book_name,
	b.id AS book_id,
	ba.date_of_delivery
FROM books b 
JOIN book_accounting ba ON b.id = ba.books_id
JOIN users u ON u.id = ba.user_id
WHERE date_of_delivery < '2020-12-31' AND date_of_delivery > '2020-01-01'
GROUP BY date_of_delivery;




 




