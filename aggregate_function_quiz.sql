select count(distinct title) from books;

select released_year, count(*) from books
	group by released_year;

select sum(stock_quantity) from books;

select concat(author_fname, ' ', author_lname) as 'author', 
avg(released_year) from books
	group by author_fname, author_lname;

select concat(author_fname, ' ', author_lname) as 'author', max(pages)
	from books;
	
select released_year as 'year', count(title) as '# books', avg(pages) as 'avg pages'
	from books group by released_year;