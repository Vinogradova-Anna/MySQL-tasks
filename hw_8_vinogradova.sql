/*1. ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, 
 ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).*/
USE vk;
SELECT 
	m.from_user_id, -- �������� ������������, �� �������� ������ ������ ����� ���������
	concat(u.firstname, ' ', u.lastname) AS name, -- ���������� ��� � ������� �� ������� users
	count(*) AS mess_count -- ������ ���������� ��������� �� ��������� ������������
FROM messages m 
JOIN users u ON m.from_user_id = u.id -- ������ ����.������, ��� id ������������ = id ����������� ���������
JOIN friend_requests fr ON 
	(fr.iniator_user_id = m.to_user_id AND fr.target_user_id=m.from_user_id) -- ������� �� ����������� � ����������
	OR 
	(fr.target_user_id = m.from_user_id AND fr.iniator_user_id=m.from_user_id)
WHERE status = 'approved' AND m.to_user_id = 16 -- �������� ��� ������� ����, �� ���� ���� ���� �� ��� � JOIN � fr , �� ������ ������
GROUP BY m.from_user_id 
ORDER BY mess_count DESC
LIMIT 1;



/* 2. ���������� ����� ���������� ������, ������� �������� ������������ ������ 11 ���.*/
SELECT 
	COUNT(*) as 'likes count'
FROM likes l
JOIN media m ON m.id =l.media_id 
JOIN profiles p ON p.user_id =m.user_id 
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11;



/* 3. ���������� ��� ������ �������� ������ (�����): ������� ��� �������.*/
SELECT 
	p.gender,
	count(*) AS g_count
FROM profiles p 
JOIN likes l ON p.user_id =l.user_id 
GROUP BY p.gender -- ������������� �� ���� gender
ORDER BY g_count DESC; -- � ������� ��������

