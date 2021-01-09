<%--
  Created by IntelliJ IDEA.
  User: Uygar KAYA and Tuna TUNCER
  Date: 8.01.2021
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register to System</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if(username == null)
    {
%>
<header>
    <p>
        <a href="/login"> Login</a>
        |
        <a href="/register"> Register</a>
    </p>
</header>
<p style="color: red">${errorMessage}</p>
<form method="post">
    Name: <input type="text" name="name"/>
    Surname: <input type="text" name="surname"/>
    Username: <input type="text" name="username"/>
    Password: <input type="password" name="password"/>
    Password Again: <input type="password" name="password_again"/>
    <input type="submit" value="Register"/>
</form>
<% } else { %>
<p> You are logged in as: <%= username %> </p>
<a href="/logout">Logout</a>
<% } %>
</body>
</html>