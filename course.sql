use bookstore;
 
 
 -- courses table
 create table courses (course_id int,
title	varchar(100),
category	varchar(100),
language	varchar(10),
subtitles	varchar(10),
price	int,
instructor_id	int,
length	time,
difficulty_level	varchar(50),
created_on	date,
last_updated_on	date,
number_of_videos	int,
number_of_quizzes	int,
view_count	int,
average_watch_duration	time,
certification_available	varchar(10),
completion_rate	decimal(5,2),
bookmark_count	int);





LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\courses.csv'
INTO TABLE courses
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(course_id, title, category, language, subtitles, price, instructor_id, length, difficulty_level, @created_on, @last_updated_on, number_of_videos, number_of_quizzes, view_count, average_watch_duration, certification_available, completion_rate, bookmark_count)
SET
created_on = STR_TO_DATE(@created_on, '%d-%m-%Y'),
last_updated_on = STR_TO_DATE(@last_updated_on, '%d-%m-%Y');

-- users table
create table users (
user_id	int,
name	varchar(100),
date_of_birth	date,
email	varchar(100),
gender	varchar(10),
category	varchar(50),
registration_date	date,
country	varchar(50),
last_login_date	date,
user_type	varchar(50));

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(user_id,name,@date_of_birth,email	,gender,	category,@registration_date,	country	,@last_login_date,	user_type)
set
date_of_birth = STR_TO_DATE(@date_of_birth, '%d-%m-%Y'),
registration_date = STR_TO_DATE(@registration_date, '%d-%m-%Y'),
last_login_date = STR_TO_DATE(@last_login_date, '%d-%m-%Y');


-- enrollments table
create table enrollments (
enrollment_id	int,
student_id	int,
course_id	int,
enrollment_date	date);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\enrollments.csv'
INTO TABLE enrollments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(enrollment_id,student_id,course_id,@enrollment_date)
set
enrollment_date = STR_TO_DATE(@enrollment_date, '%d-%m-%Y');

-- ratings table

create table ratings(review_id	int,
course_id	int,
student_id	int,
rating	int,
review_text	varchar(200) null,
first_reviewed_on	date,
last_updated_on	date,
helpful_count	int,
reported_count	int);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(review_id,	course_id, student_id, rating, @review_text, @first_reviewed_on, @last_updated_on,	helpful_count, reported_count)
set
review_text = nullif(@review_text,''),
first_reviewed_on = str_to_date(@first_reviewed_on, '%d-%m-%Y'),
last_updated_on = str_to_date(@last_updated_on,'%d-%m-%Y');


-- payments table
create table payments(payment_id	int,
enrollment_id	int,
discount_percent	int,
amount_paid	decimal(5,2),
coupon_code	varchar(20) null,
payment_method	varchar(10),
transaction_date	date,
transaction_id	varchar(100),
payment_status	varchar(10));


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(payment_id, enrollment_id, discount_percent, amount_paid, @coupon_code,	payment_method,	@transaction_date,	transaction_id,	payment_status			
)
set
coupon_code = nullif(@coupon_code,''),
transaction_date = str_to_date(@transaction_date, '%d-%m-%Y');


-- refunds table
create table refunds(
refund_id	int,
enrollment_id	int,
refund_date	date,
refund_reason	varchar(100) null,
refund_amount	int);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\refunds.csv'
INTO TABLE refunds
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(refund_id,	enrollment_id,	@refund_date,	@refund_reason,	refund_amount)
set
refund_date = str_to_date(@refund_date, '%d-%m-%Y'),
refund_reason = nullif(@refund_reason,'');



