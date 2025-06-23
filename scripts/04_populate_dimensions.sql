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
INSERT INTO dim_students (student_key, student_id, full_name, email, phone, date_of_birth, gender, address, enrollment_date, class_level, gpa, department_code, department_name, enrollment_year)
SELECT 
    ROW_NUMBER() OVER (ORDER BY s.student_id) as student_key,
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) as full_name,
    s.email,
    s.phone,
    s.date_of_birth,
    s.gender,
    s.address,
    s.enrollment_date,
    s.class_level,
    s.gpa,
    s.department_code,
    d.department_name,
    YEAR(s.enrollment_date) as enrollment_year
FROM university_operational.students s
JOIN university_operational.departments d ON s.department_code = d.department_code;

-- Populate Course Dimension
INSERT INTO dim_courses (course_key, course_code, course_name, credits, course_level, department_code, department_name, description)
SELECT 
    ROW_NUMBER() OVER (ORDER BY c.course_code) as course_key,
    c.course_code,
    c.course_name,
    c.credits,
    c.course_level,
    c.department_code,
    d.department_name,
    c.description
FROM university_operational.courses c
JOIN university_operational.departments d ON c.department_code = d.department_code;

-- Populate Faculty Dimension
INSERT INTO dim_faculty (faculty_key, faculty_id, full_name, email, phone, position, department_code, department_name, hire_date, salary, years_of_service)
SELECT 
    ROW_NUMBER() OVER (ORDER BY f.faculty_id) as faculty_key,
    f.faculty_id,
    CONCAT(f.first_name, ' ', f.last_name) as full_name,
    f.email,
    f.phone,
    f.position,
    f.department_code,
    d.department_name,
    f.hire_date,
    f.salary,
    YEAR(CURDATE()) - YEAR(f.hire_date) as years_of_service
FROM university_operational.faculty f
JOIN university_operational.departments d ON f.department_code = d.department_code;

-- Populate Department Dimension
INSERT INTO dim_departments (department_key, department_code, department_name, location, phone, email)
SELECT 
    ROW_NUMBER() OVER (ORDER BY department_code) as department_key,
    department_code,
    department_name,
    location,
    phone,
    email
FROM university_operational.departments;

-- Populate Semester Dimension
INSERT INTO dim_semesters (semester_key, semester_id, semester_name, year, start_date, end_date, is_active, season)
SELECT 
    ROW_NUMBER() OVER (ORDER BY semester_id) as semester_key,
    semester_id,
    semester_name,
    year,
    start_date,
    end_date,
    is_active,
    CASE 
        WHEN semester_name = 'First Semester' THEN 'First'
        WHEN semester_name = 'Second Semester' THEN 'Second'
        ELSE 'Other'
    END as season
FROM university_operational.semesters;

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

-- =============================================================================
-- SUCCESS MESSAGE
-- =============================================================================
SELECT 'Dimension tables populated successfully!' as status;
