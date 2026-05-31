create database project;

use project;

select *from hr;
describe hr_backup;

## duplicate table hr
CREATE TABLE hr LIKE hr_backup;
INSERT INTO hr SELECT * FROM hr_backup;

DROP TABLE hr;

## ngganti nama kolom
alter table hr
change column ï»¿id emp_id varchar(20) null;

describe hr;

select birthdate from hr;


## switch buat update isi table (birthdate, hire_date)
SET sql_safe_updates = 0;
SET sql_mode = '';

update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
	when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
    END;
    
update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
    END;

SELECT hire_date FROM hr;

## ngebenerin tipe data tablenya (birthdate)
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT birthdate FROM hr;

DESCRIBE hr;

## udpate kolom termdate dari string jadi DATE
-- 1. Matikan strict mode dulu
SET sql_mode = '';

-- 2. Update semua sekaligus
UPDATE hr
SET termdate = CASE
    WHEN termdate IS NULL OR termdate = '' 
        THEN '0000-00-00'
    ELSE 
        DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
END;

-- 3. ALTER ke tipe DATE
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

describe hr;

SELECT *FROM hr;
drop table hr;

ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
    FROM hr;

SELECT count(*) FROM hr 
	WHERE age < 18;


use project;

select * from hr;

-- mencari rata rata umur setiap departemen yang ada "ing"nya di belakang namanya seperti "engineering, marketing,etc"	
select department, avg(age) as average_age
from hr
where department like "%ing"
group by department
having average_age > 20;






