-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT emp.emp_no, last_name, first_name, gender, sal.salary FROM employees AS emp
INNER JOIN salaries AS sal
ON emp.emp_no = sal.emp_no
ORDER BY emp.emp_no;

-- 2. List employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date LIKE '1986%';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dep.dept_no, dep.dept_name, emp.emp_no, emp.last_name, emp.first_name, depman.from_date, depman.to_date FROM departments AS dep
INNER JOIN dept_manager AS depman
ON depman.dept_no = dep.dept_no
INNER JOIN employees AS emp
ON emp.emp_no = depman.emp_no

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- Ensures employees are selected by their most recent department
SELECT depemp.emp_no, emp.last_name, emp.first_name, dep.dept_name FROM dept_emp AS depemp
INNER JOIN (
	SELECT emp_no, MAX(to_date) AS MaxDate
	FROM dept_emp
	GROUP BY emp_no
) AS ge
ON depemp.emp_no = ge.emp_no
AND depemp.to_date = ge.MaxDate
INNER JOIN departments AS dep
ON dep.dept_no = depemp.dept_no
INNER JOIN employees AS emp
ON emp.emp_no = depemp.emp_no
ORDER BY emp_no


-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees 
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dep.dept_name FROM dept_emp AS depemp
INNER JOIN departments AS dep
ON depemp.dept_no = dep.dept_no
INNER JOIN employees AS emp
ON emp.emp_no = depemp.emp_no
WHERE dep.dept_name = 'Sales'
ORDER BY emp_no

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dep.dept_name FROM dept_emp AS depemp
INNER JOIN departments AS dep
ON depemp.dept_no = dep.dept_no
INNER JOIN employees AS emp
ON emp.emp_no = depemp.emp_no
WHERE dep.dept_name = 'Sales'
OR dep.dept_name = 'Development'
ORDER BY emp_no

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS namecount FROM employees
GROUP BY last_name
ORDER BY namecount DESC