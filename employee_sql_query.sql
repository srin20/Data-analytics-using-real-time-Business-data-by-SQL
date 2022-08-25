SELECT 
    *
FROM
    employee_upload
WHERE
    first_name = 'Anjali';

SELECT 
    *
FROM
    employee_upload
WHERE
    first_name = 'Arjun';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Anjali' AND gender = 'F';
    
SELECT 
    *
FROM
    employee_upload
WHERE
    gender = 'F' AND (first_name = 'Aruna' OR first_name='Anjali');
    
select * from employees where first_name in ('John', 'Arjun');

select * from employees where first_name not in('John', 'Mark', 'Arjun');

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

   

SELECT 
    *
FROM
    employees_upload
WHERE
    emp_no NOT BETWEEN '10003' AND '10009';

   

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';
