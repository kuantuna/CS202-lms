package edu.ozu.cs202project.configurations;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
public class Database
{
    @Bean
    public DataSource MySQLDataSource()
    {
        DriverManagerDataSource source = new DriverManagerDataSource();
        source.setDriverClassName("com.mysql.cj.jdbc.Driver");
        //source.setUrl("jdbc:mysql://localhost:3306/librarymanagementsystem");
        source.setUrl("jdbc:mysql://localhost:3306/librarymanagementsystem?useUnicode=true&useLegacyDatetimeCode=false&serverTimezone=Turkey");
        source.setUsername(System.getenv("UNAME"));
        source.setPassword(System.getenv("PWORD"));
        // This username and password are for our main account
        // If needed we can add for all user types in different functions
        return source;
    }
}
