-- creating staging table
CREATE TABLE sales_staging
LIKE sales
;

INSERT sales_staging
SELECT *
FROM sales
;

-- standardizing column names
ALTER TABLE sales_staging RENAME COLUMN `Invoice ID` TO invoice_id;
ALTER TABLE sales_staging RENAME COLUMN `Branch` TO branch;
ALTER TABLE sales_staging RENAME COLUMN `City` TO city;
ALTER TABLE sales_staging RENAME COLUMN `Customer type` TO customer_type;
ALTER TABLE sales_staging RENAME COLUMN `Gender` TO gender;
ALTER TABLE sales_staging RENAME COLUMN `Product line` TO product_line;
ALTER TABLE sales_staging RENAME COLUMN `Unit price` TO unit_price;
ALTER TABLE sales_staging RENAME COLUMN `Quantity` TO quantity;
ALTER TABLE sales_staging RENAME COLUMN `Tax 5%` TO tax;
ALTER TABLE sales_staging RENAME COLUMN `Total` TO total;
ALTER TABLE sales_staging RENAME COLUMN `Date` TO dte;
ALTER TABLE sales_staging RENAME COLUMN `Time` TO tme;
ALTER TABLE sales_staging RENAME COLUMN `Payment` TO payment;
ALTER TABLE sales_staging RENAME COLUMN `gross margin percentage` TO gross_mperc;
ALTER TABLE sales_staging RENAME COLUMN `gross income` TO gross_income;
ALTER TABLE sales_staging RENAME COLUMN `Rating` TO rating;

-- checking duplicates
SELECT COUNT(DISTINCT invoice_id)
FROM sales_staging
;

-- updating invoice_id to integer
UPDATE sales_staging
SET invoice_id = REPLACE(invoice_id,'-','')
;

ALTER TABLE sales_staging
MODIFY COLUMN invoice_id INT
;

-- updating dte to date
UPDATE sales_staging
SET dte = STR_TO_DATE(dte, '%m/%d/%Y')
;

ALTER TABLE sales_staging
MODIFY COLUMN dte DATE
;

-- updating tme to time
UPDATE sales_staging
SET tme = STR_TO_DATE(tme, '%H:%i') 
;

ALTER TABLE sales_staging
MODIFY COLUMN tme TIME
;

-- checking for incorrect formats
SELECT DISTINCT branch
FROM sales_staging
;

SELECT DISTINCT city
FROM sales_staging
;

SELECT DISTINCT customer_type
FROM sales_staging
;

SELECT DISTINCT gender
FROM sales_staging
;

SELECT DISTINCT product_line
FROM sales_staging
;

SELECT DISTINCT payment
FROM sales_staging
;