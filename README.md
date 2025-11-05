# 🎓 Student Result Management System

A centralized digital platform for managing and automating student academic results.

---

## 👥 Contributors

| Name | Roll | Department | University | GitHub |
|------|------|-------------|-------------|--------|
| **Md. Tamim Hossen** | 24 | CSE | Dhaka International University | [@tamim65k](https://github.com/tamim65k) |
| **Md. Montasir Hasan** | 27 | CSE | Dhaka International University | [@Montasirpeal](https://github.com/Montasirpeal) |
| **Nusrat Jahan** | 38 | CSE | Dhaka International University | [@nusrattasfi](https://github.com/nusrattasfi) |
| **Mohammed Shahparan** | 39 | CSE | Dhaka International University | [@paransha1](https://github.com/paransha1) |
| **Nushaiba Kawser Era** | 41 | CSE | Dhaka International University | [@nushaibakawser](https://github.com/nushaibakawser) |

**Submitted to:**  
📘 *Md. Ayon Mia*, Lecturer, Department of CSE, Dhaka International University  

---

## 📘 Overview

The **Student Result Management System (SRMS)** is a database-driven platform that automates the process of result computation, storage, and access for students and teachers.  
It ensures data accuracy, security, and real-time access using structured database management techniques.

Developed as part of the **Database Management System Lab (Course Code: 0612-304)**.

---

## 🎯 Objectives

- Efficiently store and manage students’ academic records digitally.  
- Automatically generate accurate result sheets from stored marks.  
- Minimize human errors in result calculation and management.  
- Allow authorized users (teachers/admins) to input, update, and manage marks securely.  
- Provide students with quick, reliable access to their results.

---

## ⚙️ Problem Statement

Manual or semi-manual result management in educational institutions causes:
- Delayed result generation  
- Calculation errors  
- Data redundancy and inconsistency  
- Limited accessibility  
- Higher administrative workload  

The **SRMS** addresses these issues by digitalizing and automating the process.

---

## 💡 Solution Overview

- Centralized result database.  
- Teachers can input marks through a user-friendly interface.  
- Automatic grade and CGPA calculation.  
- Students can securely access results online.  
- Reduced paperwork and improved data accuracy.

---

## 🧩 Entity–Relationship (ER) Model

### **Strong Entities**
- **Student**: `student_id`, `name`, `email`, `address`, `reg_number`, `department`, `batch`, `roll`, `date_of_birth`, `age`
- **Course**: `course_code`, `course_title`, `credit`
- **Teacher**: `teacher_id`, `name`, `email`, `department`
- **Result**: `result_id`, `student_id`, `course_code`, `teacher_id`, `marks`, `cgpa`, `grade`

### **Weak Entities**
- **ResultDetails**: `result_id`, `marks`, `course_code`, `exam_type`, `remarks`

---

## 🔗 Relationships

| Relationship | Type | Description |
|---------------|------|-------------|
| Student ↔ Course | M:N | A student can enroll in many courses. |
| Teacher ↔ Course | M:N | A course can be taught by multiple teachers. |
| Student ↔ Result | 1:M | One student can have multiple results. |
| Course ↔ Result | 1:M | One course can have multiple results. |
| Result ↔ ResultDetails | 1:1 | Each result has a detailed record. |

---

## 🗄️ Database Schema Mapping

| Table | Description |
|-------|--------------|
| `Student` | Student personal and academic details |
| `Student_Email` | Stores student emails separately |
| `Teacher` | Teacher information |
| `Teacher_Email` | Stores teacher emails |
| `Course` | Course details |
| `Result` | Final result with CGPA and grade |
| `Result_Details` | Marks, remarks, exam type |
| `Enrolls` | Links students to courses |
| `Conducts` | Links teachers to courses |

---

## 💾 Sample SQL Queries

```sql
-- 1. Show all students with their email addresses
SELECT Student.name, Student_Email.S_Email
FROM Student
JOIN Student_Email ON Student.student_id = Student_Email.student_id;

-- 2. List all students with their department and batch
SELECT name, department, batch FROM Student;

-- 3. Find students who scored more than 3.80 CGPA
SELECT name, cgpa FROM Result WHERE cgpa > 3.80;

-- 4. Find which teacher conducts which course
SELECT Teacher.name, Course.course_title
FROM Conducts
JOIN Teacher ON Conducts.teacher_id = Teacher.teacher_id
JOIN Course ON Conducts.course_id = Course.course_code;
