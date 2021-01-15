USE LMS;

INSERT INTO Users(user_type)
VALUES( "LibraryManager"), ("Publisher"), ("RegularUser"), ("RegularUser"), ("RegularUser"), ("Publisher"), ("Publisher");

INSERT INTO LibraryManager(user_id, first_name, last_name)
VALUES(1, "John", "Doe");

INSERT INTO Publisher(user_id, publisher_name)
VALUES(2, "AtreusAracely"), (6, "EydisTheodor"), (7, "HuldClaudiu");

INSERT INTO RegularUser(user_id, first_name, last_name, penalty_score)
VALUES(3, "Hong", "Haroldo", 0), (4, "Keeva", "Barbra", 0), (5, "Halvdan", "Birgitta", 0);

INSERT INTO Author(first_name, last_name)
VALUES("Aldhard", "Emelia"), ("Debora", "Bahija"), ("Annelie", "Octavius");

INSERT INTO AuthSystem(uname, pword, user_id)
VALUES("john", "l+oV5bi5GIYDeLkhPuI68w==", 1), ("atreus", "l+oV5bi5GIYDeLkhPuI68w==", 2), ("hong", "l+oV5bi5GIYDeLkhPuI68w==", 3),
("keeva", "l+oV5bi5GIYDeLkhPuI68w==", 4), ("halvdan", "l+oV5bi5GIYDeLkhPuI68w==", 5),
("eydis", "l+oV5bi5GIYDeLkhPuI68w==", 6), ("huld", "l+oV5bi5GIYDeLkhPuI68w==", 7);

INSERT INTO Book(title, publisher_id, borrowed_times, publication_date, is_available, is_requested, requester_id, remove_requested, is_exist)
VALUES("Solar Eclipse of the Heart", 2, 1, '2006-05-08 12:35:29', true, false, null, false, true),
("Zodiac Light", 2, 0, '2005-05-08 12:35:29', false, false, null, false, false),
("The Woman in the West", 2, 2, '2004-05-08 12:35:29', true, false, null, false, true),
("Death of the Invisible Falcon", 6, 1, '2003-05-08 12:35:29', false, true, 5, false, true);

INSERT INTO Borrowing(book_id, user_id, reserve_date, return_date)
VALUES(1, 3, '2007-05-08 12:35:29', '2007-06-08 12:35:29'), (3, 4, '2007-07-08 12:35:29', '2007-08-08 12:35:29'),
(4, 3, '2007-09-08 12:35:29', '2007-10-08 12:35:29'), (4, 4, '2007-11-08 12:35:29', null);

INSERT INTO Topic(topic_name)
VALUES("Love"), ("Death"), ("Good vs evil"), ("Power and corruption");

INSERT INTO Genre(genre_name)
VALUES("Action"), ("Adventure"), ("Classics"), ("Mystery");

INSERT INTO AuthorBook(book_id, author_id)
VALUES(1, 1), (2, 2), (2,1), (3, 1), (4, 1);

INSERT INTO TopicBook(book_id, topic_id)
VALUES(1, 1), (2, 3), (3, 3), (3, 1), (4, 4);

INSERT INTO GenreBook(book_id, genre_id)
VALUES(1, 2), (2, 2), (3, 3), (3,4), (4, 4), (4, 2);
