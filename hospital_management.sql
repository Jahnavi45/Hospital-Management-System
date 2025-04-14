-- Create table: Departments
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

-- Create table: Doctors
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100),
    DeptID INT,
    Experience INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Create table: Patients
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(15)
);

-- Create table: Appointments
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create table: Billing
CREATE TABLE Billing (
    BillID INT PRIMARY KEY,
    AppointmentID INT,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Insert sample data
INSERT INTO Departments VALUES
(1, 'Cardiology'), (2, 'Neurology'), (3, 'Orthopedics');

INSERT INTO Doctors VALUES
(101, 'Dr. Meera Rao', 1, 10),
(102, 'Dr. Rajiv Malhotra', 2, 15),
(103, 'Dr. Kavita Sharma', 3, 7);

INSERT INTO Patients VALUES
(201, 'Ananya Verma', 25, 'Female', '9988776655'),
(202, 'Amit Singh', 40, 'Male', '9876543210'),
(203, 'Riya Das', 32, 'Female', '9998887770');

INSERT INTO Appointments VALUES
(301, 201, 101, '2024-12-01', 'Completed'),
(302, 202, 102, '2024-12-05', 'Pending'),
(303, 203, 103, '2024-12-10', 'Completed');

INSERT INTO Billing VALUES
(401, 301, 1500.00, 'Paid'),
(402, 302, 2000.00, 'Unpaid'),
(403, 303, 1200.00, 'Paid');

-- Sample Queries

-- 1. List all patients with their appointment and doctor details
SELECT P.PatientName, D.DoctorName, A.AppointmentDate, A.Status
FROM Patients P
JOIN Appointments A ON P.PatientID = A.PatientID
JOIN Doctors D ON A.DoctorID = D.DoctorID;

-- 2. Total revenue from paid bills
SELECT SUM(Amount) AS TotalRevenue
FROM Billing
WHERE PaymentStatus = 'Paid';

-- 3. List of doctors with department
SELECT D.DoctorName, DP.DeptName, D.Experience
FROM Doctors D
JOIN Departments DP ON D.DeptID = DP.DeptID;

-- 4. Count of appointments per doctor
SELECT DoctorID, COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID;

-- 5. Patients who haven’t paid yet
SELECT P.PatientName, B.Amount
FROM Patients P
JOIN Appointments A ON P.PatientID = A.PatientID
JOIN Billing B ON A.AppointmentID = B.AppointmentID
WHERE B.PaymentStatus = 'Unpaid';
