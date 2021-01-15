package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class Services
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
                "SELECT b.book_id, b.title, b.publisher_id, p.publisher_name, a.first_name, " +
                        "a.last_name, t.topic_name, g.genre_name, b.publication_date, " +
                        "b.is_available, b.is_requested, b.remove_requested, b.is_exist, b.borrowed_times " +
                        "FROM Book AS b LEFT JOIN Publisher AS p ON b.publisher_id=p.user_id " +
                        "LEFT JOIN AuthorBook AS ab ON b.book_id=ab.book_id " +
                        "LEFT JOIN Author AS a ON ab.author_id=a.author_id " +
                        "LEFT JOIN TopicBook AS tb ON b.book_id=tb.book_id " +
                        "LEFT JOIN Topic AS t ON tb.topic_id=t.topic_id " +
                        "LEFT JOIN GenreBook AS gb ON b.book_id=gb.book_id " +
                        "LEFT JOIN Genre AS g ON gb.genre_id=g.genre_id ", (row, index) -> {
            return new String[]{row.getString("book_id"), row.getString("title"),
                    row.getString("publisher_id"),
                    row.getString("publisher_name"),
                    row.getString("first_name"),
                    row.getString("last_name"),
                    row.getString("topic_name"),
                    row.getString("genre_name"), row.getString("publication_date"),
                    row.getString("is_available"), row.getString("is_requested"),
                    row.getString("remove_requested"), row.getString("is_exist"),
                    row.getString("borrowed_times")
            };
        });
        return response;
    }

    public void addBook(String title, String publisherID, String publicationDate, String[] genre_ids,
                        String[] topic_ids, String[] author_ids)
    {
        connection.update("INSERT INTO Book (title, publisher_id, borrowed_times, publication_date," +
                " is_available, is_requested, requester_id, remove_requested, is_exist) " +
                "VALUE (?, ?, 0, ?, true, false, null, false, true)", new Object[]{title, publisherID, publicationDate
                    });

        List<String> response =  connection.queryForList(
                "SELECT MAX(book_id) FROM Book ", String.class);
        String book_id = response.get(0);

        for(String genre : genre_ids)
        {
            connection.update("INSERT INTO GenreBook (book_id, genre_id) VALUE (?, ?)",
                    new Object[]{book_id, Integer.parseInt(genre)+1});
        }

        for(String topic : topic_ids)
        {
            connection.update("INSERT INTO TopicBook (book_id, topic_id) VALUE (?, ?)",
                    new Object[]{book_id, Integer.parseInt(topic)+1});
        }

        for(String author : author_ids)
        {
            connection.update("INSERT INTO AuthorBook (book_id, author_id) VALUE (?, ?)",
                    new Object[]{book_id, Integer.parseInt(author)+1});
        }
    }

    public String getRealUserId(String publisher_id)
    {
        List<String> response =  connection.queryForList(
                "SELECT user_id FROM Publisher LIMIT 1 OFFSET "
                        + publisher_id, String.class);
        return response.get(0);
    }
    //

    public List<String[]> booksForRemoveRequest(String userId)
    {
        List<String[]> response = connection.query("SELECT title, book_id FROM Book WHERE remove_requested = 0 " +
                        "AND is_exist = 1 AND publisher_id = " + userId
        ,(row, index) -> { return new String[]{
                        row.getString("title"), row.getString("book_id")
                };});
        return response;
    }

    public void updateRemoveRequest(String book_id, String userId)
    {
        List<String[]> books = booksForRemoveRequest(userId);
        int count = 0;
        int real_book_id = 0;
        for(String[] item : books){
            if(count == Integer.parseInt(book_id)){
                real_book_id = Integer.parseInt(item[1]);
            }
            ++count;
        }
        connection.update("UPDATE Book SET remove_requested = 1 WHERE book_id = " + real_book_id);
    }

    public List<String[]> getPublishers()
    {
        List<String[]> response = connection.query("SELECT publisher_name FROM Publisher"
                ,(row, index) -> { return new String[]{ row.getString("publisher_name")
                };
                });
        return response;
    }

    public List<String[]> getGenres()
    {
        List<String[]> response = connection.query("SELECT genre_name FROM Genre"
                ,(row, index) -> { return new String[]{ row.getString("genre_name")
                };
                });
        return response;
    }

    public List<String[]> getTopics()
    {
        List<String[]> response = connection.query("SELECT topic_name FROM Topic"
                ,(row, index) -> { return new String[]{ row.getString("topic_name")
                };
                });
        return response;
    }

    public List<String[]> getAuthors()
    {
        List<String[]> response = connection.query("SELECT first_name, last_name FROM Author"
                ,(row, index) -> { return new String[]{ row.getString("first_name"),
                        row.getString("last_name")
                };
                });
        return response;
    }

    public void addBookRequest(String title, String publication_date, String[] genre_ids, String[] topic_ids,
                          String[] author_ids, String publisherId)
    {
        connection.update("INSERT INTO Book (title, publisher_id, publication_date, is_available, is_requested," +
                "requester_id, remove_requested, is_exist) VALUE (?, ?, ?, 1, 0, null, 0, 0)",
                new Object[]{title, publisherId, publication_date});

        List<String> response =  connection.queryForList(
                "SELECT MAX(book_id) FROM Book ", String.class);
        String book_id = response.get(0);

        for(String genre : genre_ids)
        {
            connection.update("INSERT INTO GenreBook (book_id, genre_id) VALUE (?, ?)",
                    new Object[]{book_id, Integer.parseInt(genre)+1});
        }

        for(String topic : topic_ids)
        {
            connection.update("INSERT INTO TopicBook (book_id, topic_id) VALUE (?, ?)",
                    new Object[]{book_id, Integer.parseInt(topic)+1});
        }

        for(String author : author_ids)
        {
            connection.update("INSERT INTO AuthorBook (book_id, author_id) VALUE (?, ?)",
                    new Object[]{book_id, Integer.parseInt(author)+1});
        }
    }

    public List<String[]> getBookInfos()
    {
        List<String[]> response = connection.query("SELECT book_id, is_available FROM Book"
                ,(row, index) -> { return new String[]{ row.getString("book_id"),
                        row.getString("is_available")
                };
                });
        return response;
    }

    public void removeBook(String book_id)
    {
        int bookId = Integer.parseInt(book_id) + 1;
        connection.update("DELETE FROM TopicBook WHERE book_id = ?",
                new Object[]{bookId});
        connection.update("DELETE FROM GenreBook WHERE book_id = ?",
                new Object[]{bookId});
        connection.update("DELETE FROM AuthorBook WHERE book_id = ?",
                new Object[]{bookId});
        connection.update("DELETE FROM Borrowing WHERE book_id = ?",
                new Object[]{bookId});
        connection.update("DELETE FROM Book WHERE book_id = ?",
                new Object[]{bookId});
    }

    public void borrowBook(String book_id, int user_id)
    {
        int bookId = Integer.parseInt(book_id) + 1;
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = sdf.format(date);
        connection.update("UPDATE Book SET is_available = 0 WHERE book_id = ?",
                new Object[]{bookId});
        connection.update("INSERT INTO Borrowing (book_id, user_id, reserve_date, return_date) " +
                        "VALUE (?, ?, ?, null)",
                new Object[]{bookId, user_id, dateString});
    }

    public List<String[]> getUserBorrowing(int user_id)
    {
        List<String[]> response = connection.query("SELECT DISTINCT book_id FROM Book " +
                        "NATURAL JOIN Borrowing WHERE return_date is null AND user_id = " + user_id
                ,(row, index) -> { return new String[]{ row.getString("book_id")
                };
        });
        return response;
    }

    public void returnBook(String book_id, int user_id)
    {
        System.out.println("User ID: " + user_id);
        System.out.println("Book ID: " + book_id);
        List<String> respRealBookId = connection.queryForList("SELECT DISTINCT book_id FROM Book " +
                "NATURAL JOIN Borrowing WHERE return_date is null " +
                        "AND user_id = "+ user_id+ " LIMIT 1 OFFSET " + book_id, String.class);
        String real_book_id = respRealBookId.get(0);
        List<String> response1 = connection.queryForList(
                "SELECT reserve_date FROM Borrowing WHERE user_id = ? AND book_id = ? AND return_date is null",
                String.class, user_id, real_book_id);
        String reserve_date = response1.get(0);
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String returnDate = sdf.format(date);
        connection.update("UPDATE Borrowing SET return_date = ? " +
                "WHERE user_id = ? AND book_id = ? AND return_date is null",
                new Object[]{returnDate, user_id, real_book_id});
        connection.update("UPDATE RegularUser " +
                "SET penalty_score = IF(DATEDIFF('" + returnDate + "', '" + reserve_date + "')>14, " +
                "penalty_score + DATEDIFF('" + returnDate + "', '" + reserve_date + "') , penalty_score) " +
                "WHERE user_id = ?", new Object[]{user_id});
        List<String> response2 = connection.queryForList("SELECT is_requested FROM Book WHERE book_id = ?",
                String.class, real_book_id);
        String is_requested = response2.get(0);

        // is_requested = false
        if(is_requested.equals("0"))
        {
            connection.update("UPDATE Book SET is_available = true WHERE book_id = ?",
                    new Object[]{real_book_id});
        }

        // is_requested = true
        else
        {
            List<String> response3 = connection.queryForList("SELECT requester_id FROM Book WHERE book_id = ?",
                    String.class, real_book_id);
            String requester_id = response3.get(0);
            borrowBook(String.valueOf(Integer.parseInt(real_book_id)-1), Integer.parseInt(requester_id));
            connection.update("UPDATE Book SET borrowed_times = borrowed_times+1, requester_id = null, is_requested = false " +
                    "WHERE book_id = " + real_book_id);
        }
    }
}
