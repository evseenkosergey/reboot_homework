--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

sample:
1 1
2 1
1 2
2 2
1 3
2 3

create view pages_all_products as
SELECT *, 
CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page_num, 
CASE WHEN total % 2 = 0 THEN total/2 ELSE total/2 + 1 END AS num_of_pages
FROM (
  SELECT *, ROW_NUMBER() OVER(ORDER BY price DESC) AS num, 
            COUNT(*) OVER() AS total 
  FROM Laptop
     ) as a






--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)

create view distribution_by_type as
select maker, type, count, count/sum(count) over (partition by maker) as share
from (
select maker, type, count(product.model)
from
(select model, price 
from pc 
union all 
select model, price 
from printer
union all
select model, price 
from laptop ) as a
left join product on product.model = a.model 
group by maker, type
order by maker) as b

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/

request3 = """
select maker, type, share
from distribution_by_type
"""
df = pd.read_sql_query(request3, conn)
dfA = df.query('maker == "A"')
dfB = df.query('maker == "B"')
dfC = df.query('maker == "C"')
dfD = df.query('maker == "D"')
dfE = df.query('maker == "E"')

fig31 = px.pie(dfA, names='type', values='share', title='A')
fig31.show()
fig32 = px.pie(dfB, names='type', values='share', title='B')
fig32.show()
fig33 = px.pie(dfC, names='type', values='share', title='C')
fig33.show()
fig34 = px.pie(dfD, names='type', values='share', title='D')
fig34.show()
fig35 = px.pie(dfE, names='type', values='share', title='E')
fig35.show()

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов

create table ships_two_words as
select *
from ships
where name like '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select * from
(select ship
from outcomes
union 
select name 
from ships ) as a
left join ships on ships.name = a.ship
where class is null and ship like 'S%'


--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

select model from (
select *, rank(*) over (order by price desc) as rnk
from printer 
left join product on product.model = printer.model
where maker = 'A' and price > (select avg(price) from printer left join product on product.model = printer.model where maker = 'C')) as a
where rnk in (1,2,3)
