--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 6/73: Introducing Window Functions With OVER
--YTD Sales Via Aggregate Query:
SELECT
      [Total YTD Sales] = SUM(SalesYTD)
      ,[Max YTD Sales] = MAX(SalesYTD)
FROM AdventureWorks2019.Sales.SalesPerson;

---- Insert the total YTD sales and the performance of the top salesperson in each row of the table
---- Calculate their % contribution as a % of the best performer
--YTD Sales With OVER:
SELECT BusinessEntityID
      ,TerritoryID
      ,SalesQuota
      ,Bonus
      ,CommissionPct
      ,SalesYTD
	  ,SalesLastYear
      ,[Total YTD Sales] = SUM(SalesYTD) OVER()
      ,[Max YTD Sales] = MAX(SalesYTD) OVER()
      ,[% of Best Performer] = SalesYTD/MAX(SalesYTD) OVER()
FROM AdventureWorks2019.Sales.SalesPerson;

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 7/73: Introducing Window Functions With OVER - Exercises
---- Exercise 1:
-- Create a query with the following columns:
-- FirstName and LastName, from the Person.Person table**
-- JobTitle, from the HumanResources.Employee table**
-- Rate, from the HumanResources.EmployeePayHistory table**
-- A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row
SELECT
	A.FirstName
	,A.LastName
	,B.JobTitle
	,C.Rate
	,AVG(C.Rate) OVER() AS "AveragerRate"
FROM
	AdventureWorks2019.Person.Person AS A
	INNER JOIN
	AdventureWorks2019.HumanResources.Employee AS B
	ON A.BusinessEntityID = B.BusinessEntityID
	INNER JOIN
	AdventureWorks2019.HumanResources.EmployeePayHistory AS C
	ON A.BusinessEntityID = C.BusinessEntityID;

SELECT * FROM AdventureWorks2019.Person.Person; --A
SELECT * FROM AdventureWorks2019.HumanResources.Employee; --B
SELECT * FROM AdventureWorks2019.HumanResources.EmployeePayHistory; --C

---- Exercise 2:Enhance your query from Exercise 1 by adding a derived column called "MaximumRate" that
---- returns the largest of all values in the "Rate" column, in each row
SELECT
	A.FirstName
	,A.LastName
	,B.JobTitle
	,C.Rate
	,AVG(C.Rate) OVER() AS "AveragerRate"
	,MAX(C.Rate) OVER() AS "MaximumRate"
FROM
	AdventureWorks2019.Person.Person AS A
	INNER JOIN
	AdventureWorks2019.HumanResources.Employee AS B
	ON A.BusinessEntityID = B.BusinessEntityID
	INNER JOIN
	AdventureWorks2019.HumanResources.EmployeePayHistory AS C
	ON A.BusinessEntityID = C.BusinessEntityID;

---- Exercise 3: Enhance your query from Exercise 2 by adding a derived column called "DiffFromAvgRate" that returns the result of the following calculation:
---- An employees's pay rate, MINUS the average of all values in the "Rate" column.
SELECT
	A.FirstName
	,A.LastName
	,B.JobTitle
	,C.Rate
	,AVG(C.Rate) OVER() AS "AveragerRate"
	,MAX(C.Rate) OVER() AS "MaximumRate"
	,C.Rate - (AVG(C.Rate) OVER()) AS "DiffFromAvgRate"
FROM
	AdventureWorks2019.Person.Person AS A
	INNER JOIN
	AdventureWorks2019.HumanResources.Employee AS B
	ON A.BusinessEntityID = B.BusinessEntityID
	INNER JOIN
	AdventureWorks2019.HumanResources.EmployeePayHistory AS C
	ON A.BusinessEntityID = C.BusinessEntityID;

---- Exercise 4: Enhance your query from Exercise 3 by adding a derived column called
---- "PercentofMaxRate" that returns the result of the following calculation:
---- An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.
SELECT
	A.FirstName
	,A.LastName
	,B.JobTitle
	,C.Rate
	,AVG(C.Rate) OVER() AS "AveragerRate"
	,MAX(C.Rate) OVER() AS "MaximumRate"
	,C.Rate - (AVG(C.Rate) OVER()) AS "DiffFromAvgRate"
	,(C.Rate / (MAX(C.Rate) OVER()))*100 AS "PercentofMaxRate"
FROM
	AdventureWorks2019.Person.Person AS A
	INNER JOIN
	AdventureWorks2019.HumanResources.Employee AS B
	ON A.BusinessEntityID = B.BusinessEntityID
	INNER JOIN
	AdventureWorks2019.HumanResources.EmployeePayHistory AS C
	ON A.BusinessEntityID = C.BusinessEntityID;

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 8/73: PARTITION BY
--Sum of line totals, grouped by ProductID AND OrderQty, in an aggregate query
SELECT
	ProductID,
	OrderQty,
	LineTotal = SUM(LineTotal)
FROM AdventureWorks2019.Sales.SalesOrderDetail
GROUP BY
	ProductID,
	OrderQty
ORDER BY 1,2 DESC;

--Sum of line totals via OVER with PARTITION BY
SELECT
	ProductID,
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY ProductID, OrderQty)
FROM AdventureWorks2019.Sales.SalesOrderDetail
ORDER BY ProductID, OrderQty DESC;

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 9/73: PARTITION BY - Exercises
---- Exercise 1: Create a query with the following columns:
---- “Name” from the Production.Product table, which can be alised as “ProductName”
---- “ListPrice” from the Production.Product table
---- “Name” from the Production. ProductSubcategory table, which can be alised as “ProductSubcategory”*
---- “Name” from the Production.ProductCategory table, which can be alised as “ProductCategory”**
---- *Join Production.ProductSubcategory to Production.Product on “ProductSubcategoryID”
---- **Join Production.ProductCategory to ProductSubcategory on “ProductCategoryID”
---- All the tables can be inner joined, and you do not need to apply any criteria.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

---- Exercise 2: Enhance your query from Exercise 1 by adding a derived column called
---- "AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
	,AVG(ListPrice) OVER(PARTITION BY C."Name") AS "AvgPriceByCategory"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

---- Exercise 3:Enhance your query from Exercise 2 by adding a derived column called
---- "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
	,AVG(ListPrice) OVER(PARTITION BY C."Name") AS "AvgPriceByCategory"
	,AVG(ListPrice) OVER(PARTITION BY C."Name", A."Name") AS "AvgPriceByCategoryAndSubcategory"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

---- Exercise 4:Enhance your query from Exercise 3 by adding a derived column called
---- "ProductVsCategoryDelta" that returns the result of the following calculation:
---- A product's list price, MINUS the average ListPrice for that product’s category.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
	,AVG(ListPrice) OVER(PARTITION BY C."Name") AS "AvgPriceByCategory"
	,AVG(ListPrice) OVER(PARTITION BY C."Name", A."Name") AS "AvgPriceByCategoryAndSubcategory"
	,ListPrice - AVG(ListPrice) OVER(PARTITION BY C."Name") AS "ProductVsCategoryDelta"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 10/73: ROW_NUMBER
--Ranking all records within each group of sales order IDs
SELECT
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
	Ranking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM AdventureWorks2019.Sales.SalesOrderDetail
ORDER BY SalesOrderID;

--Ranking ALL records by line total - no groups!
SELECT
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
	Ranking = ROW_NUMBER() OVER(ORDER BY LineTotal DESC)
FROM AdventureWorks2019.Sales.SalesOrderDetail
ORDER BY 5;

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 11/73: ROW_NUMBER - Exercises
---- Exercise 1:
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

---- Exercise 2:
---- Enhance your query from Exercise 1 by adding a derived column called
---- "Price Rank" that ranks all records in the dataset by ListPrice, in descending order.
---- That is to say, the product with the most expensive price should have a rank of 1, and the
---- product with the least expensive price should have a rank equal to the number of records in the dataset.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
	,ROW_NUMBER() OVER(ORDER BY ListPrice DESC) AS "Price Rank"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

---- Exercise 3:
---- Enhance your query from Exercise 2 by adding a derived column called
---- "Category Price Rank" that ranks all products by ListPrice – within each category - in descending order.
---- In other words, every product within a given category should be ranked relative to other products in the same category.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
	,ROW_NUMBER() OVER(ORDER BY ListPrice DESC) AS "Price Rank"
	,ROW_NUMBER() OVER(PARTITION BY C."Name" ORDER BY ListPrice DESC) AS "Category Price Rank"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

---- Exercise 4:Enhance your query from Exercise 3 by adding a derived column called
---- "Top 5 Price In Category" that returns the string “Yes” if a product has one of the top 5 list
---- prices in its product category, and “No” if it does not. You can try incorporating your logic from Exercise 3 into a CASE statement to make this work.
SELECT
	B."Name" AS "ProductName"
	,ListPrice AS "ListPrice"
	,A."Name" AS "ProductSubcategory"
	,C."Name" AS "ProductCategory"
	,ROW_NUMBER() OVER(ORDER BY ListPrice DESC) AS "Price Rank"
	,ROW_NUMBER() OVER(PARTITION BY C."Name" ORDER BY ListPrice DESC) AS "Category Price Rank"
	,CASE WHEN ROW_NUMBER() OVER(PARTITION BY C."Name" ORDER BY ListPrice DESC) <= 5 THEN 'Yes' ELSE 'No' END AS "Top 5 Price In Category"
FROM
	AdventureWorks2019.Production.ProductSubcategory AS A
	INNER JOIN
	AdventureWorks2019.Production.Product AS B
	ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN
	AdventureWorks2019.Production.ProductCategory AS C
	ON A.ProductCategoryID = C.ProductCategoryID;

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 12/73: RANK and DENSE_RANK

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 13/73: RANK and DENSE_RANK - Exercises

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 14/73: LEAD and LAG

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 15/73: LEAD and LAG - Exercises

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 16/73: Introducing subqueries

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 17/73: Introducing subqueries - Exercises

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 18/73: Scalar Subqueries

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 19/73: Scalar Subqueries - Exercises

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 20/73: Correlated Subqueries

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 21/73: Correlated Subqueries - Exercises

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 22/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 23/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 24/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 25/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 26/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 27/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 28/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 29/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 30/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 31/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 32/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 33/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 34/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 35/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 36/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 37/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 38/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 39/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 40/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 41/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 42/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 43/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 44/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 45/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 46/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 47/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 48/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 49/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 50/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 51/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 52/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 53/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 54/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 55/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 56/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 57/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 58/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 59/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 60/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 61/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 62/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 63/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 64/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 65/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 66/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 67/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 68/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 69/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 70/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 71/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 72/73:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 73/73:



