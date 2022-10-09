

USE accidents;

/* -------------------------------- */
/* Create Tables */
CREATE TABLE (
	accident_index VARCHAR(13),
    accident_severity INTaccident
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);

/* First: for vehicle types, create new csv by extracting data from Vehicle Type sheet from Road-Accident-Safety-Data-Guide.xls */
CREATE TABLE vehicle_types1(
	vehicle_code INT,
    vehicle_type VARCHAR(100)
);

/* -------------------------------- */
/* Load Data */
LOAD DATA  INFILE 'D:\Accidents_2015.csv'
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;


LOAD DATA  INFILE 'D:Vehicles_2015.csv'
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;


LOAD DATA  INFILE 'D:\vehicle_types.csv'
INTO TABLE vehicle_types1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE accidents_median(
vehicle_types VARCHAR(100),
severity INT
);
create index accident_index
on accident(accident_index);

create index accident_index
on vehicles(accident_index);
select * from accident;
select * from vehicles;
select * from vehicle_types1;
/* get Accident Severity and Total Accidents per Vehicle Type */
SELECT vt.vehicle_type AS 'Vehicle Type', a.accident_severity AS 'Severity', COUNT(a.accident_index) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types1 vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1
ORDER BY 2,3;

/* Average Severity by vehicle type */
SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types1 vt ON v.vehicle_type = vt.vehicle_code
GROUP BY 1
ORDER BY 2,3;


/* Average Severity and Total Accidents by Motorcyle */
SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types1 vt ON v.vehicle_type = vt.vehicle_code
WHERE vt.vehicle_type LIKE '%otorcycle%'
GROUP BY 1
ORDER BY 2,3;


