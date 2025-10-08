-- 1. Aggregate Functions (AVG, COUNT, MIN, MAX, SUM)

-- Question:
-- Analyze customer purchasing behavior between July 4, 2006, and May 6, 2008. For each customer who placed at least five orders in this period, calculate and report their total number of orders, total sales value, average order value, smallest order, and largest order.

WITH order_total AS (
  SELECT
    o.customer_id,
    o.order_id,
    SUM(od.quantity*od.unit_price) AS order_value
  FROM orders AS o
  JOIN order_details AS od
    ON o.order_id = od.order_id
  WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
  GROUP BY o.order_id
)
SELECT
  order_total.customer_id,
  COUNT(*) AS order_count,
  ROUND(SUM(order_total.order_value),2) AS total_sales_value,
  ROUND(AVG(order_total.order_value),2) AS avg_order_value,
  ROUND(MIN(order_total.order_value),2) AS min_order_value,
  ROUND(MAX(order_total.order_value),2) AS max_order_value
FROM order_total
GROUP BY order_total.customer_id
HAVING COUNT(*) >=5;

-- 2. Aliasing

-- Question:
-- Generate a report of all orders placed between July 4, 2006, and May 6, 2008. Include the order ID, order date, and the calculated total amount for each order, presented with user-friendly column names appropriate for a sales report.

SELECT
  o.order_id AS "Order ID",
  o.order_date AS "Order Date",
  SUM(od.quantity*od.unit_price) AS "Dollar Amount Ordered"
FROM orders AS o
JOIN order_details AS od
  ON o.order_id = od.order_id
WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
GROUP BY o.order_id, o.order_date;

-- 3. CASE Statements

-- Question:
-- Classify all orders placed between July 4, 2006, and May 6, 2008, into three categories based on their total value: "Small", "Medium", or "Large". Generate a report showing each order’s ID, date, total amount, and its corresponding classification.

SELECT
  o.order_id,
  o.order_date,
  SUM(od.quantity*od.unit_price) AS total_amount,
  CASE
    WHEN SUM(od.quantity*od.unit_price) >= 10000 THEN 'Large'
    WHEN SUM(od.quantity*od.unit_price) BETWEEN 1001 AND 9999 THEN 'Medium'
    WHEN SUM(od.quantity*od.unit_price) <= 1000 THEN 'Small'
  END AS order_size
FROM orders AS o
JOIN order_details AS od
  ON o.order_id = od.order_id
WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
GROUP BY o.order_id, o.order_date;

-- 4. Common Table Expressions (CTEs)

-- Question:
-- Identify the top three customers by total sales within the date range of July 4, 2006, to May 6, 2008. Use a step-by-step approach that separates the calculation of per-customer totals from the final selection of the top customers.

WITH customer_totals AS (
  SELECT
    c.customer_id,
    SUM(od.quantity*od.unit_price) AS total_purchase
  FROM customers AS c
  JOIN orders AS o
    ON c.customer_id = o.customer_id
  JOIN order_details AS od
    ON o.order_id = od.order_id
  WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
  GROUP BY c.customer_id
)
SELECT
  customer_totals.customer_id,
  customer_totals.total_purchase
FROM ad_hoc
ORDER BY ad_hoc.total_purchase DESC
LIMIT 3;

-- 5. Creating Views

-- Question:
-- Design a reusable view that summarizes each customer’s order count and total purchase amount between July 4, 2006, and May 6, 2008. Once created, query this view to identify high-value customers who made purchases exceeding 10,000 in total during this period.

-- CREATE VIEW order_data_view AS SELECT
--                                  c.customer_id,
--                                  COUNT(o.order_id) AS order_count,
--                                  SUM(od.quantity*od.unit_price) AS purchase_total
--                                FROM customers AS c
--                                JOIN orders AS o
--                                  ON c.customer_id = o.customer_id
--                                JOIN order_details AS od
--                                  ON o.order_id = od.order_id
--                                WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
--                                GROUP BY c.customer_id

SELECT *
FROM order_data_view
WHERE purchase_total > 10000
ORDER BY purchase_total DESC;

-- 6. Data Types & Casting

-- Question:
-- Prepare a financial report of order totals between July 4, 2006, and May 6, 2008. Ensure all monetary values are formatted as numbers with two decimal places, using appropriate data type conversions where necessary.

SELECT
  o.order_id,
  ROUND(SUM(od.quantity*od.unit_price),2) AS order_total
FROM orders AS o
JOIN order_details AS od
  ON o.order_id = od.order_id
WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
GROUP BY o.order_id;

-- 7. Date/Time Functions (NOW, CURRENT_DATE, etc.)

-- Question:
-- Create a dynamic query that lists all orders placed within the last 365 days relative to the most recent date in the dataset. The query should work at any point in time without hardcoding specific dates.

-- Note: This query is modified because Northwind database's most recent date is 2008-05-06. Normally this request would use NOW() or CURRENT_DATE()

WITH most_recent_date AS
  (
  SELECT MAX(o.order_date) AS max_date
  FROM orders AS o
  )
SELECT
  o.order_id,
  o.order_date
FROM orders AS o
JOIN most_recent_date
  ON TRUE
WHERE o.order_date BETWEEN most_recent_date.max_date - INTERVAL '365 days' AND most_recent_date.max_date;

-- 8. EXPLAIN / EXPLAIN ANALYZE

-- Question:
-- Evaluate the performance of a customer sales aggregation query over the date range July 4, 2006, to May 6, 2008. Use database tools to explain how the query is executed, identifying areas where indexes or query changes might improve performance.

-- simple example
EXPLAIN SELECT * FROM customers ORDER BY customer_id

EXPLAIN ANALYZE SELECT * FROM customers ORDER BY customer_id; -- includes Sort Method/Memory, Planning Time, Execution Time

-- more complex example

EXPLAIN ANALYZE
SELECT
  customers.customer_id,
  COUNT(order_id)
FROM customers
JOIN orders
  ON customers.customer_id = orders.customer_id
WHERE order_date BETWEEN '2006-07-04' AND '2008-05-06'
GROUP BY customers.customer_id;

-- 1. Read customers table (FROM clause)
-- 2. Create a hash table
-- 3. Filter dates outside of range (WHERE clause)
-- 4. Read orders table (FROM clause)
-- 5. Join tables using hash table (JOIN statement)
-- 6. Recognize GROUP BY
-- 7. COUNT() to produce order_count

EXPLAIN ANALYZE
SELECT
  c.customer_id,
  COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o
  ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
GROUP BY c.customer_id;

-- Adding aliases reduced times on all steps, specificaly:
---- Planning Time: 0.175 (without alias) --> 0.173 (with alias)
---- Execution Time: 1.030 (without alias) --> 0.382 (with alias)

-- 9. INDEX

-- Question:
-- A sales report query that joins orders and order_details over the 2006–2008 period is running slowly. Analyze the schema and propose an indexing strategy to optimize query speed. Create the necessary index and verify the performance improvement.

-- 10. JOINs (INNER, LEFT, RIGHT, Self)

-- Question:
-- Write three queries that:

-- List customers who placed at least one order during the target date range.

SELECT DISTINCT c.customer_id
FROM customers AS c
INNER JOIN orders AS o
  ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06';

-- List all customers along with their order counts, including those who placed zero orders.

SELECT
  c.customer_id,
  COUNT(order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC;

-- Create a report listing employees and their direct managers using a self-join on the employees table.

SELECT
  e.first_name AS employee_first_name,
  e.last_name AS employee_last_name,
  e.title AS employee_title,
  m.first_name AS manager_first_name,
  m.last_name AS manager_last_name,
  m.title AS manager_title
FROM employees AS e
JOIN employees AS m
  ON e.reports_to = m.employee_id
ORDER BY m.title, e.title;

-- 11. JSON Functions (->, ->>, JSONB_EXTRACT_PATH, JSONB_SET)

-- Question:
-- Assume the orders table contains a JSONB column named extra_data holding metadata like promo codes or shipping notes. Create a report that extracts specific JSON fields, updates them to include new data, and filters rows based on JSON content.

-- 12. Pivoting / Unpivoting

-- Question:
-- Produce a pivot table that displays the number of orders placed in each month between July 2006 and May 2008. Each row should represent a year and each column should represent a month (January to December), showing the count of orders placed.

-- 13. Primary Key / Foreign Key

-- Question:
-- List and describe the foreign key relationships in the Northwind database. Then, write a query to validate that all order_details records reference a valid order_id in the orders table, ensuring data integrity.

-- 14. Stored Procedures

-- Question:
-- Create a stored function that accepts a customer ID and a date range, then returns the total number of orders and total purchase value for that customer within the specified period. Use the function to generate results for a sample customer.

-- 15. String Functions (CONCAT, SUBSTRING, TRIM, UPPER, etc.)

-- Question: <-- not a good prompt for this data set; company_name standardized already
-- Generate a clean and standardized customer list by transforming company_name fields: trim whitespace, convert to uppercase, and replace common abbreviations (e.g. "LTD." → "LTD"). The final list should be suitable for consistent display in official documents.

-- 16. Subqueries (SELECT, FROM, WHERE)

-- Question:
-- Analyze customer spending by identifying which customers had total purchases above the overall average in the date range July 4, 2006, to May 6, 2008. Use subqueries in different clauses to structure your analysis.

SELECT
  c.company_name,
  customer_total.order_total,
  (SELECT ROUND(AVG(inner_totals.order_total),2) -- subquery in SELECT clause: scalar value (e.g. single value) on each table row
   FROM (
         SELECT
          o.customer_id,
          SUM(od.unit_price*od.quantity) AS order_total
         FROM orders AS o
         JOIN order_details AS od
           ON o.order_id = od.order_id
         WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
         GROUP BY o.customer_id) AS inner_totals
         ) AS avg_total_spent -- 15218.64 is the scalar value
FROM 
  (SELECT -- subquery in FROM clause: virtual table to show order total per customer
    o.customer_id AS cust_id,
    SUM(od.unit_price*od.quantity) AS order_total
  FROM order_details AS od
  JOIN orders AS o
    ON od.order_id = o.order_id
  WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
  GROUP BY o.customer_id) AS customer_total
JOIN customers AS c
  ON customer_total.cust_id = c.customer_id
WHERE customer_total.order_total > (SELECT AVG(order_total) -- subquery in WHERE clause: filters based on results in FROM clause query
                                    FROM
                                      (SELECT
                                         o.customer_id AS cust_id,
                                         ROUND(SUM(od.unit_price*od.quantity),2) AS order_total
                                       FROM order_details AS od
                                       JOIN orders AS o
                                         ON od.order_id = o.order_id
                                       WHERE o.order_date BETWEEN '2006-07-04' AND '2008-05-06'
                                       GROUP BY o.customer_id) AS avg_subquery
                                   );

-- 17. Temp Tables

-- Question:
-- Create a temporary table that stores the total sales per customer in the date range July 4, 2006, to May 6, 2008. Then use this table to join back to the main customers table and identify the top-performing accounts.

-- 18. UNION / UNION ALL

-- Question:
-- Generate a unified list of customer IDs with a label indicating whether they are “Domestic” or “International”, based on their country. Combine separate queries for each category using a set operation that preserves all matching rows.

SELECT
  customer_id,
  'Domestic' AS loc
FROM customers
WHERE country = 'USA'
UNION ALL
SELECT
  customer_id,
  'International' AS loc
FROM customers
WHERE country != 'USA';

-- 19. Updating / Deleting Data

-- Question:
-- Perform data maintenance by identifying and correcting null or invalid entries in the orders or order_details tables during the target date range. For example, assign a default shipper where missing, or delete line items with zero quantity.

-- 20. Window Functions (ROW_NUMBER, RANK, LAG, etc.)

-- Question:
-- For each customer, rank their orders by total value in descending order within the date range July 4, 2006, to May 6, 2008. Additionally, include a column showing the total value of their previous order (if any). Present a comprehensive view of each customer’s order history and behavior.