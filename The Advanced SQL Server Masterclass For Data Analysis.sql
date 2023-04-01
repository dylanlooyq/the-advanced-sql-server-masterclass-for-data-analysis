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
FROM
	AdventureWorks2019.Person.Person AS A
	INNER JOIN
	AdventureWorks2019.HumanResources.Employee AS B;


SELECT * FROM AdventureWorks2019.Person.Person; --A
SELECT * FROM AdventureWorks2019.HumanResources.Employee; --B
SELECT * FROM AdventureWorks2019.HumanResources.EmployeePayHistory; --C

---- Exercise 2:
---- Exercise 3:
---- Exercise 4:

--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 8/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 9/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 10/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 11/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 12/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 13/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 14/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 15/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 16/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 17/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 18/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 19/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 20/73:
--------------------------------------------------------------------------------------------------------------------------------------------
---- Lecture 21/73:
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
