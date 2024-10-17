CREATE DATABASE quanlyhocvien;
USE quanlyhocvien;

CREATE TABLE Address (
    AddressId INT PRIMARY KEY NOT NULL,
    address VARCHAR(100)
);

CREATE TABLE Classes (
    ClassesId INT PRIMARY KEY NOT NULL,
    ClassesName VARCHAR(45) NOT NULL,
    ClassesLanguage VARCHAR(45),
    ClassesDescription VARCHAR(45)
);

CREATE TABLE Students (
    StudentsId INT PRIMARY KEY NOT NULL,
    StudentsName VARCHAR(45) NOT NULL,
    Address_Id INT,
    age INT,
    phone VARCHAR(10) UNIQUE,
    classes_id INT,
    FOREIGN KEY (Address_Id) REFERENCES Address(AddressId),
    FOREIGN KEY (classes_id) REFERENCES Classes(ClassesId)
);

CREATE TABLE Course (
    CourseId INT PRIMARY KEY NOT NULL,
    CourseName VARCHAR(45) NOT NULL,
    CourseDescription VARCHAR(45)
);

CREATE TABLE Points (
    PointId INT PRIMARY KEY NOT NULL,
    course_id INT,
    student_id INT,
    points INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(CourseId),
    FOREIGN KEY (student_id) REFERENCES Students(StudentsId)
);

-- Viết câu query thực hiện:
-- Tìm kiếm HV có họ Nguyen

SELECT * 
FROM Students
WHERE StudentsName LIKE 'Nguyen%';

-- Tìm kiếm HV có ten Anh

SELECT * 
FROM Students
WHERE StudentsName LIKE '%Anh';

-- Tim kiem HV có độ tuổi tư 18-25

SELECT * 
FROM Students
WHERE age BETWEEN 18 AND 25;

-- Tìm kiếm HV có id là 12 hoặc 13
SELECT * 
FROM Students
WHERE StudentsId IN (12, 13);

-- Viết các câu lệnh truy vấn thực hiện nhiệm vụ sau:
-- Thống kê số lượng học viên các lớp (count) 

SELECT c.ClassesName, COUNT(s.StudentsId) AS NumberOfStudents
FROM Students s
JOIN Classes c ON s.classes_id = c.ClassesId
GROUP BY c.ClassesName;

-- Thống kê số lượng học viên tại các tỉnh (count)

SELECT a.address AS Province, COUNT(s.StudentsId) AS NumberOfStudents
FROM Students s
JOIN Address a ON s.Address_Id = a.AddressId
GROUP BY a.address;

-- Tính điểm trung bình của các khóa học (avg)

SELECT c.CourseName, AVG(p.points) AS AveragePoints
FROM Points p
JOIN Course c ON p.course_id = c.CourseId
GROUP BY c.CourseName;

-- Lấy ra điểm cao nhất, thấp nhất.

-- Điểm cao nhất
SELECT MAX(points) AS HighestPoints FROM Points;

-- Điểm thấp nhất
SELECT MIN(points) AS LowestPoints FROM Points;

-- Lấy ra danh sách HS, Chuyển đổi tên HS thành chữ hoa

SELECT UPPER(StudentsName) AS StudentNameInUpperCase 
FROM Students;

-- Đưa ra khoá học có điểm trung bình cao nhất

SELECT c.CourseName, AVG(p.points) AS AveragePoints
FROM Points p
JOIN Course c ON p.course_id = c.CourseId
GROUP BY c.CourseName
ORDER BY AveragePoints DESC
LIMIT 1;
