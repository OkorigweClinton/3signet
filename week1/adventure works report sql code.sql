--- 1. I imported data from the 10 tables to create the AdventureWorks Database 
---creating fact table AdventureWorks_Sales
CREATE TABLE AdventureWorks_Sales AS
SELECT * FROM AdventureWorks_Sales_2015
UNION ALL
SELECT * FROM AdventureWorks_Sales_2016
UNION ALL
SELECT * FROM AdventureWorks_Sales_2017;
---The Dimension Tables are Caendar, Customer, Products and Territory tables
---Creating Primary Key(PK) for Dimension Tables
/* I went to the "modify table" option after clicking on "Database Structures" and checked and updated the PK for each of these tables
AdventureWorks_Calendar PK = OrderDate, AdventureWorks_Customers PK = CustomerKey,
AdventureWorks_Products PK = ProductKey, AdventureWorks_Territories PK = TerritoryKey*/
---Modififying mismatch Primary Keys to match field name in Fact Table 
ALTER TABLE AdventureWorks_Calendar RENAME COLUMN "Date" TO OrderDate;
ALTER TABLE AdventureWorks_Territories RENAME COLUMN SalesTerritoryKey TO TerritoryKey;
----Creating FOREIGN Keys on Fact Tables
/*I went to modify table for AdventureWorks_Sales and checked the Foreign KEY for the fields
OrderDate FK = AdventureWorks_Calendar ,CustomerKey FK = AdventureWorks_Customers,
ProductKey FK = AdventureWorks_Products , TerritoryKey FK = AdventureWorks_Territories*/
---- Ensure Data Integrity and Foreign Key in Fact Table matches Primary Key in Dimension TABLE
PRAGMA foreign_keys = ON;
---- Checking for missing values
SELECT * FROM AdventureWorks_Calendar WHERE OrderDate IS NULL;
SELECT * FROM AdventureWorks_Customers WHERE CustomerKey IS NULL;
SELECT * FROM AdventureWorks_Products WHERE ProductKey IS NULL;
SELECT * FROM AdventureWorks_Territories WHERE TerritoryKey IS NULL;
--- Checking and cleaning for duplicates
SELECT OrderDate COUNT(*) FROM AdventureWorks_Calendar GROUP BY OrderDate HAVING COUNT(*) > 1;
DELETE FROM AdventureWorks_Calendar WHERE rowid NOT IN (SELECT MIN(rowid) FROM AdventureWorks_Calendar GROUP BY OrderDate);
DELETE FROM AdventureWorks_Customers WHERE rowid NOT IN (SELECT MIN(rowid) FROM AdventureWorks_Customers GROUP BY CustomerKey);
DELETE FROM AdventureWorks_Products WHERE rowid NOT IN (SELECT MIN(rowid) FROM AdventureWorks_Products GROUP BY ProductKey);
DELETE FROM AdventureWorks_Territories WHERE rowid NOT IN (SELECT MIN(rowid) FROM AdventureWorks_Territories GROUP BY TerritoryKey);
---I created a new column namred region to convert the data in territory keys to theor corresponding regions
ALTER TABLE AdventureWorks_Sales ADD Region VARCHAR(50);
---I updated the column with valuse from Territory Key and converting them to theri corresponding regions
UPDATE AdventureWorks_Sales set Region = 'United States NorthWest' where TerritoryKey =1;
UPDATE AdventureWorks_Sales set Region = 'United States NorthEast' where TerritoryKey = 2;
UPDATE AdventureWorks_Sales set Region = 'United States Central' where TerritoryKey = 3;
UPDATE AdventureWorks_Sales set Region = 'United States SouthWest' where TerritoryKey = 4;
UPDATE AdventureWorks_Sales set Region = 'United States SouthEast' where TerritoryKey = 5;
UPDATE AdventureWorks_Sales set Region = 'Canada' where TerritoryKey = 6;
UPDATE AdventureWorks_Sales set Region = 'France' where TerritoryKey = 7;
UPDATE AdventureWorks_Sales set Region = 'Germany' where TerritoryKey = 8;
UPDATE AdventureWorks_Sales set Region = 'Australia' where TerritoryKey = 9;
UPDATE AdventureWorks_Sales set Region = 'United Kingdom' where TerritoryKey = 10;
--- Then saved the SQL codes for future references

