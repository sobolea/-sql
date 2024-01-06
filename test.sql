-- 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”
drop DATABASE if exists Друзья человека;
CREATE DATABASE Друзья человека;
use Друзья человека;
-- drop table if exists животные;

-- 8. Создать таблицы с иерархией из диаграммы в БД
create table if not exists животные (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(NULL))
    ;

create table if not exists домашние животные (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(1))
    ;

create table if not exists собаки (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(2))
    ;

create table if not exists кошки (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(2))
    ;

create table if not exists хомяки (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(2))
    ;


create table if not exists вьючные животные (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(1))
    ;
   
create table if not exists лошади (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(3))
    ;

create table if not exists верблюды (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(3))
    ;

create table if not exists ослы (
 id INT PRIMARY KEY AUTO_INCREMENT,
 имя CHAR(30),
     команда TEXT,
     дата рождения DATE,
     parent_id INT DEFAULT(3))
    ;

show tables;    

-- 9. Заполнить низкоуровневые таблицы именами(животных), командами, которые они выполняют и датами рождения
INSERT INTO собаки (`имя` , команда,`дата рождения`) VALUES 
 ('тузик', 'голос', '2020-01-01'),
 ('бим', 'лежать,голос,сидеть', '2019-01-01'),
    ('лесси', 'голос', '2021-01-01');

INSERT INTO кошки (`имя` , команда,`дата рождения`) VALUES 
 ('мурзик', 'спать', '2020-02-01'),
 ('барсик', 'спать,есть', '2019-02-01'),
    ('котик', 'есть', '2021-02-01');

INSERT INTO хомяки (`имя` , команда,`дата рождения`) VALUES 
 ('боб', 'пить', '2020-03-01'),
 ('жук', 'пить,есть', '2019-03-01'),
    ('крок', 'есть', '2021-03-01');

INSERT INTO лошади (`имя` , команда,`дата рождения`) VALUES 
 ('люк', 'пить', '2020-04-01'),
 ('бурка', 'пить,гулять', '2019-04-01'),
    ('сивка', 'есть,гулять', '2021-04-01');

INSERT INTO верблюды (`имя` , команда,`дата рождения`) VALUES 
 ('ибраг', 'пить', '2020-05-01'),
 ('велли', 'пить,есть', '2019-05-01'),
    ('вилли', 'есть', '2021-05-01');

INSERT INTO ослы (`имя` , команда,`дата рождения`) VALUES 
 ('олли', 'пить', '2020-06-01'),

 ('олла', 'пить,есть,гулять', '2019-06-01'),
    ('олло', 'есть,спать', '2021-06-01');

-- select * from ослы;
select '--------';

-- 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
drop table if exists верблюды;    

insert into вьючные животные
select  null,`имя` , команда,дата рождения ,parent_id from лошади
union 
select  null,`имя` , команда,дата рождения,parent_id from ослы
;

select * from вьючные животные;
select '--------';

-- 11.Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице
