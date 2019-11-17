-- Workers
--
-- The following data definition defines an organization's employee hierarchy.
--
-- An employee is a manager if any other employee has their managerId set to the first employees id. An employee who is a manager may or may not also have a manager.
--
-- TABLE employees
--   id INTEGER NOT NULL PRIMARY KEY
--   managerId INTEGER REFERENCES employees(id)
--   name VARCHAR(30) NOT NULL
-- Write a query that selects the names of employees who are not managers.

-- Write only the SQL statement that solves the problem and nothing else.

SELECT name
FROM employees
WHERE id NOT IN (
  SELECT DISTINCT managerId
  FROM employees
  WHERE managerId IS NOT NULL
)