1)

-- Create a table Students

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
);

-- Create a table Courses

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

-- Creating the Foreign Key
ALTER TABLE Students
ADD CONSTRAINT FK_Course
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);



2)

-- Inserting Records into the Courses Table

INSERT INTO Courses (CourseID, CourseName)
VALUES (1, 'English'),
       (2, 'Urdu'),
       (3, 'Maths'),
       (4, 'Physics'),
       (5, 'Chemistry');
 -- Inserting Records into the Students Table

INSERT INTO Students (StudentID, FirstName, LastName, Age, CourseID)
VALUES (1, 'Sherlock', 'Holmes', 22, 1),
       (2, 'Shane', 'Watson', 29, 2),
       (3, 'Ali', 'Tanvir', 22, 3),
       (4, 'Sarah', 'Taylor', 24, 5),
       (5, 'Michael', 'Clarke', 20, 2),
       (6, 'Andrew', 'Trott', 26, 2),
       (7, 'Mahrukh', 'Shahzad', 21, 4),
       (8, 'Fatima', 'Abid', 25, 4),
       (9, 'Alina', 'Shabbir', 21, 1),
       (10, 'Ali', 'Hassan', 23, 5);



3)

-- Update the Record

UPDATE Students
SET Age = 30
WHERE StudentID = 3;

 -- Delete the Record

DELETE FROM Students
WHERE StudentID = 6;


4)

-- Queries and Filters

SELECT * FROM Students
WHERE Age > 20;

SELECT Students.FirstName, Students.LastName, Courses.CourseName FROM Students
JOIN Courses ON Students.CourseID


5)

-- Aggregation Functions

SELECT COUNT(*) AS TotalStudents
FROM Students;

SELECT AVG(Age) AS AverageAge
FROM Students;


6)

-- Names of students who are not enrolled in any course

SELECT FirstName, LastName
FROM Students
WHERE CourseID IS NULL;

-- Most popular course (the course with the most students enrolled)

SELECT Courses.CourseName, COUNT(*) AS EnrolledStudents
FROM Students
JOIN Courses ON Students.CourseID = Courses.CourseID
GROUP BY Courses.CourseName
ORDER BY EnrolledStudents DESC
LIMIT 1;

-- Students who are older than the average age of students

SELECT Students.FirstName, Students.LastName
FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);

-- Total number of students and average age for each course

SELECT Courses.CourseName, COUNT(*) AS TotalStudents, AVG(Age) AS AverageAge
FROM Students
JOIN Courses ON Students.CourseID = Courses.CourseID
GROUP BY Courses.CourseName;

-- Courses that have no students enrolled in them

SELECT Courses.CourseName
FROM Courses
LEFT JOIN Students ON Courses.CourseID = Students.CourseID
WHERE Students.StudentID IS NULL;


CREATE PROCEDURE GetAllStudents
AS
BEGIN
    SELECT * FROM Students;
END;
GO


CREATE PROCEDURE AddStudent
    @FirstName VARCHAR(50),
	@LastName VARCHAR (50),
    @Age INT,
    @CourseID INT
AS
BEGIN
    INSERT INTO Students (FirstName, LastName, Age, CourseID)
    VALUES (@FirstName, @LastName, @Age, @CourseID);
END;
GO

CREATE PROCEDURE UpdateStudentRecord
    @ID INT,
    @NewAge INT
AS
BEGIN
    UPDATE Students
    SET Age = @NewAge
    WHERE StudentID = @ID;
END;
GO

CREATE PROCEDURE DeleteStudent
    @ID INT
AS
BEGIN
    DELETE FROM Students
    WHERE StudentID = @ID;
END;
GO



CREATE PROCEDURE StudentsnotEnrolled
AS
BEGIN
    SELECT FirstName, LastName
FROM Students
WHERE CourseID IS NULL;

END;
GO

CREATE PROCEDURE MostPopularCourse
AS
BEGIN
   SELECT CourseName, COUNT(*) AS totalstudents
FROM Courses
JOIN Students ON Students.CourseID = Courses.CourseID
GROUP BY CourseName
ORDER BY totalstudents DESC
END;
GO

CREATE PROCEDURE StudentsOlder
AS
BEGIN
  SELECT Students.FirstName, Students.LastName
FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);
END;
GO

CREATE PROCEDURE Totalstudentsandaverageage
AS
BEGIN
SELECT Courses.CourseName, COUNT(*) AS TotalStudents, AVG(Age) AS AverageAge
FROM Students
JOIN Courses ON Students.CourseID = Courses.CourseID
GROUP BY Courses.CourseName;

END;
GO

CREATE PROCEDURE Courseswithoutstudents
AS
BEGIN
   SELECT Courses.CourseName
FROM Courses
LEFT JOIN Students ON Courses.CourseID = Students.CourseID
WHERE Students.StudentID IS NULL
END;
GO

CREATE PROCEDURE Courseshare
AS
BEGIN
    SELECT FirstName, LastName
FROM Students 
WHERE CourseID IN (SELECT CourseID FROM Students WHERE StudentID =1);

END;
GO

CREATE PROCEDURE Youngestandoldeststudent
AS
BEGIN
    SELECT Courses.CourseName,
MIN(Students.Age) AS YoungestStudent,
MAX(Students.Age) AS OldestStudent
FROM Students JOIN Courses ON Students.CourseID = Courses.CourseID
GROUP BY Courses.CourseName;

END;
GO