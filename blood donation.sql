CREATE DATABASE BloodDonationDB;
USE BloodDonationDB;

CREATE TABLE donors (
    donor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    contact_number VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE donations (
    donation_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT,
    donation_date DATE,
    quantity_ml INT,
    FOREIGN KEY (donor_id) REFERENCES donors(donor_id)
);

CREATE TABLE hospitals (
    hospital_id INT PRIMARY KEY AUTO_INCREMENT,
    hospital_name VARCHAR(100),
    location VARCHAR(100),
    contact_number VARCHAR(15)
);

CREATE TABLE requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    hospital_id INT,
    blood_group VARCHAR(5),
    required_units_ml INT,
    request_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
);

INSERT INTO donors (name, age, gender, blood_group, contact_number, address) VALUES
('Alice', 25, 'Female', 'A+', '9876543210', 'Chennai'),
('Bob', 30, 'Male', 'B+', '9876543211', 'Coimbatore'),
('Charlie', 28, 'Male', 'O-', '9876543212', 'Madurai'),
('Diana', 22, 'Female', 'AB+', '9876543213', 'Trichy');

INSERT INTO donations (donor_id, donation_date, quantity_ml) VALUES
(1, '2025-05-01', 450),
(2, '2025-05-10', 500),
(3, '2025-06-01', 400),
(4, '2025-06-05', 450);

INSERT INTO hospitals (hospital_name, location, contact_number) VALUES
('Apollo Hospital', 'Chennai', '0441234567'),
('KMC Hospital', 'Madurai', '0452234567');

INSERT INTO requests (hospital_id, blood_group, required_units_ml, request_date, status) VALUES
(1, 'A+', 900, '2025-06-10', 'Pending'),
(2, 'O-', 450, '2025-06-15', 'Fulfilled');

SELECT * FROM donors;
SELECT d.name, dn.donation_date, dn.quantity_ml
FROM donors d
JOIN donations dn ON d.donor_id = dn.donor_id;

SELECT d.blood_group, SUM(dn.quantity_ml) AS total_donated
FROM donors d
JOIN donations dn ON d.donor_id = dn.donor_id
GROUP BY d.blood_group;

SELECT r.request_id, h.hospital_name, r.blood_group, r.required_units_ml, r.status
FROM requests r
JOIN hospitals h ON r.hospital_id = h.hospital_id;

SELECT * FROM requests WHERE status = 'Pending';
