-- =============================================================================
-- SAMPLE ANALYTICS QUERIES FOR UNIVERSITY DATA WAREHOUSE
-- =============================================================================
-- Run these queries in phpMyAdmin to explore the data warehouse
-- Switch to university_dw database first: USE university_dw;

-- =============================================================================
-- 1. BASIC OVERVIEW QUERIES
-- =============================================================================

-- Overall Performance Summary
SELECT 
    COUNT(*) as total_enrollments,
    COUNT(DISTINCT student_key) as unique_students,
    COUNT(DISTINCT course_key) as unique_courses,
    COUNT(DISTINCT faculty_key) as unique_faculty,
    COUNT(DISTINCT department_key) as unique_departments,
    ROUND(AVG(final_grade), 2) as average_grade,
    ROUND((SUM(CASE WHEN is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate,
    SUM(credits_earned) as total_credits_earned
FROM fact_enrollments;

-- Department Performance Analysis
SELECT 
    dd.department_name,
    COUNT(*) as enrollments,
    COUNT(DISTINCT f.student_key) as unique_students,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate,
    SUM(f.credits_earned) as total_credits_earned,
    ROUND(AVG(f.credits_earned), 1) as avg_credits_per_enrollment
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
GROUP BY dd.department_name, dd.department_key
ORDER BY avg_grade DESC;

-- Student Performance by Class Level
SELECT 
    ds.class_level,
    COUNT(*) as enrollments,
    COUNT(DISTINCT f.student_key) as unique_students,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate,
    ROUND(AVG(ds.gpa), 2) as avg_gpa,
    SUM(f.credits_earned) as total_credits_earned
FROM fact_enrollments f
JOIN dim_students ds ON f.student_key = ds.student_key
GROUP BY ds.class_level
ORDER BY ds.class_level;

-- =============================================================================
-- 2. TIME SERIES ANALYSIS
-- =============================================================================

-- Semester Trends Analysis (Ghana University Format)
SELECT 
    dsem.semester_name,
    dsem.year,
    dsem.season,
    COUNT(*) as enrollments,
    COUNT(DISTINCT f.student_key) as unique_students,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate,
    SUM(f.credits_earned) as total_credits_earned
FROM fact_enrollments f
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
GROUP BY dsem.semester_name, dsem.year, dsem.season
ORDER BY dsem.year, dsem.semester_name;

-- Year-over-Year Growth Analysis
SELECT 
    dsem.year,
    COUNT(*) as enrollments,
    LAG(COUNT(*), 1) OVER (ORDER BY dsem.year) as prev_year_enrollments,
    ROUND(((COUNT(*) - LAG(COUNT(*), 1) OVER (ORDER BY dsem.year)) / 
           LAG(COUNT(*), 1) OVER (ORDER BY dsem.year)) * 100, 2) as growth_rate_percent
FROM fact_enrollments f
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
GROUP BY dsem.year
ORDER BY dsem.year;

-- =============================================================================
-- 3. ROLL-UP OPERATIONS (Aggregating to Higher Levels)
-- =============================================================================

-- Roll-up: Department → Course → Student (Drill-down capability)
SELECT 
    dd.department_name,
    dc.course_code,
    dc.course_name,
    COUNT(*) as enrollments,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    MIN(f.final_grade) as min_grade,
    MAX(f.final_grade) as max_grade,
    ROUND(STDDEV(f.final_grade), 2) as grade_stddev,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_courses dc ON f.course_key = dc.course_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name, dc.course_code, dc.course_name
ORDER BY dd.department_name, avg_grade DESC;

-- Roll-up: College level summary (highest aggregation)
SELECT 
    dd.department_name as college,
    COUNT(*) as total_enrollments,
    COUNT(DISTINCT f.student_key) as unique_students,
    COUNT(DISTINCT f.course_key) as unique_courses,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    SUM(f.credits_earned) as total_credits_earned,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name
ORDER BY total_enrollments DESC;

-- =============================================================================
-- 4. DRILL-DOWN OPERATIONS (Breaking down to Lower Levels)
-- =============================================================================

-- Drill-down: From department to individual student performance
SELECT 
    dd.department_name,
    ds.full_name,
    ds.class_level,
    COUNT(*) as courses_taken,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    SUM(f.credits_earned) as credits_earned,
    ROUND(AVG(ds.gpa), 2) as student_gpa,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_students ds ON f.student_key = ds.student_key
WHERE f.completion_status = 'Completed'
  AND dd.department_name = 'Computer Science'
GROUP BY dd.department_name, ds.student_key, ds.full_name, ds.class_level
ORDER BY avg_grade DESC;

-- Drill-down: Faculty performance by individual courses taught
SELECT 
    df.full_name as faculty_name,
    df.position,
    dd.department_name,
    dc.course_code,
    dc.course_name,
    dsem.semester_name,
    dsem.year,
    COUNT(*) as students_taught,
    ROUND(AVG(f.final_grade), 2) as avg_student_grade,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_faculty df ON f.faculty_key = df.faculty_key
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_courses dc ON f.course_key = dc.course_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY df.faculty_key, df.full_name, df.position, dd.department_name, 
         dc.course_code, dc.course_name, dsem.semester_name, dsem.year
ORDER BY df.full_name, dsem.year, dsem.semester_name;

-- =============================================================================
-- 5. SLICE AND DICE OPERATIONS (Filtering and Cross-tabulation)
-- =============================================================================

-- Slice: Focus on specific semester and department
SELECT 
    dc.course_level,
    ds.class_level,
    COUNT(*) as enrollments,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_courses dc ON f.course_key = dc.course_key
JOIN dim_students ds ON f.student_key = ds.student_key
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
  AND dd.department_name = 'Computer Science'
  AND dsem.year = 2023
GROUP BY dc.course_level, ds.class_level
ORDER BY dc.course_level, ds.class_level;

-- Dice: Cross-tabulation of department vs semester performance (Ghana Format)
SELECT 
    dd.department_name,
    SUM(CASE WHEN dsem.semester_name = 'First Semester' AND dsem.year = 2022 THEN 1 ELSE 0 END) as first_sem_2022,
    SUM(CASE WHEN dsem.semester_name = 'Second Semester' AND dsem.year = 2022 THEN 1 ELSE 0 END) as second_sem_2022,
    SUM(CASE WHEN dsem.semester_name = 'First Semester' AND dsem.year = 2023 THEN 1 ELSE 0 END) as first_sem_2023,
    SUM(CASE WHEN dsem.semester_name = 'Second Semester' AND dsem.year = 2023 THEN 1 ELSE 0 END) as second_sem_2023,
    COUNT(*) as total_enrollments
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name
ORDER BY total_enrollments DESC;

-- =============================================================================
-- 6. ADVANCED ANALYTICAL QUERIES
-- =============================================================================

-- Top Performing Students (Top 10)
SELECT 
    ds.full_name,
    ds.class_level,
    dd.department_name,
    COUNT(*) as courses_taken,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    SUM(f.credits_earned) as total_credits,
    ROUND(AVG(ds.gpa), 2) as student_gpa,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_students ds ON f.student_key = ds.student_key
JOIN dim_departments dd ON f.department_key = dd.department_key
WHERE f.completion_status = 'Completed'
GROUP BY ds.student_key, ds.full_name, ds.class_level, dd.department_name
HAVING COUNT(*) >= 3
ORDER BY avg_grade DESC
LIMIT 10;

-- Course Difficulty Analysis
SELECT 
    dc.course_code,
    dc.course_name,
    dd.department_name,
    COUNT(*) as enrollments,
    ROUND(AVG(f.final_grade), 2) as avg_grade,
    MIN(f.final_grade) as min_grade,
    MAX(f.final_grade) as max_grade,
    ROUND(STDDEV(f.final_grade), 2) as grade_stddev,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate,
    CASE 
        WHEN AVG(f.final_grade) >= 85 THEN 'Easy'
        WHEN AVG(f.final_grade) >= 75 THEN 'Moderate'
        ELSE 'Difficult'
    END as difficulty_level
FROM fact_enrollments f
JOIN dim_courses dc ON f.course_key = dc.course_key
JOIN dim_departments dd ON f.department_key = dd.department_key
WHERE f.completion_status = 'Completed'
GROUP BY dc.course_code, dc.course_name, dd.department_name
ORDER BY avg_grade DESC;

-- Faculty Performance Ranking
SELECT 
    df.full_name as faculty_name,
    df.position,
    dd.department_name,
    COUNT(*) as total_students_taught,
    ROUND(AVG(f.final_grade), 2) as avg_student_grade,
    ROUND((SUM(CASE WHEN f.is_passing = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate,
    COUNT(DISTINCT f.course_key) as courses_taught,
    ROUND(AVG(f.credits_earned), 1) as avg_credits_per_student
FROM fact_enrollments f
JOIN dim_faculty df ON f.faculty_key = df.faculty_key
JOIN dim_departments dd ON f.department_key = dd.department_key
WHERE f.completion_status = 'Completed'
GROUP BY df.faculty_key, df.full_name, df.position, dd.department_name
HAVING COUNT(*) >= 5
ORDER BY avg_student_grade DESC;

-- =============================================================================
-- 7. DATA QUALITY AND VALIDATION QUERIES
-- =============================================================================

-- Data Completeness Check
SELECT 
    'Students' as table_name,
    COUNT(*) as total_records,
    COUNT(CASE WHEN full_name IS NOT NULL THEN 1 END) as non_null_names,
    COUNT(CASE WHEN email IS NOT NULL THEN 1 END) as non_null_emails,
    ROUND((COUNT(CASE WHEN full_name IS NOT NULL THEN 1 END) / COUNT(*)) * 100, 2) as completeness_percent
FROM dim_students
UNION ALL
SELECT 
    'Courses' as table_name,
    COUNT(*) as total_records,
    COUNT(CASE WHEN course_name IS NOT NULL THEN 1 END) as non_null_names,
    COUNT(CASE WHEN course_code IS NOT NULL THEN 1 END) as non_null_codes,
    ROUND((COUNT(CASE WHEN course_name IS NOT NULL THEN 1 END) / COUNT(*)) * 100, 2) as completeness_percent
FROM dim_courses
UNION ALL
SELECT 
    'Enrollments' as table_name,
    COUNT(*) as total_records,
    COUNT(CASE WHEN final_grade IS NOT NULL THEN 1 END) as non_null_grades,
    COUNT(CASE WHEN letter_grade IS NOT NULL THEN 1 END) as non_null_letters,
    ROUND((COUNT(CASE WHEN final_grade IS NOT NULL THEN 1 END) / COUNT(*)) * 100, 2) as completeness_percent
FROM fact_enrollments;

-- Grade Distribution Analysis
SELECT 
    CASE 
        WHEN final_grade >= 90 THEN 'A (90-100)'
        WHEN final_grade >= 80 THEN 'B (80-89)'
        WHEN final_grade >= 70 THEN 'C (70-79)'
        WHEN final_grade >= 60 THEN 'D (60-69)'
        ELSE 'F (0-59)'
    END as grade_range,
    COUNT(*) as count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM fact_enrollments WHERE final_grade IS NOT NULL)) * 100, 2) as percentage
FROM fact_enrollments
WHERE final_grade IS NOT NULL
GROUP BY 
    CASE 
        WHEN final_grade >= 90 THEN 'A (90-100)'
        WHEN final_grade >= 80 THEN 'B (80-89)'
        WHEN final_grade >= 70 THEN 'C (70-79)'
        WHEN final_grade >= 60 THEN 'D (60-69)'
        ELSE 'F (0-59)'
    END
ORDER BY 
    CASE grade_range
        WHEN 'A (90-100)' THEN 1
        WHEN 'B (80-89)' THEN 2
        WHEN 'C (70-79)' THEN 3
        WHEN 'D (60-69)' THEN 4
        WHEN 'F (0-59)' THEN 5
    END;

-- =============================================================================
-- 8. BUSINESS INTELLIGENCE QUERIES
-- =============================================================================

-- Student Retention Analysis
SELECT 
    ds.enrollment_year,
    COUNT(DISTINCT ds.student_key) as initial_cohort,
    COUNT(DISTINCT CASE WHEN dsem.year = ds.enrollment_year + 1 THEN f.student_key END) as retained_year_1,
    COUNT(DISTINCT CASE WHEN dsem.year = ds.enrollment_year + 2 THEN f.student_key END) as retained_year_2,
    ROUND((COUNT(DISTINCT CASE WHEN dsem.year = ds.enrollment_year + 1 THEN f.student_key END) / 
           COUNT(DISTINCT ds.student_key)) * 100, 2) as retention_rate_year_1,
    ROUND((COUNT(DISTINCT CASE WHEN dsem.year = ds.enrollment_year + 2 THEN f.student_key END) / 
           COUNT(DISTINCT ds.student_key)) * 100, 2) as retention_rate_year_2
FROM dim_students ds
LEFT JOIN fact_enrollments f ON ds.student_key = f.student_key
LEFT JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
GROUP BY ds.enrollment_year
ORDER BY ds.enrollment_year;

-- Department Growth Analysis
SELECT 
    dd.department_name,
    dsem.year,
    COUNT(*) as enrollments,
    LAG(COUNT(*), 1) OVER (PARTITION BY dd.department_name ORDER BY dsem.year) as prev_year_enrollments,
    ROUND(((COUNT(*) - LAG(COUNT(*), 1) OVER (PARTITION BY dd.department_name ORDER BY dsem.year)) / 
           LAG(COUNT(*), 1) OVER (PARTITION BY dd.department_name ORDER BY dsem.year)) * 100, 2) as growth_rate_percent
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
GROUP BY dd.department_name, dsem.year
ORDER BY dd.department_name, dsem.year;

-- =============================================================================
-- SUCCESS MESSAGE
-- =============================================================================
SELECT 'Sample analytics queries loaded successfully! Switch to university_dw database and run these queries.' as status;
