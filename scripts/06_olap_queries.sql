-- OLAP Query Examples: Roll-up, Drill-down, and Slice/Dice Operations
USE university_dw;

-- =============================================================================
-- ROLL-UP OPERATIONS (Aggregating data to higher levels)
-- =============================================================================

-- 1. Roll-up: Department level enrollment summary by year
SELECT 
    dd.department_name,
    dsem.year,
    COUNT(*) as total_enrollments,
    AVG(f.final_grade) as avg_grade,
    SUM(f.credits_earned) as total_credits_earned,
    ROUND((SUM(CASE WHEN f.is_passing THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name, dsem.year
ORDER BY dd.department_name, dsem.year;

-- 2. Roll-up: College level summary (highest aggregation)
SELECT 
    dd.college,
    COUNT(*) as total_enrollments,
    AVG(f.final_grade) as avg_grade,
    SUM(f.credits_earned) as total_credits_earned,
    COUNT(DISTINCT f.student_key) as unique_students,
    COUNT(DISTINCT f.course_key) as unique_courses
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.college
ORDER BY total_enrollments DESC;

-- 3. Roll-up: Yearly trends across all dimensions
SELECT 
    dsem.year,
    dsem.season,
    COUNT(*) as total_enrollments,
    AVG(f.final_grade) as avg_grade,
    COUNT(DISTINCT f.student_key) as unique_students,
    SUM(f.credits_earned) as total_credits_earned
FROM fact_enrollments f
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY dsem.year, dsem.season
ORDER BY dsem.year, dsem.season;

-- =============================================================================
-- DRILL-DOWN OPERATIONS (Breaking down aggregated data to lower levels)
-- =============================================================================

-- 4. Drill-down: From department to course level analysis
SELECT 
    dd.department_name,
    dc.course_code,
    dc.course_name,
    dc.credits,
    COUNT(*) as enrollments,
    AVG(f.final_grade) as avg_grade,
    MIN(f.final_grade) as min_grade,
    MAX(f.final_grade) as max_grade,
    STDDEV(f.final_grade) as grade_stddev
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_courses dc ON f.course_key = dc.course_key
WHERE f.completion_status = 'Completed'
  AND dd.department_name = 'Computer Science'
GROUP BY dd.department_name, dc.course_code, dc.course_name, dc.credits
ORDER BY dc.course_code;

-- 5. Drill-down: From semester to individual student performance
SELECT 
    dsem.semester_name,
    dsem.year,
    ds.full_name,
    ds.class_level,
    COUNT(*) as courses_taken,
    AVG(f.final_grade) as semester_avg,
    SUM(f.credits_earned) as credits_earned,
    CASE WHEN SUM(f.credits_attempted) > 0 
         THEN SUM(f.gpa_points) / SUM(f.credits_attempted)
         ELSE 0 END as semester_gpa
FROM fact_enrollments f
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
JOIN dim_students ds ON f.student_key = ds.student_key
WHERE f.completion_status = 'Completed'
  AND dsem.year = 2023
  AND dsem.semester_name = 'Fall'
GROUP BY dsem.semester_name, dsem.year, ds.student_key, ds.full_name, ds.class_level
ORDER BY semester_gpa DESC;

-- 6. Drill-down: Faculty performance by individual courses taught
SELECT 
    df.full_name as faculty_name,
    df.position,
    dd.department_name,
    dc.course_code,
    dc.course_name,
    dsem.semester_name,
    dsem.year,
    COUNT(*) as students_taught,
    AVG(f.final_grade) as avg_student_grade,
    ROUND((SUM(CASE WHEN f.is_passing THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
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
-- SLICE AND DICE OPERATIONS (Filtering and cross-tabulation)
-- =============================================================================

-- 7. Slice: Focus on specific semester and department
SELECT 
    dc.course_level,
    ds.class_level,
    COUNT(*) as enrollments,
    AVG(f.final_grade) as avg_grade,
    ROUND((SUM(CASE WHEN f.is_passing THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
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

-- 8. Dice: Cross-tabulation of department vs semester performance
SELECT 
    dd.department_name,
    SUM(CASE WHEN dsem.semester_name = 'Fall' AND dsem.year = 2022 THEN 1 ELSE 0 END) as fall_2022,
    SUM(CASE WHEN dsem.semester_name = 'Spring' AND dsem.year = 2023 THEN 1 ELSE 0 END) as spring_2023,
    SUM(CASE WHEN dsem.semester_name = 'Fall' AND dsem.year = 2023 THEN 1 ELSE 0 END) as fall_2023,
    COUNT(*) as total_enrollments
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name
ORDER BY total_enrollments DESC;

-- 9. Dice: Student age group vs course level analysis
SELECT 
    ds.age_group,
    dc.course_level,
    COUNT(*) as enrollments,
    AVG(f.final_grade) as avg_grade,
    ROUND(AVG(f.gpa_points), 2) as avg_gpa_points,
    ROUND((SUM(CASE WHEN f.is_honors THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as honors_rate
FROM fact_enrollments f
JOIN dim_students ds ON f.student_key = ds.student_key
JOIN dim_courses dc ON f.course_key = dc.course_key
WHERE f.completion_status = 'Completed'
GROUP BY ds.age_group, dc.course_level
ORDER BY ds.age_group, dc.course_level;

-- =============================================================================
-- ADVANCED ANALYTICAL QUERIES
-- =============================================================================

-- 10. Time series analysis: Enrollment trends over time
SELECT 
    dsem.year,
    dsem.season,
    dd.department_type,
    COUNT(*) as enrollments,
    LAG(COUNT(*), 1) OVER (PARTITION BY dd.department_type ORDER BY dsem.year, dsem.season) as prev_semester,
    ROUND(((COUNT(*) - LAG(COUNT(*), 1) OVER (PARTITION BY dd.department_type ORDER BY dsem.year, dsem.season)) / 
           LAG(COUNT(*), 1) OVER (PARTITION BY dd.department_type ORDER BY dsem.year, dsem.season)) * 100, 2) as growth_rate
FROM fact_enrollments f
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
JOIN dim_departments dd ON f.department_key = dd.department_key
GROUP BY dsem.year, dsem.season, dd.department_type
ORDER BY dd.department_type, dsem.year, dsem.season;

-- 11. Cohort analysis: Student retention by enrollment year
SELECT 
    ds.enrollment_year,
    dsem.year as academic_year,
    COUNT(DISTINCT f.student_key) as active_students,
    FIRST_VALUE(COUNT(DISTINCT f.student_key)) OVER (PARTITION BY ds.enrollment_year ORDER BY dsem.year) as cohort_size,
    ROUND((COUNT(DISTINCT f.student_key) / 
           FIRST_VALUE(COUNT(DISTINCT f.student_key)) OVER (PARTITION BY ds.enrollment_year ORDER BY dsem.year)) * 100, 2) as retention_rate
FROM fact_enrollments f
JOIN dim_students ds ON f.student_key = ds.student_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY ds.enrollment_year, dsem.year
ORDER BY ds.enrollment_year, dsem.year;

-- 12. Performance ranking with percentiles
SELECT 
    ds.full_name,
    ds.class_level,
    dd.department_name,
    AVG(f.final_grade) as avg_grade,
    SUM(f.credits_earned) as total_credits,
    NTILE(4) OVER (ORDER BY AVG(f.final_grade)) as performance_quartile,
    PERCENT_RANK() OVER (ORDER BY AVG(f.final_grade)) as performance_percentile,
    RANK() OVER (ORDER BY AVG(f.final_grade) DESC) as grade_rank
FROM fact_enrollments f
JOIN dim_students ds ON f.student_key = ds.student_key
JOIN dim_departments dd ON f.department_key = dd.department_key
WHERE f.completion_status = 'Completed'
GROUP BY ds.student_key, ds.full_name, ds.class_level, dd.department_name
HAVING COUNT(*) >= 3  -- Students with at least 3 completed courses
ORDER BY avg_grade DESC;
