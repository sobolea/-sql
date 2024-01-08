-- 7.	В подключенном MySQL репозитории создать базу данных “Друзья человека”
drop DATABASE if exists `Друзья человека`;
CREATE DATABASE `Друзья человека`;
use `Друзья человека`;
-- drop table if exists `животные`;

-- 8.	Создать таблицы с иерархией из диаграммы в БД
create table if not exists `животные` (
    	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(NULL),
    	table_name char(100)

)
    ;

create table if not exists `домашние_животные` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(1))
    ;

create table if not exists `собаки` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(2))
    ;

create table if not exists `кошки` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(2))
    ;

create table if not exists `хомяки` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(2))
    ;


create table if not exists `вьючные_животные` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(1))
    ;
   
create table if not exists `лошади` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(3))
    ;

create table if not exists `верблюды` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(3))
    ;

create table if not exists `ослы` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT(3))
    ;

show tables;    

-- 9.	Заполнить низкоуровневые таблицы именами(животных), командами, которые они выполняют и датами рождения
INSERT INTO `собаки` (`имя` , `команда`,`дата рождения`) VALUES 
	('тузик', 'голос', '2020-01-01'),
	('бим', 'лежать,голос,сидеть', '2021-01-01'),
    ('лесси', 'голос', '2022-01-01');

INSERT INTO `кошки` (`имя` , `команда`,`дата рождения`) VALUES 
	('мурзик', 'спать', '2020-02-01'),
	('барсик', 'спать,есть', '2019-02-01'),
    ('котик', 'есть', '2022-02-01');

INSERT INTO `хомяки` (`имя` , `команда`,`дата рождения`) VALUES 
	('боб', 'пить', '2020-03-01'),
	('жук', 'пить,есть', '2019-03-01'),
    ('крок', 'есть', '2022-03-01');

INSERT INTO `лошади` (`имя` , `команда`,`дата рождения`) VALUES 
	('люк', 'пить', '2020-04-01'),
	('бурка', 'пить,гулять', '2021-04-01'),
    ('сивка', 'есть,гулять', '2022-04-01');

INSERT INTO `верблюды` (`имя` , `команда`,`дата рождения`) VALUES 
	('ибраг', 'пить', '2021-05-01'),
	('велли', 'пить,есть', '2019-05-01'),
    ('вилли', 'есть', '2022-05-01');

INSERT INTO `ослы` (`имя` , `команда`,`дата рождения`) VALUES 
	('олли', 'пить', '2020-06-01'),
	('олла', 'пить,есть,гулять', '2019-06-01'),
    ('олло', 'есть,спать', '2022-06-01');

-- select * from `ослы`;
select '-*';

-- 10.	Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
drop table if exists `верблюды`;    

insert into `вьючные_животные`
select  null,`имя` , `команда`,`дата рождения`,1  from `лошади`
union 
select  null,`имя` , `команда`,`дата рождения`,1  from `ослы`
;

select * from `вьючные_животные`;
select "-11-" as "";
-- 11.Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице
/*
create table `молодые_животные`
(select *,TIMESTAMPDIFF(MONTH, `дата рождения`,now()) as age  from `собаки`  where TIMESTAMPDIFF(MONTH, `дата рождения`,now()) >12 and  TIMESTAMPDIFF(MONTH, `дата рождения`,now()) <37
union
select *,TIMESTAMPDIFF(MONTH, `дата рождения`,now())  as age  from `кошки`  where TIMESTAMPDIFF(MONTH, `дата рождения`,now()) >12 and  TIMESTAMPDIFF(MONTH, `дата рождения`,now()) <37
union
select *,TIMESTAMPDIFF(MONTH, `дата рождения`,now())  as age  from `хомяки` where TIMESTAMPDIFF(MONTH, `дата рождения`,now()) >12 and  TIMESTAMPDIFF(MONTH, `дата рождения`,now()) <37
union
select *,TIMESTAMPDIFF(MONTH, `дата рождения`,now())  as age  from `лошади` where TIMESTAMPDIFF(MONTH, `дата рождения`,now()) >12 and  TIMESTAMPDIFF(MONTH, `дата рождения`,now()) <37
union
select *,TIMESTAMPDIFF(MONTH, `дата рождения`,now())  as age  from `ослы` where TIMESTAMPDIFF(MONTH, `дата рождения`,now()) >12 and  TIMESTAMPDIFF(MONTH, `дата рождения`,now()) <37
);

select * from `молодые_животные`;
но так получается не универсальный способ для малого количества таблиц... Поэтому применяем другой!
*/

drop table if exists `молодые_животные`;
create table `молодые_животные` 	
	(id INT  PRIMARY KEY AUTO_INCREMENT,
	`имя` CHAR(30),
    	`команда` TEXT,
    	`дата рождения` DATE,
    	parent_id INT DEFAULT( NULL),
     	age INT);

DELIMITER $$

DROP PROCEDURE IF EXISTS young$$

CREATE PROCEDURE young()
BEGIN

    DECLARE done INTEGER DEFAULT 0;
    DECLARE v_table VARCHAR(100) DEFAULT "";
  DECLARE mycursor CURSOR FOR
 	select table_name from information_schema.columns WHERE column_name ="Parent_id";
		
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN mycursor;
    
  fetch_loop: LOOP
    FETCH mycursor INTO v_table;
    IF done=1 THEN
      LEAVE fetch_loop;
    END IF;
    
      SET @sql_query = concat("insert into `молодые_животные` SELECT distinct null,`имя` , `команда`,`дата рождения`,1,TIMESTAMPDIFF(MONTH, `дата рождения`,now()) FROM ", v_table, " where parent_id>1 and TIMESTAMPDIFF(MONTH, `дата рождения`,now()) >12 and  TIMESTAMPDIFF(MONTH, `дата рождения`,now()) <37");
      PREPARE stmt FROM @sql_query;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    
  END LOOP;
  CLOSE mycursor;

END$$
DELIMITER ;

call young();

select * from `молодые_животные`;
select '-12-' as "";

-- 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблитуццам. 
-- снова применяем уже готовую процедуру, меняя только условие.
DELIMITER $$

DROP PROCEDURE IF EXISTS all_anim$$

CREATE PROCEDURE all_anim()
BEGIN

    DECLARE done INTEGER DEFAULT 0;
    DECLARE v_table VARCHAR(100) DEFAULT "";
  DECLARE mycursor CURSOR FOR
 	select table_name from information_schema.columns WHERE column_name ="Parent_id";
		
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN mycursor;
    
  fetch_loop: LOOP
    FETCH mycursor INTO v_table;
    IF done=1 THEN
      LEAVE fetch_loop;
    END IF;
    
      SET @sql_query = concat('insert into `животные` (SELECT distinct null,`имя` , `команда`,`дата рождения`,NULL,"',trim(v_table),'" FROM ', v_table, " where parent_id>1)");
      PREPARE stmt FROM @sql_query;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    
  END LOOP;
  CLOSE mycursor;

END$$


call all_anim();

select * from `животные`;

