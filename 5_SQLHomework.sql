use homework_4;

-- Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет

DROP VIEW IF EXISTS under_20;
CREATE VIEW under_20 AS 
SELECT CONCAT(firstname, ' ', lastname, '; ', gender, '; ', hometown) AS 'Пользователи не старше 20 лет'
FROM users
JOIN profiles ON users.id = profiles.user_id
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 20
GROUP BY users.id;

SELECT * FROM under_20;

/* Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей,
указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге
(первое место у пользователя с максимальным количеством сообщений). (используйте DENSE_RANK)*/

SELECT DENSE_RANK() OVER (ORDER BY COUNT(from_user_id) DESC) AS 'rating',
	COUNT(from_user_id) AS 'messages_sent',
	CONCAT(firstname, ' ', lastname) AS 'user_name'
FROM users
JOIN messages ON users.id = messages.from_user_id
GROUP BY users.id;

/* Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at)
и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG) */

SELECT *, 
LAG(created_at, 1, 0) OVER (PARTITION BY TIMESTAMPDIFF(SECOND, created_at, created_at)) AS lag_created_at,
LEAD(created_at) OVER (PARTITION BY TIMESTAMPDIFF(SECOND, created_at, created_at)) AS lead_created_at
FROM messages ORDER BY TIMESTAMPDIFF(SECOND, created_at, NOW()) DESC;
