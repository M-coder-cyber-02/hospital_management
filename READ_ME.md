## Hospital Management System – SQL Analysis Project

### Project Overview

This SQL project explores a relational hospital management database, simulating real-world healthcare operations. It includes key entities like **patients**, **doctors**, **appointments**, **treatments**, and **billing**. The project demonstrates advanced querying, aggregation, and business intelligence use cases relevant to healthcare systems.

---

###  Database Schema

Five interrelated tables were created:

#### `patients`

| Column               | Type         | Description                        |
| -------------------- | ------------ | ---------------------------------- |
| `patient_id`         | TEXT         | Unique identifier for each patient |
| `first_name`         | VARCHAR(50)  | First name of patient              |
| `last_name`          | VARCHAR(50)  | Last name of patient               |
| `gender`             | VARCHAR(10)  | Gender of patient                  |
| `date_of_birth`      | DATE         | Date of birth                      |
| `contact_number`     | VARCHAR(20)  | Contact number                     |
| `address`            | TEXT         | Home address                       |
| `registration_date`  | DATE         | Registration date in the hospital  |
| `insurance_provider` | VARCHAR(100) | Insurance company                  |
| `insurance_number`   | VARCHAR(50)  | Insurance policy ID                |
| `email`              | VARCHAR(100) | Email address                      |

#### `doctors`

| Column             | Type         | Description               |
| ------------------ | ------------ | ------------------------- |
| `doctor_id`        | TEXT         | Unique ID for each doctor |
| `first_name`       | VARCHAR(50)  | First name                |
| `last_name`        | VARCHAR(50)  | Last name                 |
| `specialization`   | VARCHAR(100) | Medical specialty         |
| `phone_number`     | VARCHAR(20)  | Contact number            |
| `years_experience` | INTEGER      | Total experience          |
| `hospital_branch`  | VARCHAR(100) | Branch they work at       |
| `email`            | VARCHAR(100) | Email address             |

#### `appointments`

| Column             | Type        | Description                       |
| ------------------ | ----------- | --------------------------------- |
| `appointment_id`   | TEXT        | Unique appointment identifier     |
| `patient_id`       | TEXT        | Refers to patient                 |
| `doctor_id`        | TEXT        | Refers to doctor                  |
| `appointment_date` | DATE        | Date of appointment               |
| `appointment_time` | TIME        | Time of appointment               |
| `reason_for_visit` | TEXT        | Reason stated by patient          |
| `status`           | VARCHAR(50) | Status (Scheduled/Completed/etc.) |

#### `treatments`

| Column           | Type         | Description                |
| ---------------- | ------------ | -------------------------- |
| `treatment_id`   | TEXT         | Unique treatment record    |
| `appointment_id` | TEXT         | Associated appointment     |
| `treatment_type` | VARCHAR(100) | Type of treatment provided |
| `description`    | TEXT         | Notes or description       |
| `cost`           | NUMERIC      | Cost of the treatment      |
| `treatment_date` | DATE         | When treatment occurred    |

#### `billing`

| Column           | Type        | Description             |
| ---------------- | ----------- | ----------------------- |
| `bill_id`        | TEXT        | Unique billing ID       |
| `patient_id`     | TEXT        | Refers to the patient   |
| `treatment_id`   | TEXT        | Refers to treatment     |
| `bill_date`      | DATE        | Date of billing         |
| `amount`         | NUMERIC     | Billed amount           |
| `payment_method` | VARCHAR(50) | Payment mode            |
| `payment_status` | VARCHAR(50) | Paid / Pending / Failed |

---

###  Key Insights & Queries

#### Joins and Basic Aggregations

* Patients with at least one appointment
All patients had at least one appointment.
* Total appointments per doctor
Among the 10 doctors, Dr. Sarah Taylor (D005) had the highest number of appointments. 
* Patients visiting multiple doctors
48 patients consulted more than one doctor, suggesting referrals or multi-specialty care.
* Total billing per patient
Out of 50 patients, Patient P012 had the highest cumulative billing amount: $30,053.08.
* Treatments performed per doctor
Dr. Sarah Taylor (D005) also performed the most treatments — 29 in total.

#### 📌 Subqueries & Grouped Metrics

* Top 5 treatment types
1. Chemotherapy
2. X-Ray
3. ECG
4. MRI
5. Physiotherapy
* Patients whose total cost > \$5000
A total of 44 patients had spent >$5000 on treatments.
* Doctors treating >10 unique patients
All 10 doctors treated multiple patients.
* Patients never billed
Two patients were not billed.
* Average cost by treatment type
1. ECG	           $2532.22
2. MRI             $3224.95
3. X-Ray           $2698.87
4. Physiotherapy   $2761.61
5. Chemotherapy    $2629.71

#### 📌 Time-Based Insights

* Appointments per month
Appointments were seen throught 12 months with maximum of 25 in April

* Doctor with most appointments in recent months
Dr. Sarah Taylor D005 with 18 appointments in the last 6 months. 

* Trends in appointment reasons over time
Most common appointment reasons overall:
Checkup and Follow-up appointments are consistently the most frequent across months.
Therapy is also regularly scheduled, peaking in months 4 and 5.
Emergency visits vary month-to-month but remain present throughout the year.
Monthly observations:
Month 4 (April) saw the highest number of Follow-up visits (9).
Month 11 (November) had a spike in Checkups (6) and Therapy (4).
Month 6 (June) saw increased Consultations (6).
Month 5 (May) had one of the highest combined totals across all categories.

* Billing totals by month
Monthly bills range from 27,569 to 64,271 with the highest total in April. 

#### 📌 Advanced Analysis

* Top 3 revenue-generating specializations
1. Pediatrics	$1289294.61
2. Dermatology	$965566.84
3. Oncology  	$493428.71

* Appointments scheduled but never treated
None of the appointments were missed!

* Hospital branch with highest avg. treatment cost
Westside Clinic with $2966.28
* Average treatment cost per doctor
Highest is for D008 with $3339.21
* Patient lifetime treatment spend
P012 has the highest lifetime treatment spend of $30053.08
---

### 📊 Sample Query Output

```sql
-- Doctors by appointment count
SELECT doctor_id, COUNT(appointment_id) AS total
FROM appointments
GROUP BY doctor_id;
```

```sql
-- Top 5 treatment types
SELECT treatment_type, COUNT(*)
FROM treatments
GROUP BY treatment_type
ORDER BY COUNT(*) DESC
LIMIT 5;
```

---

### 💡 Tools Used

* **PostgreSQL** (PGAdmin4)
* **Kaggle Hospital Management Dataset**
* Relational schema creation, indexing, and joins
* SQL subqueries, aggregation, window functions

---

### 👩‍💻 Author

**Mahwish Malik**
Master’s Student – Health Informatics
Skilled in data analysis, clinical data workflows, SQL, and healthcare system design.

---

