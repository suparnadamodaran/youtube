# DATABASE CREATION

create DATABASE healthcare;

use healthcare;

# CREATING TABLES
   # Patients
   # Doctors
   # Diagnoses
   # Appointments
   # Medications
   
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialty VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    clinic_address TEXT
);

CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis_date DATE,
    diagnosis_description TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Appointments(
appointment_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
appointment_date DATETIME,
reason TEXT,
status VARCHAR(20),
FOREIGN KEY(patient_id)REFERENCES Patients(patient_id),
FOREIGN KEY(doctor_id)REFERENCES Doctors(doctor_id)
);

CREATE TABLE Medications (
    medication_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    medication_name VARCHAR(100),
    dosage VARCHAR(50),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

SHOW VARIABLES LIKE 'secure_file_priv';


# Import CSV data into MySQL Tables

# Import patients.csv into Patients Table

LOAD DATA INFILE  'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/patients.csv' 
INTO TABLE Patients  
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;  -- Ignores header row

#  Import doctors.csv into Doctors Table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/doctors.csv'  
INTO TABLE Doctors  
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;

#Import diagnoses.csv into Diagnoses Table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/diagnoses.csv'  
INTO TABLE Diagnoses  
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;

#  Import appointments.csv into Appointments Table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/appointments.csv'  
INTO TABLE Appointments  
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;

# Import medications.csv into Medications Table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/medications.csv'  
INTO TABLE Medications  
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;



