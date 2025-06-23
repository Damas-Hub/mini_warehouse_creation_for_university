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
