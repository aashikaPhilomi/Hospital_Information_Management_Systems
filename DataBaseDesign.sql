
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    contact VARCHAR(15)
);
INSERT INTO patients VALUES
(101, 'Asha', 'F', '1995-06-12', '9876543210'),
(102, 'Rahul', 'M', '1990-02-25', '9876501234'),
(103, 'Meena', 'F', '1988-11-03', '9123456780'),
(104, 'Arjun', 'M', '1992-07-19', '9988776655'),
(105, 'Divya', 'F', '1998-09-30', NULL); 

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(50)
);
INSERT INTO doctors VALUES
(201, 'Dr. Kumar', 'Cardiology'),
(202, 'Dr. Priya', 'Neurology'),
(203, 'Dr. John', 'Orthopedics'),
(204, 'Dr. Ravi', 'General'),
(205, 'Dr. Sneha', 'Dermatology');

CREATE TABLE appointment (
    appointment_id INT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATEtime,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO appointment VALUES
(1,101, 201,'2025-04-01 10:00:00','completed'),
(2,101, 201,'2025-04-01 10:05:00','completed'), 
(3,102, 202,'2025-04-02 11:00:00','completed'),
(4,103, 203,'2025-04-03 09:30:00','completed'),
(5,NULL, 204,'2025-04-04 08:00:00','completed'), 
(6,104, NULL, '2025-04-05 12:00:00','completed'), 
(7,105, 205,'2025-04-06 14:00:00','completed'); 

CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2),
    bill_date DATE
);
INSERT INTO billing (bill_id, patient_id, amount, bill_date) VALUES
(1, 101, 500.00, '2026-04-01'),
(2, 102, 1200.50, '2026-04-02'),
(3, 103, 750.75, '2026-04-03'),
(4, 104, 300.00, '2026-04-04'),
(5, 105, 950.25, '2026-04-05'),
(6, 101, 1100.00, '2026-04-06'),
(7, 102, 450.50, '2026-04-07'),
(8, 106, 2000.00, '2026-04-08'),
(9, 107, 670.00, '2026-04-09'),
(10, 108, 890.80, '2026-04-10');

CREATE TABLE staging_appointments AS
SELECT * FROM appointment;

 
