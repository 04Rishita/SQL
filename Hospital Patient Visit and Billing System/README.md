# 🏥 Hospital Patient Visit & Billing Analytics

An Exploratory Data Analysis (EDA) project on hospital admissions, patient visits, department billing metrics, and length of stay (LOS). This project evaluates department-wise revenue, insurance coverage ratios, and patient stay durations to support healthcare resource allocation and operational efficiency.

---

## 📌 Project Overview
This project analyzes healthcare billing and patient admission records. It involves:

- Multi-table database joins across patient records, visit logs, and billing statements
- Departmental revenue evaluation (*Cardiology*, *Orthopedics*, *Emergency*, *ICU*)
- Patient Length of Stay (LOS) calculations
- Insurance claim coverage vs. out-of-pocket billing analysis

---

## 🎯 Objectives
- Calculate average patient billing amounts across hospital departments
- Determine average Length of Stay (LOS) per department
- Evaluate insurance claim approval rates versus self-pay transactions
- Identify resource bottlenecks in high-occupancy hospital wards
- Provide data-driven operational recommendations for hospital administration

---

## 📁 Dataset & Files Included

### Dataset Columns Analyzed:
- **Patient Metrics**: Patient ID, Age, Gender, Admission Date, Discharge Date
- **Clinical Metrics**: Department (*Cardiology*, *Orthopedics*, *Emergency*, etc.), Diagnosis
- **Billing Details**: Total Bill Amount ($), Insurance Coverage Amount ($), Out-of-Pocket Payment ($)

---

## 🛠️ Tools & Technologies
- **Data Engine**: Relational Database System (SQL / PostgreSQL / MySQL)
- **Analysis Environment**: Healthcare Database Workbench

---

## 🔍 Key Analysis Topics Covered

### 1. 🏥 Departmental Billing & Revenue
- Evaluating net billing totals and average bill sizes across medical departments.

### 2. ⏱️ Length of Stay (LOS) Analysis
- Calculating the average duration between admission and discharge dates across wards.

### 3. 💳 Insurance vs. Self-Pay Ratio
- Measuring insurance coverage proportions to identify out-of-pocket financial burdens on patients.

---

## 📊 Summary Output Metrics

| Department / Metric | Summary Finding |
| :--- | :--- |
| **Highest Revenue Department** | **Cardiology** generates the highest average bill per patient visit |
| **Longest Average Stay** | **Intensive Care Unit (ICU)** averages **6.4 days** per admission |
| **Insurance Coverage Share** | Insurance covers **~72% of total hospital billing costs** on average |

---

## 📌 Key Insights
- **Specialized Care Drives Revenue**: Specialized departments like Cardiology and Orthopedics generate the highest revenue per patient.
- **Length of Stay Correlation**: Wards with longer stay durations (ICU, Surgery) account for the highest total billing figures.
- **Emergency Room High Throughput**: Emergency visits feature short stays but high patient volume.

---

## 🎓 Key Learnings
Through this project, I gained practical experience in:
- **Healthcare Data Analytics**: Evaluating clinical operations, billing structures, and length of stay metrics.
- **Date & Duration Calculations**: Computing stay durations from admission and discharge dates.
- **Multi-Table Relational Schema Design**: Linking patient demographics, medical departments, and financial claims.

---

## ✅ Recommendations
- **Optimize Bed Capacity**: Reallocate bed space to high-demand departments like Cardiology to reduce admission wait times.
- **Streamline Discharge Protocols**: Implement standardized discharge procedures to decrease non-clinical LOS delays.
- **Pre-Authorize Insurance Claims**: Establish automated pre-authorization with insurers to speed up billing settlements.

---

👤 **Author**: Rishita Choksi  
