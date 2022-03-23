--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
--
select name, class
from ships
where launched > 1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
--
select name, class
from ships
where launched > 1920 and launched <= 1942

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
--
select class, count(name)
from ships
group by class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
--
select class, country 
from classes
where bore > 15

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
--

select ship
from outcomes
where battle = 'North Atlantic' and result = 'sunk'


-- Задание 6: Вывести название (ship) последнего потопленного корабля
--

select ship 
from outcomes
join battles on battles.name = outcomes.battle
where date = (
	select max(date)
	from outcomes
	join battles on battles.name = outcomes.battle
	where result = 'sunk') and result = 'sunk'


-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
--
	
select ship, class
from outcomes
join battles on battles.name = outcomes.battle
left join ships on ships.name = outcomes.ship
where date = (
	select max(date)
	from outcomes
	join battles on battles.name = outcomes.battle
	where result = 'sunk') and result = 'sunk'


-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
--
select ship, classes.class
from outcomes
left join ships on ships.name = outcomes.ship
left join classes on classes.class = ships.class
where result = 'sunk' and bore >= 16

-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
--
select class
from classes
where country = 'USA'
group by class


-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class

select name, ships.class
from ships
left join classes on classes.class = ships.class
where country = 'USA'





-- Допзадание: недоделанные пункты из урока
-- Задание 18: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D'. Вывести model
--
select printer.model 
from printer
join product on product.model = printer.model
where price > (select avg(price)
				from printer
				join product on product.model = printer.model
				where maker = 'D')



-- Задание 19: Найдите производителей, которые производили бы как PC со скоростью (speed) не менее 750, так и laptop со скоростью (speed) не менее 750. Вывести maker
--
				
select subq1.maker
from ( 
	select distinct maker 
	from product 
	join pc on pc.model = product.model
	where speed >= 750) as subq1
	join ( 
	select distinct maker 
	from product 
	join laptop on laptop.model = product.model
	where speed >= 750) as subq2 
	on subq1.maker = subq2.maker
	
	
			
				
-- Задание 20: Найдите средний размер hd PC каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

select maker, avg(hd)
from pc
join product on product.model = pc.model
where maker in (
	select distinct maker
	from printer
	join product on product.model = printer.model)
group by maker


