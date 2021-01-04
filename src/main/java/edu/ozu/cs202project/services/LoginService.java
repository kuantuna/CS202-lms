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
}
