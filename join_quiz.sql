create table students(
	id int auto_increment primary key,
	first_name varchar(100));

create table papers(
	title varchar(100),
	grade int,
	student_id int,
	foreign key(student_id) references students(id)
	on delete cascade);
	
select first_name, papers.title as 'title', papers.grade as 'grade'
	from students join papers
	on id = papers.student_id
	order by papers.grade desc;
	
select first_name, papers.title as 'title', papers.grade as 'grade'
	from students left join papers
	on id = papers.student_id;
	
select 
	first_name, 
	ifnull(papers.title, 'MISSING') as 'title', 
	ifnull(papers.grade, 0) as 'grade'
	from students left join papers
	on id = papers.student_id;
	
select 
	first_name,  
	avg(ifnull(papers.grade, 0)) as 'average'
	from students left join papers
	on id = papers.student_id
	group by first_name
	order by average desc;
	
select 
	first_name,  
	avg(ifnull(papers.grade, 0)) as 'average',
	case
	when avg(ifnull(papers.grade, 0)) >= 70 then 'PASSING'
	else 'FAILING'
	end as passing_status
	from students left join papers
	on id = papers.student_id
	group by first_name
	order by average desc;