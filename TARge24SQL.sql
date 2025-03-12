﻿-- 1tund 26.02.25
--koome db
create database TARge24

--db valimine
use TARge24

--db kustutamine
drop database TARge24

-- 2tund 05.03.2025

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values(2, 'Male')
insert into Gender (Id, Gender)
values(1,'female'),
(3, 'Unknown')

--vaatame tabeli andmeid
select * from Gender

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisetamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, Null, Null, 2)

select * from Person

--võõrvõtme ühenduse loomine ´kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

---kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust, siis
---see automaatselt sisestab sellele reale väärtuse 3 ehk nagu meil on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

select * from Person

insert into Person (Id, Name, Email)
values (7, 'Spiderman', 'spider@s.com')

--piirangu kustutamine
alter table Person
drop constraint DF_Person_GenderId

--lisame veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- rea kustutamine
delete from Person where Id = 8

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 19
where Id = 7

select * from Person

--lisame veeru juurde
alter table Person
add City nvarchar(50)

--kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik, kes ei ela Gothami linnas
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'

--näitab teatud vanusega olevaid inimesi
select * from Person where Age = 100 or Age = 45 or Age = 19
select * from Person where Age in (100, 45, 19)

--näitab teatud vanuse vahemikus olevaid inimesi
select * from Person where Age between 27 and 31

--wildcard ehk näitab kõik g-tähega linnad
select * from Person where City like 'g%'
--wildcard ehk näitab kõik g-tähte sisaldavad linnad
select * from Person where City like '%g%'

--näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email like '%"%.com'
select * from Person where Email not like '%@%.com'

--näitab kõiki, kellel on emailis ees ja peale @-märki ainult üks täht
select * from Person where Email like '_@_.com'

--kõik kellel nimes ei ole esimene täht W, A, S
select * from Person where Name Like '[^WAS]%'
select * from Person 

--kõik, kes elavad Gothamis ja New Yorkis
select * from Person where City Like '[^LMA]%'
SELECT * FROM Person WHERE City IN ('Gotham', 'New York')
select * from Person where (City = 'Gotham' or City = 'New York')

--kõik, kes elavad välja toodud linnades ja on nooremad
--kuni 30 aastased
SELECT * FROM Person WHERE Age between 19 and 29 and City IN ('Gotham', 'New York')
select * from Person where (City = 'Gotham' or  City = 'New York') 
and Age < 30

-- kuvab tähestikulises korras inimesi ja võttab aluseks nime
select * from Person order by Name
--kuvab vastupidises järjestuses
select * from Person order by Name desc

--võtab kolm esimest rida
select * from Person where Id between 1 and 3
select top 3 * from Person

--kolm esimest, aga tabeli järjestus on Age ja Name
SELECT TOP 3 Age, Name FROM Person ORDER BY Age, Name


-- 3tund 12.03.2025


--näitab esimesed 50% tabelis
select top 50 percent * from person

--järjestab vanuse järgi isikud
--see päring ei järjesta numbreid õigesti kuna Age on nvarchar
select * from Person order by Age desc

--casetime Age int andmetüübiks ja siis järjestab õigesti
select * from Person order by CAST(Age as int)

-- kõikide isikute koondvanus
select sum(cast(Age as int)) from Person
select sum(cast(Age as int)) as TotalAge from Person
select sum(cast(Age as int)) as [Total Age] from Person

--Kõige noorem isik
select min(cast(Age as int)) from Person
--Kõige vanem isik
select min(cast(Age as int)) from Person

--näeme konkreetsetes linnades olevate isikute koondvanus
--enne oli Age string, aga enne päringut muudame selle int-ks
select City, sum(Age) as TotalAge from Person group by City

--nüüd muudame andmetüübi koodiga
alter table Person
alter column Name nvarchar(25)

--kuvab esmieses reas välja toodud järjestuses ja kuvab Age-i TotalAge-ks
--järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--näitab mitu rida on selles tabelis (*-loeb kõik välja muututjad)
select count(*) from Person
select * from Person

--näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--veel arvutab vanuse kokku
select City, GenderId, sum(Age) as TotalAge, count(Id) as [Total Age(s)] from Person
where GenderId = '2'
group by GenderId, City

insert into Person values
(10, 'Black Panther', 'b@p.com', 2, 34, 'New York')

--näitab ära inimeste koondvanuse, kelle vanus on vähemalt 29 aastad
--kui palju neid linnas elab
select City, GenderId, sum(Age) as TotalAge, count(Id) as [Total Age(s)] 
from Person
group by GenderId, City having sum(Age) > 29

--loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50),
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

--andmete sisetamine Employees
insert into Employees(Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male' , 4000, 1),
insert into Employees(Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 3),
insert into Employees(Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valerie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, Null),
(10, 'Russel', 'Male', 8800, Null)

select * from Employees

--andmete sisetamine Department
insert into Department(Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London' , 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cinderella')

select * from Department

--left join
select Name, Gender, Salary, DepartmentName 
from Employees
left join Department
on Employees.Department = Department.Id

--arvutab kõikide palgad kokku
select sum(cast(Salary as int)) from Employees
--kõige väiksema palga saaja
select min(cast(Salary as int)) from Employees
--ühe kuu palgafond linnade lõikes
select Location, sum(cast(Salary as int)) as TotalSalaries 
from Employees
left join Department 
on Employees.Department = Department
group by Location

alter table Employees
add City nvarchar(30)

--sooline eripära palkade osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender

--sama nagu eelmine, aga linnad on tähestikulises järjekorras
SELECT City, Gender, SUM(CAST(Salary AS INT)) AS TotalSalary
FROM Employees
GROUP BY City, Gender
ORDER BY City

--loeb ära, mitu rida andmeid on tabelis,
select count(*) from Employees
-- * asemele võib panna ka muid veergude nimetusi
select count(Department) from Employees

--mitu töötajat on soo ja linna kaupa selles tabelis
SELECT Gender, City, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Gender, City

SELECT Gender, City,
count (Id) as [Total Employee(s)]
FROM Employees
GROUP BY Gender, City

--näitab kõik mehed linnade kaupa
SELECT Gender, City,
count (Id) as [Total Employee(s)]
FROM Employees
where Gender = 'Male'
GROUP BY Gender, City

--näitab kõik naised linnade kaupa
SELECT Gender, City,
count (Id) as [Total Employee(s)]
FROM Employees
GROUP BY Gender, City
having Gender = 'Female'

--kelle palk on vähemalt üle 4000
select * from Employees where sum(cast(Salary as int)) > 4000
-- nüüd õigem variant
select * from Employees where Salary > 4000

--kõigil kellel on palk üle 4000 ja arvutab need kokku ning näitab soo kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id) as [Total Employees(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
insert into Test1 values('X')
select * from Test1

--kustutakse ära City veerg
alter table Employees
drop column City

--inner join
--kuvab neid, kellel on DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Empoyees.DepartmentId = DepartmentId

--left join
--kuidas saada kõik andmed Employees tabelist kätte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--right join
--kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

--full outer join
--kuidas saada kõikide tabelite väärtused ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id


--cross join võtab kaks allpool olveat tabelit kokku ja korrutab need omavahel läbi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--päringu sisu e loogika
select ColumnList
from LeftTable
joinType RigtTable
on JoinCondition

--kuidas kuvada ainult need isikud, kellel on DepartmentName Null
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
