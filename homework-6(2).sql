/*1. ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.
���������� ����� ���������� ������, ������� �������� ������������ ������ 11 ���.
���������� ��� ������ �������� ������ (�����): ������� ��� �������.*/
USE vk;
SELECT from_user_id, -- �������� ������������, �� �������� ������ ������ ����� ���������
	concat( -- ���������� ��� � ������� �� ������� users, ��� id ������������ = id ����������� ���������
		(SELECT firstname FROM users WHERE id = messages.from_user_id), ' ',
		(SELECT lastname FROM users WHERE id = messages.from_user_id)
	) AS name,
	count(*) AS 'messages count' -- ������ ���������� ��������� �� ����� ������������
FROM messages
WHERE to_user_id = 16 AND from_user_id IN ( 
	SELECT iniator_user_id FROM friend_requests -- �������� ������, ������� ��������� ������ ������ id=16
	WHERE (target_user_id = 16) AND status = 'approved'-- ��� ���� �������������� ������ ������ approved
	UNION -- ���������� ��������� �� 2 SELECT-�������� � ����
	SELECT target_user_id FROM friend_requests -- ������ �������, ���� ��� ���� id = 16 �������� ������ 
	WHERE (iniator_user_id = 16) AND status = 'approved') -- � ������� ������������� ������
GROUP BY from_user_id -- ����������� �� �����������
ORDER BY count(*) DESC -- ������� ���������� ��������� �� �������� � ��������
LIMIT 1; -- ���������� 1, ����� �������� �� ������ ���, ��� ����� ������������ id=16

/* 2. ���������� ����� ���������� ������, ������� �������� ������������ ������ 11 ���.*/
SELECT COUNT(*) as 'likes count'
FROM likes
WHERE user_id IN ( -- ��� ����� ������ ���� �������������
	SELECT media_id FROM media 
	UNION 
	SELECT user_id 
	FROM profiles
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11) -- ��� ������������ ������ 11 ���
;


