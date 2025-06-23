-- =============================================================================
-- UNIVERSITY DATA WAREHOUSE - CLEAN SETUP SCRIPT
-- =============================================================================
-- This script drops existing databases and creates everything fresh
-- Run this in phpMyAdmin or MySQL command line

-- =============================================================================
-- STEP 1: DROP EXISTING DATABASES (if they exist)
-- =============================================================================

DROP DATABASE IF EXISTS university_dw;
DROP DATABASE IF EXISTS university_system;

-- =============================================================================
-- STEP 2: CREATE OPERATIONAL DATABASE
-- =============================================================================

-- Create operational database
CREATE DATABASE university_system;
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

-- =============================================================================
-- STEP 3: LOAD SAMPLE DATA INTO OPERATIONAL DATABASE
-- =============================================================================

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
(1, 9, '2023-01-14', 'Completed', 87.0, 'B+', '2023-05-12', 3),
(1, 10, '2023-01-14', 'Completed', 90.5, 'A-', '2023-05-12', 4),
(1, 11, '2023-01-14', 'Completed', 93.0, 'A', '2023-05-12', 3),

(2, 9, '2023-01-16', 'Completed', 75.5, 'C', '2023-05-12', 3),
(2, 12, '2023-01-16', 'Completed', 80.0, 'B-', '2023-05-12', 4),
(2, 14, '2023-01-16', 'Completed', 85.0, 'B', '2023-05-12', 3),

(4, 9, '2023-01-18', 'Completed', 72.0, 'C-', '2023-05-12', 3),
(4, 10, '2023-01-18', 'Completed', 68.5, 'D+', '2023-05-12', 0),

-- Fall 2023 enrollments
(1, 15, '2023-08-19', 'Completed', 91.5, 'A-', '2023-12-14', 3),
(1, 17, '2023-08-19', 'Completed', 88.0, 'B+', '2023-12-14', 4),

(5, 15, '2023-08-21', 'Completed', 86.5, 'B', '2023-12-14', 3),
(5, 18, '2023-08-21', 'Completed', 89.0, 'B+', '2023-12-14', 4),
(5, 21, '2023-08-21', 'Completed', 92.5, 'A-', '2023-12-14', 3),

(6, 16, '2023-08-20', 'Completed', 83.0, 'B-', '2023-12-14', 3),
(6, 19, '2023-08-20', 'Completed', 87.5, 'B+', '2023-12-14', 4),

(7, 15, '2023-08-22', 'Completed', 94.0, 'A', '2023-12-14', 3),
(7, 17, '2023-08-22', 'Completed', 91.0, 'A-', '2023-12-14', 3),
(7, 20, '2023-08-22', 'Completed', 96.0, 'A', '2023-12-14', 4);

-- Update current enrollment counts
UPDATE course_sections cs 
SET current_enrollment = (
    SELECT COUNT(*) 
    FROM enrollments e 
    WHERE e.section_id = cs.section_id 
    AND e.status IN ('Enrolled', 'Completed')
);

-- =============================================================================
-- STEP 4: CREATE DATA WAREHOUSE
-- =============================================================================

-- Create data warehouse database
CREATE DATABASE university_dw;
USE university_dw;

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

-- Date Dimension
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
    INDEX idx_enrollment_date (enrollment_date)
);

-- =============================================================================
-- STEP 5: POPULATE DIMENSIONS AND FACTS
-- =============================================================================

-- Populate Student Dimension
INSERT INTO dim_students (student_id, full_name, first_name, last_name, email, age, age_group, enrollment_date, enrollment_year, student_status, gpa, total_credits, class_level, effective_date)
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) as full_name,
    s.first_name,
    s.last_name,
    s.email,
    TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) as age,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) < 20 THEN '18-19'
        WHEN TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) < 22 THEN '20-21'
        WHEN TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) < 24 THEN '22-23'
        ELSE '24+'
    END as age_group,
    s.enrollment_date,
    YEAR(s.enrollment_date) as enrollment_year,
    s.status as student_status,
    s.gpa,
    s.total_credits,
    CASE 
        WHEN s.total_credits < 30 THEN 'Freshman'
        WHEN s.total_credits < 60 THEN 'Sophomore'
        WHEN s.total_credits < 90 THEN 'Junior'
        ELSE 'Senior'
    END as class_level,
    CURDATE() as effective_date
FROM university_system.students s;

-- Populate Course Dimension
INSERT INTO dim_courses (course_id, course_code, course_name, course_level, credits, subject_area, description, course_status, effective_date)
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    c.level as course_level,
    c.credits,
    d.department_name as subject_area,
    c.description,
    c.status as course_status,
    CURDATE() as effective_date
FROM university_system.courses c
JOIN university_system.departments d ON c.department_id = d.department_id;

-- Populate Faculty Dimension
INSERT INTO dim_faculty (faculty_id, full_name, first_name, last_name, email, position, hire_date, faculty_status, effective_date)
SELECT 
    f.faculty_id,
    CONCAT(f.first_name, ' ', f.last_name) as full_name,
    f.first_name,
    f.last_name,
    f.email,
    f.position,
    f.hire_date,
    f.status as faculty_status,
    CURDATE() as effective_date
FROM university_system.faculty f;

-- Populate Department Dimension
INSERT INTO dim_departments (department_id, department_name, department_code, building, phone, effective_date)
SELECT 
    d.department_id,
    d.department_name,
    d.department_code,
    d.building,
    d.phone,
    CURDATE() as effective_date
FROM university_system.departments d;

-- Populate Semester Dimension
INSERT INTO dim_semesters (semester_id, semester_name, year, season, start_date, end_date, duration_days, academic_year, semester_status)
SELECT 
    s.semester_id,
    s.semester_name,
    s.year,
    s.semester_name as season,
    s.start_date,
    s.end_date,
    DATEDIFF(s.end_date, s.start_date) as duration_days,
    CONCAT(s.year, '-', s.year + 1) as academic_year,
    s.status as semester_status
FROM university_system.semesters s;

-- Populate Section Dimension
INSERT INTO dim_sections (section_id, section_number, max_capacity, schedule_days, start_time, end_time, room, building, delivery_mode, section_status, effective_date)
SELECT 
    cs.section_id,
    cs.section_number,
    cs.max_capacity,
    cs.schedule_days,
    cs.start_time,
    cs.end_time,
    cs.room,
    cs.building,
    cs.delivery_mode,
    cs.status as section_status,
    CURDATE() as effective_date
FROM university_system.course_sections cs;

-- Populate Fact Table
INSERT INTO fact_enrollments (
    student_key, course_key, faculty_key, department_key, semester_key, section_key,
    final_grade, letter_grade, credits_attempted, credits_earned, completion_status,
    is_passing, enrollment_date, completion_date
)
SELECT 
    ds.student_key,
    dc.course_key,
    df.faculty_key,
    ddept.department_key,
    dsem.semester_key,
    dsec.section_key,
    e.final_grade,
    e.letter_grade,
    c.credits as credits_attempted,
    e.credits_earned,
    e.status as completion_status,
    CASE WHEN e.final_grade >= 60 THEN TRUE ELSE FALSE END as is_passing,
    e.enrollment_date,
    e.completion_date
FROM university_system.enrollments e
JOIN university_system.course_sections cs ON e.section_id = cs.section_id
JOIN university_system.courses c ON cs.course_id = c.course_id
JOIN university_system.departments d ON c.department_id = d.department_id
JOIN dim_students ds ON e.student_id = ds.student_id
JOIN dim_courses dc ON c.course_id = dc.course_id
JOIN dim_faculty df ON cs.faculty_id = df.faculty_id
JOIN dim_departments ddept ON d.department_id = ddept.department_id
JOIN dim_semesters dsem ON cs.semester_id = dsem.semester_id
JOIN dim_sections dsec ON cs.section_id = dsec.section_id;

-- =============================================================================
-- SUCCESS MESSAGE
-- =============================================================================
SELECT 'University Data Warehouse clean setup completed successfully!' as status; 