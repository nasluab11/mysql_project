-- Create the library database
CREATE DATABASE library;

-- Use the library database
USE library;

-- Create the Branch table
CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(255),
  Contact_no VARCHAR(20)
);

-- Insert values into the Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
  (1, 1001, 'Main Branch, Mumbai', '+91 1234567890'),
  (2, 1002, 'Central Branch, Delhi', '+91 9876543210'),
  (3, 1003, 'Regional Branch, Bangalore', '+91 7890123456'),
  (4, 1004, 'City Branch, Kolkata', '+91 9012345678'),
  (5, 1005, 'Suburban Branch, Chennai', '+91 3456789012');
  
  SELECT * FROM Branch;


-- Create the Employee table
CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(255),
  Position VARCHAR(255),
  Salary DECIMAL(10, 2),
 Branch_No INT,
FOREIGN KEY (Branch_No) REFERENCES Branch(Branch_No)
);

-- Insert values into the Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_No)
VALUES
  (1001, 'Rajesh Kumar', 'Manager', 50000.00, 1),
  (1002, 'Priya Sharma', 'Assistant Manager', 40000.00, 2),
  (1003, 'Suresh Patel', 'Clerk', 25000.00, 1),
  (1004, 'Deepa Singh', 'Clerk', 25000.00, 2);
  
  SELECT * FROM Employee;
  
  
-- Create the Customer table
CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(255),
  Customer_address VARCHAR(255),
  Reg_date DATE
);

-- Insert values into the Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
  (1, 'Rahul Verma', '123, ABC Street, Mumbai', '2023-01-10'),
  (2, 'Priya Gupta', '456, XYZ Road, Delhi', '2023-02-15'),
  (3, 'Amit Patel', '789, PQR Colony, Bangalore', '2023-03-20'),
  (4, 'Neha Sharma', '987, LMN Nagar, Kolkata', '2023-04-25');

SELECT * FROM Customer;


-- Create the IssueStatus table
CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(255),
  Issue_date DATE,
  Isbn_book INT,
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Insert values into the IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
  (1, 1, 'The Great Gatsby', '2023-01-15', 123456),
  (2, 2, 'To Kill a Mockingbird', '2023-02-28', 234567),
  (3, 3, 'Harry Potter and the Philosopher''s Stone', '2023-03-20', 345678),
  (4, 4, 'Pride and Prejudice', '2023-04-30', 456789);

SELECT * FROM IssueStatus;


-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(255),
  Return_date DATE,
  Isbn_book2 INT,
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Insert values into the ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
  (1, 1, 'The Great Gatsby', '2023-01-25', 123456),
  (2, 2, 'To Kill a Mockingbird', '2023-03-05', 234567),
  (3, 3, 'Harry Potter and the Philosopher''s Stone', '2023-03-25', 345678),
  (4, 4, 'Pride and Prejudice', '2023-05-05', 456789);
  
  SELECT * FROM ReturnStatus;


-- Create the Books table
CREATE TABLE Books (
  ISBN INT PRIMARY KEY,
  Book_title VARCHAR(255),
  Category VARCHAR(255),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(3),
  Author VARCHAR(255),
  Publisher VARCHAR(255)
);

-- Insert values into the Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
  (123456, 'The Great Gatsby', 'Fiction', 10.99, 'yes', 'F. Scott Fitzgerald', 'Vintage Books'),
  (234567, 'To Kill a Mockingbird', 'Fiction', 9.99, 'no', 'Harper Lee', 'Harper Perennial'),
  (345678, 'Harry Potter and the Philosopher''s Stone', 'Fantasy', 12.99, 'yes', 'J.K. Rowling', 'Bloomsbury Publishing'),
  (456789, 'Pride and Prejudice', 'Classic', 8.99, 'yes', 'Jane Austen', 'Penguin Classics');
  
  SELECT * FROM Books;


-- 1.Retrieve the book title, category, and rental price of all available books

SELECT Book_title,Category,Rental_Price FROM BOOKS
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;

-- 3.Retrieve the book titles and the corresponding customers who have issued those books.

SELECT b.Book_title, c.Customer_name
FROM Books b
JOIN IssueStatus i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

 SELECT Customer.Customer_name, IssueStatus.Issued_cust, IssueStatus.Issued_book_name FROM IssueStatus INNER JOIN Customer 
          ON IssueStatus.Issued_cust=Customer.Customer_Id;
          

-- 4.Display the total count of books in each category

SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6.List the customer names who registered before 2022-01-01 and have not issued any books yet

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
  AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


-- 7.Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;


-- 8.Display the names of customers who have issued books in the month of June 2023.

SELECT Customer_name
FROM Customer
WHERE Customer_Id IN (
  SELECT Issued_cust
  FROM IssueStatus
  WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023
);

-- 9.Retrieve book_title from book table containing Fiction.

SELECT Book_title
FROM Books
WHERE Category LIKE '%Fiction%';


-- 10..Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) >5;














