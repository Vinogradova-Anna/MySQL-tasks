/*1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
 который больше всех общался с выбранным пользователем (написал ему сообщений).*/
USE vk;
SELECT 
	m.from_user_id, -- выбираем пользователя, от которого пришло больше всего сообщений
	concat(u.firstname, ' ', u.lastname) AS name, -- объединили имя и фамилию из таблицы users
	count(*) AS mess_count -- найдем количество сообщений от заданного пользователя
FROM messages m 
JOIN users u ON m.from_user_id = u.id -- убрали влож.запрос, где id пользователя = id отправителя сообщений
JOIN friend_requests fr ON 
	(fr.iniator_user_id = m.to_user_id AND fr.target_user_id=m.from_user_id) -- условия на отправителя и получателя
	OR 
	(fr.target_user_id = m.from_user_id AND fr.iniator_user_id=m.from_user_id)
WHERE status = 'approved' AND m.to_user_id = 16 -- написала оба условия сюда, тк если пишу одно из них в JOIN с fr , то выдает ошибку
GROUP BY m.from_user_id 
ORDER BY mess_count DESC
LIMIT 1;



/* 2. Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.*/
SELECT 
	COUNT(*) as 'likes count'
FROM likes l
JOIN media m ON m.id =l.media_id 
JOIN profiles p ON p.user_id =m.user_id 
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11;



/* 3. Определить кто больше поставил лайков (всего): мужчины или женщины.*/
SELECT 
	p.gender,
	count(*) AS g_count
FROM profiles p 
JOIN likes l ON p.user_id =l.user_id 
GROUP BY p.gender -- сгруппировали по полю gender
ORDER BY g_count DESC; -- в порядке убывания

