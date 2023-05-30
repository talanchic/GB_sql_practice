/* create database homework_2;
-- ЗАДАНИЕ 1.
use homework_2;
create table sales
(
ID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
order_date DATE NOT NULL,
count_product INT NOT NULL
);

INSERT INTO sales (order_date, count_product)
values('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

-- ЗАДАНИЕ 2.
SELECT id,
CASE
	WHEN count_product < 100 THEN 'Маленький заказ'
	WHEN count_product  BETWEEN 100 AND 300 THEN 'Средний заказ'
	WHEN count_product > 300 THEN 'Большой заказ'
	ELSE 'непонятный заказ'
END AS order_type
FROM sales;

-- ЗАДАНИЕ 3.
CREATE TABLE orders
(
ID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
emloyee_id varchar(10) NOT NULL,
amount FLOAT NOT NULL,
order_status TEXT not null

);

ALTER TABLE orders
RENAME COLUMN emloyee_id TO employee_id;

INSERT INTO orders (employee_id, amount, order_status)
VALUES ('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

SELECT id, employee_id, amount, order_status,
if (order_status = 'OPEN', 'Order is in open state',
	if (order_status = 'CLOSED', 'Order is closed',
		if (order_status = 'CANCELLED', 'Order is cancelled', 'Not defined')))
as 'full_order_status'
FROM orders;
*/
/* ЗАДАНИЕ 4.
Чем NULL отличается от 0?
NULL - значение в принципе отсутствует, 0 - значение есть, оно равно 0, оно может влиять на результаты запросов и участвовать в фильтрациях.
*/
