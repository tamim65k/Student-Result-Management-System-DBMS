-- ===========================================================
-- 🎓 STUDENT RESULT MANAGEMENT SYSTEM
-- ===========================================================

-- 1️⃣ Create Database
CREATE DATABASE StudentResultManagement;
USE StudentResultManagement;

-- ===========================================================
-- 2️⃣ TABLE STRUCTURE
-- ===========================================================

-- 🧑‍🎓 Student Table
CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    reg_number VARCHAR(20) UNIQUE,
    department VARCHAR(50),
    batch VARCHAR(20),
    roll INT,
    date_of_birth DATE,
    age INT
);

-- ✉️ Student Email (Optional separate table for normalization)
CREATE TABLE Student_Email (
    student_id INT,
    s_email VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- 👨‍🏫 Teacher Table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50)
);

-- ✉️ Teacher Email Table
CREATE TABLE Teacher_Email (
    teacher_id INT,
    teacher_email VARCHAR(100),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- 📚 Course Table
CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    credit DECIMAL(3,1),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- 🧾 Result Table
CREATE TABLE Result (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_code VARCHAR(10),
    teacher_id INT,
    marks DECIMAL(5,2),
    cgpa DECIMAL(3,2),
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_code) REFERENCES Course(course_code),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- 🧩 Result Details Table
CREATE TABLE Result_Details (
    result_id INT,
    marks DECIMAL(5,2),
    course_code VARCHAR(10),
    exam_type VARCHAR(50),
    remarks VARCHAR(255),
    FOREIGN KEY (result_id) REFERENCES Result(result_id),
    FOREIGN KEY (course_code) REFERENCES Course(course_code)
);

-- 📘 Enrolls Table (Many-to-Many between Student & Course)
CREATE TABLE Enrolls (
    student_id INT,
    course_code VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_code) REFERENCES Course(course_code)
);

-- 👨‍🏫 Conducts Table (Many-to-Many between Teacher & Course)
CREATE TABLE Conducts (
    course_code VARCHAR(10),
    teacher_id INT,
    FOREIGN KEY (course_code) REFERENCES Course(course_code),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- ===========================================================
-- 3️⃣ SAMPLE DATA
-- ===========================================================

-- 👨‍🏫 Teachers
INSERT INTO Teacher (name, email, department)
VALUES
('Md. Ayon Mia', 'ayonmia@diu.edu.bd', 'CSE'),
('Dr. Rahim Uddin', 'rahim@diu.edu.bd', 'CSE'),
('Mrs. Nasrin Akter', 'nasrin@diu.edu.bd', 'EEE');

-- 📚 Courses
INSERT INTO Course (course_code, course_title, credit, teacher_id)
VALUES
('CSE101', 'Database Management System', 3.0, 1),
('CSE102', 'Data Structure', 3.0, 2),
('EEE101', 'Digital Logic Design', 3.0, 3);

-- 🧑‍🎓 Students
INSERT INTO Student (name, email, address, reg_number, department, batch, roll, date_of_birth, age)
VALUES
('Tamim Hossen', 'tamim@example.com', 'Dhaka', 'CSE2024001', 'CSE', '65th', 24, '2001-06-12', 24),
('Montasir Hasan', 'montasir@example.com', 'Dhaka', 'CSE2024002', 'CSE', '65th', 27, '2001-08-22', 23),
('Nusrat Jahan', 'nusrat@example.com', 'Dhaka', 'CSE2024003', 'CSE', '65th', 38, '2002-03-15', 23),
('Mohammed Shahparan', 'paran@example.com', 'Dhaka', 'CSE2024004', 'CSE', '65th', 39, '2002-01-10', 23),
('Nushaiba Kawser Era', 'era@example.com', 'Dhaka', 'CSE2024005', 'CSE', '65th', 41, '2002-02-01', 23);

-- 🧾 Enrollments
INSERT INTO Enrolls (student_id, course_code)
VALUES
(1, 'CSE101'), (1, 'CSE102'),
(2, 'CSE101'), (2, 'CSE102'),
(3, 'CSE101'), (4, 'CSE101'),
(5, 'CSE102');

-- 👨‍🏫 Conducts
INSERT INTO Conducts (course_code, teacher_id)
VALUES
('CSE101', 1),
('CSE102', 2),
('EEE101', 3);

-- 🧮 Results
INSERT INTO Result (student_id, course_code, teacher_id, marks, cgpa, grade)
VALUES
(1, 'CSE101', 1, 88, 3.90, 'A'),
(1, 'CSE102', 2, 91, 4.00, 'A+'),
(2, 'CSE101', 1, 85, 3.80, 'A-'),
(3, 'CSE101', 1, 75, 3.25, 'B+'),
(4, 'CSE101', 1, 67, 2.80, 'B'),
(5, 'CSE102', 2, 92, 4.00, 'A+');

-- 🧾 Result Details
INSERT INTO Result_Details (result_id, marks, course_code, exam_type, remarks)
VALUES
(1, 88, 'CSE101', 'Final', 'Excellent'),
(2, 91, 'CSE102', 'Final', 'Outstanding'),
(3, 85, 'CSE101', 'Midterm', 'Very Good'),
(4, 75, 'CSE101', 'Final', 'Good'),
(5, 67, 'CSE101', 'Final', 'Average'),
(6, 92, 'CSE102', 'Final', 'Excellent');

-- ===========================================================
-- 4️⃣ QUERIES & REPORTS
-- ===========================================================

-- Show all students with their email
SELECT s.name, s.email FROM Student s;

-- List all students with department and batch
SELECT name, department, batch FROM Student;

-- Students who scored above 3.80 CGPA
SELECT s.name, r.cgpa
FROM Student s
JOIN Result r ON s.student_id = r.student_id
WHERE r.cgpa > 3.80;

-- Teachers conducting courses
SELECT t.name AS Teacher, c.course_title AS Course
FROM Conducts con
JOIN Teacher t ON con.teacher_id = t.teacher_id
JOIN Course c ON con.course_code = c.course_code;

-- Show all results with remarks
SELECT s.name, c.course_title, r.cgpa, rd.exam_type, rd.remarks
FROM Result r
JOIN Student s ON r.student_id = s.student_id
JOIN Course c ON r.course_code = c.course_code
JOIN Result_Details rd ON r.result_id = rd.result_id;

-- List all students with their enrolled courses and teacher
SELECT s.name AS Student, c.course_title AS Course, t.name AS Teacher
FROM Enrolls e
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_code = c.course_code
JOIN Teacher t ON c.teacher_id = t.teacher_id;

-- Total number of students in each department
SELECT department, COUNT(*) AS total_students
FROM Student
GROUP BY department;

-- Highest CGPA and student name
SELECT s.name, MAX(r.cgpa) AS Highest_CGPA
FROM Result r
JOIN Student s ON r.student_id = s.student_id;

-- List teachers from CSE department with their email
SELECT name, email FROM Teacher WHERE department = 'CSE';

-- Average CGPA per department
SELECT s.department, AVG(r.cgpa) AS avg_cgpa
FROM Student s
JOIN Result r ON s.student_id = r.student_id
GROUP BY s.department;

