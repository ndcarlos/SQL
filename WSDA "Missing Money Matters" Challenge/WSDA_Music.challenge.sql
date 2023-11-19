/*
Noah Carlos
WSDA "Missing Money Matters"
Challenge Questions
*/

/*Challenge 1/*

/*
1.) How many transactions took place between the years 2011 and 2012?
*/

SELECT	COUNT(*)
FROM Invoice
WHERE InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31';

/*
2.) How much money did WSDA Music make during the same period?
*/

SELECT	SUM(Total)
FROM Invoice
WHERE InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31';


/* Challenge 2*/

/* 
1.) Get a list of customers who made purchases between 2011 and 2012
*/

SELECT Customer.FirstName, Customer.LastName, Invoice.Total
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
WHERE InvoiceDate BETWEEN '2011-01-01' AND '2012 - 12 - 31'
ORDER BY Invoice.Total DESC

/*
2.) Get a list of customers, sales reps, and total transaction amounts
		for each customer between 2011 and 2012
*/

SELECT Customer.FirstName, Customer.LastName, Customer.SupportRepId,  
				Employee.FirstName, Employee.LastName, Invoice.Total
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
WHERE InvoiceDate BETWEEN '2011-01-01' AND '2012 - 12 - 31'


/*
3.) How many transactions are above the average transaction amount 
		during the same time period?
*/

SELECT COUNT(*) as transactions_above_mean
FROM Invoice 
WHERE InvoiceDate BETWEEN '2011-01-01' AND '2012 - 12 - 31'
	AND Total> (SELECT AVG(Total) FROM Invoice)
	
/*
4.) What is the average transaction amount for each year that WSDA
		Music has been in business?
*/

SELECT strftime('%Y', InvoiceDate) AS year, round(avg(Total)) AS annual_average
FROM Invoice 
GROUP BY year


/* Challenge 3 */


/*
1.) Get a list of employees who exceeded the average transaction
		amount from sales they generated during 2011 and 2012.
*/

SELECT Employee.FirstName, Employee.LastName
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId 
WHERE (InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31' ) AND
	(Invoice.Total > (SELECT round(avg(Total)) FROM Invoice))
GROUP BY Employee.EmployeeId

/*
2.) Create a Commission Payout column that displays each employee’s
		commission based on 15% of the sales transaction amount.
*/

SELECT	Employee.FirstName, Employee.LastName, (SUM(Total) * 0.15) AS commission
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
WHERE (InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31' )
GROUP BY EmployeeId

/*
3.) Which employee made the highest commission?

Jane Peacock
*/

/* 
4.) List the customers that the employee identified in the last question.
*/

SELECT DISTINCT Customer.FirstName, Customer.LastName
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
WHERE (InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31' ) AND
	(Employee.EmployeeId = 3)
	
/*
5.) Which customer made the highest purchase?

Results form the query below provide that John Doeein made the highest purchase
*/	

SELECT Customer.FirstName, Customer.LastName, Invoice.Total
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
WHERE (InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31' ) AND
	(Employee.EmployeeId = 3)
ORDER BY Invoice.Total DESC

/*
6.) Look at this customer record—do you see anything suspicious?

The query below shows that John Doeein only made one purchase,  which
was identified in the query above as the largest purchase made that year.
*/

SELECT Invoice.CustomerId, Total
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
WHERE (InvoiceDate BETWEEN '2011-01-01' AND '2012-12-31' )
	AND (Invoice.CustomerId = 60)
	
/*
7.) Who do you conclude is our primary person of interest?

Jane Peacock
*/










