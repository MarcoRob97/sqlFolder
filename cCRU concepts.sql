/*
SQL Class: CRU Concepts
Lesson 1: Creating Tables
Creating Table 1
*/
CREATE TABLE table1 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

--Creating Table 2

CREATE TABLE table2 (
    student_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    grade DECIMAL(4, 2)
);

/*
Lesson 2: Inserting Data
Inserting Data into Table 1
*/

INSERT INTO table1 (id, name, age)
VALUES
    (1, 'Alice', 25),
    (2, 'Bob', 30),
    (3, 'Charlie', 22);

-- Inserting Data into Table 2

INSERT INTO table2 (student_id, course_name, grade)
VALUES
    (101, 'Mathematics', 94.5),
    (102, 'History', 88.0),
    (103, 'Science', 92.3);

/*
Lesson 3: Reading (SELECT) Data
Selecting Data from Table 1
*/

SELECT id, name, age
FROM table1;

-- Selecting Data from Table 2

SELECT student_id, course_name, grade
FROM table2;

-- Lesson 4: Updating Data
-- Updating Data in Table 1
UPDATE table1
SET age = 26
WHERE name = 'Alice';

-- Updating Data in Table 2
UPDATE table2
SET grade = 95.0
WHERE course_name = 'Mathematics';


-- Lesson 5: Deleting Data
-- Deleting Data from Table 1

DELETE FROM table1
WHERE name = 'Charlie';

-- Deleting Data from Table 2
DELETE FROM table2
WHERE course_name = 'History';


 /****************** LET'S GO A LITTE BIT ADVANCED ****************************/

-- Some advanced SQL concepts: transactions, constraints, and indexing.

-- 1. Transactions Example:

-- In this example, we'll use a transaction to transfer money from one bank account to another while maintaining data integrity.


-- Start a transaction
BEGIN;

-- Deduct $100 from Account 1
UPDATE BankAccount
SET balance = balance - 100
WHERE account_id = 1;

-- Add $100 to Account 2
UPDATE BankAccount
SET balance = balance + 100
WHERE account_id = 2;

-- Commit the transaction
COMMIT;
-- By using a transaction, we ensure that both updates are executed atomically. If an error occurs during the transaction, it can be rolled back, ensuring data consistency.

/******************************************/
-- 2. Constraints Example:

-- Let's create a table with constraints to manage student data:

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    UNIQUE (first_name, last_name),
    CHECK (age >= 18),
    enrollment_date DATE
);

-- PRIMARY KEY: Ensures each student_id is unique.
-- UNIQUE (first_name, last_name): Enforces uniqueness for the combination of first_name and last_name.
-- CHECK (age >= 18): Ensures that students are at least 18 years old.


/*
3. Indexing Example:
Consider a table of employees:
*/

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);


-- To improve query performance, we can create an index on the department column:

CREATE INDEX idx_department ON Employees (department);

-- Now, when you query the employees by department, the index will significantly speed up the search:

SELECT * FROM Employees WHERE department = 'IT';

/*
The index on the department column will make this query faster.
These examples demonstrate how to use transactions for data integrity
, constraints to ensure data quality, and indexing to improve query performance. 
Please adapt them to your specific use case and database schema.
*/



















