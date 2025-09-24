-- Create the database
CREATE DATABASE ClinicBookingSystem;
USE ClinicBookingSystem;

-- Table: Patients
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Address TEXT
);

-- Table: Doctors
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE
);

-- Table: Appointments
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Table: Treatments
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    TreatmentName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Table: Appointment_Treatments (Many-to-Many)
CREATE TABLE Appointment_Treatments (
    AppointmentID INT NOT NULL,
    TreatmentID INT NOT NULL,
    PRIMARY KEY (AppointmentID, TreatmentID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);

-- Table: Prescriptions (One-to-One with Appointment)
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,
    Medication TEXT NOT NULL,
    Dosage VARCHAR(100),
    Instructions TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Insert Patients
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, Address)
VALUES 
('Alice', 'Mwangi', '1990-05-12', 'Female', '0712345678', 'alice@example.com', 'Nairobi'),
('Brian', 'Otieno', '1985-11-23', 'Male', '0723456789', 'brian@example.com', 'Kisumu');

-- Insert Doctors
INSERT INTO Doctors (FirstName, LastName, Specialty, PhoneNumber, Email)
VALUES 
('Dr. Jane', 'Kamau', 'Cardiology', '0734567890', 'jane.kamau@clinic.com'),
('Dr. David', 'Mutua', 'Dermatology', '0745678901', 'david.mutua@clinic.com');

-- Insert Treatments
INSERT INTO Treatments (TreatmentName, Description)
VALUES 
('ECG Scan', 'Electrocardiogram for heart monitoring'),
('Skin Biopsy', 'Sample collection for skin analysis');

-- Insert Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status, Notes)
VALUES 
(1, 1, '2025-09-25 10:00:00', 'Scheduled', 'Routine heart checkup'),
(2, 2, '2025-09-26 14:30:00', 'Scheduled', 'Skin rash evaluation');

-- Link Treatments to Appointments
INSERT INTO Appointment_Treatments (AppointmentID, TreatmentID)
VALUES 
(1, 1),
(2, 2);

-- Insert Prescriptions
INSERT INTO Prescriptions (AppointmentID, Medication, Dosage, Instructions)
VALUES 
(1, 'Atenolol', '50mg daily', 'Take after breakfast'),
(2, 'Hydrocortisone cream', 'Apply twice daily', 'Use on affected area only');
