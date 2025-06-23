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
