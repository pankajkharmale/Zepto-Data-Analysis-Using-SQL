create database zepto_sql_project;
use zepto_sql_project;


# count of rows 
SELECT count(*) FROM zepto_v2;

# sample data
SELECT * FROM zepto_v2
LIMIT 10;

# null values
SELECT * FROM zepto_v2
WHERE name IS NULL 
or
category IS NULL 
or
mrp IS NULL 
or
discountPercent IS NULL 
or
discountedSellingPrice IS NULL 
or
weightInGms IS NULL 
or
availableQuantity IS NULL 
or
outOfStock IS NULL 
or
quantity IS NULL ;

# diffrent product categories
SELECT distinct category
FROM zepto_v2
ORDER BY category;

# products in stock vs out of stock
SELECT outOfStock, count(sku_id)
FROM zepto_v2
group by outOfStock;

# product with price = 0
SELECT * FROM zepto_v2
WHERE mrp = 0 or discountedSellingPrice = 0;

delete FROM zepto_v2
where mrp = 0;
 
 # convert paise to repees 
update zepto_v2
SET mrp = mrp/100.0 ,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp , discountedSellingPrice FROM zepto_v2;

# Product with high MRP nut out of stock
SELECT DISTINCT name,mrp
FROM zepto_v2
WHERE outOFStock = TRUE  and mrp > 300
ORDER BY mrp DESC ;

# Estimated Revenue for each category
SELECT category,
sum(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
group by category
order by total_revenue;

# All products where MRP is greater than 500rs and discount is less than 10%
select distinct name, mrp, discountPercent
FROM zepto_v2
Where mrp>500 AND discountPercent < 10
order by mrp desc, discountPercent desc;


# Group products into categories like Low, Medium, Bulk.
select distinct name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
    END AS weight_category
FROM zepto_v2;