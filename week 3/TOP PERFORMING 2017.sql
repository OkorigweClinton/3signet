Select ProductKey, Region, SUM (OrderQuantity) as total_sales
from AdventureWorks_Sales_2017
where OrderDate BETWEEN '01/01/2017' and '12/31/2017'
group by ProductKey,Region
order by total_sales DESC
LIMIT 1