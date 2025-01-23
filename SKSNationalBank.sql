-- Create Database
CREATE DATABASE SKSNationalBank;
USE SKSNationalBank;

-- Create Tables
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    HomeAddress VARCHAR(100)
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    LoanAmount DECIMAL(10, 2),
    PaymentDate DATE,
    BranchID INT
);

CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    HomeAddress VARCHAR(200),
    StartDate DATE,
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    AccountType VARCHAR(10),
    Balance DECIMAL(10, 2),
    LastAccessedDate DATE,
    InterestRate DECIMAL(5, 2),
    OverdraftDetails VARCHAR(100)
);

CREATE TABLE CustomerLoan (
    CustomerLoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);

-- Insert Data into Tables
INSERT INTO Branch (BranchID, BranchName, City) VALUES (1, 'Downtown', 'Calgary');

INSERT INTO Customer (CustomerID, Name, HomeAddress) VALUES (1, 'Alice Smith', '456 mks St');

INSERT INTO Employee (EmployeeID, Name, HomeAddress, StartDate, ManagerID) VALUES (1, 'Jack Jones', '963 Maple St', '2022-01-15', NULL);

INSERT INTO Account (AccountID, AccountType, Balance, LastAccessedDate, InterestRate) VALUES (1, 'Savings', 1400.00, '2024-10-03', 1.5);

INSERT INTO Loan (LoanID, LoanAmount, BranchID) VALUES (1, 20000.00, 1);

INSERT INTO CustomerLoan (CustomerLoanID, CustomerID, LoanID) VALUES (1, 1, 1);


---------------------------------------------------------------------------------


--PHASE ||
---------------------------------------------------------------------------------
--Step 1
-- Create login and user
CREATE LOGIN customer_446031 WITH PASSWORD = 'customer';
CREATE LOGIN accountant_446031 WITH PASSWORD = 'accountant';

--create users from logins
USE SKSNationalBank;
CREATE USER customer_446031 FOR LOGIN customer_446031;

CREATE USER accountant_446031 FOR LOGIN accountant_446031;

--assigning privilegess
--privilege to the customer on specific tables
GRANT SELECT ON Customer TO customer_446031;
GRANT SELECT ON Account TO customer_446031;
GRANT SELECT ON Loan TO customer_446031;


--privilege on all tables to accountant
GRANT SELECT ON Customer TO accountant_446031;
GRANT SELECT ON Loan TO accountant_446031;
GRANT SELECT ON Branch TO accountant_446031;
GRANT SELECT ON Employee TO accountant_446031;


--privilege on Loan and Account tables
DENY UPDATE ON Account TO accountant_446031;
DENY UPDATE ON Loan TO accountant_446031;
EXECUTE AS USER = 'accountant_446031';


--testing for step 1

--For customer_446031
--should work
SELECT * FROM Customer;

-- should work
SELECT * FROM Account;

-- should fail
UPDATE Account SET Balance = 1500 WHERE AccountID = 1;  


--For accountant_446031
--should work
SELECT * FROM Customer;

--should fail
UPDATE Account SET Balance = 1500 WHERE AccountID = 1; 

---------------------------------------------------------------------------------
--Step 2
--trigger new customer registration
CREATE TRIGGER trg_NewCustomer
ON Customer
FOR INSERT
AS
BEGIN
    PRINT 'A new customer has been added.';
END;

-- trigger new account creation
CREATE TRIGGER trg_NewAccount
ON Account
FOR INSERT
AS
BEGIN
    PRINT 'A new account has been created.';
END;


-- trigger loan payment and updating account balance
CREATE TRIGGER trg_LoanPayment
ON Loan
FOR UPDATE
AS
BEGIN
    IF UPDATE(PaymentDate)
    BEGIN
        DECLARE @LoanID INT;
        SELECT @LoanID = LoanID FROM INSERTED;
        PRINT 'Loan payment has been made and account updated.';
    END;
END;


-- trigger monitor data updates in Account table
CREATE TRIGGER trg_AccountUpdate
ON Account
FOR UPDATE
AS
BEGIN
    PRINT 'Account data has been updated.';
END;

-- create a log table to track data reads
CREATE TABLE BranchReadLog (
    ReadDate DATETIME DEFAULT GETDATE(),
    BranchID INT,
    Action VARCHAR(50)
);


-- trigger report data read from Branches table
CREATE TRIGGER trg_BranchRead
ON Branch
FOR INSERT
AS
BEGIN
    INSERT INTO BranchReadLog (BranchID, Action)
    SELECT BranchID, 'Read' FROM INSERTED;
END;


---------------------------------------------------------------------------------
--Step 3
-- create clustered index on the Customer table
CREATE CLUSTERED INDEX idx_CustomerName
ON Customer (Name);

-- Create clustered index on Account table
CREATE CLUSTERED INDEX idx_AccountBalanceType
ON Account (AccountType, Balance);

-- create nonclustered index on Loan table
CREATE NONCLUSTERED INDEX idx_LoanBranchAmount
ON Loan (BranchID, LoanAmount);

---------------------------------------------------------------------------------

--Step 4
-- alter Account table to add JSON column
ALTER TABLE Account
ADD ExtraInfo NVARCHAR(MAX) NULL;

-- sample JSON data
UPDATE Account
SET ExtraInfo = '{"LastAccessed": "2024-12-08", "AccountStatus": "Active"}'
WHERE AccountID = 1;

--backup
BACKUP DATABASE SKSNationalBank 
TO DISK = 'C:\SQLBackups\SKSNationalBank.bak';