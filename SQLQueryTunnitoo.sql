--Kasutame left joini
SELECT Title, FirstName, MiddleName, LastName, CompanyName, SalesPerson, EmailAddress, Phone
FROM SalesLt.Customer
LEFT JOIN SalesLt.CustomerAddress
ON Customer.CustomerId = SalesLt.CustomerAddress.CustomerId
ORDER BY LastName

--Kasutame right joini
SELECT SalesLt.CustomerAddress.CustomerID, COUNT(SalesLt.Customer.CustomerID) AS TotalCustomers
FROM SalesLt.Customer
RIGHT JOIN SalesLt.CustomerAddress
ON Customer.CustomerId = SalesLt.CustomerAddress.CustomerId
GROUP BY SalesLt.CustomerAddress.CustomerID

--Kasutame inner joini
-- kuvab neid, kellel on SalesLt.CustomerAddress all olemas väärtus
select Title, FirstName, MiddleName, LastName, CompanyName, SalesPerson, EmailAddress, Phone
from SalesLt.Customer
inner join SalesLt.CustomerAddress
on Customer.CustomerId = SalesLt.CustomerAddress.CustomerId

-- full join
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
SELECT Title, FirstName, MiddleName, LastName, SalesLt.Customer.CustomerID, SalesLt.CustomerAddress.CustomerID
FROM SalesLt.Customer
FULL JOIN SalesLt.CustomerAddress
ON Customer.CustomerID = SalesLt.CustomerAddress.CustomerID;


--- cross join võtab kaks allpool olevat tabelit kokku ja korrutab need omavahel läbi
select Title, FirstName, MiddleName, LastName, CompanyName, SalesPerson, EmailAddress, Phone
from SalesLt.Customer
cross join SalesLt.CustomerAddress

--Outer join
SELECT Title, FirstName, MiddleName, LastName, 
       SalesLt.Customer.CustomerID, SalesLt.CustomerAddress.CustomerID
FROM SalesLt.Customer
FULL OUTER JOIN SalesLt.CustomerAddress 
ON SalesLt.Customer.CustomerID = SalesLt.CustomerAddress.CustomerID


create table Employees
(
Id int primary key,
FirstName nvarchar(50),
MiddleName  nvarchar(50),
LastName  nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int,
Married nvarchar(50),
Children int,
Car  nvarchar(50),
Animal  nvarchar(50)
)
select * from Employees


insert into Employees (Id, FirstName, MiddleName, LastName, Gender, Salary, DepartmentId, Married, Children, Car, Animal)
values (1, 'Tom', 'Hendrikson', 'Mada', 'Male', 4000, 1, 'Yes', 4, 'Toyota', 'Horse')
insert into Employees (Id, FirstName, MiddleName, LastName, Gender, Salary, DepartmentId, Married, Children, Car, Animal)
values (2, 'Dim', 'Dam', 'Dum', 'Female', 6000, 2, 'No', 2, 'Toyota', 'Dog')
insert into Employees (Id, FirstName, MiddleName, LastName, Gender, Salary, DepartmentId, Married, Children, Car, Animal)
values (3, 'Ah', 'Oh', 'Uh', 'Female', 5000, 3, 'No', 8, 'Honda', 'Cat')
insert into Employees (Id, FirstName, MiddleName, LastName, Gender, Salary, DepartmentId, Married, Children, Car, Animal)
values (4, 'Tom', 'Hendrikson', 'Mada', 'Male', 4000, 3, 'Yes', 4, 'Toyota', 'Horse')
insert into Employees (Id, FirstName, MiddleName, LastName, Gender, Salary, DepartmentId, Married, Children, Car, Animal)
values (5, 'Vin', 'Ni', 'Puhh', 'Male', 8000, 5, 'Yes', 7, 'Mazda', 'Pig')
insert into Employees (Id, FirstName, MiddleName, LastName, Gender, Salary, DepartmentId, Married, Children, Car, Animal)
values (6, 'Ai', 'Oi', 'Mama', 'Male', 5959, 6, 'Yes', 5, 'BMW', 'Lemur')

