-- Students
--
-- Given the following data definition, write a query that returns the number of
-- students whose first name is John. String comparisons should be case sensitive.
--
-- TABLE students
--    id INTEGER PRIMARY KEY,
--    firstName VARCHAR(30) NOT NULL,
--    lastName VARCHAR(30) NOT NULL
--
-- Write only the SQL statement that solves the problem and nothing else.

SELECT COUNT(DISTINCT id)
FROM students
WHERE firstName = 'John'