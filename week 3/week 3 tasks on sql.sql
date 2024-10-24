--- SQL CODE REPORT FOR WEEK THREE TASK BY OKORIGWE CLINTON EGWOLOGHENE
--- here, I ran the code to retrieve the most performing product and region for 2015
Select ProductKey, Region, SUM (OrderQuantity) as total_sales
from AdventureWorks_Sales_2015
where OrderDate BETWEEN '01/01/2015' and '12/31/2015'
group by ProductKey,Region
order by total_sales DESC
LIMIT 1
--- it resulted in Australia with 23 total sales for the product with key 377
--- code for the retrivial of the top performing region/ product for 2016
Select ProductKey, Region, SUM (OrderQuantity) as total_sales
from AdventureWorks_Sales_2016
where OrderDate BETWEEN '01/01/2016' and '12/31/2016'
group by ProductKey,Region
order by total_sales DESC
LIMIT 1
----resulting in United States Southwest with 387 total sales for the product 477
----code for the retrivial of the highest performing product for 2016
Select ProductKey, Region, SUM (OrderQuantity) as total_sales
from AdventureWorks_Sales_2017
where OrderDate BETWEEN '01/01/2017' and '12/31/2017'
group by ProductKey,Region
order by total_sales DESC
LIMIT 1
---- result = United States Southwest, product- 477
---sql query for the segregation of customers based on purchasing power
WITH CustomerSpending AS (
    SELECT
        c.CustomerKey, 
        SUM(OrderValue) AS TotalSpent
    FROM
        AdventureWorks_Demographics c
    JOIN 
        AdventureWorks_Sales so ON c.CustomerKey = so.CustomerKey
    GROUP BY
        c.CustomerKey
),
CustomerSegments AS (
    SELECT
        CustomerKey,
        TotalSpent,
        CASE
            WHEN TotalSpent < 1000 THEN 'Low Spender'
            WHEN TotalSpent BETWEEN 1000 AND 5000 THEN 'Medium Spender'
            WHEN TotalSpent > 5000 THEN 'High Spender'
        END AS SpendingSegment
    FROM 
        CustomerSpending
)

SELECT
    cs.CustomerKey,
    cs.TotalSpent,
    cs.SpendingSegment
FROM
    CustomerSegments cs
ORDER BY
    cs.TotalSpent DESC;
---- resulting csv file will be attatched to the folder