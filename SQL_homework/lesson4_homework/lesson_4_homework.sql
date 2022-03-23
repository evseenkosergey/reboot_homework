--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select a.model, maker, type
from
(SELECT model FROM pc
union all
SELECT model FROM printer 
union all
select model from laptop) a
left join product on product.model = a.model

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select *,
case when price > (select avg(price) from pc)
then 1
else 0
end flag
from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select ship
from (
select distinct ship
from outcomes
union 
select name 
from ships ) as a
left join ships on ships.name = a.ship
where class is null

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.


with battle_date_dict as
(select name, extract (year from date) AS year
from battles)
select name
from battle_date_dict
where year not in (select distinct launched from ships)


--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select distinct battle
from outcomes
left join battles on battles.name = outcomes.battle
left join ships on ships.name = ships.name
where class = 'Kongo'

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as
select product.model, price,
case when price > 300
then 1
else 0
end flag
from (select model, price 
from printer
union 
select model, price 
from pc
union 
select model, price 
from laptop) as a
left join product on product.model = a.model

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as
select product.model, price,
case when price > (select avg(price) from (select price from printer union select price from pc union select price from laptop) p)
then 1
else 0
end flag
from (select model, price 
from printer
union 
select model, price 
from pc
union 
select model, price 
from laptop) as a
left join product on product.model = a.model


--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select printer.model
from printer
left join product on product.model = printer.model
where maker = 'A' and price > (select avg(price) from (select * 
														from printer 
														left join product on product.model = printer.model
														where maker = 'D' or maker = 'C') p )
														

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select product.model
from (
select model, price
from printer
union 
select model, price 
from pc
union 
select model, price 
from laptop) as a
left join product on product.model = a.model
where maker = 'A' and price > (
select avg(price) 
from (
select model, price
from printer
union 
select model, price 
from pc
union 
select model, price 
from laptop) as a
left join product on product.model = a.model
where maker = 'D' or maker = 'C' and type = 'printer')
														
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди всех продуктов производителя = 'A' (printer & laptop & pc)

select avg(price)
from (
select model, price
from printer
union 
select model, price 
from pc
union 
select model, price 
from laptop) as a
left join product on product.model = a.model
where maker = 'A'

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create view count_products_by_makers as
select maker, count(product.model)
from (
select model, price
from printer
union 
select model, price 
from pc
union 
select model, price 
from laptop) as a
left join product on product.model = a.model
group by maker

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

done

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

create table printer_updated as
select *
from printer 
where model not in 
(select product.model
from printer 
left join product on product.model = printer.model
where maker = 'D')

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)

create view printer_updated_with_makers as
select code, printer_updated.model, color, printer_updated.type, price, maker
from printer_updated
left join product on product.model = printer_updated.model


--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

create view sunk_ships_by_classes as
select count, class
from (
select class as cls, count(ship),
case when class is null 
then 0::varchar
else class
end as class
from outcomes
left join ships on ships.name = outcomes.ship
where result = 'sunk'
group by cls ) as a



--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

done

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag as
select *,
case when numguns >= 9
then 1
else 0
end flag
from classes

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

done 

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count(name)
from ships
where name like 'O%' or name like 'M%'

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count(name)
from ships
where name like '% %' 

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

select launched, count(name)
from ships
group by launched
order by launched
