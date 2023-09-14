/** Drop tables if exists before creating new ones */
DROP TABLE IF EXISTS job_positions CASCADE;
DROP TABLE IF EXISTS employment_types CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS payrolls CASCADE;
DROP TABLE IF EXISTS leaves CASCADE;
DROP TABLE IF EXISTS training_sessions CASCADE;
DROP TABLE IF EXISTS attendance_records CASCADE;

/** The job_positions table */
CREATE TABLE job_positions (
  "id" SERIAL PRIMARY KEY,
  "position" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);

/** The employment_types table */
CREATE TABLE employment_types (
  "id" SERIAL PRIMARY KEY,
  "type" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);

/** The departments table */
CREATE TABLE departments (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);



/** The employees table */
CREATE TABLE employees (
  "id" SERIAL PRIMARY KEY,
  "first_name" text,
  "last_name" text,
  "department_id" INT,
  "employment_type_id" int,
  "job_position_id" int,
  CONSTRAINT fk_departments FOREIGN KEY (department_id) REFERENCES departments (id),
  CONSTRAINT fk_employment_types FOREIGN KEY (employment_type_id) REFERENCES employment_types (id),
  CONSTRAINT fk_job_positions FOREIGN KEY (job_position_id) REFERENCES job_positions (id),
  "created_at" TIMESTAMP DEFAULT NOW()
);


/** The payrolls table */

CREATE TABLE payrolls (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "amount" text,
  "period_start" TIMESTAMP,
  "period_end" TIMESTAMP,
  "created_at" TIMESTAMP DEFAULT NOW(),
   CONSTRAINT fk_employees FOREIGN KEY (employee_id) REFERENCES employees (id)
);

/** The leaves table */
CREATE TABLE leaves (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "created_at" TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_employees FOREIGN KEY (employee_id) REFERENCES employees (id)
);

/** The training_sessions table */
CREATE TABLE training_sessions (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "created_at" TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_employees FOREIGN KEY (employee_id) REFERENCES employees (id)
);

/** The attendance_records table */
CREATE TABLE attendance_records (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "created_at" TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_employees FOREIGN KEY (employee_id) REFERENCES employees (id)
);


/** Insert dummy data to the tables */
INSERT INTO job_positions (position) VALUES ('chief technology officer'), ('manager'), ('Marketing manager');

INSERT INTO employment_types (type) VALUES ('full-time'), ('part-time');

INSERT INTO departments (name) VALUES ('accounting'), ('ict'), ('maintenance'), ('hrm');

INSERT INTO employees
(first_name, last_name, department_id, employment_type_id, job_position_id) 
VALUES
('John', 'Doe', 1, 1, 1),
('Joy', 'Rubeth', 2, 1, 2),
('Emmanuel', 'Onwukwe', 1, 2, 3);

INSERT INTO payrolls (employee_id, amount, period_start, period_end) VALUES 
(1, 10000, '02-06-2023 10:01:52', '02-07-2023 10:01:52'),
(2, 1000, '02-06-2023 10:01:52', '02-06-2023 10:01:52'),
(3, 50000, '02-06-2023 10:01:52', '02-06-2023 10:01:52');

INSERT INTO leaves (employee_id) VALUES (1), (2), (1), (1);

INSERT INTO training_sessions (employee_id) VALUES (1), (2), (1), (1);

INSERT INTO attendance_records (employee_id) VALUES (1), (2), (1), (1);
