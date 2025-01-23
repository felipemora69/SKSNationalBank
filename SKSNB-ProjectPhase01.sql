-- Authors:      Deepak Poly, Mostafa Zamani, Arman Golkar, Felipe Mora
				
-- Description: Retrieves all customers associated with a specified branch.

-- Query 1
-- Report of all customers who are associated with a specific branch
CREATE PROCEDURE GetCustomersByBranch
    @BranchID INT
AS BEGIN SELECT c.CustomerID, c.Name, c.HomeAddress FROM Customer c JOIN CustomerLoan cl ON c.CustomerID = cl.CustomerID 
    JOIN Loan l ON cl.LoanID = l.LoanID 
    WHERE l.BranchID = @BranchID; END;
	GO

--Query 2
--View all the account balances
CREATE PROCEDURE GetAccountBalancesByCustomer
    @CustomerID INT
AS BEGIN SELECT a.AccountID, a.Balance, a.AccountType FROM Account a JOIN CustomerAccount ca ON a.AccountID = ca.AccountID 
    WHERE ca.CustomerID = @CustomerID;
	END; 
GO
--Query 3
--Review all loans held by a particular customer
CREATE PROCEDURE GetLoansByCustomer
    @CustomerID INT
AS BEGIN SELECT l.LoanID, l.LoanAmount, l.PaymentDate FROM Loan l JOIN CustomerLoan cl ON l.LoanID = cl.LoanID
    WHERE cl.CustomerID = @CustomerID;
	END; 
GO

--Query 4
--Add a new customer to the database
CREATE PROCEDURE AddNewCustomer
    @CustomerID INT,
    @Name VARCHAR(100),
    @HomeAddress VARCHAR(100)
AS BEGIN INSERT INTO Customer (CustomerID, Name, HomeAddress) VALUES (@CustomerID, @Name, @HomeAddress); END; 
GO

--Query 5
--Update customer home address
CREATE PROCEDURE UpdateCustomerAddress
    @CustomerID INT,
    @NewHomeAddress VARCHAR(100)
AS BEGIN 
    UPDATE Customer
    SET HomeAddress = @NewHomeAddress
    WHERE CustomerID = @CustomerID;
	END; 
GO

--Query 6
--Record a payment made by a customer for a specific loan
CREATE PROCEDURE RecordLoanPayment
    @LoanID INT,
    @PaymentAmount DECIMAL(10, 2),
    @PaymentDate DATE
AS BEGIN INSERT INTO LoanPayments (LoanID, PaymentAmount, PaymentDate) VALUES (@LoanID, @PaymentAmount, @PaymentDate); END; 
GO

--Query 7
--See all employees working in a branch.
CREATE PROCEDURE GetEmployeesByBranch
    @BranchID INT
AS BEGIN SELECT e.EmployeeID, e.Name, e.HomeAddress FROM Employee e WHERE e.BranchID = @BranchID; END; 
GO

--Query 8
--Check if customer account has any overdraft details
CREATE PROCEDURE GetOverdraftDetails
    @AccountID INT
AS BEGIN SELECT OverdraftDetails FROM Account WHERE AccountID = @AccountID; END; 
GO

--Query 9
--Update a customer's branch association
CREATE PROCEDURE UpdateCustomerBranch
    @CustomerID INT,
    @NewBranchID INT
AS BEGIN UPDATE Customer SET BranchID = @NewBranchID WHERE CustomerID = @CustomerID; END;
GO

--Query 10
--See the total amount of loans issued by a branch
CREATE PROCEDURE GetTotalLoansByBranch
    @BranchID INT
AS
BEGIN SELECT SUM(LoanAmount) AS TotalLoansIssued FROM Loan WHERE BranchID = @BranchID; END; 
GO