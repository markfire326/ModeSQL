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
  r.name,
  COUNT(DISTINCT s.id) AS no_of_sr,
  COUNT(a.id) AS no_of_ac,
  COUNT(DISTINCT s.id)::FLOAT/COUNT(DISTINCT a.id)::FLOAT AS ratio
FROM
  sqlchallenge1.region AS r
LEFT JOIN
  sqlchallenge1.sales_reps AS s
ON
  r.id=s.region_id 
LEFT JOIN
  sqlchallenge1.accounts AS a
ON
  s.id=a.sales_rep_id
GROUP BY r.name 
ORDER BY ratio DESC;




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
  a.name as account_name,
  SUM(o.poster_qty) as poster_purch
FROM 
  sqlchallenge1.accounts as a
JOIN sqlchallenge1.orders as o
ON a.id = o.account_id 
AND a.name IN (
    SELECT a.name
    FROM 
      sqlchallenge1.accounts as a
    JOIN sqlchallenge1.sales_reps as s
    ON a.sales_rep_id =s.id 
    AND s.region_id = 1)
GROUP BY account_name
HAVING SUM(o.poster_qty) = 0;
  


-- 4. How many accounts have never ordered poster?


SELECT
  a.name as account_name,
  a.id,
    CASE 
    WHEN SUM(o.poster_qty) > 0 THEN 'Has Bought'
    ELSE 'Never Bought' 
  END as poster_purchase
FROM 
  sqlchallenge1.orders as o
JOIN sqlchallenge1.accounts as a
ON a.id = o.account_id
GROUP BY a.name, a.id
ORDER BY poster_purchase DESC;



-- 5. What is the most common firstname for account primary pocs?


SELECT
    SUBSTR(primary_poc,1, POSITION(' ' IN primary_poc)) as firstname,
    COUNT(id) as count
FROM sqlchallenge1.accounts
GROUP BY 1
ORDER BY 2 DESC;
