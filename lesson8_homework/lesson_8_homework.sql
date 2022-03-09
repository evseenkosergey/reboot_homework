--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select Department, Employee, Salary
from
(select *, dense_rank () over (partition by Department order by Salary desc) as rnk
from (
select department.name as Department, employee.name as Employee, Salary
from employee
left join department on department.id = employee.departmentid ) as a) as b
where rnk <= 3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

select member_name, status, sum(unit_price * amount) as costs
from FamilyMembers
full join Payments on payments.family_member = FamilyMembers.member_id
group by member_name, status


select member_name, status, sum(amount * unit_price) as costs
from FamilyMembers
join Payments
on FamilyMembers.member_id = Payments.family_member
where YEAR(date) = 2005
group by member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select name
from (
select name, count(id) as cnt
from Passenger
group by name
having cnt > 1) as a

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count from (
select first_name, count (id) as count
from Student
group by first_name
having first_name = 'Anna') as a

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(distinct classroom) as count
from Schedule
where date = '2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

повтор

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT 
(floor(avg((YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))))
    ) as age
from FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

select good_type_name, sum(amount*unit_price) as costs
FROM Payments
left join Goods on goods.good_id = Payments.good
LEFT JOIN GoodTypes on GoodTypes.good_type_id = Goods.type
where YEAR(date) = 2005
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

SELECT 
(floor(min((YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))))
    ) as year
from Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

select (floor(max((YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))))
    ) as max_year 
from Student
LEFT JOIN Student_in_class on Student_in_class.student = student.id
LEFT JOIN class on class.id = Student_in_class.class
where name like '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

select status, member_name, sum(unit_price*amount) as costs
from Payments
LEFT JOIN FamilyMembers on FamilyMembers.member_id = Payments.family_member
left join goods on Goods.good_id = Payments.good
LEFT JOIN GoodTypes on GoodTypes.good_type_id = Goods.type
where good_type_name = 'entertainment'
group by status, member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from company where id in (
select company from (
select company, count(*) as count
from trip
group by company
having count(*) = (
select min(a.count) from (
select company, count(*) as count
from Trip
group by company) as a )) as b)

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select classroom
from (
select classroom, count(*) as count
from Schedule
group by classroom
having count in (select max(count) from (
select classroom, count(*) as count
from Schedule
group by classroom
order by count desc) as a) 
order by count desc) as b



--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select last_name
from Schedule
left join teacher on Teacher.id = Schedule.teacher
left join Subject on Subject.id = Schedule.subject
where name = 'Physical Culture'
group by last_name
order by last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

select concat(last_name,'.', substring(first_name,1,1),'.', substring(middle_name,1,1), '.') as name
from Student
order by name