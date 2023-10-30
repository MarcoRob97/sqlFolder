/********* VIEWS, STORE PROCEDURES, CRU CONCEPTS ********************/

/*#####################   VIEWS  ##############################/

/*
Creating a View:

To create a view, you use a SELECT statement and store it as a named object in the database.
Views are often created to present data in a more structured and user-friendly format, to aggregate data, or to restrict access to certain columns.
Example of creating a view:
*/

CREATE VIEW EmployeeDetails AS
SELECT employee_id, first_name, last_name, department
FROM Employees;


/*
After creating a view, you can query it just like you would a regular table.
Views are read-only, so you can't directly perform INSERT, UPDATE, or DELETE operations on them. However, you can manipulate the data in the underlying tables by using the view.
Example of querying a view:
*/

SELECT * FROM EmployeeDetails;

/*
Modifying Views:

You can modify the SQL query that defines a view using the ALTER VIEW statement.
Example of modifying a view:
*/
ALTER VIEW EmployeeDetails AS
SELECT employee_id, first_name, last_name, department, salary
FROM Employees;

/*
Dropping Views:
You can remove a view using the DROP VIEW statement.
Example of dropping a view:
*/
DROP VIEW EmployeeDetails;

/*
Benefits of Using Views:

Abstraction: Views hide the complexity of the underlying data structure and provide a simplified 
and consistent interface for users.

Security: You can grant users access to views while restricting their access to the underlying tables. 
This helps protect sensitive data.

Performance: Views can optimize queries by pre-joining tables or aggregating data, reducing the need for complex queries 
in application code.

Simplicity: Views are useful for saving and reusing commonly used queries, reducing the need to rewrite complex SQL statements.
Types of Views:

Simple Views: These are based on a single table and contain all the rows and columns of that table.
Complex Views: These can involve multiple tables, aggregations, and calculated fields.
Indexed Views (Materialized Views): Some databases allow you to create indexed views, which are 
physically stored on disk, making them much faster for certain queries.
*/


/*############################# STORE PROCEDURE BASICSS #########################################**/

/*
To create a stored procedure, you use the CREATE PROCEDURE statement.
A stored procedure can take parameters, perform SQL operations, and return results.
Example of creating a simple stored procedure:
*/

CREATE PROCEDURE sp_GetEmployeeByDepartment(IN department_name VARCHAR(50))
BEGIN
    SELECT * FROM Employees WHERE department = department_name;
END;

/*
Executing a Stored Procedure:
You can execute a stored procedure using the CALL statement or simply by invoking its name.
Example of executing a stored procedure:
*/

CALL sp_GetEmployeeByDepartment('IT'); -- OR execute in MS SQL SERVER

/*
Parameters:
Stored procedures can accept input parameters, allowing you to pass values to the procedure when it's executed.
Parameters are declared using the IN, OUT, or INOUT keywords.
Example of a stored procedure with an input parameter:
*/

CREATE PROCEDURE sp_AddEmployee(IN first_name VARCHAR(50), IN last_name VARCHAR(50))

BEGIN

    INSERT INTO Employees (first_name, last_name) VALUES (first_name, last_name);

END;

/*
Output Parameters:
In addition to input parameters, stored procedures can have output parameters to return values to the caller.
Example of a stored procedure with an output parameter:
*/

CREATE PROCEDURE sp_GetTotalEmployees(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM Employees;
END;

/*
Modifying Stored Procedures:
You can use the ALTER PROCEDURE statement to modify an existing stored procedure.
Example of altering a stored procedure:
*/


ALTER PROCEDURE sp_AddEmployee(IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN department VARCHAR(50))
BEGIN
    INSERT INTO Employees (first_name, last_name, department) VALUES (first_name, last_name, department);
END;


/*
Dropping Stored Procedures:
You can remove a stored procedure using the DROP PROCEDURE statement.
Example of dropping a stored procedure:
*/
DROP PROCEDURE sp_GetEmployeeByDepartment;

/*
Benefits of Using Stored Procedures:
Reusability: You can reuse the same block of code in multiple places, reducing code duplication.

Security: Stored procedures can provide an additional layer of security, as users only need execute 
privileges on the procedure, not direct table access.

Performance: Stored procedures can be precompiled and optimized, improving query performance.

Encapsulation: You can encapsulate complex business logic within a stored procedure, making it easier to maintain and understand.
*/


/* $$$$$$$$$$$$$$$$$$$$$ A D V A N D C E D    Q  U E R Y    F U N C T I O N S $$$$$$$$$$$$$$$$$$$$$$$$$ */
/*
Window Functions with PARTITION BY:

Window functions allow you to perform calculations across a set of table rows related to the current row. 
The PARTITION BY clause divides the result set into partitions to perform window functions independently within each partition.

*/
-- Calculate the average salary within each department and show employee salaries along with the department average.
SELECT emp_id, emp_name, department, salary, AVG(salary) OVER (PARTITION BY department) AS avg_department_salary
FROM employees;
Common Table Expressions (CTE):

-- CTEs provide a way to define temporary result sets within a SQL query, improving code readability and maintainability.

-- Calculate the total sales per product category using a CTE.
WITH CategorySales AS (

    SELECT category, SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY category

)
SELECT category, total_sales
FROM CategorySales;

/*
Advanced Aggregation Functions:

SQL offers various advanced aggregation functions like RANK(), DENSE_RANK(), PERCENT_RANK(), and CUME_DIST() for ranking 
and percentile calculations.

*/

-- Rank employees by salary within each department.
SELECT emp_name, department, salary, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank_within_dept
FROM employees;

-- Row Number 
/* is a window function in SQL that assigns a unique integer value to each row within a result set.*/
SELECT emp_id, emp_name, salary, 
       ROW_NUMBER() OVER (ORDER BY salary) AS rownum
FROM Employees;

