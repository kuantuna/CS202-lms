USE LMS;

INSERT INTO Users(user_type)
VALUES( "LibraryManager"), ("Publisher"), ("RegularUser"), ("RegularUser"), ("Author"), ("RegularUser"), ("Publisher"), ("Publisher"), ("Author"), ("Author");

INSERT INTO LibraryManager(user_id, first_name, last_name)
VALUES(1, "John", "Doe");

INSERT INTO Publisher(user_id, publisher_name)
VALUES(2, "AtreusAracely"), (7, "EydisTheodor"), (8, "HuldClaudiu");

INSERT INTO RegularUser(user_id, first_name, last_name, penalty_score)
VALUES(3, "Hong", "Haroldo", 0), (4, "Keeva", "Barbra", 0), (6, "Halvdan", "Birgitta", 0);

INSERT INTO Author(user_id, first_name, last_name)
VALUES(5, "Aldhard", "Emelia"), (9, "Debora", "Bahija"), (10, "Annelie", "Octavius");

INSERT INTO AuthSystem(uname, pword, user_id)
VALUES("john", "l+oV5bi5GIYDeLkhPuI68w==", 1), ("atreus", "l+oV5bi5GIYDeLkhPuI68w==", 2), ("hong", "l+oV5bi5GIYDeLkhPuI68w==", 3),
("keeva", "l+oV5bi5GIYDeLkhPuI68w==", 4), ("aldhard", "l+oV5bi5GIYDeLkhPuI68w==", 5), ("halvdan", "l+oV5bi5GIYDeLkhPuI68w==", 6),
("eydis", "l+oV5bi5GIYDeLkhPuI68w==", 7), ("huld", "l+oV5bi5GIYDeLkhPuI68w==", 8), ("debora", "l+oV5bi5GIYDeLkhPuI68w==", 9),
("annelie", "l+oV5bi5GIYDeLkhPuI68w==", 10);

INSERT INTO Book(title, publisher_id, publication_date, is_available, is_requested, remove_requested, is_exist)
VALUES("Solar Eclipse of the Heart", 2, '2006-05-08 12:35:29.123', true, false, false, true),
("Zodiac Light", 2, '2005-05-08 12:35:29.123', false, false, false, false),
("The Woman in the West", 2, '2004-05-08 12:35:29.123', true, false, false, true),
("Death of the Invisible Falcon", 7, '2003-05-08 12:35:29.123', false, true, false, false);

INSERT INTO Borrowing(book_id, user_id, reserve_date, return_date)
VALUES(1, 3, '2007-05-08 12:35:29.123', '2007-06-08 12:35:29.123'), (3, 4, '2007-07-08 12:35:29.123', '2007-08-08 12:35:29.123'),
(4, 4, '2007-09-08 12:35:29.123', '2007-10-08 12:35:29.123'), (3, 4, '2007-11-08 12:35:29.123', null);

INSERT INTO Topic(topic_name)
VALUES("Love"), ("Death"), ("Good vs evil"), ("Power and corruption");

INSERT INTO Genre(genre_name)
VALUES("Action"), ("Adventure"), ("Classics"), ("Mystery");

INSERT INTO AuthorBook(book_id, user_id)
VALUES(1, 5), (2, 5), (2, 9), (3, 5), (4, 9);

INSERT INTO TopicBook(book_id, topic_id)
VALUES(1, 1), (2, 3), (3, 3), (3, 1), (4, 4);

INSERT INTO GenreBook(book_id, genre_id)
VALUES(1, 2), (2, 2), (3, 3), (3,4), (4, 4), (4, 2);
