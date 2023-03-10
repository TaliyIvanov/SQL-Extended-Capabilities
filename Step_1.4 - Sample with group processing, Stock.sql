USE summary;

/*Step_1.4.2 - Для каждой профессиональной области создать "усредненный" портрет соискателя. 
Найти количество соискателей, среднюю минимальную заработную плату и "среднюю" дату рождения по каждой профессиональной области. 
Среднюю минимальную заработную плату округлить до целого. 
Столбцы назвать Специализация, Количество, Мин_зарплата, Дата_рождения. 
Информацию отсортировать по убыванию минимальной заработной платы.*/

/*Алгоритм вычисления "средней даты рождения":
из каждой даты рождения выделить год и найти среднее арифметическое года для каждой профессиональной области;
из каждой даты рождения выделить количество дней, прошедших с начала года до дня рождения,  и найти среднее арифметическое количества дней для каждой профессиональной области;
построить новую дату по полученным средним значениям.*/

SELECT 
	specialisation Специализация, 
    COUNT(applicant) Количество, 
    ROUND(AVG(min_salary), 0) Мин_зарплата, 
    MAKEDATE(AVG(YEAR(date_birth)), AVG(DAYOFYEAR(date_birth))) Дата_рождения
FROM resume
GROUP BY specialisation
ORDER BY Мин_зарплата DESC;

/*Step_1.4.3 - Для каждой профессиональной области создать "усредненный" портрет соискателя. 
Найти среднюю минимальную заработную плату и "среднюю" дату рождения по каждой профессиональной области. 
Среднюю минимальную заработную плату округлить до целого. 
Столбцы назвать Специализация, Мин_зарплата, Дата_рождения. 
Информацию отсортировать по убыванию минимальной заработной платы.*/

/*Немного теории
Значения типа DATE можно представить в форме unix-времени.
Unix-время определяется как количество секунд, прошедших с полуночи (00:00:00 UTC) 1 января 1970 года (четверг); этот момент называют «эпохой Unix». Например, 2 августа 2021 года в формате unix-времени - это число  1627862400.
В SQL для перевода из обычного формата времени используется функция UNIX_TIMESTAMP(дата).  Для обратного перевода используется функция FROM_UNIXTIME(число). Например
UNIX_TIMESTAMP('2021-08-02') = 1627862400
UNIX_TIMESTAMP('1964-08-02') = 0
FROM_UNIXTIME(1527869999) = '2018-06-01 16:19:59'
Обратите внимание, что для всех дат ранее 1 января 1970 года и позже 19 января 2038 равно 0.*/

/*по сути задачка на то, чтобы показать функцию Unix ну такое себе крч*/

/*Алгоритм вычисления "средней" даты рождения:
перевести каждую дату в unix-время;
найти среднее арифметическое для найденных значений по каждой профессиональной области;
перевести среднее арифметическое дат в обычный формат.
К сожалению, при таком алгоритме для всех людей, рожденных ранее 1 января 1970 года, будет считаться, что они родились 1 января 1970 года...*/

SELECT 
	specialisation Специализация, 
	ROUND(AVG(min_salary), 0) Мин_зарплата,
    FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(date_birth))) Дата_рождения
FROM resume
GROUP BY specialisation
ORDER BY Мин_зарплата DESC;

/*Step_1.4.4 - Для каждой профессиональной области создать "усредненный" портрет соискателя. 
Найти среднюю минимальную заработную плату и "среднюю" дату рождения по каждой профессиональной области. 
Среднюю минимальную заработную плату округлить до целого. 
Дату рождения вывести в формате число, название месяца и год через пробел (например, 3 June 2001). 
Столбцы назвать Специализация, Мин_зарплата, Дата_рождения. Информацию отсортировать по убыванию минимальной заработной платы.*/

SELECT 
	specialisation Специализация, 
	ROUND(AVG(min_salary), 0) Мин_зарплата,
    FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(date_birth)), '%e %M %Y') Дата_рождения
FROM resume
GROUP BY specialisation
ORDER BY Мин_зарплата DESC;

/*Step_1.4.5 - Найти разницу в возрасте (в годах)  между самым молодым и самым возрастным соискателем в каждой профессиональной области. 
Вывести название профессиональной области и разницу в возрасте. 
Последний столбец назвать Количество_лет. 
Информацию отсортировать по возрастанию разницы.*/

SELECT 
	specialisation, 
    MAX(YEAR(date_birth))-MIN(YEAR(date_birth)) Количество_лет
FROM resume
GROUP BY specialisation
ORDER BY Количество_лет;

/*Step_1.4.6 - Вывести профессиональные области, в которых есть соискатели, не меняющие специализацию. 
Посчитать, сколько соискателей не меняли специализацию. 
Если человек работал в указанной профессиональной области с 23 лет и ранее - будем считать, что он специализацию не менял (в поле experience хранится количество лет, которое человек работает по указанной специализации). 
Текущим считать 2021 год. 
Вывести профессиональную область и вычисленное количество таких соискателей, последний столбец назвать Количество. 
Информацию отсортировать по убыванию количества соискателей.*/

SELECT 
	specialisation,
    COUNT(applicant) Количество
FROM resume 
WHERE 2021 - YEAR(date_birth) - experience <= 23
GROUP BY specialisation
ORDER BY Количество DESC;

/*Step_1.4.7 - Для каждой должности найти "лучшего" кандидата. Кандидат считается "лучшим", если у него самый большой опыт работы. 
Если опыт работы одинаков "лучшим" считается тот, у кого минимальная заработная плата ниже. 
Если совпадает и эта характеристика, предпочтение отдать более молодому соискателю. 
Вывести профессиональную область, должность и фамилию и имя отчество соискателя. 
Последний столбец назвать Кандидат. 
Информацию отсортировать сначала по профессиональной области в алфавитном порядке, затем по названию должности в алфавитном порядке. */

/*Странная фигня, у меня долго не принималось решение с группировкой по одной колонкой. Не понимаю зачем здесь необходимо группировать по двум колонкам*/

SELECT 
	specialisation,
    position,
    SUBSTRING_INDEX(GROUP_CONCAT(DISTINCT applicant ORDER BY experience DESC, min_salary, date_birth SEPARATOR ","), ",", 1) Кандидат  
FROM resume
GROUP BY position, specialisation
ORDER BY specialisation, position;

/*Step_1.4.8 - Составить список соискателей старше 50 для приглашения в госпрограмму трудоустройства.
А также сформировать резерв из тех, кто старше 45. (Текущим считаем 2021 год)*/

SELECT
    CASE /* формируем название возрастных групп */ 
       WHEN 2021-YEAR(date_birth) > 50 THEN "старше 50"
       WHEN 2021-YEAR(date_birth) > 45 THEN "старше 45"
    END AS Возраст, 
    GROUP_CONCAT(applicant) 
FROM resume
WHERE /* выбираем только людей, ПОДХОДЯЩИХ ПО ВОЗРАСТУ*/
     2021-YEAR(date_birth) > 45
GROUP BY  /* группируем по возрастным группам */
   CASE 
       WHEN 2021-YEAR(date_birth) > 50 THEN "старше 50"
       WHEN 2021-YEAR(date_birth) > 45 THEN "старше 45"
    END;