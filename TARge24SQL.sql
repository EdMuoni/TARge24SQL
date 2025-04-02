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
select FirstName, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k]ik andmed Employees tabelist kätte
select FirstName, Gender, Salary, DepartmentName
from Employees
left join Department -- võib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada Deparmtentname alla uus nimetus e antud juhul Other Department
select FirstName, Gender, Salary, DepartmentName
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
select FirstName, Gender, Salary, DepartmentName
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

--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.Id is null

-- 4 tund

--kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null


--full join
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select FirstName, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department' , 'Department123'
sp_rename 'Department123' , 'Department'

--teeme left join-i, aga Employees tabeli nimetus on lühendina: E
select Name, E.Gender, E.Salary, D.DepartmentName
from Employees as E
left join Department as D -- võib kasutada ka LEFT OUTER JOIN-i
on E.DepartmentId = D.Id

--teine variant
select E.Name as Employee, M.Name as Manager
from Employees E
left join  Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--inner join
--kuvab ainult ManagerId all olevate isikute väärtused
select E.Name as Employee, M.Name as Manager
from Employees E
inner join  Employees M
on E.ManagerId = M.Id

--cross join
--kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select isnull('Asd', 'No manager') as Manager

--NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--neil kellel ei ole ülemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme päringu, kus kasutame case-i
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

--muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'

--Lisame Employees tabeli andmed FirstName, MiddleName ja LastName
update Employees
set MiddleName = 'Nick', LastName = 'Jones' 
where Id = 1;

update Employees
set MiddleName = Null, LastName = 'Anderson' 
where Id = 2;

update Employees
set MiddleName = Null, LastName = Null
where Id = 3

update Employees
set MiddleName = Null, LastName = 'Smith' 
where Id = 4

update Employees
set FirstName = Null, MiddleName = 'Todd', LastName = 'Someone' 
where Id = 5

update Employees
set MiddleName = 'Ten', LastName = 'Sven' 
where Id = 6

update Employees
set MiddleName = 'Nick', LastName = 'Jones' 
where Id = 7

update Employees
set MiddleName = Null, LastName = 'Connor' 
where Id = 8

update Employees
set MiddleName = '007', LastName = 'Bond' 
where Id = 9

update Employees
set FirstName = Null, MiddleName = Null, LastName = 'Crowe' 
where Id = 10

select * from Employees

--igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name 
from Employees

--loome kaks tabelit juurde
create table IndidanCustomers
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
insert into IndidanCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndidanCustomers
select * from UKCustomers

--kasutame union all, see näitab kõike ridu
select Id, Name, Email from IndidanCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndidanCustomers
union
select Id, Name, Email from UKCustomers

--kasuta union all ja sorteeri nime järgi
select Id, Name, Email from IndidanCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--kutsuda stored procedure esile
spGetEmployees;

exec spGetEmployees;

execute spGetEmployees;

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20), 
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--kutsume selle sp esile ja selle puhul tuleb sisestada parameetrid
spGetEmployeesByGenderAndDepartment 'Male', 1

--niimodi saab sp tahetud järjekorras mööda minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja võti peale panna, et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb võtme peale
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

--sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab ära nõuetele vastavad read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'asd', @TotalCount out
if (@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount

--näitab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out,
@Gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
--tabeli info
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

--millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabeli sõltuvust
sp_depends Employees

--
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end
--veateadet ei näita, aga tulemust ka ei näita
spGetNameById 1, 'Tom'

--töötav variant
declare @FirstName nvarchar(20)
execute spGetNameById 1, @FirstName output
print 'Name of the Employee =' + @FirstName

--uus sp
create proc spGetNameById1
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees where Id = @Id
end

declare @FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName output
print 'Name of the Employee = ' + @FirstName


declare
@FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName out
print 'Name = ' + @FirstName


create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

--tuleb veateade kuna kutsusime välja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName


--sisseehitatud sting funktsioonid
--see konverteerib ASCII täheväärtuse nubriks
select ASCII('a')
--kuvab A-tähe numbrina 97 ehk annab tähele A-le numbrilise väärtuse
select char(65)

---prindime kogu tähestiku välja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin 
	select char (@Start)
	set @Start = @Start + 1
end

--eemaldame tühjad kohad sulgudes vasakult poolt ehk "lefttrim"
select ltrim('            Hello')

select * from Employees

--tühikute eemaldamine veerust
select ltrim(FirstName) as [First Name], MiddleName, LastName from Employees 

select * from Employees

--eemaldame tühjad kohad sulgudes peramlt poolt ehk "righttrim"
select rtrim('   Hello    --                ')

--6 tund 02.04.2025

--keerab selle kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-iga saan muuta märkide suurust
--reverse funktsioon pöörab kõik ümber
select REVERSE(upper(ltrim(FirstName))) as [First Name], MiddleName, lower(LastName) as LastName,
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--näitab, et mitu tähte on sõnal ja loeb tühikuid sisse
select FirstName, len(FirstName) as [Total characters] from Employees
--eemaldamae tühikuid ja ei loe sisse
--select ltrim(FirstName) as [First Name] from Employees

select FirstName, len(ltrim(FirstName)) as [Total characters] from Employees

select * from Employees

--left, right ja substring
--vasakult poolt neli esimest tähte
select left('ABCDEF', 4)
--paremalt poolt kolm tähte
select right('ABCDEF', 3)

--kuvab @-tähemärgi asetust
select charindex('@', 'sara@aaa.com')

--esimine number peale komakohta näitab, mimendast alustab 
--ja siis mitu nr peale seda kuvada
select substring('pam@bbb.com', 5, 2)

-- @-märgist kuvab kolm tähemärki. Viimase numbriga saab määrata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 3)

--peale @-märki reguleerib tähemärkide pikkuse näitamist
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

--tahame teada saada domeeninimed emailides
select substring(Email, charindex('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees set Email = 'Tom@aaa.com' where Id = 1;

update Employees set Email = 'Pam@bbb.com' where Id = 2;

update Employeesset Email = 'John@aaa.com' where Id = 3;

update Employees set Email = 'Sam@bbb.com' where Id = 4;

update Employees
set Email = 'Todd@bbb.com' 
where Id = 5;

update Employees
set Email = 'Ben@ccc.com' 
where Id = 6;

update Employees
set Email = 'Sara@ccc.com' 
where Id = 7;

update Employees set Email = 'Valerie@aaa.com' where Id = 8;

update Employees
set Email = 'James@bbb.com' 
where Id = 9;

update Employees set Email = 'Russel@bbb.com' where Id = 10;

--lisame *-märgi alates teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + REPLICATE('*', 5) + --peale teist tähemärki paneb viis tärni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email)+ 1) as Email -- kuni @-märgini on dünaamiline
from Employees

--kolm korda näitab stringis olevat väärtust
select replicate('asd', 3)

--kuidas sisestada tühikut kahe nime vahele
select space(5)
--tühikute arv kahe nime vahel
select FirstName + space(20) + LastName as FullName
from Employees

--PATINDEX
--sama, mis charindex, aga dünaamilisem ja saab kasutada WILDCARD-i
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 --leian kõik selle domeeni esindajad ja
-- alataes mitmendast märgist algab @

--kõik .com-d asendatakse .net-ga
SELECT Email, 
       CASE 
           WHEN Email LIKE '%@aaa.com' THEN REPLACE(Email, '@aaa.com', '@aaa.net')
           WHEN Email LIKE '%@bbb.com' THEN REPLACE(Email, '@bbb.com', '@bbb.net')
           WHEN Email LIKE '%@ccc.com' THEN REPLACE(Email, '@ccc.com', '@ccc.net')
           ELSE Email 
       END AS UpdatedEmail
FROM Employees;

--See asendab kõik kolm domeeni korraga ilma CASE-ita.
SELECT Email, 
       REPLACE(REPLACE(REPLACE(Email, '@aaa.com', '@aaa.net'), 
                       '@bbb.com', '@bbb.net'),
                       '@ccc.com', '@ccc.net') AS UpdatedEmail
FROM Employees;

--õpetaj poolne variant
select Email, REPLACE(Email, '.com', '.net') as ConvertEmail
from Employees

--soovin asendada peale esimest märki kolm tähte viie tärniga
--peate kasutama stuff-i
SELECT STUFF(Email, 2, 3, '*****') as UpdatedEmail
from Employees;

--õpetaja variant
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

--ajaühikute tabel
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetitme datetime,
c_datetitme2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select GETDATE(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

--muudame tabeli andmeid
update DateTime set c_datetimeoffset = '2025-04-02 14:08:41.3566667 +10:00'
where c_datetimeoffset = '2025-04-02 14:08:41.3566667 +00:00'

select CURRENT_TIMESTAMP, ' CURRENT_TIMESTAMP' --aja päring
-- leida veel kolm aja päringut
--Leia praegune kuupäev ja kellaaeg
SELECT GETDATE() AS CurrentDateTime, CURRENT_TIMESTAMP AS CurrentTimeStamp;
--mitu päeva on möödunud teatud kuupäevast
SELECT DATEDIFF(DAY, '2024-01-01', GETDATE()) AS DaysSinceNewYear;
-- leia järgmise kuu esimene päev
SELECT DATEADD(DAY, 1, EOMONTH(GETDATE())) AS FirstDayNextMonth;

--õpetaja poolt pakutud variandid aja päringu kohta
select SYSDATETIME(), 'SYSDATETIME' -natuke täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --utc aeg

--
select isdate('asd') -- tagastab 0 kuna string ei ole date

select isdate(GETDATE()) --tagastab 1-te kuna see on aeg

select ISDATE('2025-04-02 14:08:41.3566667') --tagastab 0 kuna max 3 numbrit peale koma tohib olla
select ISDATE('2025-04-02 14:08:41.356') -- tagastab 1
select day(getdate())-- annab tänase päeva numbri
select day('01/31/2025') -- annab stringis oleva kuupäeva ja järjestus peab olema õige
select month(getdate()) -- annab jooksva kuu arvu
select month('01/31/2025') -- annab stringis oleva kuu arvu
select year(getdate()) -- annab jooksva aata arvu
select year('01/31/2025') -- annab stringis oleva aasta arvu

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (1, 'Sam', '1980-12-30 00:00:00.000');
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (2, 'Pam', '1982-09-01 12:02:36.260');
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (3, 'John', '1985-08-22 12:03:30.370');
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (4, 'Sara', '1979-11-29 12:59:30.670');


--kuidas võta ühest veerust andmeid ja selle abil luua uued veerud
select Name, DateOfBirth, DateName(weekday, DateOfBirth) as [day], --võtab veerust päeva andmeid ja kuvab päeva nimetuse sõnana
	MONTH(DateOfBirth) as MonthNumber, --võtab veerust kuupäevad ja kuvab kuu nr
	DATENAME(Month, DateOfBirth) as [MonthName], --võtab veerust kuu andmeid ja kuvab kuu nimetuse sõnana
	Year(DateOfBirth) as [Year] -- võtab DOB veerust aasta
from EmployeesWithDates





