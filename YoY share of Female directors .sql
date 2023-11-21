--Year over year share of Female Directors in Companies, How the share of Female vs Male Directors is changing in Companies
--Creating a View
Create View YoY_Female_Directors
AS
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
--ORDER BY Yearly_Directors.Year;
GO

Select * From YoY_Female_Directors
