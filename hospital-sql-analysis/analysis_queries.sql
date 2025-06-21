--Section 1: Joins and Basic Aggregation
--1.	List all patients who have had at least one appointment.
SELECT patient_id,
	appointment_id
FROM appointments;

--2.	Show the total number of appointments for each doctor.

SELECT a.doctor_id, 
		COUNT(appointment_id) AS total_appointments,
		d.first_name,
		d.last_name
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY a.doctor_id, d.first_name, d.last_name
ORDER BY a.doctor_id;

--3.	Find patients who visited more than one doctor.
SELECT a.patient_id,
	   COUNT(a.doctor_id)
FROM appointments a
GROUP BY a.patient_id
HAVING COUNT(a.doctor_id) > 1;

--4.	Display the total billing amount for each patient.

SELECT patient_id, 
	   SUM(amount)
FROM billing
GROUP BY patient_id
ORDER BY patient_id;

--5.	List the number of treatments done by each doctor.
SELECT COUNT(t.treatment_id) AS total_treatments,
	   a.doctor_id
FROM treatments t 
JOIN appointments a ON t.appointment_id = a.appointment_id
GROUP BY a.doctor_id
ORDER BY a.doctor_id;

--Section 2: Subqueries & Grouping
--6.	Find the top 5 most common treatment types.
SELECT treatment_type,
	   COUNT(*) AS count
FROM treatments
GROUP BY treatment_type
ORDER BY count DESC
LIMIT 5;
	
--7.	List all patients whose total cost of treatments exceeds $5000.

SELECT patient_id,
       SUM(amount)
FROM billing
GROUP BY patient_id
HAVING SUM(amount) > 5000
ORDER BY patient_id;
	
--8.	Find doctors who have treated more than 10 unique patients.

SELECT doctor_id,
	   COUNT(DISTINCT(patient_id))
FROM appointments
GROUP BY doctor_id
HAVING COUNT(DISTINCT(patient_id)) > 10;

--9.	Find patients who have never been billed.

SELECT p.*
FROM patients p
LEFT JOIN billing b ON p.patient_id = b.patient_id
WHERE b.patient_id IS NULL;

--10.	Get the average cost of treatments grouped by treatment type.

SELECT treatment_type,
	   ROUND(AVG(cost), 2)
FROM treatments 
GROUP BY treatment_type;

--Section 3: Time-Based Queries
--11.	Calculate the number of appointments scheduled each month.
SELECT EXTRACT(MONTH FROM appointment_date) AS month,
	   COUNT(appointment_id)
FROM appointments
GROUP BY month
ORDER BY month;
	  
--12.	Find the doctor with the most appointments in the last 6 months.

-- Suppose latest date is '2023-06-01', then:
SELECT doctor_id,
       COUNT(appointment_id) AS total_appointments
FROM appointments
WHERE appointment_date >= '2023-06-01'
GROUP BY doctor_id
ORDER BY total_appointments DESC
LIMIT 1;

--13.	Identify trends in appointment reasons over time (monthly frequency of each reason).

SELECT reason_for_visit,
	   COUNT(reason_for_visit) AS frequency,
	   EXTRACT (month FROM appointment_date) AS months
FROM appointments
GROUP BY reason_for_visit, months
ORDER BY months;

--14.	Get the total billing amount per month.

SELECT  SUM(amount),
		EXTRACT (month FROM bill_date) AS months
FROM billing
GROUP BY months
ORDER BY months;

--Section 4: Advanced Analysis
--15.	Find the top 3 specializations by revenue generated

SELECT d.specialization,
	   SUM(b.amount) AS total_revenue
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
JOIN billing b ON a.patient_id = b.patient_id
GROUP BY d.specialization
ORDER BY total_revenue DESC
LIMIT 3;

--16.	Identify appointments that were scheduled but never treated (i.e., missing from treatment table).
	
SELECT *
FROM appointments a 
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
WHERE t.appointment_id IS NULL;

--17.	Which hospital branch has the highest average treatment cost?

SELECT d.hospital_branch,
	   ROUND(AVG(t.cost), 2) AS avg_cost
FROM doctors d
JOIN appointments a ON a.doctor_id = d.doctor_id
JOIN treatments t ON a.appointment_id = t.appointment_id 
GROUP BY d.hospital_branch
ORDER BY avg_cost DESC
LIMIT 1;

--18.	Calculate the average treatment cost per doctor.
SELECT d.doctor_id,
	   ROUND(AVG(t.cost), 2) avg_cost
FROM doctors d
JOIN appointments a ON a.doctor_id = d.doctor_id
JOIN treatments t ON a.appointment_id = t.appointment_id 
GROUP BY d.doctor_id
ORDER BY d.doctor_id;

--19.	For each patient, calculate their lifetime value (total spent on treatments).

SELECT patient_id,
	   ROUND(SUM(amount), 2)
FROM billing 
GROUP BY patient_id
ORDER BY patient_id;