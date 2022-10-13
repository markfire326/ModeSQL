-- Returns first 100 rows from sqlchallenge1.accounts
  SELECT * FROM sqlchallenge1.accounts LIMIT 100;

-- Returns first 100 rows from sqlchallenge1.orders
  SELECT * FROM sqlchallenge1.orders LIMIT 100;

-- Returns first 100 rows from sqlchallenge1.sales_reps
  SELECT 
		id,
		name,
		region_id
 FROM sqlchallenge1.sales_reps LIMIT 100;

-- Returns first 100 rows from sqlchallenge1.region
  SELECT 
		id,
		name
 FROM sqlchallenge1.region LIMIT 100;
 
 
-- 1. List the account name with the longest website url

SELECT name, LENGTH(website) as length
FROM sqlchallenge1.accounts
ORDER BY length DESC;


-- 2. How many sales rep have the letter 'E' in the names?

SELECT COUNT(name)
FROM sqlchallenge1.sales_reps
WHERE name ILIKE '%e%';


-- 3. What is alphabetically first account name that contains '&' ?


SELECT name
FROM sqlchallenge1.accounts
WHERE name ILIKE '%&%'
ORDER BY name;


-- 4. What is the id of the sales rep that sold the last order in may 2015?


SELECT sr.id, o.occurred_at
FROM sqlchallenge1.sales_reps as sr
JOIN sqlchallenge1.accounts as ac
  ON sr.id = ac.sales_rep_id
JOIN sqlchallenge1.orders as o
  ON ac.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-05-01 00:00:00' AND '2015-05-31 23:59:59'
ORDER BY o.occurred_at DESC;


-- 5. Wow many sales reps represent the north east region?

SELECT COUNT(*)
FROM sqlchallenge1.sales_reps
WHERE region_id = 1;
