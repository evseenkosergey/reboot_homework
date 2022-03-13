--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT case when GRADE < 8 then 'NULL' else NAME end, GRADE, MARKS
FROM STUDENTS
JOIN GRADES on STUDENTS.Marks BETWEEN GRADES.Min_Mark and GRADES.Max_Mark
ORDER BY GRADE DESC, NAME;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

select distinct city
from station
where city not like 'A%' 
and city not like 'E%' 
and city not like 'Y%' 
and city not like 'U%'
and city not like 'O%'
and city not like 'I%'
order by city;

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct city
from station
where city not like '%a' 
and city not like '%e' 
and city not like '%y' 
and city not like '%u'
and city not like '%o'
and city not like '%i'
order by city;

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem


--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct city
from station
where city not like 'A%' 
and city not like 'E%' 
and city not like 'Y%' 
and city not like 'U%'
and city not like 'O%'
and city not like 'I%'
and city not like '%a' 
and city not like '%e' 
and city not like '%y' 
and city not like '%u'
and city not like '%o'
and city not like '%i'
order by city;

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name
from employee
where salary > 2000 and months <10

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

повтор
