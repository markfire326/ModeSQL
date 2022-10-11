-- Link to the tables: https://app.mode.com/sqlchallenge1/tables

-- Returns first 100 rows from sqlchallenge1.accounts
  SELECT * FROM sqlchallenge1.accounts;
  
  -- Returns first 100 rows from sqlchallenge1.orders
  SELECT * FROM sqlchallenge1.orders;
  
  -- Returns first 100 rows from sqlchallenge1.region
  SELECT * FROM sqlchallenge1.region LIMIT 100;
  
  -- Returns first 100 rows from sqlchallenge1.sales_reps
  SELECT * FROM sqlchallenge1.sales_reps;
  

-- 1. Which region has the lowest proportion of sales reps to accounts?

SELECT 
  r.name as region_name, COUNT(s.id) as no_of_reps
FROM 
  sqlchallenge1.sales_reps as s
JOIN 
  sqlchallenge1.region as r
ON r.id = s.region_id 
GROUP BY r.name 
ORDER BY no_of_reps DESC;




-- 2. Among sales reps Tia Amato, Delilah Krum and Soraya Fulton, which ones had accounts with the greatest total quantity ordered (not USD) in September 2016?

SELECT 
  s.name as name,
  SUM(o.total) as total_qty
FROM 
  sqlchallenge1.sales_reps AS s
JOIN 
 sqlchallenge1.accounts as a
ON 
  s.id = a.sales_rep_id
JOIN 
 sqlchallenge1.orders as o
ON 
  o.account_id = a.id 
WHERE s.name IN ('Tia Amato','Delilah Krum','Soraya Fulton')
AND o.occurred_at BETWEEN '2016-09-01 00:00:00' AND '2016-09-30 23:59:59'
GROUP BY s.name
ORDER BY total_qty DESC;



-- 3. Of accounts served by sales reps in the Northeast, one account has NEVER bought any posters. Which one?


SELECT 
    DISTINCT a.name as account_name,
    SUM(o.poster_qty) as poster_purchase
FROM 
    sqlchallenge1.orders as o
JOIN sqlchallenge1.accounts as a
ON a.id = o.account_id
JOIN sqlchallenge1.sales_reps as s
ON s.id = a.sales_rep_id
JOIN sqlchallenge1.region as r
ON r.id = s.region_id 
WHERE
  r.id = 1
GROUP BY a.name  
HAVING SUM(o.poster_qty) <= 0; 
  


-- 4. How many accounts have never ordered poster?


SELECT 
  DISTINCT a.name as account_name,
  COUNT(a.name) as poster_purchase
FROM 
    sqlchallenge1.orders as o
JOIN sqlchallenge1.accounts as a
ON a.id = o.account_id
GROUP BY a.name  
HAVING SUM(o.poster_qty) = 0;



-- 5. What is the most common firstname for account primary pocs?


SELECT DISTINCT primary_poc as pocname, COUNT(primary_poc)
FROM sqlchallenge1.accounts
GROUP BY pocname
ORDER BY 2 DESC
