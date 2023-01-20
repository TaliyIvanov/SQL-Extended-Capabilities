USE Stock;

/*Step_1.3.2 - При анализе остатков книг на складе, было решено дополнительно заказать книги авторов, у которых суммарное число экземпляров книг меньше 20. 
В таблице должны быть отображены авторы, наименьшее и наибольшее количество их книг. Столбцы назвать Автор, Наименьшее_количество, Наибольшее_количество. 
Информацию отсортировать по фамилии автора в алфавитном порядке.*/

SELECT 
	author AS Автор, 
	MIN(amount) AS Наименьшее_количество,
    MAX(amount) AS Наибольшее_количество
FROM book
GROUP BY author
HAVING SUM(amount) < 20
ORDER BY author;

/*Step_1.3.3 - Найти авторов, у которых есть не менее двух книг с ценой более 300 и количеством не менее 3 штук на складе.  
Учитывая только эти книги, вывести автора, количество различных произведений автора, минимальную цену и количество всех экземпляров книг автора. 
Столбцы назвать Автор, Различных_книг, Минимальная_цена, Количество. 
Информацию отсортировать сначала по фамилии автора в алфавитном порядке, а затем по убыванию количества.*/

SELECT 
	author AS Автор, 
    COUNT(title) AS Различных_книг, 
    MIN(price) AS Минимальная_цена, 
    SUM(amount) AS Количество
FROM book
WHERE price > 300 AND amount >= 3
GROUP BY author
HAVING COUNT(title) >= 2
ORDER BY author, Количество DESC;

/*Step_1.3.4 - Сколько денег понадобится покупателю, чтобы приобрести все имеющиеся на складе книги, по одному экземпляру каждой? 
Вывести стоимость покупки и количество купленных книг. 
Столбцы назвать Стоимость и Количество.*/

/*Это отстойное решение, которое не требует группировки, оно подходит исключительно для этого урока*/
SELECT SUM(price) AS Стоимость, COUNT(amount) AS Количество
FROM book
WHERE amount >= 1;

/*А вот это решение уже хорошее. В БД. могут попадаться записи одних и тех же книг с разным количеством и мы можем
посчитать одну и ту же книгу дважды. Именно поэтому необходимо использовать группировку и вложенный запрос.
Изначально я пытался написать что то подобное, думал SQL умеет делать SUM(SUM(price)), но как оказалось без вложенного запроса нет!*/

SELECT 
    SUM(price) Стоимость, 
    SUM(amount) Количество
FROM (
    SELECT SUM(price) price, COUNT(amount) amount FROM book
    GROUP BY title, author
    HAVING SUM(price/amount) is NOT NULL
) new_table;

/*Step_1.3.5 - Выбрать авторов, у которых на складе  в наличии более трех наименований произведений. 
Для таких авторов вывести общее число экземпляров их книг и среднюю цену одного экземпляра (суммарную  стоимость разделить на количество экземпляров книг). 
Столбцы назвать Автор, Количество и Средняя_цена. 
Последний столбец округлить до двух знаков после запятой. 
Информацию отсортировать по фамилии автора в алфавитном порядке.*/

SELECT author Автор , SUM(amount) Количество, ROUND(SUM(price*amount)/SUM(amount), 2) Средняя_цена
FROM book
WHERE amount > 0
GROUP BY author
HAVING COUNT(title) > 3 
ORDER BY author;

/*Step_1.3.6 - Вывести авторов и перечислить их произведения через точку с запятой в алфавитном порядке. 
Столбцы назвать Автор и Книги.*/

SELECT author AS Автор, GROUP_CONCAT(DISTINCT title ORDER BY title SEPARATOR ";") AS Книги
FROM book
GROUP BY author;

/*Step_1.3.7 - Если на складе есть книги с одинаковыми названиями, вывести это название и авторов, которые написали эти книги. 
Авторов перечислить в алфавитном порядке через запятую. 
Столбцы назвать Книга и Авторы. 
Информацию отсортировать по названию книги в алфавитном порядке.*/
/*Решение:
1 - Запрос: наименование книг, Объединяем авторов в одну строку, через Group Concat.
2 - FROM book
3 - Группируем
4 - Т.к. мы сгруппировали по названию книги, то задаем условием, в котором у нас количество авторов >=2*/

SELECT title AS Книга, GROUP_CONCAT(DISTINCT author ORDER BY author SEPARATOR ",") AS Авторы
FROM book
GROUP BY title
HAVING COUNT(author) >= 2;

/*Step_1.3.8 - Для каждого автора вывести книгу с наименьшей ценой. 
Столбцы назвать Автор и Книга. 
Информацию отсортировать по фамилии автора в алфавитном порядке.*/
/*Алгоритм решения
С помощью GROUP_CONCAT() объединить в одну строку книги каждого автора, отсортировав их по возрастанию цены,
Первая книга в этой строке и будет самой дешёвой. 
Выделить ее с помощью функции SUBSTRING_INDEX().*/

SELECT author Автор, SUBSTRING_INDEX(GROUP_CONCAT(DISTINCT title ORDER BY price SEPARATOR ','), ',', 1) Книга
FROM book
GROUP BY author;

/*Step_1.3.9 - Для каждого автора вывести книгу с наибольшей ценой. 
Добавить цену книги к названию через символ "-". Столбцы назвать Автор и Книга. 
Информацию отсортировать по фамилии автора в алфавитном порядке.*/
/*Такие жесткие нагромождения конечно*/

SELECT author Автор, CONCAT(SUBSTRING_INDEX(GROUP_CONCAT(DISTINCT title ORDER BY price SEPARATOR ','), ',', -1), '-', MAX(price)) Книга
FROM book
GROUP BY author;