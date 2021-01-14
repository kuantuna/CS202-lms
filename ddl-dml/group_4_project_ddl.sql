CREATE DATABASE LMS;
USE LMS;

CREATE TABLE Users(
	user_id int auto_increment,
    user_type varchar(30) not null,
    PRIMARY KEY(user_id)
);

CREATE TABLE AuthSystem(
	uname varchar(30) not null,
    pword varchar(30) not null,
    user_id int not null,
    PRIMARY KEY(uname),
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

CREATE TABLE RegularUser(
	user_id int not null,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    penalty_score float not null,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    CHECK(penalty_score>=0)
);

CREATE TABLE LibraryManager(
	user_id int not null,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

CREATE TABLE Publisher(
	user_id int not null,
    publisher_name varchar(30) not null,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

CREATE TABLE Book(
	book_id int auto_increment not null,
    title varchar(30) not null,
    publisher_id int not null,
    publication_date datetime not null,
    is_available boolean not null,
    is_requested boolean not null,
    remove_requested boolean not null,
    is_exist boolean not null,
    PRIMARY KEY(book_id),
    FOREIGN KEY(publisher_id) REFERENCES Publisher(user_id),
    CONSTRAINT check_is_requested
    CHECK( is_requested = CASE WHEN is_available = true THEN false END ),
    CONSTRAINT check_is_remove_requested
    CHECK( remove_requested = CASE WHEN is_exist = false THEN false END )
    /* Kontrol et */
);

CREATE TABLE Borrowing(
	borrowing_id int auto_increment not null,
    book_id int not null,
    user_id int not null,
	reserve_date datetime not null,
    return_date datetime,
    PRIMARY KEY(borrowing_id),
    FOREIGN KEY(book_id) REFERENCES Book(book_id),
    FOREIGN KEY(user_id) REFERENCES RegularUser(user_id)
);

CREATE TABLE Author(
	user_id int not null,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

CREATE TABLE AuthorBook(
	book_id int not null,
    user_id int not null,
    PRIMARY KEY(book_id, user_id),
    FOREIGN KEY(book_id) REFERENCES Book(book_id),
    FOREIGN KEY(user_id) REFERENCES Author(user_id)
);

CREATE TABLE Topic(
	topic_id int auto_increment not null,
    topic_name varchar(30) not null,
    PRIMARY KEY(topic_id)
);

CREATE TABLE TopicBook(
	topic_id int not null,
    book_id int not null,
    PRIMARY KEY(topic_id, book_id),
    FOREIGN KEY(topic_id) REFERENCES Topic(topic_id),
    FOREIGN KEY(book_id) REFERENCES Book(book_id)
);

CREATE TABLE Genre(
	genre_id int auto_increment not null,
    genre_name varchar(30) not null,
    PRIMARY KEY(genre_id)
);

CREATE TABLE GenreBook(
	genre_id int not null,
    book_id int not null,
    PRIMARY KEY(genre_id, book_id),
    FOREIGN KEY(genre_id) REFERENCES Genre(genre_id),
	FOREIGN KEY(book_id) REFERENCES Book(book_id)    
);