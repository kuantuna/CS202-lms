package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

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
                "SELECT * FROM AuthenticationSystem WHERE usernames = ? AND passwords = ?",
                new Object[]{username, password});
        return response.size() == 1;
    }

    public boolean usernameExist(String username)
    {
        List<Map<String, Object>> response =  connection.queryForList(
                "SELECT * FROM AuthenticationSystem WHERE usernames = ? ", new Object[]{username});
        return response.size() == 1;
    }

    public Integer getUserId(String username)
    {
        List<Integer> response =  connection.queryForList(
                "SELECT userID FROM AuthenticationSystem WHERE usernames = ? ", Integer.class, username);
        return response.get(0);
    }

    public String getPrivilegeLevel(int userID)
    {
        List<String> response =  connection.queryForList(
                "SELECT PrivilegeLevel FROM Users WHERE userID = ? ",
                String.class, userID);
        return response.get(0);
    }

    public void insertRegularUser(String firstName, String lastName, String username, String password)
    {
        connection.update("INSERT INTO users (PrivilegeLevel) VALUES ('RegularUser')");

        List<Integer> response =  connection.queryForList(
                "SELECT MAX(UserID) FROM users WHERE PrivilegeLevel = 'RegularUser' ", Integer.class);
        int userID = response.get(0);

        connection.update("INSERT INTO regularuser (UserID, FirstName, LastName) VALUES (?, ?, ?)",
                new Object[]{userID , firstName, lastName});

        connection.update("INSERT INTO AuthenticationSystem (UserID, Usernames, Passwords) VALUES (?, ?, ?)",
                new Object[]{userID , username, password});
    }

    public void insertPublisher(String name, String username, String password)
    {
        connection.update("INSERT INTO users (PrivilegeLevel) VALUES ('Publisher')");

        List<Integer> response =  connection.queryForList(
                "SELECT MAX(UserID) FROM users WHERE PrivilegeLevel = 'Publisher' ", Integer.class);
        int userID = response.get(0);

        connection.update("INSERT INTO publisher (UserID, PublisherName) VALUES (?, ?)",
                new Object[]{userID , name});

        connection.update("INSERT INTO AuthenticationSystem (UserID, Usernames, Passwords) VALUES (?, ?, ?)",
                new Object[]{userID , username, password});
    }

    public List<String[]> displayBorrowings()
    {
        List<String[]> response =  connection.query(
                "SELECT * FROM BorrowingInfo NATURAL JOIN regularuser", (row, index) -> {
                    return new String[]{row.getString("BorrowingID"), row.getString("BookID"),
                            row.getString("Title"), row.getString("UserID"),
                            row.getString("FirstName"),row.getString("LastName"),
                            row.getString("ReserveDate"), row.getString("DueDate"),
                            row.getString("ReturnDate")};
                });
        return response;
    }

    public List<String[]> displayBookInformation()
    {
        List<String[]> response =  connection.query("SELECT * FROM book NATURAL JOIN publisherbook " +
                "NATURAL JOIN publisher", (row, index) -> {
            return new String[]{row.getString("BookID"), row.getString("PublisherName"),
                    row.getString("Title"),row.getString("Author"), row.getString("Topic"),
                    row.getString("Genre"),row.getString("PublicationDate"),
                    row.getString("IsAvailable"), row.getString("IsRequested"),
                    row.getString("IsExist"), row.getString("RemoveRequested"),
                    row.getString("UserID")};
        });
        return response;
    }
}
