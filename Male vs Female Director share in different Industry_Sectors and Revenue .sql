--Find out Male vs Female Director share in different Industry_Sectors and Revenue Category
--Revenue Catrgory - 
--$100M to < $300M
--$300M to < $1B
--Below $100M
--20 B and Above
--$3B to < $10B
--$10B to < $20B

-- Create the CTE for revenue categories and director counts
WITH CTE_Revenue_Category AS (
    SELECT 
        Director_ID, 
        Industry_Sector,
        Gender,
        CASE 
            WHEN Revenue >= 100000000 AND Revenue < 300000000 THEN '$100M to < $300M'
            WHEN Revenue >= 300000000 AND Revenue < 1000000000 THEN '$300M to < $1B'
            WHEN Revenue < 100000000 THEN 'Below $100M'
            WHEN Revenue >= 20000000000 THEN '$20B and Above'
            WHEN Revenue >= 3000000000 AND Revenue < 10000000000 THEN '$3B to < $10B'
            WHEN Revenue >= 10000000000 AND Revenue < 20000000000 THEN '$10B to < $20B'
            ELSE 'Other'
        END AS Revenue_Category
    FROM Company
)

-- Calculate male and female director counts and percentages
SELECT
    CTE_Revenue_Category.Revenue_Category,
    CTE_Revenue_Category.Industry_Sector,
    SUM(CASE WHEN Gender = 'M' THEN 1 ELSE 0 END) AS Male_Directors,
    SUM(CASE WHEN Gender = 'F' THEN 1 ELSE 0 END) AS Female_Directors,
    SUM(CASE WHEN Gender = 'M' THEN 1 ELSE 0 END) * 100.0 / COUNT(Director_ID) AS 'Male_Percentage %',
    SUM(CASE WHEN Gender = 'F' THEN 1 ELSE 0 END) * 100.0 / COUNT(Director_ID) AS 'Female_Percentage %'
FROM CTE_Revenue_Category
GROUP BY CTE_Revenue_Category.Revenue_Category, CTE_Revenue_Category.Industry_Sector
-- Order the results outside of the CTE
ORDER BY CTE_Revenue_Category.Industry_Sector, CTE_Revenue_Category.Revenue_Category;
