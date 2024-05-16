CREATE DATABASE IF NOT EXISTS ee_university
    WITH
    OWNER = admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

DROP SCHEMA IF EXISTS public;

CREATE SCHEMA IF NOT EXISTS university;

CREATE TABLE IF NOT EXISTS university.faculty(
	id int primary key,
	name varchar(50),
	cost_of_education numeric(15,2));

CREATE TABLE IF NOT EXISTS university.course(
	id int primary key,
	number varchar(1),
	faculty_id int REFERENCES university.faculty(id));

CREATE TABLE IF NOT EXISTS university.student(
	id int primary key,
	surname varchar(100),
	name varchar(100),
	patronymic varchar(100),
	is_budget boolean,
	course_id int REFERENCES university.course(id));

INSERT INTO university.faculty values(1, 'Инженерный', 30000);
INSERT INTO university.faculty values(2, 'Экономический', 49000);

INSERT INTO university.course values(1, '1', 1);
INSERT INTO university.course values(2, '1', 2);
INSERT INTO university.course values(3, '4', 2);

INSERT INTO university.student values(1, 'Петров', 'Петр', 'Петрович', true, 1);
INSERT INTO university.student values(2, 'Иванов', 'Иван', 'Иваныч', false, 1);
INSERT INTO university.student values(3, 'Михно', 'Сергей', 'Иваныч', true, 3);
INSERT INTO university.student values(4, 'Стоцкая', 'Ирина', 'Юрьевна', false, 3);
INSERT INTO university.student values(5, 'Младич', 'Настасья', null, false, 2);

SELECT 
	university.student.surname,
	university.student.name,
	university.student.patronymic
FROM university.student
	join university.course on university.student.course_id = university.course.id
	join university.faculty on university.course.faculty_id = university.faculty.id
WHERE university.faculty.cost_of_education > 30000
ORDER BY university.student.id ASC;

UPDATE university.student
	SET course_id = 2
	WHERE surname = 'Петров';

SELECT
	university.student.surname,
	university.student.name,
	university.student.patronymic
FROM university.student
WHERE university.student.surname ISNULL OR university.student.patronymic ISNULL;

SELECT
	university.student.surname,
	university.student.name,
	university.student.patronymic
FROM university.student
WHERE university.student.surname LIKE '%ван%' 
	OR university.student.name LIKE '%ван%'
	OR university.student.patronymic LIKE '%ван%';

DELETE FROM university.student;
DELETE FROM university.course;
DELETE FROM university.faculty;