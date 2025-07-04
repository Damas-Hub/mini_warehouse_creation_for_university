-- University Course Registration System - Operational Database
-- Create operational tables for the source system

-- Create database
CREATE DATABASE IF NOT EXISTS university_system;
USE university_system;

-- Departments table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(10) UNIQUE NOT NULL,
    building VARCHAR(50),
    phone VARCHAR(20),
    head_faculty_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Faculty table
CREATE TABLE faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT,
    position VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'Active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Add foreign key constraint for department head
ALTER TABLE departments 
ADD FOREIGN KEY (head_faculty_id) REFERENCES faculty(faculty_id);

-- Students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    phone VARCHAR(20),
    enrollment_date DATE,
    status VARCHAR(20) DEFAULT 'Active',
    gpa DECIMAL(3,2) DEFAULT 0.00,
    total_credits INT DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT NOT NULL,
    department_id INT,
    level VARCHAR(20),
    prerequisites TEXT,
    status VARCHAR(20) DEFAULT 'Active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Semesters table
CREATE TABLE semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    semester_name VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'Active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_semester (semester_name, year)
);

-- Course sections table
CREATE TABLE course_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    faculty_id INT,
    semester_id INT,
    section_number VARCHAR(10),
    max_capacity INT,
    current_enrollment INT DEFAULT 0,
    schedule_days VARCHAR(20),
    start_time TIME,
    end_time TIME,
    room VARCHAR(20),
    building VARCHAR(50),
    delivery_mode VARCHAR(20) DEFAULT 'In-Person',
    status VARCHAR(20) DEFAULT 'Active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id),
    UNIQUE KEY unique_section (course_id, semester_id, section_number)
);

-- Enrollments table
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    section_id INT,
    enrollment_date DATE,
    status VARCHAR(20) DEFAULT 'Enrolled',
    final_grade DECIMAL(5,2),
    letter_grade VARCHAR(2),
    completion_date DATE,
    credits_earned INT DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (section_id) REFERENCES course_sections(section_id),
    UNIQUE KEY unique_enrollment (student_id, section_id)
);

-- Create indexes for better performance
CREATE INDEX idx_enrollments_student ON enrollments(student_id);
CREATE INDEX idx_enrollments_section ON enrollments(section_id);
CREATE INDEX idx_enrollments_date ON enrollments(enrollment_date);
CREATE INDEX idx_sections_course ON course_sections(course_id);
CREATE INDEX idx_sections_semester ON course_sections(semester_id);
CREATE INDEX idx_courses_department ON courses(department_id);
-- Load sample data into operational tables
USE university_system;

-- Insert Departments
INSERT INTO departments (department_name, department_code, building, phone) VALUES
('Computer Science', 'CS', 'Tech Building', '555-0101'),
('Mathematics', 'MATH', 'Science Hall', '555-0102'),
('Business Administration', 'BUS', 'Business Center', '555-0103'),
('English Literature', 'ENG', 'Liberal Arts', '555-0104'),
('Psychology', 'PSY', 'Social Sciences', '555-0105'),
('Engineering', 'ENGR', 'Engineering Complex', '555-0106'),
('Biology', 'BIO', 'Life Sciences', '555-0107'),
('History', 'HIST', 'Humanities', '555-0108');

-- Insert Faculty
INSERT INTO faculty (first_name, last_name, email, department_id, position, hire_date, salary) VALUES
('John', 'Smith', 'j.smith@university.edu', 1, 'Professor', '2015-08-15', 85000.00),
('Sarah', 'Johnson', 's.johnson@university.edu', 1, 'Associate Professor', '2018-01-10', 75000.00),
('Michael', 'Brown', 'm.brown@university.edu', 2, 'Professor', '2012-09-01', 80000.00),
('Emily', 'Davis', 'e.davis@university.edu', 2, 'Assistant Professor', '2020-08-20', 65000.00),
('Robert', 'Wilson', 'r.wilson@university.edu', 3, 'Professor', '2010-01-15', 90000.00),
('Lisa', 'Anderson', 'l.anderson@university.edu', 3, 'Associate Professor', '2017-03-10', 78000.00),
('David', 'Taylor', 'd.taylor@university.edu', 4, 'Professor', '2014-08-25', 72000.00),
('Jennifer', 'Martinez', 'j.martinez@university.edu', 5, 'Associate Professor', '2019-01-08', 70000.00),
('Christopher', 'Garcia', 'c.garcia@university.edu', 6, 'Professor', '2011-09-12', 95000.00),
('Amanda', 'Rodriguez', 'a.rodriguez@university.edu', 7, 'Assistant Professor', '2021-08-30', 68000.00);

-- Update department heads
UPDATE departments SET head_faculty_id = 1 WHERE department_id = 1;
UPDATE departments SET head_faculty_id = 3 WHERE department_id = 2;
UPDATE departments SET head_faculty_id = 5 WHERE department_id = 3;
UPDATE departments SET head_faculty_id = 7 WHERE department_id = 4;
UPDATE departments SET head_faculty_id = 8 WHERE department_id = 5;

-- Insert Students
INSERT INTO students (first_name, last_name, email, date_of_birth, phone, enrollment_date, gpa, total_credits) VALUES
('Alice', 'Cooper', 'alice.cooper@student.edu', '2002-03-15', '555-1001', '2020-08-25', 3.75, 45),
('Bob', 'Miller', 'bob.miller@student.edu', '2001-07-22', '555-1002', '2020-08-25', 3.20, 48),
('Carol', 'White', 'carol.white@student.edu', '2002-11-08', '555-1003', '2020-08-25', 3.90, 42),
('Daniel', 'Lee', 'daniel.lee@student.edu', '2001-05-12', '555-1004', '2020-08-25', 2.85, 39),
('Eva', 'Thompson', 'eva.thompson@student.edu', '2003-01-30', '555-1005', '2021-08-23', 3.60, 30),
('Frank', 'Harris', 'frank.harris@student.edu', '2002-09-18', '555-1006', '2021-08-23', 3.40, 33),
('Grace', 'Clark', 'grace.clark@student.edu', '2003-04-25', '555-1007', '2021-08-23', 3.85, 36),
('Henry', 'Lewis', 'henry.lewis@student.edu', '2001-12-03', '555-1008', '2020-08-25', 3.15, 51),
('Iris', 'Walker', 'iris.walker@student.edu', '2003-08-14', '555-1009', '2022-08-22', 3.70, 18),
('Jack', 'Hall', 'jack.hall@student.edu', '2002-06-07', '555-1010', '2021-08-23', 2.95, 27);

-- Insert Courses
INSERT INTO courses (course_code, course_name, description, credits, department_id, level) VALUES
('CS101', 'Introduction to Programming', 'Basic programming concepts using Python', 3, 1, 'Undergraduate'),
('CS201', 'Data Structures', 'Advanced data structures and algorithms', 4, 1, 'Undergraduate'),
('CS301', 'Database Systems', 'Database design and management', 3, 1, 'Undergraduate'),
('CS401', 'Software Engineering', 'Software development methodologies', 4, 1, 'Undergraduate'),
('MATH101', 'Calculus I', 'Differential calculus', 4, 2, 'Undergraduate'),
('MATH201', 'Calculus II', 'Integral calculus', 4, 2, 'Undergraduate'),
('MATH301', 'Linear Algebra', 'Matrices and vector spaces', 3, 2, 'Undergraduate'),
('BUS101', 'Introduction to Business', 'Fundamentals of business', 3, 3, 'Undergraduate'),
('BUS201', 'Marketing Principles', 'Basic marketing concepts', 3, 3, 'Undergraduate'),
('BUS301', 'Financial Management', 'Corporate finance principles', 4, 3, 'Undergraduate'),
('ENG101', 'English Composition', 'Writing and communication skills', 3, 4, 'Undergraduate'),
('PSY101', 'Introduction to Psychology', 'Basic psychological principles', 3, 5, 'Undergraduate');

-- Insert Semesters
INSERT INTO semesters (semester_name, year, start_date, end_date) VALUES
('Fall', 2022, '2022-08-22', '2022-12-15'),
('Spring', 2023, '2023-01-16', '2023-05-12'),
('Summer', 2023, '2023-06-05', '2023-07-28'),
('Fall', 2023, '2023-08-21', '2023-12-14'),
('Spring', 2024, '2024-01-15', '2024-05-10'),
('Summer', 2024, '2024-06-03', '2024-07-26'),
('Fall', 2024, '2024-08-19', '2024-12-12');

-- Insert Course Sections
INSERT INTO course_sections (course_id, faculty_id, semester_id, section_number, max_capacity, schedule_days, start_time, end_time, room, building) VALUES
-- Fall 2022
(1, 1, 1, '001', 30, 'MWF', '09:00:00', '09:50:00', '101', 'Tech Building'),
(1, 2, 1, '002', 30, 'TTH', '10:00:00', '11:15:00', '102', 'Tech Building'),
(2, 1, 1, '001', 25, 'MWF', '11:00:00', '11:50:00', '103', 'Tech Building'),
(5, 3, 1, '001', 35, 'MWF', '08:00:00', '08:50:00', '201', 'Science Hall'),
(5, 4, 1, '002', 35, 'TTH', '13:00:00', '14:15:00', '202', 'Science Hall'),
(8, 5, 1, '001', 40, 'MW', '14:00:00', '15:15:00', '301', 'Business Center'),
(11, 7, 1, '001', 25, 'TTH', '09:00:00', '10:15:00', '401', 'Liberal Arts'),
(12, 8, 1, '001', 30, 'MWF', '10:00:00', '10:50:00', '501', 'Social Sciences'),

-- Spring 2023
(1, 2, 2, '001', 30, 'MWF', '09:00:00', '09:50:00', '101', 'Tech Building'),
(2, 1, 2, '001', 25, 'TTH', '11:00:00', '12:15:00', '103', 'Tech Building'),
(3, 2, 2, '001', 20, 'MWF', '13:00:00', '13:50:00', '104', 'Tech Building'),
(6, 3, 2, '001', 35, 'MWF', '08:00:00', '08:50:00', '201', 'Science Hall'),
(7, 4, 2, '001', 30, 'TTH', '14:00:00', '15:15:00', '203', 'Science Hall'),
(9, 6, 2, '001', 35, 'MW', '15:00:00', '16:15:00', '302', 'Business Center'),

-- Fall 2023
(1, 1, 4, '001', 30, 'MWF', '09:00:00', '09:50:00', '101', 'Tech Building'),
(2, 2, 4, '001', 25, 'TTH', '10:00:00', '11:15:00', '103', 'Tech Building'),
(3, 1, 4, '001', 20, 'MWF', '14:00:00', '14:50:00', '104', 'Tech Building'),
(4, 2, 4, '001', 20, 'TTH', '13:00:00', '14:15:00', '105', 'Tech Building'),
(5, 3, 4, '001', 35, 'MWF', '08:00:00', '08:50:00', '201', 'Science Hall'),
(6, 4, 4, '001', 35, 'TTH', '09:00:00', '10:15:00', '202', 'Science Hall'),
(10, 5, 4, '001', 30, 'MW', '16:00:00', '17:15:00', '303', 'Business Center');

-- Insert Enrollments with realistic patterns
INSERT INTO enrollments (student_id, section_id, enrollment_date, status, final_grade, letter_grade, completion_date, credits_earned) VALUES
-- Fall 2022 enrollments
(1, 1, '2022-08-20', 'Completed', 89.5, 'B+', '2022-12-15', 3),
(1, 4, '2022-08-20', 'Completed', 92.0, 'A-', '2022-12-15', 4),
(1, 6, '2022-08-20', 'Completed', 85.5, 'B', '2022-12-15', 3),
(1, 7, '2022-08-20', 'Completed', 94.0, 'A', '2022-12-15', 3),

(2, 2, '2022-08-22', 'Completed', 78.5, 'C+', '2022-12-15', 3),
(2, 5, '2022-08-22', 'Completed', 82.0, 'B-', '2022-12-15', 4),
(2, 8, '2022-08-22', 'Completed', 88.5, 'B+', '2022-12-15', 3),

(3, 1, '2022-08-19', 'Completed', 96.5, 'A', '2022-12-15', 3),
(3, 4, '2022-08-19', 'Completed', 94.5, 'A', '2022-12-15', 4),
(3, 6, '2022-08-19', 'Completed', 91.0, 'A-', '2022-12-15', 3),

-- Spring 2023 enrollments
(1, 10, '2023-01-14', 'Completed', 87.0, 'B+', '2023-05-12', 4),
(1, 11, '2023-01-14', 'Completed', 90.5, 'A-', '2023-05-12', 3),
(1, 13, '2023-01-14', 'Completed', 93.0, 'A', '2023-05-12', 3),

(2, 9, '2023-01-16', 'Completed', 75.5, 'C', '2023-05-12', 3),
(2, 12, '2023-01-16', 'Completed', 80.0, 'B-', '2023-05-12', 4),
(2, 14, '2023-01-16', 'Completed', 85.0, 'B', '2023-05-12', 35),

(4, 9, '2023-01-18', 'Completed', 72.0, 'C-', '2023-05-12', 3),
(4, 10, '2023-01-18', 'Completed', 68.5, 'D+', '2023-05-12', 0),

-- Fall 2023 enrollments
(1, 17, '2023-08-19', 'Completed', 91.5, 'A-', '2023-12-14', 3),
(1, 19, '2023-08-19', 'Completed', 88.0, 'B+', '2023-12-14', 4),

(5, 15, '2023-08-21', 'Completed', 86.5, 'B', '2023-12-14', 3),
(5, 20, '2023-08-21', 'Completed', 89.0, 'B+', '2023-12-14', 4),
(5, 23, '2023-08-21', 'Completed', 92.5, 'A-', '2023-12-14', 3),

(6, 16, '2023-08-20', 'Completed', 83.0, 'B-', '2023-12-14', 3),
(6, 21, '2023-08-20', 'Completed', 87.5, 'B+', '2023-12-14', 4),

(7, 15, '2023-08-22', 'Completed', 94.0, 'A', '2023-12-14', 3),
(7, 18, '2023-08-22', 'Completed', 91.0, 'A-', '2023-12-14', 3),
(7, 22, '2023-08-22', 'Completed', 96.0, 'A', '2023-12-14', 4);

-- Update current enrollment counts
UPDATE course_sections cs 
SET current_enrollment = (
    SELECT COUNT(*) 
    FROM enrollments e 
    WHERE e.section_id = cs.section_id 
    AND e.status IN ('Enrolled', 'Completed')
);
-- University Data Warehouse - Star Schema Implementation
-- Create data warehouse database and dimension/fact tables

CREATE DATABASE IF NOT EXISTS university_dw;
USE university_dw;

-- Dimension Tables

-- Student Dimension
CREATE TABLE dim_students (
    student_key INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    full_name VARCHAR(101),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    age INT,
    age_group VARCHAR(20),
    enrollment_date DATE,
    enrollment_year INT,
    student_status VARCHAR(20),
    gpa DECIMAL(3,2),
    total_credits INT,
    class_level VARCHAR(20),
    effective_date DATE,
    expiry_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_student_id (student_id),
    INDEX idx_is_current (is_current)
);

-- Course Dimension
CREATE TABLE dim_courses (
    course_key INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    course_code VARCHAR(20),
    course_name VARCHAR(100),
    course_level VARCHAR(20),
    credits INT,
    subject_area VARCHAR(50),
    description TEXT,
    prerequisites TEXT,
    course_status VARCHAR(20),
    effective_date DATE,
    expiry_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_course_id (course_id),
    INDEX idx_course_code (course_code),
    INDEX idx_is_current (is_current)
);

-- Faculty Dimension
CREATE TABLE dim_faculty (
    faculty_key INT AUTO_INCREMENT PRIMARY KEY,
    faculty_id INT NOT NULL,
    full_name VARCHAR(101),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    position VARCHAR(50),
    rank VARCHAR(30),
    years_experience INT,
    hire_date DATE,
    salary_range VARCHAR(20),
    faculty_status VARCHAR(20),
    effective_date DATE,
    expiry_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_faculty_id (faculty_id),
    INDEX idx_is_current (is_current)
);

-- Department Dimension
CREATE TABLE dim_departments (
    department_key INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    department_name VARCHAR(100),
    department_code VARCHAR(10),
    building VARCHAR(50),
    college VARCHAR(100),
    department_type VARCHAR(50),
    phone VARCHAR(20),
    effective_date DATE,
    expiry_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_department_id (department_id),
    INDEX idx_is_current (is_current)
);

-- Semester Dimension
CREATE TABLE dim_semesters (
    semester_key INT AUTO_INCREMENT PRIMARY KEY,
    semester_id INT NOT NULL,
    semester_name VARCHAR(50),
    year INT,
    season VARCHAR(20),
    quarter INT,
    start_date DATE,
    end_date DATE,
    duration_days INT,
    academic_year VARCHAR(20),
    semester_status VARCHAR(20),
    is_current BOOLEAN DEFAULT FALSE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_semester_id (semester_id),
    INDEX idx_year (year),
    INDEX idx_season (season)
);

-- Section Dimension
CREATE TABLE dim_sections (
    section_key INT AUTO_INCREMENT PRIMARY KEY,
    section_id INT NOT NULL,
    section_number VARCHAR(10),
    max_capacity INT,
    schedule_days VARCHAR(20),
    time_slot VARCHAR(50),
    start_time TIME,
    end_time TIME,
    room VARCHAR(20),
    building VARCHAR(50),
    delivery_mode VARCHAR(20),
    section_status VARCHAR(20),
    effective_date DATE,
    expiry_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_section_id (section_id),
    INDEX idx_is_current (is_current)
);

-- Date Dimension (for time-based analysis)
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_of_week INT,
    day_name VARCHAR(10),
    day_of_month INT,
    day_of_year INT,
    week_of_year INT,
    month_number INT,
    month_name VARCHAR(10),
    quarter INT,
    year INT,
    is_weekend BOOLEAN,
    is_holiday BOOLEAN,
    academic_year VARCHAR(20),
    semester_season VARCHAR(20)
);

-- Fact Table
CREATE TABLE fact_enrollments (
    enrollment_key INT AUTO_INCREMENT PRIMARY KEY,
    student_key INT,
    course_key INT,
    faculty_key INT,
    department_key INT,
    semester_key INT,
    section_key INT,
    enrollment_date_key INT,
    completion_date_key INT,
    
    -- Measures
    enrollment_count INT DEFAULT 1,
    final_grade DECIMAL(5,2),
    letter_grade VARCHAR(2),
    credits_attempted INT,
    credits_earned INT,
    gpa_points DECIMAL(5,2),
    completion_status VARCHAR(20),
    days_to_completion INT,
    
    -- Flags
    is_passing BOOLEAN,
    is_honors BOOLEAN,
    is_repeat BOOLEAN,
    
    -- Dates
    enrollment_date DATE,
    completion_date DATE,
    
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (student_key) REFERENCES dim_students(student_key),
    FOREIGN KEY (course_key) REFERENCES dim_courses(course_key),
    FOREIGN KEY (faculty_key) REFERENCES dim_faculty(faculty_key),
    FOREIGN KEY (department_key) REFERENCES dim_departments(department_key),
    FOREIGN KEY (semester_key) REFERENCES dim_semesters(semester_key),
    FOREIGN KEY (section_key) REFERENCES dim_sections(section_key),
    FOREIGN KEY (enrollment_date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (completion_date_key) REFERENCES dim_date(date_key),
    
    INDEX idx_student_key (student_key),
    INDEX idx_course_key (course_key),
    INDEX idx_semester_key (semester_key),
    INDEX idx_enrollment_date (enrollment_date),
    INDEX idx_completion_status (completion_status)
);

-- Create aggregate tables for performance
CREATE TABLE agg_enrollment_summary_by_semester (
    semester_key INT,
    department_key INT,
    total_enrollments INT,
    total_completions INT,
    avg_grade DECIMAL(5,2),
    total_credits_earned INT,
    completion_rate DECIMAL(5,2),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (semester_key, department_key)
);

CREATE TABLE agg_student_performance_summary (
    student_key INT,
    semester_key INT,
    total_courses INT,
    total_credits_attempted INT,
    total_credits_earned INT,
    semester_gpa DECIMAL(3,2),
    cumulative_gpa DECIMAL(3,2),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (student_key, semester_key)
);
-- Populate Data Warehouse Dimensions
USE university_dw;

-- Populate Date Dimension (simplified version)
INSERT INTO dim_date (date_key, full_date, day_of_week, day_name, day_of_month, day_of_year, 
                     week_of_year, month_number, month_name, quarter, year, is_weekend, is_holiday)
SELECT 
    DATE_FORMAT(date_val, '%Y%m%d') as date_key,
    date_val as full_date,
    DAYOFWEEK(date_val) as day_of_week,
    DAYNAME(date_val) as day_name,
    DAY(date_val) as day_of_month,
    DAYOFYEAR(date_val) as day_of_year,
    WEEK(date_val) as week_of_year,
    MONTH(date_val) as month_number,
    MONTHNAME(date_val) as month_name,
    QUARTER(date_val) as quarter,
    YEAR(date_val) as year,
    CASE WHEN DAYOFWEEK(date_val) IN (1,7) THEN TRUE ELSE FALSE END as is_weekend,
    FALSE as is_holiday
FROM (
    SELECT DATE('2022-01-01') + INTERVAL seq DAY as date_val
    FROM (
        SELECT a.N + b.N * 10 + c.N * 100 + d.N * 1000 as seq
        FROM (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
        CROSS JOIN (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
        CROSS JOIN (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
        CROSS JOIN (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) d
    ) numbers
    WHERE DATE('2022-01-01') + INTERVAL seq DAY <= '2025-12-31'
) dates;

-- Populate Student Dimension
INSERT INTO dim_students (student_id, full_name, first_name, last_name, email, age, age_group, 
                         enrollment_date, enrollment_year, student_status, gpa, total_credits, 
                         class_level, effective_date, expiry_date)
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) as full_name,
    s.first_name,
    s.last_name,
    s.email,
    TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) as age,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) < 20 THEN 'Under 20'
        WHEN TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) BETWEEN 20 AND 22 THEN '20-22'
        WHEN TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) BETWEEN 23 AND 25 THEN '23-25'
        ELSE 'Over 25'
    END as age_group,
    s.enrollment_date,
    YEAR(s.enrollment_date) as enrollment_year,
    s.status as student_status,
    s.gpa,
    s.total_credits,
    CASE 
        WHEN s.total_credits < 30 THEN 'Freshman'
        WHEN s.total_credits BETWEEN 30 AND 59 THEN 'Sophomore'
        WHEN s.total_credits BETWEEN 60 AND 89 THEN 'Junior'
        ELSE 'Senior'
    END as class_level,
    s.created_date as effective_date,
    '2099-12-31' as expiry_date
FROM university_system.students s;

-- Populate Course Dimension
INSERT INTO dim_courses (course_id, course_code, course_name, course_level, credits, subject_area, 
                        description, prerequisites, course_status, effective_date, expiry_date)
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    c.level as course_level,
    c.credits,
    SUBSTRING(c.course_code, 1, LOCATE(SUBSTRING(c.course_code, 1, 10), '0123456789') - 1) as subject_area,
    c.description,
    c.prerequisites,
    c.status as course_status,
    c.created_date as effective_date,
    '2099-12-31' as expiry_date
FROM university_system.courses c;

-- Populate Faculty Dimension
INSERT INTO dim_faculty (faculty_id, full_name, first_name, last_name, email, position, rank, 
                        years_experience, hire_date, salary_range, faculty_status, effective_date, expiry_date)
SELECT 
    f.faculty_id,
    CONCAT(f.first_name, ' ', f.last_name) as full_name,
    f.first_name,
    f.last_name,
    f.email,
    f.position,
    f.position as rank,
    TIMESTAMPDIFF(YEAR, f.hire_date, CURDATE()) as years_experience,
    f.hire_date,
    CASE 
        WHEN f.salary < 70000 THEN 'Under $70K'
        WHEN f.salary BETWEEN 70000 AND 85000 THEN '$70K-$85K'
        ELSE 'Over $85K'
    END as salary_range,
    f.status as faculty_status,
    f.created_date as effective_date,
    '2099-12-31' as expiry_date
FROM university_system.faculty f;

-- Populate Department Dimension
INSERT INTO dim_departments (department_id, department_name, department_code, building, college, 
                           department_type, phone, effective_date, expiry_date)
SELECT 
    d.department_id,
    d.department_name,
    d.department_code,
    d.building,
    CASE 
        WHEN d.department_code IN ('CS', 'MATH', 'ENG') THEN 'College of Science and Engineering'
        WHEN d.department_code = 'BUS' THEN 'College of Business'
        WHEN d.department_code IN ('ENG', 'HIST') THEN 'College of Liberal Arts'
        WHEN d.department_code IN ('PSY', 'BIO') THEN 'College of Social Sciences'
        ELSE 'Other'
    END as college,
    CASE 
        WHEN d.department_code IN ('CS', 'MATH', 'ENG', 'BIO') THEN 'STEM'
        WHEN d.department_code = 'BUS' THEN 'Business'
        ELSE 'Liberal Arts'
    END as department_type,
    d.phone,
    d.created_date as effective_date,
    '2099-12-31' as expiry_date
FROM university_system.departments d;

-- Populate Semester Dimension
INSERT INTO dim_semesters (semester_id, semester_name, year, season, quarter, start_date, end_date, 
                          duration_days, academic_year, semester_status)
SELECT 
    s.semester_id,
    s.semester_name,
    s.year,
    s.semester_name as season,
    CASE 
        WHEN s.semester_name = 'Fall' THEN 1
        WHEN s.semester_name = 'Spring' THEN 2
        WHEN s.semester_name = 'Summer' THEN 3
    END as quarter,
    s.start_date,
    s.end_date,
    DATEDIFF(s.end_date, s.start_date) as duration_days,
    CASE 
        WHEN s.semester_name = 'Fall' THEN CONCAT(s.year, '-', s.year + 1)
        ELSE CONCAT(s.year - 1, '-', s.year)
    END as academic_year,
    s.status as semester_status
FROM university_system.semesters s;

-- Populate Section Dimension
INSERT INTO dim_sections (section_id, section_number, max_capacity, schedule_days, time_slot, 
                         start_time, end_time, room, building, delivery_mode, section_status, 
                         effective_date, expiry_date)
SELECT 
    cs.section_id,
    cs.section_number,
    cs.max_capacity,
    cs.schedule_days,
    CONCAT(TIME_FORMAT(cs.start_time, '%H:%i'), '-', TIME_FORMAT(cs.end_time, '%H:%i')) as time_slot,
    cs.start_time,
    cs.end_time,
    cs.room,
    cs.building,
    cs.delivery_mode,
    cs.status as section_status,
    cs.created_date as effective_date,
    '2099-12-31' as expiry_date
FROM university_system.course_sections cs;
-- Populate Fact Table
USE university_dw;

-- Populate Fact Enrollments
INSERT INTO fact_enrollments (
    student_key, course_key, faculty_key, department_key, semester_key, section_key,
    enrollment_date_key, completion_date_key, enrollment_count, final_grade, letter_grade,
    credits_attempted, credits_earned, gpa_points, completion_status, days_to_completion,
    is_passing, is_honors, is_repeat, enrollment_date, completion_date
)
SELECT 
    ds.student_key,
    dc.course_key,
    df.faculty_key,
    dd.department_key,
    dsem.semester_key,
    dsec.section_key,
    DATE_FORMAT(e.enrollment_date, '%Y%m%d') as enrollment_date_key,
    CASE WHEN e.completion_date IS NOT NULL 
         THEN DATE_FORMAT(e.completion_date, '%Y%m%d') 
         ELSE NULL END as completion_date_key,
    1 as enrollment_count,
    e.final_grade,
    e.letter_grade,
    c.credits as credits_attempted,
    e.credits_earned,
    CASE 
        WHEN e.letter_grade = 'A' THEN c.credits * 4.0
        WHEN e.letter_grade = 'A-' THEN c.credits * 3.7
        WHEN e.letter_grade = 'B+' THEN c.credits * 3.3
        WHEN e.letter_grade = 'B' THEN c.credits * 3.0
        WHEN e.letter_grade = 'B-' THEN c.credits * 2.7
        WHEN e.letter_grade = 'C+' THEN c.credits * 2.3
        WHEN e.letter_grade = 'C' THEN c.credits * 2.0
        WHEN e.letter_grade = 'C-' THEN c.credits * 1.7
        WHEN e.letter_grade = 'D+' THEN c.credits * 1.3
        WHEN e.letter_grade = 'D' THEN c.credits * 1.0
        ELSE 0
    END as gpa_points,
    e.status as completion_status,
    CASE WHEN e.completion_date IS NOT NULL 
         THEN DATEDIFF(e.completion_date, e.enrollment_date)
         ELSE NULL END as days_to_completion,
    CASE WHEN e.final_grade >= 60 THEN TRUE ELSE FALSE END as is_passing,
    CASE WHEN e.final_grade >= 90 THEN TRUE ELSE FALSE END as is_honors,
    FALSE as is_repeat, -- Simplified for this example
    e.enrollment_date,
    e.completion_date
FROM university_system.enrollments e
JOIN university_system.course_sections cs ON e.section_id = cs.section_id
JOIN university_system.courses c ON cs.course_id = c.course_id
JOIN university_system.students s ON e.student_id = s.student_id
JOIN university_system.faculty f ON cs.faculty_id = f.faculty_id
JOIN university_system.departments d ON c.department_id = d.department_id
JOIN university_system.semesters sem ON cs.semester_id = sem.semester_id
JOIN dim_students ds ON s.student_id = ds.student_id AND ds.is_current = TRUE
JOIN dim_courses dc ON c.course_id = dc.course_id AND dc.is_current = TRUE
JOIN dim_faculty df ON f.faculty_id = df.faculty_id AND df.is_current = TRUE
JOIN dim_departments dd ON d.department_id = dd.department_id AND dd.is_current = TRUE
JOIN dim_semesters dsem ON sem.semester_id = dsem.semester_id
JOIN dim_sections dsec ON cs.section_id = dsec.section_id AND dsec.is_current = TRUE;

-- Populate Aggregate Tables
INSERT INTO agg_enrollment_summary_by_semester (semester_key, department_key, total_enrollments, 
                                               total_completions, avg_grade, total_credits_earned, completion_rate)
SELECT 
    f.semester_key,
    f.department_key,
    COUNT(*) as total_enrollments,
    SUM(CASE WHEN f.completion_status = 'Completed' THEN 1 ELSE 0 END) as total_completions,
    AVG(f.final_grade) as avg_grade,
    SUM(f.credits_earned) as total_credits_earned,
    (SUM(CASE WHEN f.completion_status = 'Completed' THEN 1 ELSE 0 END) / COUNT(*)) * 100 as completion_rate
FROM fact_enrollments f
GROUP BY f.semester_key, f.department_key;

INSERT INTO agg_student_performance_summary (student_key, semester_key, total_courses, 
                                           total_credits_attempted, total_credits_earned, semester_gpa)
SELECT 
    f.student_key,
    f.semester_key,
    COUNT(*) as total_courses,
    SUM(f.credits_attempted) as total_credits_attempted,
    SUM(f.credits_earned) as total_credits_earned,
    CASE WHEN SUM(f.credits_attempted) > 0 
         THEN SUM(f.gpa_points) / SUM(f.credits_attempted)
         ELSE 0 END as semester_gpa
FROM fact_enrollments f
WHERE f.completion_status = 'Completed'
GROUP BY f.student_key, f.semester_key;
