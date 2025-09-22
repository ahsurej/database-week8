-- creating the database
CREATE DATABASE clinicBooking;
USE  clinicBooking;
-- creating patient tables
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    address TEXT,
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- creating doctor table 
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    availability_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- creating appointments table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled', 'no-show') NOT NULL DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE RESTRICT,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE RESTRICT,
    UNIQUE KEY unique_booking (doctor_id, appointment_date, appointment_time)
);

   -- inserting data to the tables
INSERT INTO patients (first_name, last_name, email, phone) 
VALUES ('John', 'Doe', 'john@gmail.com', '0975834637'),
('Alice', 'Smith', 'alice.smith@gmail.com', '0987654321');

INSERT INTO doctors (first_name,last_name,specialty,email,phone) 
VALUES ('Helen','Dadu','paedetrician','helendadu@gmail.com', '0729463426');

    INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time)
VALUES (1, 1, '2023-10-15', '10:30:00');
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES (1, 1, '2023-10-16', '14:00:00', 'completed', 'Follow-up visit for check-up.');

-- outputing the data
SELECT * FROM appointments ;
SELECT 
    a.appointment_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialty,
    a.appointment_date,
    a.appointment_time,
    a.status,
    a.notes
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
ORDER BY a.appointment_date, a.appointment_time;
