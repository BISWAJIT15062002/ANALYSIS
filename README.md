ANALYSIS OF BUSINESS DATA USING MY SQL
	There is Multiple Data sets of a Technical Institute ,which provided different types of courses.
	The Data sets are basically in CSV format, also there are multiple ‘NULL’  values.
	Project Overview
•	This project focuses on performing **Exploratory Data Analysis (EDA)** using **SQL** on a dataset from a *Coding Institute*.  
•	The dataset contains information about **Users, Courses, Enrollments, Payments, Refunds, and Ratings**.  
•	The goal of this analysis was to understand **student behavior**, **course performance**, and **revenue patterns** through efficient SQL queries.
	The Files are
 	"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\courses.csv"
 	"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\enrollments.csv"
 	"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\payments.csv"
 	"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ratings.csv"
 	"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\refunds.csv"
 	"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\users.csv"
	Dataset Description
•	| **Users** | Information about students and instructors (user_id, name, email, country, registration_date, user_type) |
•	| **Courses** | Details of each course (course_id, title, category, instructor_id, price) |
•	| **Enrollments** | Links users to the courses they enrolled in (enrollment_id, student_id, course_id, enrollment_date) |
•	| **Payments** | Payment transactions for courses (payment_id, student_id, amount, payment_date, status) |
•	| **Refunds** | Refund details (refund_id, payment_id, refund_date, refund_amount, reason) |
•	| **Ratings** | Ratings and reviews for courses (review_id, course_id, student_id, rating, review_text, date) |
	To Perform EDA (Exploratory Data Analysis) in these data sets we have to follows different steps, let’s discuss one by one 

	ELT(Extraction Load Transformation)
•	1st we extract the Data sets from Kaggle , then load these data sets one by one in my SQL server, after loading data then Transform the values into required format.
•	To load the data we have to create multiple tables according to data files, change the data types.
•	Make all the column Nullable so that if there is any null values in the data sets that can easily inserted .
•	Then in Transformation steps  Remove the Null values, Blank Rows, Duplicate Rows, Change the Date data Type.
	EDA(Exploratory Data Analysis)
•	Calculate KPI Cards : Total Revenue, Total Users, Average Ratings of courses, etc.
•	Calculate Monthly, Yearly Trends.
•	Calculate Total Students by course wise category, Measure Refund Reasons, etc.
	Concept Used
Select Clause, Group By clause, Agg Functions, Window Functions, Joins, Subquery, Stored Procedure etc.
 
                                                           🧑‍💻 Author

                                                         **Biswajit Das**  
                                                      Data Analyst Enthusiast  
                                                 📧 dasbiswajitdas2020@gmail.com  

