SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY patient_id, appointment_date
               ORDER BY patient_id DESC
           ) AS rn
    FROM staging_appointments
)t; -- Calculating the number of Patients in one day those who are waiting for check-up. 

SELECT *,
       CASE 
           WHEN status = 'cancelled' THEN 'INACTIVE'
           ELSE 'ACTIVE'
       END AS appointment_flag
FROM staging_appointments;--  Checking the status of the appointment whether it is completed or not


SELECT *
FROM staging_appointments 
WHERE patient_id < (
    SELECT MAX(appointment_date) FROM appointment
); -- Calculating the number of Patients in one day for appointment for tracking and monitoring. 

SELECT doctor_id, COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id
ORDER BY total_appointments DESC; --  To check the doctor's performance by tracing number of patients appointment in one day. 


SELECT patient_id,
       COUNT(*) AS visit_count
FROM appointments
GROUP BY patient_id; --  To calculate the total count of the patients.  


SELECT *,
       RANK() OVER (ORDER BY total_appointments DESC) AS rnk
FROM (
    SELECT doctor_id, COUNT(*) total_appointments
    FROM appointments
    GROUP BY doctor_id)t;
    SELECT COUNT(*) FROM staging_appointments; --  To calculate the rank of the doctor according to the doctor's performance by the number of patients who registered for the appointment 
    
    
SELECT COUNT(*) FROM appointment;
SELECT *
FROM staging_appointments s
LEFT JOIN appointment t
ON s.patient_id = t.patient_id
WHERE t.patient_id IS NULL; --  Combining the patients with the appointment in the staging process  


DELIMITER $$
drop procedure if exists run_hims;
CREATE PROCEDURE run_hims()
BEGIN

   
    DELETE FROM staging_appointments
    WHERE patient_id IS NULL
       OR doctor_id IS NULL
       OR appointment_date IS NULL;
       select* from staging_appointments;
       desc staging_appointments; -- Cleaning the data of doctors, patients and appointments which is null , empty or else missing. 

    
    DELETE FROM staging_appointments
    WHERE (patient_id, appointment_date) IN (
        SELECT patient_id, appointment_date
        FROM (
            SELECT patient_id, appointment_date,
                   ROW_NUMBER() OVER (
                       PARTITION BY patient_id, appointment_date
                       ORDER BY patient_id DESC
                   ) AS rn
            FROM staging_appointments
        ) t
        WHERE rn > 1
    ); -- Cleaning the data of doctors, patients and appointments which is null , empty or else missing. 

   
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
    SELECT s.patient_id, s.doctor_id, s.appointment_date, s.status
    FROM staging_appointments s
    LEFT JOIN appointments t
    ON s.patient_id = t.patient_id
    AND s.appointment_date = t.appointment_date
    WHERE t.patient_id IS NULL; -- Cleaning the data of doctors, patients and appointments which is null , empty or else missing.
    END $$

DELIMITER ;
 
delete
FROM appointments
WHERE patient_id IS NULL 
   OR doctor_id IS NULL;
   
   SELECT 
    a.appointment_id,
    a.appointment_date,
   p.name,
    d.name,
    d.specialization
   
FROM appointment a
LEFT JOIN patients p ON a.patient_id = p.patient_id
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN billing b ON a.patient_id = b.patient_id;--  Combining all the data like doctor,patient,appointment and specialization of doctors.


update doctors
set doctor_id=203
where doctor_id is null;
desc doctors;
select* from patients;
delete from patients 
where contact is null; -- Updating the values in the missing or null values to prevent from the data duplication and proceed with the data cleaning.



SELECT 
   
    SUM(amount) AS total_revenue
FROM billing 
GROUP BY amount
ORDER BY total_revenue DESC; -- To calculate the revenue of the salary (Total) in the hospital. 






SELECT 
COUNT(*) AS total_appointments,
    COUNT(DISTINCT patient_id) AS total_patients,
    COUNT(DISTINCT doctor_id) AS total_doctors,
    appointment_date,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY appointment_date
ORDER BY appointment_date;


update doctors
set doctor_id=206 where doctor_id is null; -- To remove the null values.
select * from
(
SELECT doctor_id,
    patient_id,
    COUNT(*) AS visit_count,count(*) as total_appointment
FROM appointment
GROUP BY patient_id,doctor_id
ORDER BY visit_count,total_appointment DESC)as t;
select*from doctors; -- To combine all the doctor,patient and appointment details. 


SELECT 
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_bill_amount,
    MAX(amount) AS highest_bill,
    MIN(amount) AS lowest_bill
FROM billing; -- To filterize the lowest to highest revenue in the hospital management. 

