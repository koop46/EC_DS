USE Hoppet


-- Create 
INSERT INTO Staff (names, address, phoneNr, product)
VALUES ('Ronaldo', 'Rio de janeiro street 9', 0739, 'Sambusa')


--Read
select * from Customers


-- Update
update Customers
SET companyName = 'NIKE LTD',
address = 'Drottninggatan 11',
phoneNr = 111
WHERE customerID = 1


-- Delete
DELETE FROM Staff
WHERE staffID = 6


-- Join
SELECT Customers.companyName, Sales.product_amount, Sales.salesDate
FROM Sales
INNER JOIN Customers on Sales.customerID = Customers.customerID


-- Nested query, range
SELECT Staff.names, Staff.product, Sales.product_amount 
FROM Staff
INNER JOIN Sales on Staff.product = Sales.product
WHERE Sales.product_amount IN (
    SELECT max(Sales.product_amount)
    FROM Sales)


-- count amount of sales between 5 and 10
SELECT Sales.product, COUNT (Sales.product_amount) as Amount_of_sales_between_5_and_10 FROM Sales
    WHERE product_amount BETWEEN 5 AND 10
    GROUP BY Sales.product


-- average amount of sales first 5 days of month
SELECT AVG(product_amount) as Average_daily_sales_first_5_days_of_February FROM Sales
    WHERE salesDate BETWEEN '2022-2-1' and '2022-2-6'


-- top, order by
SELECT TOP 5 * FROM Invoice 
    ORDER BY due_date ASC


-- group by
SELECT reference, sum(total) as Customer_Tab FROM Invoice 
GROUP BY reference
ORDER BY Customer_Tab DESC

-- variables
DECLARE @LSA NVARCHAR(MAX) =(
    SELECT TOP 1 SUM(Sales.product_amount) FROM Sales
    GROUP BY Sales.product
    ORDER BY SUM(Sales.product_amount)

)

DECLARE @LSP NVARCHAR(MAX) =(
    SELECT TOP 1 Sales.product FROM Sales
    WHERE Sales.product_amount IN (
        SELECT TOP 3 SUM(Sales.product_amount) FROM Sales
        GROUP BY Sales.product
        ORDER BY SUM(Sales.product_amount))       
)

DECLARE @LSS NVARCHAR(MAX) = (
SELECT TOP 1 Staff.names FROM Staff
INNER JOIN Sales ON Staff.product = Sales.product
GROUP BY Staff.[names]
ORDER BY SUM(Sales.product_amount)
)


SELECT
@LSP AS 'Least sold product',
@LSA AS 'Least sold total Amount',
@LSS AS 'Least sold staff'



