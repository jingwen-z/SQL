-- Medium

-- Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers,
-- total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
-- https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true

SELECT Company.company_code
        , founder
        , COUNT(DISTINCT Lead_Manager.lead_manager_code) AS lead_manager_nb
        , COUNT(DISTINCT Senior_Manager.senior_manager_code) AS senior_manager_nb
        , COUNT(DISTINCT Manager.manager_code) AS manager_nb
        , COUNT(DISTINCT Employee.employee_code) AS employee_nb
FROM Company
JOIN Lead_Manager
ON Company.company_code = Lead_Manager.company_code
JOIN Senior_Manager
ON Lead_Manager.company_code = Senior_Manager.company_code
AND Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
JOIN Manager
ON Senior_Manager.company_code = Manager.company_code
AND Senior_Manager.lead_manager_code = Manager.lead_manager_code
AND Senior_Manager.senior_manager_code = Manager.senior_manager_code
JOIN Employee
ON Manager.company_code = Employee.company_code
AND Manager.lead_manager_code = Employee.lead_manager_code
AND Manager.senior_manager_code = Employee.senior_manager_code
AND Manager.manager_code = Employee.manager_code
GROUP BY Company.company_code, founder
ORDER BY Company.company_code
