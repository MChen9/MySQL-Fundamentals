create table users (
    id integer auto_increment primary key,
    username varchar(255) unique not null,
    created_at timestamp default now()
);

create table photos (
	id integer auto_increment primary key,
	image_url varchar(100) not null,
	user_id integer not null,
	created_at timestamp default now(),
	foreign key(user_id) references users(id)
);

create table comments (
	id integer auto_increment primary key,
	comment_text varchar(255) not null,
	photo_id int not null,
	user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
	foreign key(photo_id) references photos(id),
	foreign key(user_id) references users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

create table tags (
	id integer auto_increment primary key,
	tag_name varchar(255) unique,
	created_at timestamp default now()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);