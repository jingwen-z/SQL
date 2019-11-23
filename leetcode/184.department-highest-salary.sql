-- Medium
SELECT Department.Name AS "Department", Employee.Name AS "Employee", Employee.Salary AS Salary
FROM Employee
INNER JOIN Department
ON Employee.DepartmentId = Department.Id
WHERE (Employee.DepartmentId, Employee.Salary) IN (
    SELECT Employee.DepartmentId, MAX(Salary)
    FROM Employee
    GROUP BY Employee.DepartmentId
)