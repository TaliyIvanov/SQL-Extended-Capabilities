# SQL-Extended-Capabilities
Здесь вы можете ознакомиться с моими реальными навыками по SQL.
Я буду выкладывать свое прохождение данного курса и решения задач. А так же, важные, по моему мнению, ссылки на различные учебные материалы, которые пригодятся мне в будущем.
По мере изучаения GitHub возможно буду вести здесь свой конспект лекций.

**Полезные ссылки:**
-курс Interactive SQL Trainer: https://stepik.org/course/63054/syllabus
-руководство по стилю SQL: https://www.sqlstyle.guide/ru/
-отформатировать ваш запрос с помощью: https://codebeautify.org/sqlformatter

**Темы, которые изучаются на курсе**
-Основы SQL, расширенные возможности
-Запросы SQL к связанным таблицам
-Расширенные возможности SQL(Оконные функции, Хранимые функции, Тригеры, Оптимизация запросов)

#Step_1.1 - Простая выборка: "Склад"/Simple Sample: "Stock"

Содержание урока
В этом уроке предлагается написать SQL запросы для таблицы book, в которой хранится информация о книгах на некотором складе. Большинство заданий придуманы пользователями курса "Интерактивный тренажер по SQL"

Новые темы:

-оператор CASE;

-строковая функция CHAR_LENGTH();

-строковые функции CONCAT() и CONCAT_WS();

-строковые функции LEFT() и RIGHT();

-строковая функция SUBSTRING_INDEX().

#Step_1.2 - Простая выборка: "Склад"/Simple Sample: "Summary"

Содержание урока
В этом уроке предлагается написать SQL запросы для таблицы resume, в которой хранится информация о резюме для трудоустройства. Каждое резюме содержит имя соискателя, профессиональную область, в которой он ищет работу, должность, минимальную зарплату, стаж работы в этой должности, а также дату рождения соискателя. Дату рождения, как правило, в резюме не указывают, но здесь она включена, чтобы повторить и изучить новые функции работы с датами.

Новая тема - регулярные выражения:

-наличие текста в строке;

-начало и конец строки (^, $);

-наличие заданных символов в строке ([символы]);

-наличие интервала символов в строке ([интервал]);

-отсутствие символов и интервала символов в строке ([^символы], [^интервал]);

-проверка соответствия одному из нескольких шаблонов ( |);

-соответствие одному любому символу(.);

-повторение символов 0 и более раз (символ*);

-повторение символов один и более раз (символ+);

-наличие или отсутствие символов (символ?);

-специальный символ для выделения слова (\\b).