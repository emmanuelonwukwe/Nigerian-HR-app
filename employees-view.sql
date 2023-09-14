DROP VIEW IF EXISTS employees_info;

CREATE VIEW employees_info AS
SELECT
    employees.id, employees.first_name, employees.last_name,
    departments.name AS department,
    employment_types.type AS employment_type,
    job_positions.position AS job_position,
    COUNT(DISTINCT attendance_records.*) AS attendance_count,
    COUNT(DISTINCT leaves.*) AS leave_count
FROM
    employees
LEFT JOIN 
    departments ON employees.id = departments.id
left JOIN
    employment_types ON employees.employment_type_id = employment_types.id
left JOIN
    job_positions ON employees.job_position_id = job_positions.id
left JOIN
    attendance_records ON employees.id = attendance_records.employee_id
left JOIN
    leaves ON attendance_records.employee_id = leaves.employee_id
GROUP BY employees.id, departments.name, employment_types.type, job_positions.position;