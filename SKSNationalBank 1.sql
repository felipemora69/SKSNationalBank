-- Create Database
CREATE DATABASE SKSNationalBank;
GO

-- Use the new database
USE SKSNationalBank;
GO

-- Create Tables
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    HomeAddress VARCHAR(100),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) -- Reference to the Branch table
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    LoanAmount DECIMAL(10, 2),
    PaymentDate DATE,
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) -- Reference to the Branch table
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    HomeAddress VARCHAR(200),
    StartDate DATE,
    ManagerID INT,
    BranchID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) -- Reference to the Branch table
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

CREATE TABLE CustomerAccount (
    CustomerAccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Insert Data into Branch table
INSERT INTO Branch (BranchID, BranchName, City) VALUES
(1, 'Downtown', 'Calgary'),
(2, 'North End', 'Edmonton'),
(3, 'Westside', 'Vancouver'),
(4, 'Central', 'Toronto'),
(5, 'East Hill', 'Ottawa'),
(6, 'South Coast', 'Victoria');

-- Insert Data into Customer table
INSERT INTO Customer (CustomerID, Name, HomeAddress, BranchID) VALUES
(1, 'Alice Smith', '456 Mks St', 1),
(2, 'Bob Johnson', '789 Pine Ave', 2),
(3, 'Carol White', '321 Oak Blvd', 3),
(4, 'David Brown', '654 Cedar Dr', 4),
(5, 'Eve Black', '987 Birch Ln', 5),
(6, 'Frank Green', '135 Maple Ct', 6),
(7, 'Grace Lee', '753 Palm St', 1),
(8, 'Henry Kim', '159 Pine St', 2),
(9, 'Ivy Adams', '951 Willow Rd', 3),
(10, 'Jack Wright', '741 Elm St', 4),
(11, 'Kelly Martin', '369 Spruce Ave', 5),
(12, 'Liam Cruz', '258 Redwood Blvd', 6),
(13, 'Mia Fox', '147 Ash Dr', 1),
(14, 'Noah Wood', '369 Cherry St', 2),
(15, 'Olivia Evans', '951 Cypress Ct', 3),
(16, 'Paul Baker', '246 Fir Rd', 4),
(17, 'Quincy Reed', '753 Juniper Ave', 5),
(18, 'Rita Hill', '159 Poplar St', 6),
(19, 'Sam Carter', '951 Palm Rd', 1),
(20, 'Tina Moore', '654 Alder Ln', 2);

-- Insert Data into Employee table
INSERT INTO Employee (EmployeeID, Name, HomeAddress, StartDate, ManagerID, BranchID) VALUES
(1, 'Jack Jones', '963 Maple St', '2022-01-15', NULL, 1),
(2, 'Sally Taylor', '123 Pine Ave', '2021-05-10', 1, 1),
(3, 'Tom Harris', '456 Oak Blvd', '2020-06-25', 1, 2),
(4, 'Rebecca White', '789 Cedar Dr', '2019-03-12', 2, 2),
(5, 'Mark Davis', '951 Birch Ln', '2018-10-08', 2, 3),
(6, 'Linda King', '753 Maple Ct', '2017-11-20', 3, 3),
(7, 'Kevin Brown', '159 Palm St', '2016-04-14', 3, 4),
(8, 'Emily Adams', '369 Willow Rd', '2015-09-01', 4, 4),
(9, 'Brian Lewis', '147 Elm St', '2014-12-03', 4, 5),
(10, 'Tina Clark', '258 Spruce Ave', '2013-07-19', 5, 5);

-- Insert Data into Account table
INSERT INTO Account (AccountID, AccountType, Balance, LastAccessedDate, InterestRate, OverdraftDetails) VALUES
(1, 'Savings', 1400.00, '2024-10-03', 1.5, NULL),
(2, 'Checking', 2500.50, '2024-10-01', NULL, 'Overdraft: $500 on 2024-09-28'),
(3, 'Savings', 1000.00, '2024-09-25', 1.2, NULL),
(4, 'Checking', 300.75, '2024-09-30', NULL, 'Overdraft: $300 on 2024-09-18'),
(5, 'Savings', 4500.00, '2024-10-05', 1.7, NULL),
(6, 'Checking', 100.00, '2024-09-22', NULL, 'Overdraft: $100 on 2024-09-15'),
(7, 'Savings', 2200.00, '2024-09-26', 1.3, NULL),
(8, 'Checking', 1800.00, '2024-10-01', NULL, 'Overdraft: $400 on 2024-09-12'),
(9, 'Savings', 750.00, '2024-09-29', 1.4, NULL),
(10, 'Checking', 450.25, '2024-10-04', NULL, 'Overdraft: $200 on 2024-09-29');

-- Insert Data into Loan table
INSERT INTO Loan (LoanID, LoanAmount, PaymentDate, BranchID) VALUES
(1, 20000.00, '2024-10-10', 1),
(2, 15000.00, '2024-09-15', 2),
(3, 30000.00, '2024-08-20', 3),
(4, 25000.00, '2024-07-30', 4),
(5, 18000.00, '2024-09-25', 5),
(6, 5000.00, '2024-10-05', 6),
(7, 10000.00, '2024-09-12', 1),
(8, 12000.00, '2024-08-18', 2),
(9, 22000.00, '2024-07-25', 3),
(10, 1500.00, '2024-06-10', 4);

-- Insert Data into CustomerLoan table
INSERT INTO CustomerLoan (CustomerLoanID, CustomerID, LoanID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

-- Insert Data into CustomerAccount table
INSERT INTO CustomerAccount (CustomerAccountID, CustomerID, AccountID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 1),
(12, 12, 2),
(13, 13, 3),
(14, 14, 4),
(15, 15, 5),
(16, 16, 6),
(17, 17, 7),
(18, 18, 8),
(19, 19, 9),
(20, 20, 10);