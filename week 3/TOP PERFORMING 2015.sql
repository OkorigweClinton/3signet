Select ProductKey, Region, SUM (OrderQuantity) as total_sales
from AdventureWorks_Sales_2015
where OrderDate BETWEEN '01/01/2015' and '12/31/2015'
group by ProductKey,Region
order by total_sales DESC
LIMIT 1