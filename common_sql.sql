# Database Operations

create database <name>;

drop database <name>;

show databases;

use <database name>; // begin to use a database

select database(); // tell current db in use

drop table table_name;

# Table Operations

create table <name> (
	col_name datatype,
	col_name datatype);

create table <name> (
	col_name datatype not null,
	col_name datatype not null); // values with default null

create table <name> (
	col_name datatype default <value>,
	col_name datatype default <value>); // values with default value
	
create table <name> (
	col_name datatype not null default <value>,
	col_name datatype not null default <value>); // default value cannot be null

show tables;

show columns from <table_name>;
OR
desc <table_name>; //describe table

drop table <table_name>; // similar to drop database

show tables;


# Data Operations

insert into cats(name, age)
values ('Jetson', 3); // order matters

insert into table_name(col_name, col_name, ...)
values (, , ...),
	 (...),
	(...); // multiple insert/update

select * from table_name; // show all data in the table

show warnings; // truncate if length exceed


# Primary Key
create table table_name (
	cat_id int not null,
	name varchar(100),
	age int,
	primary key(cat_id));

create table table_name (
	cat_id int not null auto_increment, // do not need to add value, auto increment
	name varchar(100),
	age int,
	primary key(cat_id));


# SELECT
// select columns
select col_name, col_name, ... from table_name;


# WHERE

select col_name from table_name where condition;


# Alias
// easier to read data

select col_name as new_name from table_name;


# UPDATE

update table_name set col_name = value
where condition;


# DELETE
// delete rows
delete from table_name where conditions;

delete from table_name; // delete all rows, but table still be


# Run SQL Files

source file_name.sql;
OR
source path/file_name.sql;


# String Functions

select concat(x, y, z) from table_name;

select concat(fname, ' ', lname) from table_name; // give a space between fname and lname
OR
select concat_ws(separator, x, y, z) from table_name;


select substring(col_name, s_pos, len) from table_name; //start from 1
OR
select substring(col_name, start_pos) from table_name; // negative goes from end of str

select concat(substring(author_fname, 2), ' ', substring(author_lname, 2)) from books;


select replace('Hello World', 'Hell', '@#$Q') from table_name; // case sensitive


select reverse(col_name) from table_name;


select char_length(col_name) from table_name;
e.g. select char_length(author_fname) from books;


select upper(col_name) from table_name; // can only take one argument
select lower(col_name) from table_name;

select concat(substring(title, 1, 10), '...') as 'short title',
	concat(author_fname, ',', author_lname) as 'author',
	concat(stock_quantity, ' in stock') as 'quantity'
	from books;


# Refine Selection

select distinct col_name from table_name; // right after select

select distinct concat(author_lname, ' ', author_fname) as 'full name' from books;

select col_name from table_name order by col_name;

select col_name from table_name order by col_name desc;

select col1, col2, col3 from table_name order by 2; // 2 means selected col2

select col1, col2, col3 from table_name order by col1, col2; // after sort by col1, then sort by col2


select col_name from table_name order by col_name desc limit num; // return how many rows

select col_name from table_name order by col_name desc limit start_pos, num;


select col_name from table_name where col_name like <pattern>;

select author_fname from books where author_fname like '%a%'; 
// % means anything before a or after a
// '____' means 4 chars long


# Aggregate/Group Functions

select count(col_name) from table_name; // how many rows

select count(distict col_name) from table_name; // how many different rows

select col_name from table_name group by col_name; //condense same rows


select min(col_name) from table_name;

select max(col_name) from table_name;

select * from table_name
	where col_name = 
	(select min(col_name) from table_name);

// find the year that authors published their first books
select author_fname, author_lname, min(released_year)
	from books group by author_fname, author_lname;

// find longest pages for every authors
select concat(author_fname, ' ', author_lname) as 'author', max(pages)
	from books group by author_fname, author_lname;
	
	
select col_name from table_name;

// sum + group by
select concat(author_fname, ' ', author_lname) as 'author', sum(pages) from books
	group by author_fname, author_lname;


select avg(col_name) from table_name;

// avg + group by
select released_year, avg(stock_quantity) from books
	group by released_year;
	
	
# Date Time

select curtime(); // current curtime
select curdate(); // current date
select now(); // get current datetime

insert into people(name, birthdate, birthtime, birthdt)
	values('Kack', curdate(), curtime(), now());
	
set time_zone = '-7:00';

// formatting dates
day();
dayname();
dayofweek();
dayofyear();
monthname();

date_format(date, format);
select date_format('2009-10-04 22:23:00', '%W-%M-%Y'); -- case sensitive

select date_format(birthdt, 'was born at %W') from people;


# Date Arithmetic
datediff();
select datediff(now(), birthdate) from people;

date_add(col_name, interval);
select date_add(birthdt, interval 1 month) from people;

+/- interval
select birthdt + interval 3 quarter from people;


# Time stamp
create table comments (
    content varchar(100),
    create_at timestamp default now()); -- create_at do not need to manually add data
	
create table comments2 (
    content varchar(100),
    changed_at timestamp default now() on update current_timestamp);
	
	
# Logical Operator

=/!=

not like/like

>=/<=

and/&&

or/||

-- between and 
select name, birthdt 
	from people
	where birthdt between '1980-01-01' and '2010-01-01';
	
in/not in



# Case Statement

SELECT title, released_year,
       CASE 
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM books;

SELECT title,
	case when stock_quantity between 0 and 50 then '*'
	when stock_quantity between 51 and 100 then '**'
	else '***'
	end as stock 
	from books;

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '****'
    END AS STOCK
FROM books;



# ONE to ONE
create table customers(
    id int auto_increment primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100));
	
create table orders(
	id int auto_increment primary key,
	order_date date,
	amount decimal(8, 2),
	customer_id int,
	foreign key(customer_id) references customers(id));
	
select * from orders where customer_id = 
	(select id from customers
	where last_name = 'George');


-- cross join, all combinations(rows by rows)
select * from orders, customers;

-- implicit inner join
select * from orders, customers
	where orders.customer_id = customers.id;
	
-- explicit inner join
select * from orders join customers
    on customers.id = orders.customer_id;

-- left join
-- select every row in A, along with any matched records in B
select * from orders left join customers
    on customers.id = orders.customer_id;

select first_name, last_name, ifnull(sum(amount), 0) -- ifnull
	from orders left join customers
    on customers.id = orders.customer_id
	group by customers.id;
	

-- right join
-- select every row in B, along with any matched records in A
select * from orders right join customers
    on customers.id = orders.customer_id;

select 
ifnull(first_name, 'MISSING'), ifnull(last_name, 'MISSING'), order_date, amount
from customers
right join orders
	on customer_id = orders.id
group by customer_id;


-- ON DELETE CASCADE
-- If delet
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
 
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE
);


# MANY to MANY
create table reviewers(
	id int auto_increment primary key,
	first_name varchar(100),
	last_name varchar(100)
);
	
create table series(
	id int auto_increment primary key,
	title varchar(100),
	released_year year(4),
	genre varchar(100)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

select title,
	avg(reviews.rating) as avg_rating
	from series join reviews
	on series.id = reviews.id
	group by title
	order by avg_rating;
	
select first_name, last_name, rating
	from reviewers join reviews
	on reviewers.id = reviews.reviewer_id;
	
select title as unreviewed_series
	from series left join reviews
	on series.id = reviews.series_id
	where rating is null;
	
select genre,
	round(avg(rating)) as avg_rating
	from series inner join reviews
	on series.id = reviews.series_id
	group by genre;
	
select first_name, last_name, 
	count(reviewer_id) as COUNT,
	ifnull(min(rating), 0.0) as MIN,
	ifnull(max(rating), 0.0) as MAX,
	ifnull(avg(rating), 0.0) as AVG,
	case
	when count(reviewer_id) > 0 then 'ACTIVE'
	else 'INACTIVE'
	end as STATUS
	from reviewers left join reviews
	on reviewers.id = reviews.reviewer_id
	group by first_name, last_name;
	
-- multiple inner join 
-- foreign key refer to which key is important
select title, rating, 
	concat(first_name, ' ', last_name) as reviewer
	from reviewers
	inner join reviews
	on reviewers.id = reviews.reviewer_id
	inner join series 
	on series.id = reviews.series_id
	order by title;
	
