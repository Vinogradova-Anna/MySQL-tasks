/*1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
Определить кто больше поставил лайков (всего): мужчины или женщины.*/
USE vk;
SELECT from_user_id, -- выбираем пользователя, от которого пришло больше всего сообщений
	concat( -- объединили имя и фамилию из таблицы users, где id пользователя = id отправителя сообщений
		(SELECT firstname FROM users WHERE id = messages.from_user_id), ' ',
		(SELECT lastname FROM users WHERE id = messages.from_user_id)
	) AS name,
	count(*) AS 'messages count' -- найдем количество сообщений от этого пользователя
FROM messages
WHERE to_user_id = 16 AND from_user_id IN ( 
	SELECT iniator_user_id FROM friend_requests -- выбираем юзеров, которые отправили заявку нашему id=16
	WHERE (target_user_id = 16) AND status = 'approved'-- где есть подтвержденный статус дружбы approved
	UNION -- объединяем результат из 2 SELECT-запросов в один
	SELECT target_user_id FROM friend_requests -- теперь смотрим, кому наш юзер id = 16 отправил запрос 
	WHERE (iniator_user_id = 16) AND status = 'approved') -- и получил подтверждение дружбы
GROUP BY from_user_id -- сгруппируем по отправителю
ORDER BY count(*) DESC -- Выведем количество сообщений от большего к меньшему
LIMIT 1; -- ограничили 1, иначе вывелись бы просто все, кто писал пользователю id=16

/* 2. Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.*/
SELECT COUNT(*) as 'likes count'
FROM likes
WHERE user_id IN ( -- все медиа записи этих пользователей
	SELECT media_id FROM media 
	UNION 
	SELECT user_id 
	FROM profiles
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11) -- все пользователи младше 11 лет
;


