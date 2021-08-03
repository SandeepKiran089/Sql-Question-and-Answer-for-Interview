# Instructions to setup mysql on your local computer if you have not setup yet.
1) Follow step in this video to install mysql on your local computer https://www.youtube.com/watch?v=WuBcTJnIuzo

2) SQL database which need to be dump into your local system. Use hr_dbms.sql file above. Download hr_dbms.sql file to your local computer and import it as per 
instructions given in the tutorial video

To use database use below commands

use hr_dbms;
SHOW databases;
show table status;
show tables;

Show all employee records

SELECT * FROM hr_dbms.employees;


# Write a query to extraxct the domain name from the email column

SELECT instr(email,'@') from hr_dbms.employees;
select substr(email,instr(email,'@')+1) from hr_dbms.employees;


# Write a query to fetch the dependents first_name,last_name,relationship of employee who's department is IT 
# and country_name is United States of America;

select * from hr_dbms.dependents;
select * from hr_dbms.departments;
select * from hr_dbms.employees;
select * from hr_dbms.locations;
select * from hr_dbms.countries where country_name='United States of America';


select d.first_name,d.last_name,d.relationship from hr_dbms.dependents d
inner join hr_dbms.employees e on d.employee_id= e.employee_id
inner join hr_dbms.departments dt on dt.department_id=e.department_id
inner join hr_dbms.locations lo on lo.location_id=dt.location_id
inner join hr_dbms.countries cr on cr.country_id=lo.country_id
where dt.department_name='IT' and cr.country_name='United States of America'; 


# Write a query to fetch the region_name and country_name

select region_name,country_name 
from (
select region_name, country_name from hr_dbms.regions re
, hr_dbms.countries co 
where re.region_id = co.region_id
and region_name='Asia'
and country_name='India') as rgn;

# In what order does SQL run the clauses? Select the correct option from the list of choices below:
# SELECT, FROM, WHERE, GROUP BY
# FROM, WHERE, HAVING, SELECT, LIMIT
# SELECT, FROM, INNER JOIN, GROUP BY
# FROM, SELECT, LIMIT, WHERE

use classicmodels;

select * from classicmodels.customers where country='USA';
select max(creditLimit) from classicmodels.customers;
select * from classicmodels.payments;

#227600.00
SELECT c.customerName, p.checkNumber,p.amount ,sum(c.creditLimit)
  FROM classicmodels.customers c
 INNER JOIN classicmodels.payments p
       ON c.customerNumber = p.customerNumber
 WHERE c.state in ('CA','NY','MA')
 GROUP BY c.customerName, p.checkNumber,p.amount
 HAVING p.amount<max(c.creditLimit)
 ORDER BY c.customerName
 LIMIT 5;
 
use hr_dbms;

# Fetch data of all employee who is from same department

select * from hr_dbms.employees;
select * from hr_dbms.departments;

select e.employee_id, concat(e.first_name," ",e.last_name) as employee_name,d.department_name
from hr_dbms.employees e, hr_dbms.employees e1, hr_dbms.departments d
where e.department_id=d.department_id
and e1.employee_id != e.employee_id
limit 5;

# Fetch the emaployee details from employee table who joined the organization in year 2021

select * from hr_dbms.employees;
select employee_id,first_name,last_name, hire_date from hr_dbms.employees
where hire_date between '2000-01-01' and '2000-12-31';

select * from hr_dbms.employees;

# Write an SQL query to fetch duplicate records from EmployeeDetails (without considering the primary key – EmpId).

select first_name,last_name,email,phone_number,hire_date,salary,count(*)
from hr_dbms.employees
group by first_name,last_name,email,phone_number,hire_date,salary
having count(*)>1;

# Write an SQL query to fetch only odd rows from the table.

/*  MySQL ROW_NUMBER() Function
	The ROW_NUMBER() function in MySQL is used to returns the sequential number for each row 
    within its partition. It is a kind of window function. The row number starts from 1 to the 
    number of rows present in the partition. */
    
    
select *,row_number() over(order by first_name) as row_nmm from hr_dbms.employees;
SELECT * FROM
(SELECT *, ROW_NUMBER() OVER(ORDER BY employee_id) AS rn FROM hr_dbms.employees
) temp
WHERE (temp.rn%2)=1;

# Write an SQL query to fetch only odd even from the table.

select * from
(
	select *, @rownum:=@rownum+1 as rn from hr_dbms.employees
    join (select @rownum:=0) t
) temp
where (temp.rn%2=0);


