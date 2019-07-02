# Find the 5 oldest users
select * from users
	order by created_at
	limit 5;
	
# What day of the week do most users register on?
select dayofweek(created_at) as day
	from users
	group by day
	order by day desc limit 1;
	
# Find the users who have never posted a photo
select *
	from users left join photos
	on users.id = photos.user_id
	where photos.id is null;
	
# We're running a new contest to see who can get the most likes on a single photo
select users.id, users.username, photos.image_url, 
	count(likes.photo_id) as num_likes
	from users inner join photos
	on users.id = photos.user_id
	inner join likes 
	on photos.id = likes.photo_id
	group by likes.photo_id
	order by num_likes desc limit 1;
	
select max(num_likes) from (
select users.id, users.username, photos.image_url, 
	count(likes.photo_id) as num_likes
	from users inner join photos
	on users.id = photos.user_id
	inner join likes 
	on photos.id = likes.photo_id
	group by likes.photo_id ) as tb;
	
# How many times does the average user post?
select avg(post) from (
	select count(photos.image_url) as post
	from users inner join photos
	on users.id = photos.user_id
	group by photos.user_id)
	as tb1;
	
# What are the top 5 most commonly used hashtags?
select count(photo_id) as num
	from photo_tags
	group by tag_id
	order by num desc limit 5;
	
# Find users who have liked every single photo on the site
select user_id, num_likes from (
	select user_id, count(photo_id) as num_likes
	from likes group by user_id
) as tb1
where num_likes = 
(select count(distinct image_url) 
	 from photos);
	 
select user_id, count(photo_id) as num_likes
	from likes group by user_id
	having num_likes =  -- comes with group by
	(select count(distinct image_url) 
	 from photos);
	 
# Find users who have never commented on a photo
select users.id as id, username 
	from users left join comments
	on users.id = comments.user_id
	where comments.id is null;
	
# Find the percentage of our users who have either never commented on a photo or have commented on every photo
select ((
	select count(user_id) as bots from (
	select user_id, count(photo_id) as num_likes
	from likes group by user_id
) as tb1
where num_likes = 
(select count(distinct image_url) 
	 from photos)
) + (
	select count(*) as celebrity 
	from users left join comments
	on users.id = comments.user_id
	where comments.id is null
)) /  
(select count(distinct id) 
	from users) as percentage;	

	
