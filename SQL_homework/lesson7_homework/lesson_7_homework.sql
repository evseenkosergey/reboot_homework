--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select email 
from
(select email, count(*) as cnt
from person
group by email) as a
where cnt > 1


--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

вариант 1:

with mng_dict as
(select id, name as mng_name, salary as mng_salary
from employee
where managerid is null)
select name as Employee
from employee
left join mng_dict on mng_dict.id = employee.managerid
where salary > mng_salary

вариант 2:
SELECT a.NAME AS Employee
FROM Employee AS a JOIN Employee AS b
ON a.ManagerId = b.Id
AND a.Salary > b.Salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

select score, dense_rank(*) over (order by score desc) as rank
from Scores

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select firstName, lastName, city, state
from Person
left join Address on Address.personId = Person.personId
