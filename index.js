import express from "express";
import sql from "./db.js";

/**
 * This function returns a table of the employee information display employee information
 * and total salary he should receive.
 */
async function show_employee_payroll(employee_id, period_start, period_end) {
  // Get the employee data from the employees_info view created
  const employeeDataArray =
    await sql`SELECT * FROM employees_info WHERE id = ${employee_id}`;
  const employee = employeeDataArray[0];
  //console.log(employee.first_name);

  // Get the employee payrolls with
  const employeePayrolls =
    await sql`SELECT * FROM payrolls WHERE employee_id = ${employee_id}`;
  console.log(employeePayrolls);

  let tr = "";
  // Form the table to display the payroll and the employee info
  employeePayrolls.forEach((payroll) => {
    // create a table row
    tr = tr.concat(
      `<tr>
        <td>${employee.id}</td>
        <td>${employee.first_name}</td>
        <td>${employee.last_name}</td>
        <td>${employee.department}</td>
        <td>${employee.employment_type}</td>
        <td>${employee.job_position}</td>
        <td>${employee.leave_count}</td>
        <td>${employee.attendance_count}</td>
        <td>\$${payroll.amount}</td>
        <td>${payroll.period_start}</td>
        <td>${payroll.period_end}</td>
    </tr>`
    );
  });

  const table = `<table>
    <thead>
        <th>Employee id</th>
        <th>First name</th>
        <th>Last name</th>
        <th>Department</th>
        <th>Employment type</th>
        <th>Job position</th>
        <th>Leaves</th>
        <th>Attendance</th>
        <th>Payroll amount</th>
        <th>Payroll start date</th>
        <th>Payroll end date</th>
    </thead>
    <tbody>
        ${tr}
    </tbody>
  </table>`;

  //console.table(table);
  return table;
}

// Note the time stamp must be correct else it will not be able to select data from the payroll db
show_employee_payroll(2, "2023-02-07 09:01:52", "2023-02-07 09:01:52");
