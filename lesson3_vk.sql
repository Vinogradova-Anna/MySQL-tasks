DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;
 
DROP TABLE IF EXISTS users;
CREATE TABLE users ( 
	id SERIAL PRIMARY KEY, -- serial == BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	firstname VARCHAR(255),
	lastname VARCHAR(255) COMMENT 'Фамилия', -- COMMENT на случай, если имя неочевидное
	email VARCHAR(100) UNIQUE,
	password_hash VARCHAR(100),
	phone BIGINT,
	is_deleted BIT DEFAULT 0,
	INDEX users_firstname_lastname_idx(firstname, lastname) -- часто поиск осущ по им и фам, поэтому сделаем для этого индекс
);

-- 1-1
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` ( 
	user_id SERIAL PRIMARY KEY, -- предпосылка для внешнего ключа, точно такого же типа как и поле, на которое ссылается
	gender CHAR(1), 
	birthday DATE, -- дата до дня "0000-00-00"
	photo_id BIGINT UNSIGNED, -- предпосылка для фото аватарки
	created_at DATETIME DEFAULT NOW(), -- дата дня создания профиля по умолчанию
	hometown VARCHAR(100)
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;
	
-- 1-M
DROP TABLE IF EXISTS messages;
CREATE TABLE messages ( 
	id SERIAL PRIMARY KEY, -- идентификатор сообщения
	from_user_id BIGINT UNSIGNED NOT NULL, -- без serial, тк двух AUTO_INCREMENT в 1 табл НИЗЯ
	to_user_id BIGINT UNSIGNED NOT NULL, -- большое целое беззнаковое сообщ без отправителя не мб
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE 
	
);

DROP TABLE IF EXISTS friend_requests; -- заявки(одобрение общения)
CREATE TABLE friend_requests ( 
	iniator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	`status` ENUM('requested', 'approved', 'declined', 'unfriended'), -- enum - перечисление значений из списка допустимых значений, явно перечисленных в спецификации в момент создания таблицы
	requested_at DATETIME DEFAULT NOW(), -- дата заявки
	updated_at DATETIME ON UPDATE NOW(), -- дата последнего обновления 
	 
	PRIMARY KEY (iniator_user_id, target_user_id), -- первичный ключ не id, а 1,2 != 2,1 (Маша мне может подать, я могу одобрить или гаоборот, без задвоения дей-ий)
	FOREIGN KEY (iniator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE 
);

-- М-М
DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255), 
	admin_user_id BIGINT UNSIGNED,
	
	INDEX communities_name_idx(name), -- поиск по имени сообщества
	FOREIGN KEY (admin_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL -- в случае удаления сообщ-ва оставить пустое значение
);
-- промежуточная таблица
DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities (
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
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

   
-- Связь 1 к 1: У меня будет реализован плей-лист(раздел музыка), id = 1 user может быть только одним артистом,
   -- не может быть несколько артистов для 1 юзера
   -- не может быть нескольких юрезов для одного артиста (пока что так, только сольные певцы =))
/*DROP TABLE IF EXISTS artists;
CREATE TABLE artists ( 
	user_id SERIAL PRIMARY KEY,
	nickname VARCHAR(255) COMMENT 'Псевдоним артиста',
	genre VARCHAR(255) COMMENT 'Музыкальный жанр',
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Связь 1 ко многим: у одного автора может быть много песен
DROP TABLE IF EXISTS songs;
CREATE TABLE songs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название песни',
	duration INT NOT NULL, -- длительность песни
	artist_id BIGINT UNSIGNED NOT NULL, -- без serial, тк двух AUTO_INCREMENT в 1 табл НИЗЯ
	
	INDEX song_name_idx(name, artist_id), -- поиск по артисту и его песне
	FOREIGN KEY (artist_id) REFERENCES artists (user_id) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Связь многие ко многим: плэй-лист.
-- все из юзеров можгут создать свой плэй-лист из треков разных артистов, и каждый пользователь может слушать этот плейлист
-- пока очень кривая реализация, но мне кажется, она показывает связь М-М

DROP TABLE IF EXISTS play_list;
CREATE TABLE play_list( 
	playlist_id SERIAL PRIMARY KEY,
	name VARCHAR(255) UNIQUE, -- название плэй-листа, пусть будет уникальным
	user_id BIGINT UNSIGNED NOT NULL, -- создатель плей-листа
	song_id BIGINT UNSIGNED NOT NULL, -- название песни
	artist_id BIGINT UNSIGNED NOT NULL,
	
	
	FOREIGN KEY (user_id) REFERENCES  users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (song_id) REFERENCES songs(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES  users(id) ON UPDATE CASCADE ON DELETE CASCADE
);
	
    
