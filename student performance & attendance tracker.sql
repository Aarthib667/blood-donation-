CREATE DATABASE StudentTrackerDB;
USE StudentTrackerDB;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    roll_number VARCHAR(20) UNIQUE,
    department VARCHAR(50),
    semester INT
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(10) UNIQUE,
    subject_name VARCHAR(100),
    department VARCHAR(50),
    semester INT
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    date DATE,
    status ENUM('Present', 'Absent') DEFAULT 'Absent',
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    marks_obtained INT,
    max_marks INT,
    exam_type VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE
);

INSERT INTO students (name, roll_number, department, semester) VALUES
('Alice', 'CSE101', 'CSE', 5),
('Bob', 'CSE102', 'CSE', 5),
('Charlie', 'ECE101', 'ECE', 5);

INSERT INTO subjects (subject_code, subject_name, department, semester) VALUES
('CS501', 'Database Systems', 'CSE', 5),
('CS502', 'Software Engineering', 'CSE', 5),
('EC501', 'Microprocessors', 'ECE', 5);

INSERT INTO attendance (student_id, subject_id, date, status) VALUES
(1, 1, '2025-07-01', 'Present'),
(1, 1, '2025-07-02', 'Absent'),
(2, 1, '2025-07-01', 'Present'),
(3, 3, '2025-07-01', 'Absent');

INSERT INTO marks (student_id, subject_id, marks_obtained, max_marks, exam_type) VALUES
(1, 1, 85, 100, 'Final'),
(1, 2, 78, 100, 'Final'),
(2, 1, 66, 100, 'Final'),
(3, 3, 72, 100, 'Final');
-- 1. Attendance Summary
SELECT s.name, sub.subject_name,
       COUNT(*) AS total_classes,
       SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS days_present,
       ROUND(SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id
GROUP BY s.student_id, sub.subject_id;

-- 2. Student Performance (Marks %)
SELECT s.name, s.roll_number,
       ROUND(SUM(marks_obtained) * 100.0 / SUM(max_marks), 2) AS overall_percentage
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_id;

-- 3. Low Attendance Alert (< 75%)
SELECT s.name, sub.subject_name,
       ROUND(SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id
GROUP BY s.student_id, sub.subject_id
HAVING attendance_percentage < 75;

-- 4.Top Performers (> 80%)
SELECT s.name, s.roll_number,
       ROUND(SUM(marks_obtained) * 100.0 / SUM(max_marks), 2) AS percentage
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_id
HAVING percentage > 80;


