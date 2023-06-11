/* Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру,
с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old.
(использование транзакции с выбором commit или rollback – обязательно). */
USE homework_4;

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE, 
    firstname VARCHAR(50), 
    lastname VARCHAR(50), 
    email VARCHAR(50)
);

DELIMITER //
DROP PROCEDURE IF EXISTS moving;
CREATE PROCEDURE moving (IN num_1 INT) 
BEGIN
INSERT INTO users_old (firstname,lastname,email) 
SELECT firstname, lastname, email 
	FROM users 
	WHERE users.id = num_1;
DELETE FROM users 
	WHERE id = num_1;
COMMIT;
END//
DELIMITER ;
CALL moving(4);
CALL moving(5);
CALL moving (7);
CALL moving(2);

/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */

DELIMITER //
CREATE FUNCTION greeting() 
	RETURNS VARCHAR(25)
    deterministic
BEGIN
DECLARE greeting VARCHAR(25);
SELECT CASE 
	WHEN CURRENT_TIME >= '12:00:00' AND  CURRENT_TIME < '18:00:00' THEN 'Добрый день'
	WHEN CURRENT_TIME >= '06:00:00' AND  CURRENT_TIME < '12:00:00' THEN 'Доброе утро'
	WHEN CURRENT_TIME >= '00:00:00' AND  CURRENT_TIME < '06:00:00' THEN 'Доброй ночи'
	ELSE 'Доброго времени суток'
END INTO greeting;
RETURN greeting;
END//

DELIMITER ;

SELECT greeting();