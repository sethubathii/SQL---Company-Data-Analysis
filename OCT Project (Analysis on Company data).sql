use [OCT Sql project]

--1. What is the total revenue by Industry Sector?
Select Format(sum(Revenue)/1000000000, 'N') + 'Billion' as 'Total_Revenue'
From Company

--2. How many Directors are Male and Female?
Select 
Sum(Case When Gender = 'M' then 1 Else 0 End) as 'Number of Male Directors',
Sum(Case When Gender = 'F' then 1 Else 0 End) as 'Number of Female Directors'
From Company;

--3. How many CEOs are there who are female and over 50 yrs of age?
Select count(Director_ID) as 'Female_CEOs'
From Company
Where (Gender = 'F') and (CEO = 1) and (Age > 50);

--4.	What is the total revenue per Industry Sector for Directors that have a Retirement_Age_Directors_Years recorded?
Select Industry_Sector, Sum(Case When Retirement_Age_Directors_Years is not null THEN Revenue else 0 END) as 'Total Revenue'
From Company
Group by Industry_Sector;


--5.	How many Directors that have a Retirement_Age_Directors_Years recorded are over the age of 60?
Select count(Retirement_Age_Directors_Years) as Retired_directors_over60
From Company
Where Retirement_Age_Directors_Years > 60;

--6.	How many Directors have a Board_Membership of "Member" or "Chair", Resignation_date recorded and Retirement_Age_Directors_Years recorded?
Select 
Sum(Case When Board_Membership like 'Member' then 1 Else 0 End) as 'Member',
Sum(Case When Board_Membership like 'Chair' then 1 Else 0 End) as 'Chair'
From Company
Where (Resignation_date is not null) and (Retirement_Age_Directors_Years is not null);

--7.	What is the total revenue per Industry_Sector for Directors that have a Retirement_Age_Directors_Years recorded and served as Chair?
Select Industry_Sector,Format(sum(Revenue)/1000000000, 'N') + 'Billion'as Total_Revenue
From Company
Where (Retirement_Age_Directors_Years is not null) and (Board_Membership like 'Chair')
Group by Industry_Sector
Order by 2 ;

--8.	What is the total revenue per Industry_Sector for Directors who have a Retirement_Age_Directors_Years recorded, 
--have served as "Chair", have a Resignation_date recorded, and have been appointed to the board after 01-01-2015?

Select Industry_Sector, Format(sum(Revenue)/1000000000, 'N') + ' Billion' as Total_Revenue
From Company
Where (Retirement_Age_Directors_Years is not null) and (Board_Membership like 'Chair') and (Resignation_date is not null) and (Board_joining_date > 2015-01-01)
Group by Industry_Sector
Order by 2 desc;

--9.	How many Directors have a Retirement_Age_Directors_Years recorded, have served as a "Member", 
--have a Resignation_date recorded, and have been appointed to the board before 01-01-2010?

Select count(Director_ID) as Number_of_Directors
From Company
Where Retirement_Age_Directors_Years is not null
and Board_Membership like 'Member'
and Resignation_date is not null
and Board_joining_date < '2010-01-01';

--10.	What is the average revenue per Industry_Sector for Directors who joined the board before 01-01-2010, 
--have a Board_Membership of "Chair" or "Member", have a Resignation_date recorded, and have a Retirement_Age_Directors_Years recorded?

Select Industry_Sector, Format(avg(Revenue)/1000000000, 'N') + ' Billion' as Total_Revenue
From Company
Where Board_joining_date < '2010-01-01'
and (Board_Membership like 'Chair' or Board_Membership like 'Member')
and Resignation_date is not null
and Retirement_Age_Directors_Years is not null
Group by Industry_Sector
Order by 2 desc;

--Year over year share of Female Directors in Companies, How the share of Female vs Male Directors is changing in Companies

With Yearly_Directors As (
    Select
        Year(Board_joining_date) as Year,
        Count(Director_ID) as Total_Directors,
        Sum(Case When Gender = 'F' Then 1 Else 0 END) as Female_Directors
    From Company
    Group By YEAR(Board_joining_date)
	--Order by 1
)
Select
    Yearly_Directors.Year,
    (Yearly_Directors.Female_Directors *100/ Yearly_Directors.Total_Directors)  as 'Female Director Percentage % '
From Yearly_Directors
Order By Yearly_Directors.Year;
