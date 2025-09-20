CREATE DATABASE hospital_db;
USE hospital_db;
drop database hospital_db;

drop table Patients ;
-- Patients Table
CREATE TABLE Patients (
    Patient_id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) not null,
    Age INT,
    Gender ENUM('Male','Female','Other'),
    Contact VARCHAR(15) not null,
    Address TEXT
);

alter table Patients
add column Blood_group varchar(50);

desc Patients;

INSERT INTO Patients (name, age, gender, contact, address, blood_group)
VALUES
('Ravi Kumar', 32, 'Male', '9876543210', 'Delhi', 'O+'),
('Meera Sharma', 40, 'Female', '9123456789', 'Mumbai', 'A+'),
('Amit Verma', 25, 'Male', '9988776655', 'Bangalore', 'B+'),
('Priya Singh', 29, 'Female', '9876501234', 'Kolkata', 'AB-'),
('Sanjay Gupta', 50, 'Male', '9012345678', 'Chennai', 'O-'),
('Anita Desai', 37, 'Female', '9345678901', 'Hyderabad', 'A-'),
('Rahul Nair', 30, 'Male', '9765432101', 'Pune', 'B-'),
('Kiran Das', 26, 'Other', '9234567890', 'Jaipur', 'AB+'),
('Neha Kapoor', 42, 'Female', '9456789012', 'Lucknow', 'O+'),
('Vikram Joshi', 34, 'Male', '9871203456', 'Ahmedabad', 'A+');

select * from patients;

-- Doctors Table
CREATE TABLE Doctors(
    Doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) not null,
    Specialization VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

desc Doctors;

INSERT INTO doctors (name, specialization, phone, email)
VALUES
('Dr. Meera Singh', 'Cardiologist', '9876543210', 'meera.singh@hospital.com'),
('Dr. Anil Kumar', 'Orthopedic', '9123456789', 'anil.kumar@hospital.com'),
('Dr. Neha Kapoor', 'Dermatologist', '9988776655', 'neha.kapoor@hospital.com'),
('Dr. Vikram Joshi', 'Neurologist', '9765432100', 'vikram.joshi@hospital.com'),
('Dr. Priya Sharma', 'Pediatrician', '9345678901', 'priya.sharma@hospital.com'),
('Dr. Sanjay Gupta', 'General Physician', '9012345678', 'sanjay.gupta@hospital.com'),
('Dr. Anita Desai', 'Gynecologist', '9234567890', 'anita.desai@hospital.com'),
('Dr. Rahul Nair', 'Psychiatrist', '9456789012', 'rahul.nair@hospital.com'),
('Dr. Kiran Das', 'ENT Specialist', '9871203456', 'kiran.das@hospital.com'),
('Dr. Ramesh Verma', 'Oncologist', '9123409876', 'ramesh.verma@hospital.com');

select * from doctors;

-- Appointments Table
drop table Appointments;
CREATE TABLE Appointments (
    Appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    Patient_id INT,
    Doctor_id INT,
    Appointment_date DATE,
    Appointment_time TIME,
    Status ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

desc Appointments;
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status)
VALUES
(1, 1, '2025-09-01', '10:00:00', 'Completed'),
(2, 2, '2025-09-02', '11:30:00', 'Completed'),
(3, 3, '2025-09-03', '12:15:00', 'Scheduled'),
(4, 5, '2025-09-04', '09:45:00', 'Completed'),
(5, 6, '2025-09-05', '14:00:00', 'Completed'),
(6, 7, '2025-09-06', '16:20:00', 'Scheduled'),
(7, 8, '2025-09-07', '13:10:00', 'Completed'),
(8, 9, '2025-09-08', '15:30:00', 'Scheduled'),
(9, 3, '2025-09-09', '10:50:00', 'Completed'),
(10, 4, '2025-09-10', '12:40:00', 'Completed');

select * from appointments;

select 
	a.appointment_id,
    p.name as patient_name ,
    d.name as doctor_name ,
	a.appointment_date , 
    a.appointment_time ,
    a.status
from appointments a 
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id;

-- Billing Table
drop table Billing;
CREATE TABLE Billing (
    Bill_id INT AUTO_INCREMENT PRIMARY KEY,
    Appointment_id INT NOT NULL,
    Bill_date DATE NOT NULL,
    Payment_status ENUM('Paid','Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);
desc billing;

INSERT INTO billing (appointment_id, bill_date, payment_status)
VALUES
(1,'2025-09-01', 'Paid'),
(2,'2025-09-02', 'Paid'),
(3,'2025-09-03', 'Unpaid'),
(4,'2025-09-04', 'Paid'),
(5,'2025-09-05', 'Unpaid'),
(6,'2025-09-06', 'Paid'),
(7,'2025-09-07', 'Paid'),
(8,'2025-09-08', 'Unpaid'),
(9,'2025-09-09', 'Paid'),
(10,'2025-09-10', 'Unpaid');

select * from billing;

drop table Billing_items;
create table Billing_items(
	Item_id int auto_increment primary key,
    Bill_id int not null ,
    Service_type ENUM('Consultation','Lab Test','Medicine','Other') not null,
    Description varchar(100),
    Amount decimal(10,3) not null,
    FOREIGN KEY (bill_id) references billing(bill_id)
);
select * from billing_items;

INSERT INTO billing_items (bill_id, service_type, description, amount)
VALUES
(1, 'Consultation', 'Cardiology consultation fee', 500.00),
(1, 'Medicine', 'Blood pressure tablets (10 days)', 300.00),
(1, 'Lab Test', 'ECG Test', 400.00),
(2, 'Consultation', 'Orthopedic consultation fee', 600.00),
(2, 'Lab Test', 'Knee X-Ray', 250.00),
(2, 'Medicine', 'Calcium supplements', 150.00),
(3, 'Consultation', 'Dermatology consultation fee', 700.00),
(3, 'Medicine', 'Skin cream and antibiotics', 500.00),
(3, 'Lab Test', 'Allergy test', 300.00),
(4, 'Consultation', 'Pediatric consultation fee', 400.00),
(4, 'Lab Test', 'Blood test (CBC)', 200.00),
(4, 'Medicine', 'Vitamin syrup', 180.00),
(5, 'Consultation', 'General consultation fee', 350.00),
(5, 'Medicine', 'Fever tablets', 120.00),
(5, 'Lab Test', 'Urine test', 180.00),
(6, 'Consultation', 'Gynecology consultation fee', 500.00),
(6, 'Lab Test', 'Ultrasound scan', 700.00),
(6, 'Medicine', 'Iron supplements', 250.00),
(7, 'Consultation', 'Psychiatry consultation fee', 800.00),
(7, 'Medicine', 'Anti-anxiety tablets (15 days)', 600.00),
(7, 'Other', 'Counseling session', 500.00),
(8, 'Consultation', 'ENT consultation fee', 450.00),
(8, 'Lab Test', 'Hearing test', 350.00),
(8, 'Medicine', 'Ear drops', 200.00),
(9, 'Consultation', 'Dermatology consultation fee', 650.00),
(9, 'Lab Test', 'Skin biopsy', 900.00),
(9, 'Medicine', 'Moisturizing lotion', 250.00),
(10, 'Consultation', 'Neurology consultation fee', 1000.00),
(10, 'Lab Test', 'MRI Scan', 3000.00),
(10, 'Medicine', 'Nerve pain tablets', 500.00);

SELECT 
	b.bill_id,
    p.name AS patient_name,
    d.name AS doctor_name,
    b.bill_date,
    bi.service_type,
    bi.description,
    bi.amount,
    b.payment_status
FROM billing b
JOIN billing_items bi ON b.bill_id = bi.bill_id
JOIN appointments a ON b.appointment_id = a.appointment_id
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
ORDER BY b.bill_id, bi.item_id;