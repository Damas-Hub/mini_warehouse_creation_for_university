-- Load sample data into operational tables
USE university_system;

-- Insert Departments
INSERT INTO departments (department_name, department_code, building, phone) VALUES
('Computer Science', 'CS', 'Tech Building', '555-0101'),
('Mathematics', 'MATH', 'Science Hall', '555-0102'),
('Business Administration', 'BUS', 'Business Center', '555-0103'),
('English Literature', 'ENG', 'Liberal Arts', '555-0104'),
('Psychology', 'PSY', 'Social Sciences', '555-0105'),
('Engineering', 'ENG', 'Engineering Complex', '555-0106'),
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
('First Semester', 2022, '2022-08-22', '2022-12-15'),
('Second Semester', 2023, '2023-01-16', '2023-05-12'),
('First Semester', 2023, '2023-08-21', '2023-12-14'),
('Second Semester', 2024, '2024-01-15', '2024-05-10'),
('First Semester', 2024, '2024-08-19', '2024-12-12');

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
