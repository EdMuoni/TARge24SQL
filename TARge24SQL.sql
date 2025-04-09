-- 1tund 26.02.25
--loome db
crEaTE database TARge24

--db valimine
use TARge24

-- db kustutamine
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
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female'),
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

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

select * from Person

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust, siis
--- see automaatselt sisestab sellele reale väärtuse 3 e nagu meil on unknown
alter table Person
add constraint DF_Person_GenderId
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

-- k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'

-- näitab teatud vanusega olevaid inimesi
select * from Person where Age = 100 or Age = 45 or Age = 19
select * from Person where Age in (100, 45, 19)

-- näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 27 and 31

-- wildcard e näitab kõik g-tähega linnad
select * from Person where City like 'g%'
select * from Person where City like '%g%'

--näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

-- n'tiab kõiki, kellel on emailis ees ja peale @-märki ainult üks täht
select * from Person where Email like '_@_.com'

-- kõik, kellel nimes ei ole esimene täht W, A, S
select * from Person where Name Like '[^WAS]%'
select * from Person

--kõik, kes elavad Gothamis ja New Yorkis
select * from Person where City in ('Gotham','New York')

--- kõik, kes elavad välja toodud linnades ja on nooremad 
--  kui 30 a 
select * from Person where (City = 'Gotham' or City = 'New York')
and Age < 30

-- kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name
-- kuvab vastupidises järjestuses
select * from Person order by Name desc

-- võtab kolm esimest rida
select top 3 * from person

-- kolm esimest, aga tabeli järjestus on Age ja siis Name
select top 3 Age, Name from Person

-- 3tund 12.03.2025

--näita esimesed 50% tabelis
select top 50 percent * from Person

--järjestab vanuse järgi isikud
-- see päring ei järjesta numbreid õigesti kuna Age on nvarchar
select * from Person order by Age desc

--castime Age int andmetüübiks ja siis järjestab õigesti
select * from Person order by CAST(Age as int)

-- kõikide isikute koondvanus
select sum(cast(Age as int)) as [Total Age] from Person

--k]ige noorem isik
select min(cast(Age as int)) from Person
--k]ige vanem isik
select max(cast(Age as int)) from Person

-- n'eme konkreetsetes linnades olevate isikute koondvanust
-- enne oli Age nvarchar, aga enne päringut muudame selle int-ks
select City, sum(Age) as TotalAge from Person group by City

-- nüüd muudame muutuja andmetüüpi koodiga
alter table Person
alter column Name nvarchar(25)

--- kuvab esimeses reas välja toodud järjestuses ja kuvab Age-i TotalAge-ks
--- järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--- näitab, et mitu rida on selles tabelis
select count(*) from Person
select * from Person

--- näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
-- veel arvutab vanuse kokku
select City, GenderId, sum(Age) as TotalAge, count(Id)as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

insert into Person values
(10, 'Black Panther', 'b@b.com', 2, 34, 'New York')

--- näitab ära inimeste koondvanuse, kelle vanus on vähemalt 29 a
-- kui palju neid igas linnas elab
select GenderId, City, sum(Age) as TotalAge, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 29


--loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)
select * from Employees


insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

--left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- arvutab k]ikide palgad kokku
select sum(cast(Salary as int)) from Employees
-- k]ige v'iksema palgasaaja palk
select min(cast(Salary as int)) from Employees
--ühe kuu palgafond linnade lõikes
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

--sooline erip'ra palkade osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees
group by City, Gender
-- sama nagu eelmine, aga linnad on t'hestikulises j'rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees
group by City, Gender
order by City

-- loeb ära, mitu rida andmeid on tabelis,
-- * asemele võib panna ka muid veergude nimetusi
select count(DepartmentId) from Employees

--mitu töötajat on soo ja linna kaupa selles tabelis
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

-- näitab kõik mehed linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- näitab kõik naised linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- kelle palk on vähemalt üle 4000
select * from Employees where sum(cast(Salary as int)) > 4000
-- nüüd õige päring
select * from Employees where Salary > 4000

-- k]igil,kellel on palk üle 4000 ja arvutab need kokku ning näitab soo kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id) as [Total Employee(s)]
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

--kustutage ära City veerg Employees tabelist
alter table Employees
drop column City

--- inner join
-- kuvab neid, kellel on DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k]ik andmed Employees tabelist kätte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department -- võib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada Deparmtentname alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

-- full outer join
--- kuidas saada kõikide tabelite väärtused ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--- cross join võtab kaks allpool olevat tabelit kokku ja korrutab need omavahel läbi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--päringu sisu e loogika
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- 4 tund 19.03.2025
--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

-- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- full join
-- mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

-- saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department123' , 'Department'

--teeme left join-i, aga Employees tabeli nimetus on lühendina: E
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--inner join
--kuvab ainult ManagerId all olevate isikute väärtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join
--kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select isnull('Asd', 'No manager') as Manager

--NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--- neil kellel ei ole ülemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

---muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'

update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

--igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

--loome kaks tabelit juurde
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UkCustomers

--korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kasuta union all ja sorteeri nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UkCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

-- kutsuda stored procedure esile
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- kutsume selle sp esile ja selle puhul tuleb sisestada parameetrid
spGetEmployeesByGenderAndDepartment 'Male', 1

--niimoodi saab sp tahetud järjekorrast mööda minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

-- kuidas muuta sp-d ja võti peale panna, et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb võtme peale
as begin 
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

-- sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab 'ra n]uetele vastavad read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount


--- näitab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @totalCount out, @Gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info
sp_help Employees
-- kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

--millest sõltub seesp
sp_depends spGetEmployeeCountByGender
-- vaatame tabeli sõltuvust
sp_depends Employees

-- 
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end
--veateadet ei näita, aga tulemust ka ei ole
spGetNameById 1, 'Tom'

--töötav variant
declare @FirstName nvarchar(20)
execute spGetNameById 1, @FirstName output
print 'Name of the employee = ' + @FirstName

-- uus sp
create proc spGetNameById1
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees where Id = @Id
end

declare @FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

--- 5 tund 26.03.2025

declare 
@FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName out
print 'Name = ' + @FirstName

create proc spGetnameById2
@Id int 
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v'lja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

-- sisseehitatud string funktsioonid
-- see konverteerib ASCII tähe väärtuse numbriks
select ASCII('a')
-- kuvab A-tähe
select char(65)

---prindime kogu tähestiku välja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin 
	select char (@Start)
	set @Start = @Start + 1
end

---eemaldame tühjad kohad sulgudes vasakult poolt
select ltrim('             Hello')

select * from Employees

--tühikute eemaldamine veerust
select LTRIM(FirstName) as [First Name], MiddleName, LastName from Employees

---paremalt poolt eemaldab tühjad stringid
select rtrim('    Hello     --      ')

-- 6 tund 02.04.2025

--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta märkide suurust
--reverse funktsioon pöörab kõik ümber
select REVERSE(upper(ltrim(FirstName))) as [First Name], MiddleName, lower(LastName) as LastName,
RTRIM(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--näitab, et mitu tähte on sõnal ja loeb tühikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
--eemaldame t[hikud ja ei loe sisse ????
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees
select * from Employees

--left, right ja substring
--vasakult poolt neli esimest tähte
select LEFT('ABCDEF', 4)
--paremalt poolt kolm tähte
select RIGHT('ABCDEF', 3)

--kuvab @-tähemärgi asetust
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr peale komakohta näitab, et mitmendast alustab 
--ja siis mitu nr peale seda kuvada
select SUBSTRING('pam@bbb.com', 4, 4)

--- @-märgist kuvab kom tähemärki. Viimase nr saab määrata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 2)

--peale @-märki reguleerib tähemärkide pikkuse näitamist
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 
len('pam@bbb.com') - charindex('@', 'pam@bbb.com')) 


alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

---tahame teada saada domeeninimed emailides
select SUBSTRING(Email, CHARINDEX('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

--lisame *-märgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + --peale teist tähemärki paneb viis tärni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - CHARINDEX('@', Email)+1) as Email --kuni @-märgini on dünaamiline
from Employees

---kolm korda näitab stringis olevat väärtust
select REPLICATE('asd', 3)

-- kuidas sisestada tühikut kahe nime vahele
select space(5)

--tühikute arv kahe nime vahel
select FirstName + space(20) + LastName as FullName
from Employees

--PATINDEX
--sama, mis charindex, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 ---leian kõik selle domeeni esindajad ja
-- alates mitmendast märgist algab @

--- kõik .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--soovin asendada peale esimest märki kolm tähte viie tärniga
--peate kasutama stuff-i
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

---- ajaühikute tabel
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

---konkreetse masina kellaaeg
select GETDATE(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

--muudame tabeli andmeid
update DateTime set c_datetimeoffset = '2025-04-02 14:06:17.0566667 +10:00'
where c_datetimeoffset = '2025-04-02 14:06:17.0566667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT TIMESTAMP' -- aja päring
-- leida veel kolm aja päringut
select SYSDATETIME(), 'SYSDATETIME' --natuke täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --utc aeg

---
select isdate('asd') --tagastab 0 kuna string ei ole date
select isdate(GETDATE()) --tagastab 1 kuna on aeg
select isdate('2025-04-02 14:06:17.0566667') --tagastab 0 kuna max 3 numbrit peale koma tohib olla
select isdate('2025-04-02 14:06:17.056') --tagastab 1
select day(getdate()) -- annab tänase päeva nr
select day('01/31/2025')-- annab stringis oleva kp ja järjestus peab olema õige
select month(getdate()) -- annab jooksva kuu arvu
select month('01/31/2025') --annab stringis oleva kuu nr
select year(getdate()) -- annab jooksva aasta arvu
select year('01/31/2025') --annab stringis oleva aasta nr

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

--- kuidas v]tta [hest veerust andmeid ja selle abil luua uued veerud
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day], --vt DoB veerust p'eva ja kuvab p'eva nimetuse s]nana
	MONTH(DateOfBirth) as MonthNumber,  -- vt DoB veerust kp-d ja kuvab kuu nr
	DATENAME(Month, DateOfBirth) as [MonthName], -- vt DoB veerust kp-d ja kuvab kuu sõnana
	Year(DateOfBirth) as [Year] -- võtab DoB veerust aasta
from EmployeesWithDates

-- tund 7 09.04.25
select DATEPART(WEEKDAY, '2025-01-29 12:59:30.670') --näitab nelja kuna USA nädal algab pühapäevast
select DATEPART(month, '2025-01-29 12:59:30.670') --näitab kuu numbrit
select dateadd(day, 20, '2025-01-29 12:59:30.670') --liidab stringis olevale kp-le 20 päeva juurde
select dateadd(day, -20, '2025-01-29 12:59:30.670') --lahutab 20 päeva maha
select datediff(month, '11/30/2024', '01/30/2024') --kuvab kahe stringi vahel olevat kuudevahelist aega
select datediff(year, '11/30/2020', '01/30/2025') --kuvab kahe stringi vahel olevat aastatevahelist aega

CREATE FUNCTION fnComputeAge (@DOB DATETIME)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @tempdate DATETIME, @years INT, @months INT, @days INT;

    SET @tempdate = @DOB;

-- Calculate years
SET @years = DATEDIFF(YEAR, @tempdate, GETDATE()) 
	- CASE 
	  WHEN (MONTH(@DOB) > MONTH(GETDATE())) 
	  OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
	  THEN 1 
	  ELSE 0 
END

    -- Add calculated years to DOB to update tempdate
    SET @tempdate = DATEADD(YEAR, @years, @DOB);

    -- Calculate months
    SET @months = DATEDIFF(MONTH, @tempdate, GETDATE()) 
        - CASE 
            WHEN DAY(@DOB) > DAY(GETDATE()) 
            THEN 1 
            ELSE 0 
          END;

    -- Add calculated months to tempdate
    SET @tempdate = DATEADD(MONTH, @months, @tempdate);

    -- Calculate days
    SET @days = DATEDIFF(DAY, @tempdate, GETDATE());

    -- Construct the final age string
    DECLARE @Age NVARCHAR(50);
    SET @Age = CAST(@years AS NVARCHAR(4)) + ' Years ' 
             + CAST(@months AS NVARCHAR(2)) + ' Months ' 
             + CAST(@days AS NVARCHAR(2)) + ' Days old';

    RETURN @Age;
END;

--saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age 
from EmployeesWithDates

-- kui kasutame seda funktsiooni, 
-- siis saame teada t'nase päeva vahet stringis välja tooduga
select dbo.fnComputeAge('11/30/2010')

--nr peale DOB muutujat näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 109) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id]
from EmployeesWithDates

select cast(getdate() as date) --tänane kuupäev
select convert(date, getdate()) --tänane kp


--matemaatilised funktsioonid
select ABS(-101.5) --ABS on absoluutväärtus ja miinus võetakse ära
select CEILING(15.2) --ümardab suurema arvu poole
select CEILING(-15.2) --tulemus on -15 ja suurendab positiivse täisarvu suunas
select floor(15.2) --ümardab väiksema numbri poole
select floor(-15.2) --ümardab väiksema numbri poole ehk -16
select power(2, 4) --hakkab korrutama 2x2x2x2, esimene nr on korrutatav
select SQUARE(9) --antud juhul on meil 9 ruudus
select SQRT(81) --annab vastuse 9, võtab arvu ruutjuure alla

select rand() --annab suvalise numbri
select floor(rand() * 100) --korrutab sajaga iga suvalise arvu

--iga kord näitab 10 suvalist numbrit
-- Loob 10 rida numbritega 1 kuni 10 ja genereerib igale reale suvalise arvu
-- variant1
SELECT TOP 10 
    CAST(ABS(CHECKSUM(NEWID())) % 100 + 1 AS INT) AS RandomNumber
FROM sys.all_objects

--variant2
declare @counter int
set @counter = 1
while (@counter <= 10)
	begin
		print floor(rand() * 1000)
		set @counter = @counter + 1
	end

select round(850.556, 2) --ümardab kaks kohta peale komat, tulemus 850.560
select round(850.556, 2, 1) --ümardab kaks kohta peale komat allapoole, tulemus 850.550
select round(850.556, 1) --ümardab üks koht peale komat ülespoole, tulemus 850.600
select round(850.556, 1, 1) --ümardab üks koht peale komat allapoole, tulemus 850.500
select round(850.556, -2) --ümardab täisnumber ülesse
select round(850.556, -1) --ümardab täisnumber alla

---
create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = datediff(year, @DOB, getdate()) - 
	case
		when (month(@DOB) > MONTH(getdate())) or
			(month(@DOB)) > MONTH(getdate()) and day(@DOB) > day(getdate())
			then 1
			else 0
			end
		return @Age
end

exec CalculateAge '08/14/2010'

--arvutab välja kui vana on isik ja võtab arvesse kuud ja päevad
--antud juhul näitab kõike, kes on üle 36 aastad vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 42

--inline table
alter table EmployeesWithDates
add DepartmentId int

alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

-- scalare function annab mingis vahemikus olevaid andmeid, aga
-- inline table values ei kasuta begin ja ned funktsioone
-- scalar annab väärtused ja inline annab tabeli

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
	from EmployeesWithDates
	where Gender = @Gender)

-- kõik female töötajad
select * from fn_EmployeesByGender('female')

select * from fn_EmployeesByGender('female')
where Name = 'Pam'

select * from Department

select Name, Gender, DepartmentName
from fn_EmployeesByGender('male') E
join Department D on D.Id = E.DepartmentId

--inline funktsioon
create function fn_GetEmployees()
returns table as
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_GetEmployees()
where Name = 'Pam'

--teha multi-state funktsioon
--peab defineerima uue tabeli veerud koos muutujatega
--Id int, Name nvarchar(20), DOB date
--funktsiooni nimi on fn_MS_getEmployees()

CREATE FUNCTION fn_MS_getEmployees()
RETURNS @Result TABLE (
    Id INT,
    Name NVARCHAR(20),
    DOB DATE
)
AS BEGIN
    INSERT INTO @Result
    SELECT Id, Name, CAST(DateOfBirth AS DATE) FROM EmployeesWithDates

    RETURN
END

select * from fn_MS_getEmployees()

--inline tabeli funktsioonid on paremini töötamas kuna käistetakse vaatena
--multi puhul on pm tegemist stored proceduriga ja kulutab resurssi rohkem

update fn_getEmployees() set Name = 'Sam1' where Id = 1 --saab muuta andmeid
update fn_MS_getEmployees() set Name = 'Sam 1' where Id = 1 --ei saa muuta andmeid

--deterministic ja non-deterministic
select count(*) from EmployeesWithDates
select Square(3) --kõik tehtemärgid on deterministic funktsioonid
--sinna kuuluvad veel sum, avg ja square

--non-deterministic
select getdate()
select current_timestamp
select rand() --see funktsioon saab olla mõlemas kategoorias, kõik oleneb sellest
--kas sulgudes on 1 või ei ole midagi

--loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(1)

create function fn_getEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

--muudame ülevalpool olevat funktsiooni
--Kindlasti tabeli ette panna dbo.TabeliNimi

alter function dbo.fn_getEmployeeNameById(@Id int)
returns nvarchar(30)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @Id)
end

--ei saa kutsuda tabeleid ilma funktsiooni kutsumata
drop table dbo.EmployeesWithDates

--temporary tables

--#-märgi ette panemisel saame aru, et tegeimist on temp tabeliga
--seda tabelit saab ainult selles päringus avada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like '#PersonDetails%'

---kustuta temp tabeli
drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

select * from [dbo].[#B8B16215]

--globaalse temp tabeli tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))

--Erinevused lokaalse ja globaalse ajutise tabeli osas:
--1. Lokaalsed ajutised tabelid on ühe # märgiga
--aga globaalsetel on ## tükki.
--2. SQL serever lisab suvalisi numbreid lokaalse ajutise tabelise nimesse,
--aga globaalse puhul seda ei ole.
--3. Lokaalsed on nähtavad ainult selles sessioonis,
--mis on selle loonud, aga globaalsed on nähtavad kõikides sessioonides.
--4. Lokaalsed ajutised tabelid on automaatselt kustutatud,
--kui selle loonud sessioon on kinni pandud,
--aga globaalsed ajutised tabelid lõpetatakse alles
--peale viimase ühenduse lõpetamist.

-- rida 1147
-- tund