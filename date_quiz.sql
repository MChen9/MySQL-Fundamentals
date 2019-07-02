select current_time();

select current_date();

select dayofweek(current_date());

select dayname(current_date());

select date_format(now(), '%m/%d/%y');

select date_format(now(), '%M %D at %h:%i');

create table tweets (
	content varchar(100),
	user_name varchar(100),
	created_at timestamp default now());