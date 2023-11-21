--% of Companies disclosing Retirement age of Directors

Create View Perc_Companies_disclosing_Retirement_age_Directors
As
Select count(Distinct Case When Retirement_Age_Directors_Years is not null Then Company_Name Else null End)*100 / Count(Distinct Company_Name) AS '% Companies_Disclosing_Retirement_Age_Directors'
From Company;
GO
Select * from Perc_Companies_disclosing_Retirement_age_Directors