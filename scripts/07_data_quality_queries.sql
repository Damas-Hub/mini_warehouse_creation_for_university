-- Data Quality Assessment and Metadata Management Queries
USE university_dw;

-- =============================================================================
-- DATA QUALITY CHECKS
-- =============================================================================

-- 1. Check for missing or null values in critical fields
SELECT 
    'Students' as table_name,
    SUM(CASE WHEN student_id IS NULL THEN 1 ELSE 0 END) as null_student_id,
    SUM(CASE WHEN full_name IS NULL OR full_name = '' THEN 1 ELSE 0 END) as null_name,
    SUM(CASE WHEN email IS NULL OR email = '' THEN 1 ELSE 0 END) as null_email,
    SUM(CASE WHEN enrollment_date IS NULL THEN 1 ELSE 0 END) as null_enrollment_date,
    COUNT(*) as total_records
FROM dim_students
UNION ALL
SELECT 
    'Courses' as table_name,
    SUM(CASE WHEN course_id IS NULL THEN 1 ELSE 0 END) as null_course_id,
    SUM(CASE WHEN course_code IS NULL OR course_code = '' THEN 1 ELSE 0 END) as null_course_code,
    SUM(CASE WHEN course_name IS NULL OR course_name = '' THEN 1 ELSE 0 END) as null_course_name,
    SUM(CASE WHEN credits IS NULL OR credits <= 0 THEN 1 ELSE 0 END) as invalid_credits,
    COUNT(*) as total_records
FROM dim_courses
UNION ALL
SELECT 
    'Fact_Enrollments' as table_name,
    SUM(CASE WHEN student_key IS NULL THEN 1 ELSE 0 END) as null_student_key,
    SUM(CASE WHEN course_key IS NULL THEN 1 ELSE 0 END) as null_course_key,
    SUM(CASE WHEN enrollment_date IS NULL THEN 1 ELSE 0 END) as null_enrollment_date,
    SUM(CASE WHEN final_grade < 0 OR final_grade > 100 THEN 1 ELSE 0 END) as invalid_grades,
    COUNT(*) as total_records
FROM fact_enrollments;

-- 2. Check for duplicate records
SELECT 
    'Duplicate Students' as check_type,
    COUNT(*) - COUNT(DISTINCT student_id) as duplicate_count
FROM dim_students
WHERE is_current = TRUE
UNION ALL
SELECT 
    'Duplicate Courses' as check_type,
    COUNT(*) - COUNT(DISTINCT course_id) as duplicate_count
FROM dim_courses
WHERE is_current = TRUE
UNION ALL
SELECT 
    'Duplicate Enrollments' as check_type,
    COUNT(*) - COUNT(DISTINCT CONCAT(student_key, '-', course_key, '-', semester_key)) as duplicate_count
FROM fact_enrollments;

-- 3. Check for referential integrity violations
SELECT 
    'Orphaned Fact Records' as check_type,
    COUNT(*) as violation_count
FROM fact_enrollments f
LEFT JOIN dim_students ds ON f.student_key = ds.student_key
WHERE ds.student_key IS NULL
UNION ALL
SELECT 
    'Missing Course References' as check_type,
    COUNT(*) as violation_count
FROM fact_enrollments f
LEFT JOIN dim_courses dc ON f.course_key = dc.course_key
WHERE dc.course_key IS NULL
UNION ALL
SELECT 
    'Missing Faculty References' as check_type,
    COUNT(*) as violation_count
FROM fact_enrollments f
LEFT JOIN dim_faculty df ON f.faculty_key = df.faculty_key
WHERE df.faculty_key IS NULL;

-- 4. Data consistency checks
SELECT 
    'Grade vs Letter Grade Consistency' as check_type,
    COUNT(*) as inconsistent_records
FROM fact_enrollments
WHERE (final_grade >= 97 AND letter_grade != 'A') OR
      (final_grade BETWEEN 93 AND 96.99 AND letter_grade != 'A-') OR
      (final_grade BETWEEN 90 AND 92.99 AND letter_grade != 'B+') OR
      (final_grade BETWEEN 87 AND 89.99 AND letter_grade != 'B') OR
      (final_grade BETWEEN 83 AND 86.99 AND letter_grade != 'B-') OR
      (final_grade BETWEEN 80 AND 82.99 AND letter_grade != 'C+') OR
      (final_grade BETWEEN 77 AND 79.99 AND letter_grade != 'C') OR
      (final_grade BETWEEN 73 AND 76.99 AND letter_grade != 'C-') OR
      (final_grade BETWEEN 70 AND 72.99 AND letter_grade != 'D+') OR
      (final_grade BETWEEN 67 AND 69.99 AND letter_grade != 'D') OR
      (final_grade < 67 AND letter_grade != 'F');

-- 5. Business rule violations
SELECT 
    'Credits Earned vs Attempted' as check_type,
    COUNT(*) as violation_count
FROM fact_enrollments
WHERE credits_earned > credits_attempted
UNION ALL
SELECT 
    'Enrollment Date vs Completion Date' as check_type,
    COUNT(*) as violation_count
FROM fact_enrollments
WHERE completion_date < enrollment_date
UNION ALL
SELECT 
    'Invalid GPA Points' as check_type,
    COUNT(*) as violation_count
FROM fact_enrollments
WHERE gpa_points < 0 OR gpa_points > (credits_attempted * 4.0);

-- =============================================================================
-- DATA PROFILING AND STATISTICS
-- =============================================================================

-- 6. Data distribution analysis
SELECT 
    'Student Age Distribution' as metric,
    age_group,
    COUNT(*) as count,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()), 2) as percentage
FROM dim_students
WHERE is_current = TRUE
GROUP BY age_group
UNION ALL
SELECT 
    'Course Level Distribution' as metric,
    course_level,
    COUNT(*) as count,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()), 2) as percentage
FROM dim_courses
WHERE is_current = TRUE
GROUP BY course_level
ORDER BY metric, count DESC;

-- 7. Grade distribution analysis
SELECT 
    letter_grade,
    COUNT(*) as frequency,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()), 2) as percentage,
    AVG(final_grade) as avg_numeric_grade,
    MIN(final_grade) as min_grade,
    MAX(final_grade) as max_grade
FROM fact_enrollments
WHERE completion_status = 'Completed' AND letter_grade IS NOT NULL
GROUP BY letter_grade
ORDER BY 
    CASE letter_grade
        WHEN 'A' THEN 1
        WHEN 'A-' THEN 2
        WHEN 'B+' THEN 3
        WHEN 'B' THEN 4
        WHEN 'B-' THEN 5
        WHEN 'C+' THEN 6
        WHEN 'C' THEN 7
        WHEN 'C-' THEN 8
        WHEN 'D+' THEN 9
        WHEN 'D' THEN 10
        ELSE 11
    END;

-- =============================================================================
-- METADATA MANAGEMENT
-- =============================================================================

-- 8. Table metadata and row counts
SELECT 
    table_name,
    table_rows,
    ROUND((data_length + index_length) / 1024 / 1024, 2) as size_mb,
    table_comment
FROM information_schema.tables
WHERE table_schema = 'university_dw'
ORDER BY table_rows DESC;

-- 9. Column metadata analysis
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default,
    column_comment
FROM information_schema.columns
WHERE table_schema = 'university_dw'
  AND table_name IN ('fact_enrollments', 'dim_students', 'dim_courses', 'dim_faculty')
ORDER BY table_name, ordinal_position;

-- 10. Index usage and performance metadata
SELECT 
    table_name,
    index_name,
    column_name,
    seq_in_index,
    cardinality,
    nullable
FROM information_schema.statistics
WHERE table_schema = 'university_dw'
ORDER BY table_name, index_name, seq_in_index;

-- =============================================================================
-- DATA LINEAGE AND AUDIT TRAIL
-- =============================================================================

-- 11. Data freshness check
SELECT 
    'dim_students' as table_name,
    MAX(created_date) as last_updated,
    COUNT(*) as total_records,
    DATEDIFF(NOW(), MAX(created_date)) as days_since_update
FROM dim_students
UNION ALL
SELECT 
    'fact_enrollments' as table_name,
    MAX(created_date) as last_updated,
    COUNT(*) as total_records,
    DATEDIFF(NOW(), MAX(created_date)) as days_since_update
FROM fact_enrollments
UNION ALL
SELECT 
    'agg_enrollment_summary_by_semester' as table_name,
    MAX(created_date) as last_updated,
    COUNT(*) as total_records,
    DATEDIFF(NOW(), MAX(created_date)) as days_since_update
FROM agg_enrollment_summary_by_semester;

-- 12. Data quality scorecard
SELECT 
    'Overall Data Quality Score' as metric,
    ROUND(
        (
            -- Completeness score (non-null critical fields)
            (SELECT (COUNT(*) - SUM(CASE WHEN student_id IS NULL OR full_name IS NULL OR email IS NULL THEN 1 ELSE 0 END)) * 100.0 / COUNT(*) FROM dim_students) * 0.3 +
            -- Accuracy score (valid grades)
            (SELECT (COUNT(*) - SUM(CASE WHEN final_grade < 0 OR final_grade > 100 THEN 1 ELSE 0 END)) * 100.0 / COUNT(*) FROM fact_enrollments WHERE final_grade IS NOT NULL) * 0.3 +
            -- Consistency score (grade vs letter grade alignment)
            (SELECT (COUNT(*) - COUNT(CASE WHEN (final_grade >= 90 AND letter_grade NOT IN ('A', 'A-')) OR (final_grade < 60 AND letter_grade != 'F') THEN 1 END)) * 100.0 / COUNT(*) FROM fact_enrollments WHERE final_grade IS NOT NULL AND letter_grade IS NOT NULL) * 0.4
        ), 2
    ) as quality_score_percentage;
