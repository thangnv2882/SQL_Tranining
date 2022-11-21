-- Note: 36, 37

-- Exercise 1
-- Write a SELECT query to display Full name of all employees in lower-case as following:
SELECT
  LOWER(e.LastName + ' ' + e.FirstName) AS 'Full name',
  e.TitleOfCourtesy AS 'titleOfCourtesy'
FROM
  Employees e

-- Exercise 2
-- Write a SELECT query to display Full name of all employees in upper-case as following:
SELECT
  UPPER(e.LastName + ' ' + e.FirstName) AS 'Full name'
FROM
  Employees e

 --Exercise 3
 --Write a SELECT query to display all employees that are from United States as following:
SELECT
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title,
  e.City,
  e.Country
FROM
  Employees e
WHERE
  e.Country = 'USA'

--Exercise 4
--Write a SELECT query to display all customers that are from UK as following:
SELECT
  c.CustomerID,
  c.CompanyName,
  c.ContactName,
  c.ContactTitle,
  c.Country
FROM
  Customers c
WHERE
  C.Country = 'UK'

--Exercise 5
--Write a SELECT query to display all customers that are from Mexico as following:
SELECT
  c.CustomerID,
  c.CompanyName,
  c.Address,
  c.City,
  c.Country
FROM
  Customers c
WHERE
  C.Country = 'Mexico'

--Exercise 6
--Write a SELECT query to display all customers that are from Sweden as following:
SELECT
  c.CustomerID,
  c.CompanyName,
  c.Phone,
  c.Address,
  c.City,
  c.Country
FROM
  Customers c
WHERE
  C.Country = 'Sweden'

--Exercise 7
--In Products table, values of UnitsInStock tell you the total units in the 
--inventory of every product. Write a SELECT query to display product id, product name, 
--unit price of all products such that their total units in the inventory is between 5 and 10 as following:
SELECT
  p.ProductID,
  p.ProductName,
  p.UnitPrice,
  p.UnitsInStock
FROM
  Products p
WHERE
  p.UnitsInStock > 4
  AND p.UnitsInStock < 11

--Exercise 8
--In Products table, the value of UnitsOnOrder tells you the total ordered units 
--for every product. Write a SELECT query to display product id, product name, unit price, 
--re-order level… of all products that have total ordered units between 60 and 100 as following:
SELECT
  p.ProductID,
  p.ProductName,
  p.UnitPrice,
  p.ReorderLevel,
  p.UnitsOnOrder
FROM
  Products p
WHERE
  p.UnitsOnOrder > 59
  AND p.UnitsOnOrder < 101

--Exercise 9
--Write a SELECT query to display total orders of every employee in 1996 as following:
SELECT
  o.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title,
  YEAR(o.OrderDate) AS 'Year',
  COUNT(*) AS 'Total Order'
FROM
  Orders o
  INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
GROUP BY
  o.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title,
  YEAR(o.OrderDate)
HAVING
  YEAR(o.OrderDate) = 1996

--Exercise 10
--Write a SELECT query to display total orders of every employee in 1998 as following:
SELECT
  o.EmployeeID,
  e.LastName,
  e.FirstName,
  e.City,
  e.Country,
  COUNT(*) AS 'Total Order'
FROM
  Orders o
  INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
GROUP BY
  o.EmployeeID,
  e.LastName,
  e.FirstName,
  e.City,
  e.Country,
  YEAR(o.OrderDate)
HAVING
  YEAR(o.OrderDate) = 1998

--Exercise 11
--Write a SELECT query to display total orders of every employee from 1/1/1998 to 31/7/1998 as following:
SELECT
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.HireDate,
  COUNT(*) AS 'Total Orders'
FROM
  Orders o
  INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE 
  o.OrderDate > '1997-12-31'
  AND o.OrderDate < '1998-08-01'
GROUP BY
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.HireDate


--Exercise 12
--Write a SELECT query to display total orders of every employee from 1/1/1997 to 30/6/1997 as following:
SELECT
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.HireDate,
  COUNT(o.OrderDate) AS 'Total Orders'
FROM
  Orders o
  INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE 
  o.OrderDate > '1996-12-31'
  AND o.OrderDate < '1997-07-01'
GROUP BY
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.HireDate


--Exercise 13
--An order will be taxed 10% if its freight cost is larger than or equal to 100$.
--Otherwise, an order will be taxed 5% if its freight cost is smaller than 100$. 
--Write a SELECT query to show the freight with taxes of orders placed between 1/8/1996 and 5/8/1996 as following:
SELECT
  o.OrderID,
  DAY(o.OrderDate)   AS 'OrderDay',
  MONTH(o.OrderDate) AS 'OrderMonth',
  YEAR(o.OrderDate)  AS 'Orderyear',
  o.Freight,
  CASE
    WHEN o.Freight < 100 THEN '5%'
    ELSE '10%'
  END AS 'Tax',
  CASE
    WHEN o.Freight < 100 THEN o.Freight * 1.05
    ELSE o.Freight * 1.1
  END AS 'FreightWithTax'
FROM
  Orders o

-- Bonus 13
SELECT
  o.OrderID,
  DAY(o.OrderDate)   AS 'OrderDay',
  MONTH(o.OrderDate) AS 'OrderMonth',
  YEAR(o.OrderDate)  AS 'Orderyear',
  o.Freight,
  IIF(o.Freight < 100, '5%', '10%') AS 'Tax',
  IIF(o.Freight < 100, o.Freight * 1.05, o.Freight * 1.1) AS 'FreightWithTax'
FROM
  Orders o

--Bonus 13 has bug
--declare @tax int
--set @tax = 0
--select
--  DAY(o.OrderDate) as 'OrderDay',
--  MONTH(o.OrderDate) as 'OrderMonth',
--  YEAR(o.OrderDate) as 'Orderyear',
--  o.Freight,
--  @tax in (select IIF(o2.Freight < 100, 5, 10) FROm Orders o2)
--FROm
--  Orders o

--Exercise 14
--Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
---	If title of courtesy is ‘Mr.’ then sex is set to ‘Male’
---	If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘Female’
SELECT
  e.LastName + ' ' + e.FirstName AS 'Fullname',
  e.TitleOfCourtesy,
  CASE
    e.titleOfCourtesy
    WHEN 'Mr.' THEN 'Male'
	WHEN 'Ms.' THEN 'Female'
	WHEN 'Mrs.' THEN 'Female'
    ELSE '...'
  END AS 'Sex'
FROM
  Employees e

-- Bonus 14
SELECT
  e.LastName + ' ' + e.FirstName AS 'Fullname',
  e.TitleOfCourtesy,
  CASE
    WHEN e.titleOfCourtesy = 'Mr.' THEN 'Male'
	WHEN e.titleOfCourtesy = 'Ms.' OR e.titleOfCourtesy = 'Mrs.' THEN 'Female'
    ELSE '...'
  END AS 'Sex'
FROM
  Employees e


--  Exercise 15
--	Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
---	If title of courtesy is ‘Mr.’ or ‘Dr.’ then sex is set to ‘M’
---	If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘F’
SELECT
  e.LastName + ' ' + e.FirstName AS 'Fullname',
  e.TitleOfCourtesy,
  CASE
    WHEN e.titleOfCourtesy = 'Mr.' OR e.titleOfCourtesy = 'Dr.' THEN 'M'
    WHEN e.titleOfCourtesy = 'Ms.' OR e.titleOfCourtesy = 'Mrs.' THEN 'F'
  END AS 'Sex'
FROM
  Employees e


--  Exercise 16
--	Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
---	If title of courtesy is ‘Mr.’ then sex is set to ‘Male’
---	If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘Female’
---	If title of courtesy is not ‘Mr.’ and not ‘Mrs.’ and not ‘Ms.’ then sex is set to ‘Unknown’
SELECT
  e.LastName + ' ' + e.FirstName AS 'Fullname',
  e.TitleOfCourtesy,
  CASE
    WHEN e.titleOfCourtesy = 'Mr.' THEN 'Male'
	WHEN e.titleOfCourtesy = 'Ms.' OR e.titleOfCourtesy = 'Mrs.' THEN 'Female'
    ELSE 'Unknown'
  END AS 'Sex'
FROM
  Employees e


--	Exercise 17
--	Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
---	If title of courtesy is ‘Mr.’ then sex is set to 1
---	If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to 0
---	If title of courtesy is not ‘Mr.’ and not ‘Mrs.’ and not ‘Ms.’ then sex is set to 2
SELECT
  e.LastName + ' ' + e.FirstName AS 'Fullname',
  e.TitleOfCourtesy,
  CASE
    WHEN e.titleOfCourtesy = 'Mr.' THEN '1'
	WHEN e.titleOfCourtesy = 'Ms.' OR e.titleOfCourtesy = 'Mrs.' THEN '0'
    ELSE '2'
  END AS 'Sex'
FROM
  Employees e


--  Exercise 18
--	Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
--	If title of courtesy is ‘Mr.’ then sex is set to ‘M’
--	If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘F’
--	If title of courtesy is not ‘Mr.’ and not ‘Mrs.’ and not ‘Ms.’ then sex is set to ‘N/A’

SELECT
  e.LastName + ' ' + e.FirstName AS 'Fullname',
  e.TitleOfCourtesy,
  CASE
    WHEN e.titleOfCourtesy = 'Mr.' THEN 'M'
	WHEN e.titleOfCourtesy = 'Ms.' OR e.titleOfCourtesy = 'Mrs.' THEN 'F'
    ELSE 'N/A'
  END AS 'Sex'
FROM
  Employees e


--Exercise 21
--Write a query to determine the revenues for all products from 1/7/1996 
--to 5/7/1996 as following (Revenue = Quantity * Unitprice). Note: 
--The output must be order by category id and then product id.

SELECT
  p.CategoryID,
  c.CategoryName,
  p.ProductID,
  p.ProductName,
  DAY(o.OrderDate)                AS 'Day',
  MONTH(o.OrderDate)              AS 'Month',
  YEAR(o.OrderDate)               AS 'Year',
  SUM(od.Quantity * od.UnitPrice) AS 'Revenue'
FROM
  products p
  INNER JOIN [ORDER Details] od ON od.ProductID = p.ProductID
  INNER JOIN Orders o ON o.OrderID = od.OrderID
  INNER JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY
  p.CategoryID,
  c.CategoryName,
  p.ProductID,
  p.ProductName,
  o.OrderDate
HAVING
  o.OrderDate > '1996-07-01'
  AND o.OrderDate < '1996-07-06'


--Exercise 22
--Write a query to display information about 7-days late orders and 
--their employees (an order is called late if it is shipped after required date):
SELECT
  o.EmployeeID,
  e.LastName,
  e.FirstName,
  o.OrderID,
  o.OrderDate,
  o.RequiredDate,
  o.ShippedDate
FROM
  Orders o
  INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE
  o.ShippedDate - o.RequiredDate > 7

--Exercise 23
--Write a query to display the names and telephone numbers of all employees 
--and all customers satisfy the condition:  all customers have names start with ‘W’.
SELECT
  c.CompanyName,
  c.Phone
FROM
  Customers c
WHERE
  c.CompanyName LIKE 'W%'
UNION
SELECT
  e.LastName + ' ' + e.FirstName,
  e.HomePhone
FROM
  Employees e


--Exercise 24
--Write a query to display information about the customer that placed 
--the order with Id equal to 10643 as following:
SELECT
  o.CustomerID,
  c.CompanyName,
  c.ContactName,
  c.ContactTitle
FROM
  Orders o
  INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE
  o.OrderID = 10643

--Exercise 25
--Write a query to display the product ids, product names and total units 
--ordered of all products that satisfy: the total units ordered must be greater 
--than or equal to 1200 units.
SELECT
  od.ProductID,
  p.ProductName,
  SUM(od.Quantity) AS 'Total Order'
FROM
  [ORDER Details] od
  INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY
  od.ProductID,
  p.ProductName
HAVING
  SUM(od.Quantity) >= 1200

--Exercise 26
--Write a query to display the product ids, product names, supplier id, 
--category id and total units ordered of all products that satisfy: 
--the total units ordered must be greater than or equal to 1400 units.
SELECT
  od.ProductID,
  p.ProductName,
  s.SupplierID,
  p.CategoryID,
  SUM(od.Quantity) AS 'Total Order'
FROM
  [ORDER Details] od
  INNER JOIN Products p ON p.ProductID = od.ProductID
  INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID
GROUP BY
  od.ProductID,
  p.ProductName,
  s.SupplierID,
  p.CategoryID
HAVING
  SUM(od.Quantity) >= 1400


--Exercise 27
--Write a query to display the categories that have maximum total product as following:
SELECT
  p.CategoryID,
  c.CategoryName,
  COUNT(*) AS 'Total Products'
FROM
  Products p
  INNER JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY
  p.CategoryID,
  c.CategoryName
HAVING
  COUNT(*) = (
    SELECT
      MAX(item.mycount)
    FROM
      (
        SELECT
          p1.CategoryID,
          COUNT(*) mycount
        FROM
          Products p1
        GROUP BY
          p1.CategoryID
      ) item
  )

--Bonus 27: Không hợp lý lắm :v
SELECT
  TOP(1)                       
  p.CategoryID,
  c.CategoryName,
  COUNT(p.ProductID) AS 'Total Products'
FROM
  Products p
  INNER JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY
  p.CategoryID,
  c.CategoryName
ORDER BY
  [Total Products] DESC


--Exercise 28
--Write a query to display the categories that have minimum total product as following:
SELECT
  p.CategoryID,
  c.CategoryName,
  COUNT(*) AS 'Total Products'
FROM
  Products p
  INNER JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY
  p.CategoryID,
  c.CategoryName
HAVING
  COUNT(*) = (
    SELECT
      MIN(item.cnt)
    FROM
      (
        SELECT
          p1.CategoryID,
          COUNT(*) cnt
        FROM
          Products p1
        GROUP BY
          p1.CategoryID
      ) item
  )

--Exercise 29
--Write a query to display the total record in Customer and Employees tables:
SELECT
  e.cnt + c.cnt AS 'Total record'
FROM
  (
    SELECT
      COUNT(*) cnt
    FROM
      Employees
  ) AS e,
  (
    SELECT
      COUNT(*) cnt
    FROM
      Customers
  ) AS c


--Exercise 30
--Write a query to display information about employees who have minimum total orders as following:
SELECT
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title,
  SUM(od.Quantity) AS 'Total Orders'
FROM
  Employees e
  INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
  INNER JOIN [ORDER Details] od ON od.OrderID = o.OrderID
GROUP BY
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title
HAVING
  SUM(od.Quantity) = (
    SELECT
      MIN(item.cnt)
    FROM
      (
        SELECT
          o.EmployeeID,
          SUM(od1.Quantity) cnt
        FROM
          [ORDER Details] od1
          INNER JOIN Orders o ON o.OrderID = od1.OrderID
        GROUP BY
          o.EmployeeID
      ) item
  )


--Exercise 31
--Write a query to display information about employees who have maximum total orders as following:
SELECT
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title,
  SUM(od.Quantity) AS 'Total Orders'
FROM
  Employees e
  INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
  INNER JOIN [ORDER Details] od ON od.OrderID = o.OrderID
GROUP BY
  e.EmployeeID,
  e.LastName,
  e.FirstName,
  e.Title
HAVING
  SUM(od.Quantity) = (
    SELECT
      MAX(item.s)
    FROM
      (
        SELECT
          o.EmployeeID,
          SUM(od1.Quantity) s
        FROM
          [ORDER Details] od1
          INNER JOIN Orders o ON o.OrderID = od1.OrderID
        GROUP BY
          o.EmployeeID
      ) item
  )


--Exercise 32
--In Products table, the value of UnitsInStock tells you the total unit in the inventory for every product.  
--Write a query to display information about products that have maximum total unit in inventory as following:
SELECT
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID,
  SUM(p.UnitsInStock) AS 'UnitsInStock'
FROM
  Products p
GROUP BY
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID
HAVING
  SUM(p.UnitsInStock) = (
    SELECT
      MAX(item.s)
    FROM
      (
        SELECT
          p1.ProductID,
          SUM(p1.UnitsInStock) s
        FROM
          Products p1
        GROUP BY
          p1.ProductID
      ) item
  )

--Exercise 33
--In Products table, the value of UnitsInStock tells you the total unit in the inventory for every product.  
--Write a query to display information about products that have minimum total unit in inventory as following:
SELECT
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID,
  SUM(p.UnitsInStock) AS 'UnitsInStock'
FROM
  Products p
GROUP BY
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID
HAVING
  SUM(p.UnitsInStock) = (
    SELECT
      MIN(item.s)
    FROM
      (
        SELECT
          p1.ProductID,
          SUM(p1.UnitsInStock) s
        FROM
          Products p1
        GROUP BY
          p1.ProductID
      ) item
  )

--Exercise 34
--In Products table, the value of UnitsOnOrder tells you the total ordered unit for every product.  
--Write a query to display information about products that have maximum total ordered unit as following:
SELECT
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID,
  SUM(p.UnitsOnOrder) AS 'UnitsOnOrder'
FROM
  Products p
GROUP BY
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID
HAVING
  SUM(p.UnitsOnOrder) = (
    SELECT
      MAX(item.s)
    FROM
      (
        SELECT
          p1.ProductID,
          SUM(p1.UnitsOnOrder) s
        FROM
          Products p1
        GROUP BY
          p1.ProductID
      ) AS item
  )

--Exercise 35
--In Products table, the value of ReOrderLevel tells you the re-order level for every product.  
--Write a query to display information about products that have maximum re-order level as following:
SELECT
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID,
  SUM(p.ReOrderLevel) AS 'ReOrderLevel'
FROM
  Products p
GROUP BY
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  p.CategoryID
HAVING
  SUM(p.ReOrderLevel) = (
    SELECT
      MAX(item.s)
    FROM
      (
        SELECT
          p1.ProductID,
          SUM(p1.ReOrderLevel) s
        FROM
          Products p1
        GROUP BY
          p1.ProductID
      ) item
  )


--Exercise 36
--Write a query to display the information about employees who have maximum total delayed-orders as following:
--SELECT
--  e.EmployeeID,
--  e.LastName,
--  e.FirstName,
--  COUNT(o.OrderID)
--FROM
--  Employees e
--  INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID
--GROUP BY
--  e.EmployeeID,
--  e.LastName,
--  e.FirstName
--HAVING
--  MAX(o.OrderID) = (
--    SELECT
--	  MAX(item.c)
--    FROM
--      (
--        SELECT
--		  o.EmployeeID,
--          COUNT(*) c
--        FROM
--		  Orders o
--		WHERE 
--			o.ShippedDate - o.RequiredDate > 0
--        GROUP BY
--		  o.EmployeeID
--      ) AS item
--  )

SELECT
  MAX(item.c)
FROM
(
        SELECT
		  o.EmployeeID,
          COUNT(*) c
        FROM
		  Orders o
		WHERE 
			o.ShippedDate - o.RequiredDate > 0
        GROUP BY
		  o.EmployeeID
      ) item
	  
	  


--Exercise 37
--Write a query to display the information about employees who have at least 
--one delayed-order and have minimum total delayed-orders as following:


--Exercise 38
--Write a query to display product ids and product names of all products that have
--total ordered-units in three-highest level (top 3 to top 1) as following:
SELECT
  *
FROM
  (
    SELECT
      TOP(3)                     
	  p.ProductID,
      p.ProductName,
      SUM(od.Quantity) AS 'Total Orders'
    FROM
      Products p
      INNER JOIN [ORDER Details] od ON od.ProductID = p.ProductID
    GROUP BY
      p.ProductID,
      p.ProductName
    ORDER BY
      [Total Orders] DESC
  ) as demo
ORDER BY
  [Total Orders] ASC


--Exercise 39
--Write a query to display product ids and product names of all products 
--that have total ordered-units in five-highest level (top 5 to top 1) as following:

SELECT
  *
FROM
  (
    SELECT
      TOP(5)                     
	  p.ProductID,
      p.ProductName,
      SUM(od.Quantity) AS 'Total Orders'
    FROM
      Products p
      INNER JOIN [ORDER Details] od ON od.ProductID = p.ProductID
    GROUP BY
      p.ProductID,
      p.ProductName
    ORDER BY
      [Total Orders] DESC
  ) demo
ORDER BY
  [Total Orders] ASC