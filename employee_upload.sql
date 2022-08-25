DROP DATABASE IF EXISTS employees;
CREATE DATABASE IF NOT EXISTS employees; 
USE employees;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      CHAR(4)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
) 
; 

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
) 
; 

CREATE OR REPLACE VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

# shows only the current department for each employee
CREATE OR REPLACE VIEW current_dept_emp AS
    SELECT l.emp_no, dept_no, l.from_date, l.to_date
    FROM dept_emp d
        INNER JOIN dept_emp_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;

flush /*!50503 binary */ logs;

INSERT INTO `employees` VALUES (10001,'1953-09-02','Georgi','Facello','M','1986-06-26'),
(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21'),
(10003,'1959-12-03','Parto','Bamford','M','1986-08-28'),
(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01'),
(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12'),
(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02'),
(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10'),
(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15'),
(10009,'1952-04-19','Simanti','Peac','F','1985-02-18'),
(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24'),
(10011,'1953-11-07','Mary','Sluis','F','1990-01-22'),
(10012,'1960-10-04','Patricio','Bridgland','M','1992-12-18'),
(10013,'1963-06-07','Eberhardt','Terkki','M','1985-10-20'),
(10014,'1956-02-12','Berni','Genin','M','1987-03-11'),
(10015,'1959-08-19','Guoxiang','Nooteboom','M','1987-07-02'),
(10016,'1961-05-02','Abhijit','Singh','M','1995-01-27'),
(10017,'1958-07-06','Anjali','Basu','F','1993-08-03'),
(10018,'1954-06-19','Arjun','Mishra','M','1987-04-03'),
(10019,'1953-01-23','Lillian','Haddadi','M','1999-04-30'),
(10020,'1952-12-24','Mayuko','Warwick','M','1991-01-26');

INSERT INTO `dept_emp` VALUES (10001,'d002','1999-12-26','9999-01-01'),
(10002,'d004','1992-03-29','9999-01-01'),
(10003,'d005','1989-07-07','9999-01-01'),
(10004,'d009','1990-10-10','1994-08-12'),
(10005,'d005','1993-07-27','9999-01-01'),
(10006,'d009','1987-01-12','1993-07-27'),
(10007,'d005','1988-06-16','9999-01-01'),
(10008,'d004','1997-03-04','9999-01-01'),
(10009,'d004','1993-12-08','9999-01-01'),
(10010,'d007','1991-04-22','9999-01-01'),
(10011,'d004','1996-01-14','9999-01-01');

INSERT INTO `dept_manager` VALUES (10001,'Senior Staff','1995-09-12','9999-01-01'),
(10002,'Staff','1987-09-12','1995-09-12'),
(10003,'Senior Staff','1999-09-19','9999-01-01'),
(10004,'Staff','1994-09-19','1999-09-19'),
(10005,'Senior Staff','1987-01-19','9999-01-01'),
(10006,'Senior Engineer','1995-05-14','9999-01-01'),
(10007,'Senior Engineer','1994-12-03','2002-03-05'),
(10008,'Senior Staff','2001-05-09','9999-01-01'),
(10009,'Staff','1992-05-09','2001-05-09'),
(10010,'Senior Staff','1992-03-10','1997-10-09'),
(10011,'Staff','1985-03-10','1992-03-10'),
(10012,'Senior Engineer','1985-05-08','9999-01-01'),
(10013,'Staff','1999-06-29','9999-01-01'),
(10014,'Engineer','1993-11-27','9999-01-01');

INSERT INTO `SALARY` VALUES (10830,57684,'1996-08-22','1997-08-22'),
(10830,58758,'1997-08-22','1998-08-22'),
(10830,59375,'1998-08-22','1999-08-22'),
(10830,63309,'1999-08-22','2000-08-21'),
(10830,67321,'2000-08-21','2001-08-21'),
(10830,71748,'2001-08-21','9999-01-01'),
(10831,82330,'1998-02-22','1999-02-22'),
(10831,83359,'1999-02-22','2000-02-22'),
(10831,84288,'2000-02-22','2001-02-21'),
(10831,87734,'2001-02-21','2002-02-21');