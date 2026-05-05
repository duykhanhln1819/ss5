
CREATE DATABASE IF NOT EXISTS CompanyDB;
USE CompanyDB;

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(255),
    Position VARCHAR(100),
    Salary INT
);

INSERT INTO Employees (EmpId, FullName, Position, Salary) VALUES
(101, 'Nguyễn Văn Tuấn', 'Developer', 1500),
(102, 'Trần Mai Phương', 'Designer', 1200),
(103, 'Lê Quốc Bảo', 'Tester', 1000),
(104, 'Phạm Hải Yến', 'HR Manager', 1800),
(105, 'Hoàng Minh Trí', 'Marketing', 1300),
(106, 'Đặng Thị Hoa', 'Accountant', 1400),
(107, 'Vũ Hoàng Anh', 'Sales', 1100);

SELECT * 
FROM Employees
LIMIT 3;


SELECT * 
FROM Employees
LIMIT 3 OFFSET 3;