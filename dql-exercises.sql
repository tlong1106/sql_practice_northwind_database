-- 1. Aggregate Functions (AVG, COUNT, MIN, MAX, SUM)

-- Question:
-- Analyze customer purchasing behavior between July 4, 2006, and May 6, 2008. For each customer who placed at least five orders in this period, calculate and report their total number of orders, total sales value, average order value, smallest order, and largest order.

-- 2. Aliasing

-- Question:
-- Generate a report of all orders placed between July 4, 2006, and May 6, 2008. Include the order ID, order date, and the calculated total amount for each order, presented with user-friendly column names appropriate for a sales report.

-- 3. CASE Statements

-- Question:
-- Classify all orders placed between July 4, 2006, and May 6, 2008, into three categories based on their total value: "Small", "Medium", or "Large". Generate a report showing each order’s ID, date, total amount, and its corresponding classification.

-- 4. Common Table Expressions (CTEs)

-- Question:
-- Identify the top three customers by total sales within the date range of July 4, 2006, to May 6, 2008. Use a step-by-step approach that separates the calculation of per-customer totals from the final selection of the top customers.

-- 5. Creating Views

-- Question:
-- Design a reusable view that summarizes each customer’s order count and total purchase amount between July 4, 2006, and May 6, 2008. Once created, query this view to identify high-value customers who made purchases exceeding 10,000 in total during this period.

-- 6. Data Types & Casting

-- Question:
-- Prepare a financial report of order totals between July 4, 2006, and May 6, 2008. Ensure all monetary values are formatted as numbers with two decimal places, using appropriate data type conversions where necessary.

-- 7. Date/Time Functions (NOW, CURRENT_DATE, etc.)

-- Question:
-- Create a dynamic query that lists all orders placed within the last 365 days relative to the current system date. The query should work at any point in time without hardcoding specific dates.

-- 8. EXPLAIN / EXPLAIN ANALYZE

-- Question:
-- Evaluate the performance of a customer sales aggregation query over the date range July 4, 2006, to May 6, 2008. Use database tools to explain how the query is executed, identifying areas where indexes or query changes might improve performance.

-- 9. INDEX

-- Question:
-- A sales report query that joins orders and order_details over the 2006–2008 period is running slowly. Analyze the schema and propose an indexing strategy to optimize query speed. Create the necessary index and verify the performance improvement.

-- 10. JOINs (INNER, LEFT, RIGHT, Self)

-- Question:
-- Write three queries that:

-- List customers who placed at least one order during the target date range.

-- List all customers along with their order counts, including those who placed zero orders.

-- Create a report listing employees and their direct managers using a self-join on the employees table.

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

-- Question:
-- Generate a clean and standardized customer list by transforming company_name fields: trim whitespace, convert to uppercase, and replace common abbreviations (e.g. "LTD." → "LTD"). The final list should be suitable for consistent display in official documents.

-- 16. Subqueries (SELECT, FROM, WHERE)

-- Question:
-- Analyze customer spending by identifying which customers had total purchases above the overall average in the date range July 4, 2006, to May 6, 2008. Use subqueries in different clauses to structure your analysis.

-- 17. Temp Tables

-- Question:
-- Create a temporary table that stores the total sales per customer in the date range July 4, 2006, to May 6, 2008. Then use this table to join back to the main customers table and identify the top-performing accounts.

-- 18. UNION / UNION ALL

-- Question:
-- Generate a unified list of customer IDs with a label indicating whether they are “Domestic” or “International”, based on their country. Combine separate queries for each category using a set operation that preserves all matching rows.

-- 19. Updating / Deleting Data

-- Question:
-- Perform data maintenance by identifying and correcting null or invalid entries in the orders or order_details tables during the target date range. For example, assign a default shipper where missing, or delete line items with zero quantity.

-- 20. Window Functions (ROW_NUMBER, RANK, LAG, etc.)

-- Question:
-- For each customer, rank their orders by total value in descending order within the date range July 4, 2006, to May 6, 2008. Additionally, include a column showing the total value of their previous order (if any). Present a comprehensive view of each customer’s order history and behavior.