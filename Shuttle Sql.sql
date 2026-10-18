DROP DATABASE shuttle_tracker1;
CREATE DATABASE shuttle_tracker1;
USE shuttle_tracker1;

CREATE TABLE IF NOT EXISTS Driver (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS Bus (
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_number VARCHAR(10),
    capacity INT,
    driver_id INT,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE IF NOT EXISTS Route (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    source VARCHAR(50),
    destination VARCHAR(50)
);

CREATE TABLE Stops (
    stop_id INT PRIMARY KEY AUTO_INCREMENT,
    stop_name VARCHAR(50),
    route_id INT,
    FOREIGN KEY (route_id) REFERENCES Route(route_id)
);

CREATE TABLE IF NOT EXISTS Bus_Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT,
    latitude DOUBLE,
    longitude DOUBLE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id)
);

CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT,
    route_id INT,
    arrival_time TIME,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    FOREIGN KEY (route_id) REFERENCES Route(route_id)
);

CREATE TABLE IF NOT EXISTS Delay_Data (
    delay_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT,
    expected_time TIME,
    actual_time TIME,
    delay_minutes INT,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id)
);

CREATE TABLE IF NOT EXISTS Trip (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT,
    route_id INT,
    driver_id INT,
    departure_time TIME,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    FOREIGN KEY (route_id) REFERENCES Route(route_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

INSERT INTO Bus (bus_number, capacity) VALUES
('B1', 40),
('B2', 35),
('B3', 50),
('B4', 45),
('B5', 60),
('B6', 30),
('B7', 55),
('B8', 40),
('B9', 35),
('B10', 50);

INSERT INTO Driver (name, phone) VALUES
('Raj', '9876543210'),
('Amit', '9123456780'),
('Ravi', '9000000001'),
('Suresh', '9000000002'),
('Kiran', '9000000003'),
('Anil', '9000000004'),
('Vikas', '9000000005'),
('Manoj', '9000000006'),
('Deepak', '9000000007'),
('Arjun', '9000000008');

INSERT INTO Route (source, destination) VALUES
('Gate', 'Hostel'),
('Library', 'Cafeteria'),
('Admin Block', 'Auditorium'),
('Parking', 'Sports Complex'),
('Hostel', 'Main Gate'),
('Lab', 'Library'),
('Cafeteria', 'Hostel'),
('Auditorium', 'Gate'),
('Sports Complex', 'Parking'),
('Main Gate', 'Admin Block');

INSERT INTO Schedule (bus_id, route_id, arrival_time) VALUES
(1,1,'10:00:00'),
(2,2,'10:15:00'),
(3,3,'10:30:00'),
(4,4,'10:45:00'),
(5,5,'11:00:00'),
(6,6,'11:15:00'),
(7,7,'11:30:00'),
(8,8,'11:45:00'),
(9,9,'12:00:00'),
(10,10,'12:15:00');

INSERT INTO Stops (stop_name, route_id) VALUES
('Gate Stop', 1),
('Hostel Stop', 1),
('Library Stop', 2),
('Cafeteria Stop', 2),
('Admin Stop', 3),
('Auditorium Stop', 3),
('Parking Stop', 4),
('Sports Stop', 4),
('Main Gate Stop', 5),
('Lab Stop', 6);

INSERT INTO Bus_Location (bus_id, latitude, longitude) VALUES
(1, 28.7041, 77.1025),
(2, 28.5355, 77.3910),
(3, 28.6000, 77.2000),
(4, 28.6100, 77.2100),
(5, 28.6200, 77.2200),
(6, 28.6300, 77.2300),
(7, 28.6400, 77.2400),
(8, 28.6500, 77.2500),
(9, 28.6600, 77.2600),
(10, 28.6700, 77.2700);

INSERT INTO Trip (bus_id, route_id, driver_id, departure_time) VALUES
(1, 1, 1, '08:00:00'),
(2, 2, 2, '09:00:00'),
(3, 3, 3, '09:30:00'),
(4, 4, 4, '10:00:00'),
(5, 5, 5, '10:30:00'),
(6, 6, 6, '11:00:00'),
(7, 7, 7, '11:30:00'),
(8, 8, 8, '12:00:00'),
(9, 9, 9, '12:30:00'),
(10, 10, 10, '13:00:00');

INSERT INTO Delay_Data (bus_id, expected_time, actual_time, delay_minutes) VALUES
(1, '08:00:00', '08:10:00', 10),
(1, '08:00:00', '08:15:00', 15),
(2, '09:00:00', '09:05:00', 5),
(2, '09:00:00', '09:08:00', 8),
(3, '09:30:00', '09:40:00', 10),
(3, '09:30:00', '09:45:00', 15),
(4, '10:00:00', '10:20:00', 20),
(5, '10:30:00', '10:40:00', 10),
(6, '11:00:00', '11:15:00', 15),
(7, '11:30:00', '11:50:00', 20),
(8, '12:00:00', '12:10:00', 10),
(9, '12:30:00', '12:40:00', 10),
(10, '13:00:00', '13:25:00', 25);

SELECT b.bus_number, d.name AS driver_name
FROM Bus b
JOIN Driver d ON b.driver_id = d.driver_id;

SELECT b.bus_number, r.source, r.destination, t.departure_time
FROM Trip t
JOIN Bus b ON t.bus_id = b.bus_id
JOIN Route r ON t.route_id = r.route_id;

SELECT b.bus_number, d.delay_minutes
FROM Bus b
JOIN Delay_Data d ON b.bus_id = d.bus_id;

SELECT AVG(delay_minutes) AS avg_delay
FROM Delay_Data;

SELECT MAX(delay_minutes) AS max_delay
FROM Delay_Data;

SELECT r.source, r.destination, s.stop_name
FROM Stops s
JOIN Route r ON s.route_id = r.route_id;

SELECT b.bus_number, s.arrival_time
FROM Schedule s
JOIN Bus b ON s.bus_id = b.bus_id;

ALTER TABLE Bus
ADD UNIQUE (bus_number);

SELECT * FROM Bus;
SELECT * FROM Driver;
SELECT * FROM Route;
SELECT * FROM Schedule;
SELECT * FROM Stops;
SELECT * FROM Bus_Location;
SELECT * FROM Trip;
SELECT * FROM Delay_Data;