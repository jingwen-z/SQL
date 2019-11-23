-- Hard
SELECT Department.Name AS "Department", E1.Name AS "Employee", E1.Salary
FROM Employee AS E1
INNER JOIN Department
ON E1.DepartmentId = Department.Id
WHERE 3 > (
    SELECT COUNT(DISTINCT E2.Salary)
    FROM Employee AS E2
    WHERE E1.DepartmentId = E2.DepartmentId
    AND E2.Salary > E1.Salary
)