DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;
 
DROP TABLE IF EXISTS users;
CREATE TABLE users ( 
	id SERIAL PRIMARY KEY, -- serial == BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	firstname VARCHAR(255),
	lastname VARCHAR(255) COMMENT '�������', -- COMMENT �� ������, ���� ��� �����������
	email VARCHAR(100) UNIQUE,
	password_hash VARCHAR(100),
	phone BIGINT,
	is_deleted BIT DEFAULT 0,
	INDEX users_firstname_lastname_idx(firstname, lastname) -- ����� ����� ���� �� �� � ���, ������� ������� ��� ����� ������
);

-- 1-1
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` ( 
	user_id SERIAL PRIMARY KEY, -- ����������� ��� �������� �����, ����� ������ �� ���� ��� � ����, �� ������� ���������
	gender CHAR(1), 
	birthday DATE, -- ���� �� ��� "0000-00-00"
	photo_id BIGINT UNSIGNED, -- ����������� ��� ���� ��������
	created_at DATETIME DEFAULT NOW(), -- ���� ��� �������� ������� �� ���������
	hometown VARCHAR(100)
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;
	
-- 1-M
DROP TABLE IF EXISTS messages;
CREATE TABLE messages ( 
	id SERIAL PRIMARY KEY, -- ������������� ���������
	from_user_id BIGINT UNSIGNED NOT NULL, -- ��� serial, �� ���� AUTO_INCREMENT � 1 ���� ����
	to_user_id BIGINT UNSIGNED NOT NULL, -- ������� ����� ����������� ����� ��� ����������� �� ��
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE 
	
);

DROP TABLE IF EXISTS friend_requests; -- ������(��������� �������)
CREATE TABLE friend_requests ( 
	iniator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	`status` ENUM('requested', 'approved', 'declined', 'unfriended'), -- enum - ������������ �������� �� ������ ���������� ��������, ���� ������������� � ������������ � ������ �������� �������
	requested_at DATETIME DEFAULT NOW(), -- ���� ������
	updated_at DATETIME ON UPDATE NOW(), -- ���� ���������� ���������� 
	 
	PRIMARY KEY (iniator_user_id, target_user_id), -- ��������� ���� �� id, � 1,2 != 2,1 (���� ��� ����� ������, � ���� �������� ��� ��������, ��� ��������� ���-��)
	FOREIGN KEY (iniator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE 
);

-- �-�
DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255), 
	admin_user_id BIGINT UNSIGNED,
	
	INDEX communities_name_idx(name), -- ����� �� ����� ����������
	FOREIGN KEY (admin_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL -- � ������ �������� �����-�� �������� ������ ��������
);
-- ������������� �������
DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities (
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (user_id, community_id), -- ����� �� ���� 2 ������� � ������������ � ����������
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	media_type_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	filename VARCHAR(255),
	`size` INT,
	metadata JSON,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (media_type_id) REFERENCES media_types (id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	id SERIAL,
	name VARCHAR(255) DEFAULT NULL,
	user_id BIGINT UNSIGNED DEFAULT NULL,
	
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL,
	PRIMARY KEY (id)
);


DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	 id SERIAL PRIMARY KEY,
	 album_id BIGINT UNSIGNED NOT NULL,
	 media_id BIGINT UNSIGNED NOT NULL,
	 
	 FOREIGN KEY (album_id) REFERENCES photo_albums(id) ON UPDATE CASCADE ON DELETE CASCADE,
     FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);


ALTER TABLE `profiles` ADD CONSTRAINT fk_photo_id
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    ON UPDATE CASCADE ON DELETE SET NULL;

   
-- ����� 1 � 1: � ���� ����� ���������� ����-����(������ ������), id = 1 user ����� ���� ������ ����� ��������,
   -- �� ����� ���� ��������� �������� ��� 1 �����
   -- �� ����� ���� ���������� ������ ��� ������ ������� (���� ��� ���, ������ ������� ����� =))
/*DROP TABLE IF EXISTS artists;
CREATE TABLE artists ( 
	user_id SERIAL PRIMARY KEY,
	nickname VARCHAR(255) COMMENT '��������� �������',
	genre VARCHAR(255) COMMENT '����������� ����',
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- ����� 1 �� ������: � ������ ������ ����� ���� ����� �����
DROP TABLE IF EXISTS songs;
CREATE TABLE songs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT '�������� �����',
	duration INT NOT NULL, -- ������������ �����
	artist_id BIGINT UNSIGNED NOT NULL, -- ��� serial, �� ���� AUTO_INCREMENT � 1 ���� ����
	
	INDEX song_name_idx(name, artist_id), -- ����� �� ������� � ��� �����
	FOREIGN KEY (artist_id) REFERENCES artists (user_id) ON UPDATE CASCADE ON DELETE CASCADE
);


-- ����� ������ �� ������: ����-����.
-- ��� �� ������ ������ ������� ���� ����-���� �� ������ ������ ��������, � ������ ������������ ����� ������� ���� ��������
-- ���� ����� ������ ����������, �� ��� �������, ��� ���������� ����� �-�

DROP TABLE IF EXISTS play_list;
CREATE TABLE play_list( 
	playlist_id SERIAL PRIMARY KEY,
	name VARCHAR(255) UNIQUE, -- �������� ����-�����, ����� ����� ����������
	user_id BIGINT UNSIGNED NOT NULL, -- ��������� ����-�����
	song_id BIGINT UNSIGNED NOT NULL, -- �������� �����
	artist_id BIGINT UNSIGNED NOT NULL,
	
	
	FOREIGN KEY (user_id) REFERENCES  users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (song_id) REFERENCES songs(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES  users(id) ON UPDATE CASCADE ON DELETE CASCADE
);
	
    
