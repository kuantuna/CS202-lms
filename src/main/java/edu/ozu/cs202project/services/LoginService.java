package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class LoginService
{
    @Autowired
    JdbcTemplate connection;

    public boolean credentialsExist(String username, String password)
    {
        List<Map<String, Object>> response =  connection.queryForList(
                "SELECT * FROM AuthSystem WHERE uname = ? AND pword = ?",
                new Object[]{username, password});
        return response.size() == 1;
    }
    // TAMAM

    public boolean usernameExist(String username)
    {
        List<Map<String, Object>> response =  connection.queryForList(
                "SELECT * FROM AuthSystem WHERE uname = ? ", new Object[]{username});
        return response.size() == 1;
    }
    // TAMAM

    public Integer getUserId(String username)
    {
        List<Integer> response =  connection.queryForList(
                "SELECT user_id FROM AuthSystem WHERE uname = ? ", Integer.class, username);
        return response.get(0);
    }
    // TAMAM

    public String getPrivilegeLevel(int userID)
    {
        List<String> response =  connection.queryForList(
                "SELECT user_type FROM Users WHERE user_id = ? ",
                String.class, userID);
        return response.get(0);
    }
    // TAMAM

    public void insertRegularUser(String firstName, String lastName, String username, String password)
    {
        connection.update("INSERT INTO Users (user_type) VALUES ('RegularUser')");

        List<Integer> response =  connection.queryForList(
                "SELECT MAX(user_id) FROM Users WHERE user_type = 'RegularUser' ", Integer.class);
        int userID = response.get(0);

        connection.update("INSERT INTO RegularUser (user_id, first_name, last_name, penalty_score)" +
                        " VALUES (?, ?, ?, 0)", new Object[]{userID , firstName, lastName});

        connection.update("INSERT INTO AuthSystem (user_id, uname, pword) VALUES (?, ?, ?)",
                new Object[]{userID , username, password});
    }
    // TAMAM

    public void insertPublisher(String name, String username, String password)
    {
        connection.update("INSERT INTO Users (user_type) VALUES ('Publisher')");

        List<Integer> response =  connection.queryForList(
                "SELECT MAX(user_id) FROM Users WHERE user_type = 'Publisher' ", Integer.class);
        int userID = response.get(0);

        connection.update("INSERT INTO Publisher (user_id, publisher_name) VALUES (?, ?)",
                new Object[]{userID , name});

        connection.update("INSERT INTO AuthSystem (user_id, uname, pword) VALUES (?, ?, ?)",
                new Object[]{userID , username, password});
    }
    // TAMAM

    public List<String[]> displayBorrowings()
    {
        List<String[]> response =  connection.query(
                "SELECT br.borrowing_id, br.book_id, bk.title, br.user_id, rg.first_name, rg.last_name, br.reserve_date, br.return_date " +
                        "FROM Borrowing AS br " +
                        "LEFT JOIN RegularUser AS rg " +
                        "USING(user_id) " +
                        "LEFT JOIN Book AS bk " +
                        "USING(book_id)", (row, index) -> {
                    return new String[]{row.getString("borrowing_id"), row.getString("book_id"),
                            row.getString("title"), row.getString("user_id"),
                            row.getString("first_name"),row.getString("last_name"),
                            row.getString("reserve_date"), row.getString("return_date")};
                });
        return response;
    }
    // TAMAM

    public List<String[]> displayBookInformation()
    {
        List<String[]> response =  connection.query(
                "SELECT b.book_id, b.title, b.publisher_id, p.publisher_name, ab.user_id AS author_id, a.first_name, " +
                        "a.last_name, tb.topic_id, t.topic_name, gb.genre_id, g.genre_name, " +
                        "b.publication_date, b.is_available, b.is_requested, b.remove_requested, b.is_exist " +
                        "FROM Book AS b LEFT JOIN Publisher AS p ON b.publisher_id=p.user_id " +
                        "LEFT JOIN AuthorBook AS ab ON b.book_id=ab.book_id " +
                        "LEFT JOIN Author AS a ON ab.user_id=a.user_id " +
                        "LEFT JOIN TopicBook AS tb ON b.book_id=tb.book_id " +
                        "LEFT JOIN Topic AS t ON tb.topic_id=t.topic_id " +
                        "LEFT JOIN GenreBook AS gb ON b.book_id=gb.book_id " +
                        "LEFT JOIN Genre AS g ON gb.genre_id=g.genre_id ", (row, index) -> {
            return new String[]{row.getString("book_id"), row.getString("title"),
                    row.getString("publisher_name"),
                    row.getString("first_name"),
                    row.getString("last_name"),
                    row.getString("topic_name"),
                    row.getString("genre_name"), row.getString("publication_date"),
                    row.getString("is_available"), row.getString("is_requested"),
                    row.getString("remove_requested"), row.getString("is_exist")
            };
        });
        return response;
    }

    public boolean isPublisher(String userId)
    {
        List<String> response =  connection.queryForList(
                "SELECT user_type FROM Users WHERE user_id = ?", String.class, userId);
        return response.get(0).equals("Publisher");
    }

    public void addBook(String title, String author, String topic, String genre, String publisherID)
    {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = sdf.format(date);

        connection.update("INSERT INTO book (PublicationDate, IsAvailable, Title, Author," +
                " Topic, Genre, BorrowedTimes, IsExist, IsRequested, RemoveRequested) " +
                "VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", new Object[]{dateString, true, title, author,
                    topic, genre, 0, true, false, false});

        List<Integer> response =  connection.queryForList(
                "SELECT MAX(BookID) FROM book", Integer.class);
        int bookID = response.get(0);

        connection.update("INSERT INTO publisherbook (BookID, UserID) VALUE (?, ?)", new Object[]{bookID, publisherID});
    }
}
