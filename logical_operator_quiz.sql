# false true true

select * 
	from books
	where released_year < 1980;
	
select * 
	from books
	where author_lname = 'Eggers' || author_lname = 'Chabon';

select * 
	from books
	where author_lname = 'Lahiri' && released_year > 2000;
	
select * 
	from books
	where pages between 100 and 200;

select * 
	from books
	where author_lname like 'C%' || author_lname like 'S%';
	
select title, author_lname,
	case
	when title like '%stories%' then 'Short Stories'
	when title = 'Just Kids' || title = 'A Heartbreaking Work' then 'Memoir'
	else 'Novel'
	end as TYPE
from books;

select title, author_lname, concat(count(*), ' books')
	from books group by author_lname;
	
