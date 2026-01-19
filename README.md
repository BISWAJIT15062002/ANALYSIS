# Analysis of Business Data using MySQL

## 📌 Project Overview
This project focuses on performing **Exploratory Data Analysis (EDA)** using **MySQL** on multiple business datasets from a **Technical / Coding Institute** that offers various professional courses.

The datasets were provided in **CSV format** and contained multiple **NULL values, duplicate records, and inconsistent data types**. The project demonstrates a complete **ELT (Extract, Load, Transform)** workflow followed by analytical SQL queries to understand **student behavior, course performance, and revenue patterns**.

This project reflects **real-world SQL and data analysis scenarios** commonly handled by data analysts and consulting professionals.

---

## 🎯 Business Objective
The objectives of this project are to:
- Clean and transform raw CSV datasets using MySQL
- Analyze course enrollments and student behavior
- Identify revenue and refund trends
- Evaluate course ratings and engagement
- Generate actionable business insights using SQL

---

## 🛠️ Tech Stack
- **Database:** MySQL Server 8.0
- **Data Format:** CSV
- **Tools:** MySQL Workbench
- **Concepts:** SQL, ELT, EDA
- **Version Control:** GitHub

---

## 📂 Data Sources
The following CSV files were loaded into MySQL:
C:\ProgramData\MySQL\MySQL Server 8.0\Uploads
- ├── courses.csv
- ├── enrollments.csv
- ├── payments.csv
- ├── ratings.csv
- ├── refunds.csv
- └── users.csv

---

## 🗄️ Dataset Description
| Table Name | Description |
|-----------|------------|
| **Users** | Student and instructor details (user_id, name, email, country, registration_date, user_type) |
| **Courses** | Course details (course_id, title, category, instructor_id, price) |
| **Enrollments** | Student–course enrollment records (enrollment_id, student_id, course_id, enrollment_date) |
| **Payments** | Payment transaction details (payment_id, student_id, amount, payment_date, status) |
| **Refunds** | Refund information (refund_id, payment_id, refund_date, refund_amount, reason) |
| **Ratings** | Course ratings and reviews (review_id, course_id, student_id, rating, review_text, date) |

---

## 🔄 ELT Process (Extract, Load, Transform)

### 1️⃣ Extraction
- Datasets were sourced from **Kaggle** in CSV format

### 2️⃣ Load
- Created separate tables for each dataset in MySQL
- Defined appropriate data types for each column
- All columns were kept **NULLABLE** to allow seamless data loading
- Imported data using `LOAD DATA INFILE`

### 3️⃣ Transformation
- Removed NULL values and blank rows
- Eliminated duplicate records
- Standardized date formats
- Cleaned inconsistent data values

---

## 📊 Exploratory Data Analysis (EDA)

### 🔹 KPI Metrics
- Total Revenue
- Total Users
- Total Enrollments
- Average Course Ratings

### 🔹 Trend Analysis
- Monthly revenue trends
- Yearly enrollment growth
- Course demand over time

### 🔹 Business Insights
- Students by course category
- Course-wise revenue contribution
- Refund analysis by reason
- High-performing and low-performing courses

---

## 🧠 SQL Concepts Used
- SELECT, WHERE, HAVING
- GROUP BY
- Aggregate Functions (SUM, COUNT, AVG)
- Window Functions
- Joins (INNER, LEFT)
- Subqueries
- Stored Procedures

---

## 💡 Key Learnings
- Handling real-world messy datasets using SQL
- Implementing ELT workflows in MySQL
- Writing optimized analytical queries
- Translating raw data into meaningful insights

---

## 🚀 Future Enhancements
- Advanced stored procedures and functions
- Indexing and performance tuning
- Automated EDA reports
- Power BI / Tableau integration
- Migration to Oracle PL/SQL

---

## 🧑‍💻 Author
**Biswajit Das**  
Data Analyst Enthusiast  
📧 dasbiswajitdas2020@gmail.com

---

⭐ *If you find this project useful, feel free to star the repository!*


                                                      

