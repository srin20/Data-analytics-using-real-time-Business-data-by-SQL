SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Anjali';

SELECT 
    *
FROM
    employees
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
    employees
WHERE
    gender = 'F' AND (first_name = 'Aruna' OR first_name='Anjali');
    
select * from employees where first_name in ('John', 'Arjun');

select * from employees where first_name not in('John', 'Mark', 'Arjun');