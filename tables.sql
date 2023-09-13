/** The employees table */
DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
  "id" SERIAL PRIMARY KEY,
  "first_name" text,
  "last_name" text,
  "department_name" text,
  "employment_type" text,
  "job_position" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO employees
(first_name, last_name, department_name, employment_type, job_position) 
VALUES
('John', 'Doe', 'accounting', 'full-time', 'manager'),
('Joy', 'Rubeth', 'ict', 'full-time', 'manager'),
('Emmanuel', 'Onwukwe', 'maintenance', 'part-time', 'manager');

/** The departments table */
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO departments (name) VALUES ('accounting'), ('ict'), ('maintenance'), ('hrm');

/** The job_positions table */
DROP TABLE IF EXISTS job_positions CASCADE;

CREATE TABLE job_positions (
  "id" SERIAL PRIMARY KEY,
  "position" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO job_positions (position) VALUES ('chief technology officer'), ('manager'), ('Marketing manager');

/** The employment_types table */
DROP TABLE IF EXISTS employment_types CASCADE;

CREATE TABLE employment_types (
  "id" SERIAL PRIMARY KEY,
  "type" text,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO employment_types (type) VALUES ('full-time'), ('part-time');

/** The payrolls table */
DROP TABLE IF EXISTS payrolls CASCADE;

CREATE TABLE payrolls (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "amount" text,
  "period_start" TIMESTAMP,
  "period_end" TIMESTAMP,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO employment_types (employee_id, amount, period_start, period_end) VALUES 
(1, 10000, "01-06-2023 10:01:52", "30-06-2023 10:01:52"),
(2, 50000, "20-06-2023 01:01:50", "20-07-2023 01:01:50"),
(3, 1000, "10-05-2023 10:00:00", "10-05-2023 11:00:00");

/** The leaves table */
DROP TABLE IF EXISTS leaves CASCADE;

CREATE TABLE leaves (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO leaves VALUES (1), (2), (1), (1);

/** The training_sessions table */
DROP TABLE IF EXISTS training_sessions CASCADE;

CREATE TABLE training_sessions (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO training_sessions VALUES (1), (2), (1), (1);

/** The attendance_records table */
DROP TABLE IF EXISTS attendance_records CASCADE;

CREATE TABLE attendance_records (
  "id" SERIAL PRIMARY KEY,
  "employee_id" integer,
  "created_at" TIMESTAMP DEFAULT NOW()
);

INSERT INTO training_sessions VALUES (1), (2), (1), (1);


/** Alter the tables and add the foreign keys for the relations */
ALTER TABLE "employees" ADD FOREIGN KEY ("job_position") REFERENCES "job_positions" ("position");

ALTER TABLE "employees" ADD FOREIGN KEY ("employment_type") REFERENCES "employment_types" ("type");

ALTER TABLE "leaves" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "attendance_records" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "employees" ADD FOREIGN KEY ("department_name") REFERENCES "departments" ("name");

ALTER TABLE "training_sessions" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "payrolls" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");
