-- 

-- JOINs (INNER, LEFT, RIGHT):

--- INNER JOIN:
--- List all orders along with the names of the customers who placed them.

SELECT customers.company_name, orders.order_id
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id;

--- LEFT JOIN:
--- List all customers and any orders they have placed. Include customers with no orders.

SELECT customers.company_name, orders.order_id
FROM customers -- primary table
LEFT JOIN orders ON orders.customer_id = customers.customer_id;

--- RIGHT JOIN:
--- List all orders and their associated employees. Include orders even if the employee is not listed.

SELECT orders.order_id, employees.first_name, employees.last_name
FROM orders -- primary table
RIGHT JOIN employees ON orders.employee_id = employees.employee_id;



-- UNION:
--- Find all cities from both customers and suppliers. Eliminate duplicates.

--- Find all contact names from customers and employees with a label for where each name came from.



-- CASE Statements:
--- Add a column to the order details that categorizes the discount as:
----- 'High Discount' if discount > 0.2
----- 'Medium Discount' if discount between 0.1 and 0.2
----- 'Low or No Discount' otherwise
----- For each product, show a label: 'Discontinued' or 'Available' based on the discontinued flag.



-- Updating, Deleting Data (Use CTEs to preserve original data if needed):
--- UPDATE: Increase the unit price of all products in the "Beverages" category by 10%.

--- DELETE: Delete all records from the orders table where the order date is before January 1, 1997.



-- PARTITION BY:
--- For each employee, list their orders along with a running count of orders they’ve handled (use ROW_NUMBER() or RANK() ----- over a partition by employee).

--- Show the top 2 most expensive products per category using RANK() or DENSE_RANK().



-- Data Types:
--- Create a new table ArchivedOrders with appropriate data types based on selected columns from the orders table. Include ---- an archive date (DATE type) that defaults to CURRENT_DATE.



-- Aliasing:
--- Retrieve product names and their total quantity sold. Use clear table and column aliases to make the query readable.



-- Creating Views:
--- Create a view CustomerOrderSummary that shows:
----- Customer ID
----- Company Name
----- Total Orders
----- Total Quantity Ordered
----- Total Value of Orders (Quantity * Unit Price)



-- HAVING, GROUP BY:
--- List all products that have been sold more than 500 units in total.

--- For each category, show the average unit price of its products. Only include categories with an average price over $20.



-- GETDATE() (or CURRENT_DATE / NOW() in PostgreSQL):
--- Show all orders placed in the last 30 days using NOW() or CURRENT_DATE.

--- Calculate the number of days it took to ship each order (ShippedDate - OrderDate). Label late shipments (>7 days).



-- Primary Key / Foreign Key:
--- Identify all foreign key relationships between these tables:
----- orders, order_details, customers, employees, products, categories, suppliers.

----- Create a diagram or write SQL to show which tables reference products through foreign keys.

