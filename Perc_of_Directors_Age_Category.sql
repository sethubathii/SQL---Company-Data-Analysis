--% of Directors in mentioned Age Category 
--40 Years or Below
--41 to 60 Years
--61 to 72 Years
--Above 72 Years

Create View Perc_of_Directors_Age_Category
AS
With Age_Category As (
	Select Director_ID,
	Case When Age <= 40 Then 'Director_Below_40'
		 When Age > 40 AND Age <= 60 Then 'Director_Between_41_to_60'
		 When Age > 60 AND Age <= 72 Then 'Director_Between_61_to_72'
		 When Age > 72  Then 'Director_Above_72'
		 Else 'Other'
	End as Age_Category
	From Company
)
Select Age_Category,
	   Count(Director_ID) as Total_Directors,
	   Count(Director_ID) * 100 / (Select Count(Director_ID) From Company) as '% Percentage'
From Age_Category
Group by Age_Category
--Order by Age_Category;
GO

Select * From Perc_of_Directors_Age_Category