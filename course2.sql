use bookstore;

-- . How many courses are free and how many courses have a price associated with them?**
alter table courses
add column course_type varchar(10);

SET SQL_SAFE_UPDATES = 0;

update courses
set course_type = 'Paid' where price > 0;

select course_type,count(*) from courses group by course_type;

-- . How many courses is each instructor teaching on the platform?**
select instructor_id,count(*) from 
courses  
group by instructor_id;

-- . Which courses are the most popular based on the number of bookmarks?**
select title,bookmark_count from courses order by bookmark_count desc limit 5;

-- . How many users are registered in each user category (e.g., Working, Student, Homemaker, Retired)?**
select a.category,count(b.student_id) from users a right join enrollments b on a.user_id = b.student_id group by a.category;


-- **. What is the male-to-female ratio among the users?**
select (select count(*) from users where gender = 'male')/(select count(*) from users where gender = 'female') as gender_ratio;

-- **. Which courses have the worst completion rates?**
select title from courses order by completion_rate limit 1;

-- **. What is the most common rating given by students?**
select rating from (select rating,count(*) from ratings group by rating order by count(*) desc limit 1) as t;

-- **. How many unique users are enrolled in at least one course?**
select count(distinct(student_id)) from enrollments;


-- **. How many users are enrolled in multiple courses?**
select count(student_id) from (select student_id,count(*) as course_count from enrollments group by student_id)as t where course_count > 1;


-- **. Which 5 courses have the most enrollments?**
select a.title from courses a 
join 
(select course_id,count(*) as purchase_count from enrollments group by course_id order by purchase_count desc limit 5) as t
on a.course_id = t.course_id order by t.purchase_count desc;

-- **. Find the total revenue generated from successful payments.**
select sum(amount_paid) from payments where payment_status like '%success%';


-- **. What is the average discount percentage applied across all discounted payments?**
select (select sum(discount_percent)from payments)/(select count(*) from payments where discount_percent > 0) as avg_disc;

-- **. Find top 3 countries with the highest number of students**
select country from
(select country,count(*) as total_student from users group by country order by total_student desc limit 3) 
as t order by t.total_student desc;


-- **. What is the most common reasons for refunds?**
select refund_reason, count(*) as most_reason from refunds group by refund_reason order by most_reason desc limit 1;


-- **. Add an age column to the users table and then calculate average age of the students on the website**
alter table users
add column age int;

update users
set age = timestampdiff(YEAR,date_of_birth,curdate());

select avg(age) from users;


-- **. Find average age of the students in each course**

select c.title,avg(a.age) from users a 
join 
enrollments b on a.user_id = b.student_id 
join 
courses c on b.course_id = c.course_id 
group by c.title;


-- **. Find average age of the students in each course category**
select c.category,avg(a.age) from users a 
join 
enrollments b on a.user_id = b.student_id
join
courses c on b.course_id = c.course_id
group by c.category;


-- **. Calculate the average age of users for each user category (e.g., Working, Student, Homemaker, Retired)**
select category,avg(age) from users group by category;


-- **. Find the top 5 most popular courses based on view counts**
select title from courses order by view_count desc limit 5;


-- **. Find the top 2 popular courses in each category based on view counts**

select category,title from (select category,title, view_count,
dense_rank() over(partition by category order by view_count desc )as r from courses) as t
where t.r <=2;

-- **. What is the average course duration per category.**
select category,avg(length) from courses group by category;


-- **. Find the top 5 highest revenue generating courses**
select a.title,sum(c.amount_paid) as total_rev from courses a join enrollments b on a.course_id = b.course_id
join payments c on b.enrollment_id = c.enrollment_id
group by a.title order by total_rev desc limit 5;

-- **. What is the average transaction amount for each payment method.**

select payment_method,avg(amount_paid) from payments group by payment_method;


-- **. Calulate the average rating for each course and add a column average_rating in courses_df**
alter table courses
add column average_rating decimal(5,2);

create temporary table t ( select course_id,avg(rating) as average_rating from ratings group by course_id);

UPDATE courses c
JOIN t ON c.course_id = t.course_id
SET c.average_rating = t.average_rating;


-- **. Find 2 top rated courses in each course category**
select category,title from (select a.category,a.title,b.ratings,
dense_rank()over(partition by a.category order by b.ratings desc) as ranks
from courses a join
(select course_id,avg(rating) as ratings from ratings group by course_id) as b on  a.course_id = b.course_id) as t where ranks <=2;


-- **. Display the average rating of each course category**
select a.category,avg(b.rating) from courses a join ratings b on a.course_id = b.course_id group by a.category;


-- **. Calculate the average rating for each instructor.**
select a.instructor_id,avg(b.rating) from courses a join ratings b on a.course_id = b.course_id
group by a.instructor_id;


-- **. Display courses with no ratings**
select a.title,a.course_id ,b.rating from courses a left join ratings b
on a.course_id = b.course_id where b.rating is null;


-- **. Find courses that have no students enrolled in them**
select a.title,b.enrollment_id from courses a left join enrollments b
on a.course_id = b.course_id where b.enrollment_id is null;

-- **. Find the number of students from each country based on their enrollments.**
select a.country,count(b.student_id) from users a join enrollments b 
on a.user_id = b.student_id group by a.country;

-- **. Get the course popularity details by country i.e. find the course with the highest number of students in each country.**
select country,title from (select a.country,c.title,count(b.student_id),
dense_rank()over(partition by a.country order by count(b.student_id) desc ) as rankk
 from users a join enrollments b 
on a.user_id = b.student_id
join courses c on c.course_id = b.course_id
group by a.country,c.title) as t where t.rankk = 1;


-- **. Find the top 5 bestselling paid courses**
select a.title,count(b.course_id) as purchase_count from courses a join enrollments b 
on a.course_id = b.course_id where a.price > 0
group by a.title order by purchase_count desc limit 5;


-- **. Find the bestselling course in each category**
select category,title from(select a.category,a.title,count(b.course_id) as purchase_count,
dense_rank() over(partition by a.category order by count(b.course_id) desc) as ranks
from courses a join enrollments b on a.course_id = b.course_id
group by a.category,a.title) as t where t.ranks = 1; 


-- **. Calculate the number of free enrollments and paid enrollments**
select a.course_type,count(b.course_id) as counts from courses a
join enrollments b on a.course_id = b.course_id
group by a.course_type;


-- **. How many payment transactions failed using paypal**
select count(*) from payments where payment_method = 'paypal' and payment_status like '%failed%';

-- **. Get a summary of payment methods, including how many successful, failed or pending payments are there for each method.**
select payment_method,payment_status,count(*) from payments group by payment_method,payment_status;

-- **. Display the courses that were never refunded**
select distinct(c.title) from enrollments a left join refunds b
on a.enrollment_id = b.enrollment_id 
join courses c on a.course_id = c.course_id;


-- **. Identify the course category with the most enrollments**
select a.category,count(*) from courses a join enrollments b on 
a.course_id = b.course_id group by category order by count(*) desc
limit 1;


-- **. What is the average price of courses in each category? (exclude the free courses)**
select category,avg(price) from courses where price > 0 group by category;


-- **. How many courses are available with subtitles?**
select count(*) from courses where subtitles = 'yes';


-- **. What percentage of courses offer certifications?**
select (((select count(*) from courses where certification_available like '%yes%')* 100)/ (select count(*) from courses)) as perc;


-- **. What is the average time gap between a user's registration date and their first enrollment date?**
select avg(timestampdiff(DAY,a.registration_date,b.enrollment_date)) as avg_day_gap from users a join enrollments b 
on a.user_id = b.student_id;

-- **. Get the email addresses and names of users who have signed up but have not enrolled in any course.**
select a.name,a.email from users a left join enrollments b on a.user_id = b.student_id
where b.student_id is null;

-- **. Find the customers who are refunding without any reason**
select c.name from enrollments a join refunds b on a.enrollment_id = b.enrollment_id
join users c on c.user_id = a.student_id 
where refund_reason is null;

-- **. Analyze monthly new user growth to understand monthly trends**
select date_format(registration_date,'%b%Y') as month_name ,count(*) from users group by month_name;

-- **. Generate the monthly revenue report** 
select date_format(a.enrollment_date,'%b%Y') as month_year,sum(b.price) from enrollments a join courses b
on a.course_id = b.course_id group by month_year;


-- **. Generate the annual revenue report** 
select date_format(a.enrollment_date,'%Y') as years,sum(b.price) from enrollments a join courses b
on a.course_id = b.course_id group by years;

-- **. Which coupon code is used most frequently?  Visualize the distribution of coupon code usage**
select coupon_code,count(*) as count from payments where coupon_code is not null group by coupon_code order by count desc limit 1 ;

-- **. Analyze completion rates by country**
select c.country,avg(b.completion_rate) from enrollments a join courses b on
a.course_id = b.course_id join users c
on c.user_id =  a.student_id group by c.country;