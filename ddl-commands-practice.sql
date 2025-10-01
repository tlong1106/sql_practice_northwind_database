--- This file documents changes to the Northwind databse using data definition language (DDL), including:
--- SQL commands to change table names from CREATES, INSERTS in northwind.sql to better align with the schema in GitHub
--- SQL commands to align data types when mismatched between tables during insertion


--- Drop blank tables:

DROP TABLE customercustomerdemographic;

DROP TABLE customerdemographic;

--- Update table, column names to align with entity-relation diagram:

ALTER TABLE category
RENAME TO categories;

ALTER TABLE categories
RENAME COLUMN categoryid TO category_id;

ALTER TABLE categories
RENAME COLUMN categoryname TO category_name;

---

ALTER TABLE product
RENAME TO products;

ALTER TABLE products
RENAME COLUMN productid TO product_id;

ALTER TABLE products
RENAME COLUMN productname TO product_name;

ALTER TABLE products
RENAME COLUMN supplierid TO supplier_id;

ALTER TABLE products
RENAME COLUMN categoryid TO category_id;

ALTER TABLE products
RENAME COLUMN quantityperunit TO quantity_per_unit;

ALTER TABLE products
RENAME COLUMN unitprice TO unit_price;

ALTER TABLE products
RENAME COLUMN unitsinstock TO units_in_stock;

ALTER TABLE products
RENAME COLUMN unitsonorder TO units_on_order;

ALTER TABLE products
RENAME COLUMN reorderlevel TO reorder_level;

ALTER TABLE products
RENAME COLUMN quantityperunit TO quantity_per_unit;

---

ALTER TABLE supplier
RENAME TO suppliers;

ALTER TABLE suppliers
RENAME COLUMN supplierid TO supplier_id;

ALTER TABLE suppliers
RENAME COLUMN companyname TO company_name;

ALTER TABLE suppliers
RENAME COLUMN contactname TO contact_name;

ALTER TABLE suppliers
RENAME COLUMN contacttitle TO contact_title;

ALTER TABLE suppliers
RENAME COLUMN postalcode TO postal_code;

---

ALTER TABLE orderdetail
RENAME TO order_details;

ALTER TABLE order_details
RENAME COLUMN orderid TO order_id;

ALTER TABLE order_details
RENAME COLUMN productid TO product_id;

ALTER TABLE order_details
RENAME COLUMN unitprice TO unit_price;

ALTER TABLE order_details
RENAME COLUMN qty TO quantity;

---

ALTER TABLE salesorder
RENAME TO orders;

ALTER TABLE orders
RENAME COLUMN orderid TO order_id;

ALTER TABLE orders
RENAME COLUMN custid TO customer_id;

ALTER TABLE orders
RENAME COLUMN empid TO employee_id;

ALTER TABLE orders
RENAME COLUMN orderdate TO order_date;

ALTER TABLE orders
RENAME COLUMN requireddate TO required_date;

ALTER TABLE orders
RENAME COLUMN shippeddate TO shipped_date;

ALTER TABLE orders
RENAME COLUMN shipperid TO ship_via;

ALTER TABLE orders
RENAME COLUMN orderid TO order_id;

ALTER TABLE orders
RENAME COLUMN shipname TO ship_name;

ALTER TABLE orders
RENAME COLUMN shipaddress TO ship_address;

ALTER TABLE orders
RENAME COLUMN shipcity TO ship_city;

ALTER TABLE orders
RENAME COLUMN shipregion TO ship_region;

ALTER TABLE orders
RENAME COLUMN shippostalcode TO ship_postal_code;

ALTER TABLE orders
RENAME COLUMN shipcountry TO ship_country;

---

ALTER TABLE customer
RENAME TO customers;

ALTER TABLE customers
RENAME COLUMN custid TO customer_id;

ALTER TABLE customers
RENAME COLUMN companyname TO company_name;

ALTER TABLE customers
RENAME COLUMN contactname TO contact_name;

ALTER TABLE customers
RENAME COLUMN contacttitle TO contact_title;

ALTER TABLE customers
RENAME COLUMN postalcode TO postal_code;

---

ALTER TABLE employee
RENAME TO employees;

ALTER TABLE employees
RENAME COLUMN empid TO employee_id;

ALTER TABLE employees
RENAME COLUMN lastname TO first_name;

ALTER TABLE employees
RENAME COLUMN firstname TO last_name;

ALTER TABLE employees
RENAME COLUMN titleofcourtesy TO title_of_courtesy;

ALTER TABLE employees
RENAME COLUMN birthdate TO birth_date;

ALTER TABLE employees
RENAME COLUMN hiredate TO hire_date;

ALTER TABLE employees
RENAME COLUMN postalcode TO postal_code;

ALTER TABLE employees
RENAME COLUMN homephone TO home_phone;

ALTER TABLE employees
RENAME COLUMN mgrid TO reports_to;

ALTER TABLE employees
RENAME COLUMN photopath TO photo_path;

---

ALTER TABLE employeeterritory
RENAME TO employee_territories;

ALTER TABLE employee_territories
RENAME COLUMN employeeid TO employee_id;

ALTER TABLE employee_territories
RENAME COLUMN territoryid TO territory_id;

---

ALTER TABLE territory
RENAME TO territories;

ALTER TABLE territories
RENAME COLUMN territoryid TO territory_id;

ALTER TABLE territories
RENAME COLUMN territorydescription TO territory_description;

ALTER TABLE territories
RENAME COLUMN regionid TO region_id;

---

ALTER TABLE region
RENAME COLUMN regionid TO region_id;

ALTER TABLE region
RENAME COLUMN regiondescription TO region_description;

---

ALTER TABLE shipper
RENAME TO shippers;

ALTER TABLE shippers
RENAME COLUMN shipperid TO shipper_id;

ALTER TABLE shippers
RENAME COLUMN companyname TO company_name;

-- Update data types:

ALTER TABLE orders
ALTER COLUMN customer_id TYPE INTEGER
USING customer_id::INTEGER;