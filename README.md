# SKSNationalBank
This document outlines the requirements for the SKS National Bank database system. The database is designed to manage customer accounts, employee information, loan processing, and branch management. The aim is to provide a robust and efficient system that supports the bank's operations.
Objectives
	Store and manage customer information, including personal details and account information.
	Manage employee records, including roles, branches, and hierarchy.
	Handle loan applications, approvals, and repayments.
	Maintain branch details and their relationships with customers and employees.

Requirements
This document outlines the requirements for the SKS National Bank database system. The database is designed to manage customer accounts, employee information, loan processing, and branch management. The aim is to provide a robust and efficient system that supports the bank's operations.

Functional Requirements

Customer Management
	Ability to add, update, and delete customer records.
	Track customer addresses and contact details.
	Link customers to accounts and loans.

Employee Management
	Maintain employee records including name, address, start date, and manager ID.
	Assign employees to branches.

Branch Management
	Store branch information including branch name and location.
	Associate customers and employees with their respective branches.

Loan Management
	Record loan applications, approvals, and payment schedules.
	Link loans to customers and branches.

Account Management
	Track customer accounts, balances, and transaction history.
	Support different types of accounts (e.g., savings, checking).

Non-Functional Requirements
	Performance: The database should efficiently handle concurrent transactions with minimal latency.
	Security: Customer data must be protected and accessible only to authorized personnel.
	Scalability: The system should accommodate future growth in data volume and user load.

Database Design

Entity-Relationship Model
The database will consist of the following entities and their relationships:
•	Customer
•	Branch
•	Employee
•	Loan
•	Account

Relationships will include:
•	A many-to-one relationship between Customer and Branch (multiple customers can belong to one branch).
•	A many-to-one relationship between Employee and Branch (multiple employees can work at one branch).
•	A many-to-many relationship between Customer and Loan (a customer can have multiple loans, and a loan can involve multiple customers).
Normalization
The database design will adhere to normalization principles, ensuring data integrity and reducing redundancy. It will progress through the following normal forms:
•	First Normal Form (1NF)
•	Second Normal Form (2NF)
•	Third Normal Form (3NF)

Contribution of Group Members
Mostafa Zamani: 
	Conducted research on database design and requirements.
	Developed the initial draft of the ER diagram.
Deepak Poly:
	Designed and implemented the database schema.
	Created SQL scripts for table creation and data insertion.
Felipe Mora:
	Drafted the normalization steps and documented them.
	Wrote the queries and stored procedures for the database.
Arman Golkar:
	Compiled the final document and ensured consistency.
	Prepared the presentation of the project findings.
Conclusion
The SKS National Bank database is designed to streamline operations and enhance service delivery by providing a centralized system for managing customer accounts, employee information, loans, and branch details. By clearly defining the requirements and employing a structured approach to database design, the project ensures data integrity and minimizes redundancy through normalization. This robust database will enable the bank to respond effectively to customer needs, improve operational efficiency, and adapt to future challenges, ultimately supporting the bank's growth and innovation in the financial services sector.
