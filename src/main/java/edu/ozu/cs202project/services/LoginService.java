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

    public boolean validate(String username, String password)
    {
        List<Map<String, Object>> response =  connection.queryForList(
                "SELECT * FROM AuthenticationSystem WHERE usernames = ? AND passwords = ?",
                new Object[]{username, password});
        return response.size() == 1;
    }

    public boolean userExist(String username)
    {
        List<Map<String, Object>> response =  connection.queryForList(
                "SELECT * FROM AuthenticationSystem WHERE usernames = ? ", new Object[]{username});
        return response.size() == 1;
    }

    public void insertRegularUser(String firstName, String lastName, String username, String password)
    {
        connection.update("INSERT INTO users (PrivilegeLevel) VALUES (" + "'RegularUser'" +")");

        List<Integer> response =  connection.queryForList(
                "SELECT MAX(UserID) FROM users WHERE PrivilegeLevel = 'RegularUser' ", Integer.class);
        int userID = response.get(0);

        connection.update("INSERT INTO regularuser (UserID, FirstName, LastName) VALUES (?, ?, ?)",
                new Object[]{userID , firstName, lastName});

        connection.update("INSERT INTO AuthenticationSystem (UserID, Usernames, Passwords) VALUES (?, ?, ?)",
                new Object[]{userID , username, password});
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
}
