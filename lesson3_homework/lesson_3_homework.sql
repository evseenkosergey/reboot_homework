--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

with class_dict as (
SELECT distinct class
FROM ships )

select class, count
from (
select class_dict.class, ship_cnt,
	case when ship_cnt is null
	then 0
	else ship_cnt
	end count
from 
(SELECT class, count(ship) as ship_cnt
FROM outcomes
LEFT JOIN ships ON ships.name = outcomes.ship
where result = 'sunk'
group by class) as a
right join class_dict on class_dict.class = a.class
) as b

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. 
--Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select class, min(launched)
from ships
group by class



select distinct class
from ships
where class not in (
	select distinct class
	from ships
	where class = name) 



--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

select a.class, sunk_cnt
from (
(select class, count(name) AS name_cnt
from ships
group by class
having count(name) >= 3 ) a
join (
SELECT class, count(ship) as sunk_cnt
FROM outcomes
LEFT JOIN ships ON ships.name = outcomes.ship
where result = 'sunk'
group by class) as b on b.class = a.class
)

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

with name_dict as (
select a.name, class
from (select distinct name
from ships
union
select distinct ship
from outcomes) as a left join ships on ships.name = a.name
),  
max_numguns as (
select displacement, max(numguns) as max_numguns
from (
select name, displacement, max(numguns) as numguns
from name_dict 
left join classes on classes.class = name_dict.class
group by name, displacement
order by displacement ) as b
where numguns is not null
group by displacement )
select name, numguns, classes.displacement
from name_dict
left join classes on classes.class = name_dict.class
join max_numguns on max_numguns.max_numguns = classes.numguns and max_numguns.displacement = classes.displacement
order by classes.displacement



--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
select distinct maker 
from printer 
left join product on product.model = printer.model
where maker in (

select distinct maker 
from pc 
left join product on product.model = pc.model
where ram = (select min(ram) from pc) 
and speed = (select max(speed) from (
	select * 
	from pc 
	left join product on product.model = pc.model
	where ram = (select min(ram) from pc))c 
	) 
	)

