-- Easy

-- Write a SQL query to find all duplicate emails in a table named Person.
--
--+----+---------+
--| Id | Email   |
--+----+---------+
--| 1  | a@b.com |
--| 2  | c@d.com |
--| 3  | a@b.com |
--+----+---------+
-- For example, your query should return the following for the above table:
--
--+---------+
--| Email   |
--+---------+
--| a@b.com |
--+---------+

-- Method 1 (749 ms)
SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(Email) > 1

-- Method 2 (489 ms)
SELECT Email
FROM (
    SELECT
        Email
        , COUNT(DISTINCT Id) AS nb
    FROM Person
    GROUP BY Email) AS emailCount
WHERE nb > 1