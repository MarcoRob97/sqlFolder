/*######   Complex Stored Procedure Example 1: Data Manipulation ##########*/

--In this example, we'll create a stored procedure that transfers funds between bank accounts while also logging the transaction.


DELIMITER //
CREATE PROCEDURE sp_TransferFunds(
    IN from_account_id INT,
    IN to_account_id INT,
    IN amount DECIMAL(10, 2)
)
BEGIN
    DECLARE current_balance_from DECIMAL(10, 2);
    DECLARE current_balance_to DECIMAL(10, 2);

    -- Get current balances
    SELECT balance INTO current_balance_from FROM BankAccount WHERE account_id = from_account_id;
    SELECT balance INTO current_balance_to FROM BankAccount WHERE account_id = to_account_id;

    -- Check if there's enough balance in the source account
    IF current_balance_from >= amount THEN
        -- Perform the transfer
        UPDATE BankAccount SET balance = current_balance_from - amount WHERE account_id = from_account_id;
        UPDATE BankAccount SET balance = current_balance_to + amount WHERE account_id = to_account_id;

        -- Log the transaction
        INSERT INTO TransactionLog (from_account_id, to_account_id, amount, transaction_date)
        VALUES (from_account_id, to_account_id, amount, NOW());

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance for the transfer';
    END IF;
END;
//
DELIMITER ;

-- This stored procedure transfers funds between two bank accounts, updates the balances, and logs the transaction. 
-- It also checks for insufficient balance and raises an exception if necessary.

/*##### Complex Stored Procedure Example 2: Data Retrieval and Aggregation ###########/
In this example, we'll create a stored procedure that retrieves employee statistics by department.
*/


DELIMITER //
CREATE PROCEDURE sp_GetEmployeeStatistics()
BEGIN
    SELECT department,
           COUNT(*) AS total_employees,
           AVG(salary) AS avg_salary,
           MAX(salary) AS max_salary,
           MIN(salary) AS min_salary
    FROM Employees
    GROUP BY department;
END;
//
DELIMITER ;


-- This stored procedure returns statistics for employees, including the total count, average salary, 
-- maximum salary, and minimum salary, grouped by department.

/*##### Variables using @ MS SQL SERVER */

/*
Local variables are declared with the @ symbol followed by a variable name.
They are used to store and manipulate data within the scope of a stored procedure, function, or batch of SQL code.
*/

DELIMITER //
CREATE PROCEDURE sp_ConditionalAction(IN step INT)
BEGIN
    -- Check the value of the 'step' parameter
    IF @step = 1 
        BEGIN
            -- Execute SQL code for step 1
            SELECT * FROM Table1;

        END

    IF @step = 2 
        BEGIN
            -- Execute SQL code for step 2
            SELECT * FROM Table2;
        END

    IF @step = 3 
        BEGIN
            -- Execute a default action if 'step' is not 1 or 2
            SELECT * FROM Table2;
        END 
    ;
END;
//
DELIMITER ;


/* Other example using if statement and the variable @ */

CREATE PROCEDURE sp_CalculateDiscount(
    @orderTotal DECIMAL(10, 2),
    @discount DECIMAL(5, 2) OUTPUT
)
AS
BEGIN
    -- Declare a local variable to store the discount percentage
    DECLARE @discountPercentage DECIMAL(5, 2);

    -- Calculate the discount based on the order total
    IF @orderTotal >= 100.00
        SET @discountPercentage = 0.1; -- 10% discount for orders over $100
    ELSE
        SET @discountPercentage = 0.05; -- 5% discount for orders under $100

    -- Calculate the discount amount
    SET @discount = @orderTotal * @discountPercentage;

    -- Return the calculated discount percentage and amount
    SELECT @discountPercentage AS DiscountPercentage, @discount AS DiscountAmount;
END;


-- ## now for use it 

DECLARE @orderTotal DECIMAL(10, 2);
DECLARE @discount DECIMAL(5, 2);

SET @orderTotal = 120.00;

EXEC sp_CalculateDiscount @orderTotal, @discount OUTPUT;

PRINT 'Discount Percentage: ' + CAST(@discount AS VARCHAR);

/************************************************************************************/

