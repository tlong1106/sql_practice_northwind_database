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

-- SELF JOIN:
-- Find each employee and their manager.

SELECT
  e.first_name AS employee_first,
  e.last_name AS employee_last,
  e.title AS employee_title,
  m.first_name AS manager_first,
  m.last_name AS manager_last,
  m.title AS manager_title
FROM employees AS e -- primary table
LEFT JOIN employees AS m
  ON e.reports_to = m.employee_id
ORDER BY e.last_name, e.first_name;

-- Find products that share the same category.

SELECT
  p1.product_id AS prod1_id,
  p1.product_name AS prod1_name,
  p2.product_id AS prod2_id,
  p2.product_name AS prod2_name,
  c.category_name AS shared_category
FROM products AS p1
JOIN products AS p2
  ON p1.category_id = p2.category_id
  AND p1.product_id < p2.product_id
JOIN categories AS c
  ON p1.category_id = c.category_id
ORDER BY p1.category_id, p1.product_id, p2.product_id;



-- UNION:
--- Find all cities from both customers and suppliers. Eliminate duplicates.

SELECT city
FROM customers
UNION
SELECT city
FROM suppliers
ORDER BY city;

--- Find all contact names from customers and employees with a label for where each name came from.

SELECT
  SPLIT_PART(contact_name, ',', 2) AS first_name,
  SPLIT_PART(contact_name, ',', 1) AS last_name,
  city,
  'customers' AS label
FROM customers
UNION
SELECT
  first_name,
  last_name,
  city,
  'employees' AS label
FROM employees
ORDER BY last_name, first_name;



-- CASE Statements:
--- Add a column to the order details that categorizes the discount as:
----- 'High Discount' if discount > 0.2
----- 'Medium Discount' if discount between 0.1 and 0.2
----- 'Low or No Discount' otherwise
----- For each product, show a label: 'Discontinued' or 'Available' based on the discontinued flag.

SELECT
  order_details.*,
  CASE
    WHEN discount > 0.2 THEN 'High Discount'
    WHEN discount BETWEEN 0.1 AND 02 THEN 'Medium Discount'
    ELSE 'Low or No Discount'
  END AS discount_category,
  CASE
    WHEN discontinued = '1' THEN 'Discountinued'
    Else 'Available'
  END AS label
FROM order_details
JOIN products
  ON order_details.product_id = products.product_id;

-- Updating, Deleting Data (Use CTEs to preserve original data if needed):
--- UPDATE: Increase the unit price of all products in the "Beverages" category by 10%.

--- DELETE: Delete all records from the orders table where the order date is before January 1, 1997.



-- PARTITION BY:
--- For each employee, list their orders along with a running count of orders they’ve handled (use ROW_NUMBER() or RANK() ----- over a partition by employee).

SELECT
  o.order_id,
  o.order_date,
  c.customer_id,
  e.first_name,
  e.last_name,
  ROW_NUMBER() OVER(PARTITION BY e.employee_id ORDER BY o.order_date) AS row_num,
  RANK() OVER(PARTITION BY e.employee_id ORDER BY o.order_date) AS rank_num
FROM employees AS e
LEFT JOIN orders AS o
  ON e.employee_id = o.employee_id
JOIN customers AS c
  ON o.customer_id = c.customer_id;

--- Show the top 2 most expensive products per category using RANK() or DENSE_RANK().

WITH ranked_products AS (SELECT 
                           p.product_id,
                           p.product_name,
                           c.category_name,
                           /*DENSE_*/RANK() OVER(PARTITION BY c.category_name ORDER BY p.unit_price) AS rank_num
                         FROM products AS p
                         JOIN categories AS c
                           ON p.category_id = c.category_id
                         ORDER BY p.unit_price DESC)
SELECT *
FROM ranked_products
WHERE rank_num <= 2
ORDER BY category_name, rank_num;



-- Data Types:
--- Create a new table ArchivedOrders with appropriate data types based on selected columns from the orders table. Include ---- an archive date (DATE type) that defaults to CURRENT_DATE.



-- Aliasing:
--- Retrieve product names and their total quantity sold. Use clear table and column aliases to make the query readable.

SELECT
  p.product_name,
  SUM(od.quantity) AS quantity_sold
FROM products AS p
JOIN order_details AS od
  ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY quantity_sold DESC;



-- Creating Views:
--- Create a view CustomerOrderSummary that shows:
----- Customer ID
----- Company Name
----- Total Orders
----- Total Quantity Ordered
----- Total Value of Orders (Quantity * Unit Price)



-- HAVING, GROUP BY:
--- List all products that have been sold more than 500 units in total.

SELECT
  p.product_id,
  p.product_name,
  SUM(quantity) AS total_quantity_sold
FROM products AS p
JOIN order_details AS od
  ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(quantity) > 500
ORDER BY total_quantity_sold DESC;

--- For each category, show the average unit price of its products. Only include categories with an average price over $20.

SELECT
  c.category_id,
  c.category_name,
  ROUND(AVG(p.unit_price),2) AS avg_price
FROM products AS p
JOIN categories AS c
  ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
HAVING AVG(unit_price) > 20
ORDER BY avg_price DESC;



-- GETDATE() (or CURRENT_DATE / NOW() in PostgreSQL):
--- Show all orders placed in the last 30 days using NOW() or CURRENT_DATE.



--- Calculate the number of days it took to ship each order (ShippedDate - OrderDate). Label late shipments (>7 days).



-- Primary Key / Foreign Key:
--- Identify all foreign key relationships between these tables:
----- orders, order_details, customers, employees, products, categories, suppliers.

----- Create a diagram or write SQL to show which tables reference products through foreign keys.

