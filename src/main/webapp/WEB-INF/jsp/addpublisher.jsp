<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Publisher</title>
</head>
<body>
    <header>
        <p>
            <a href="/index">Main Page</a>
            |
            <a href="/addpublisher">Add Publisher</a>
            |
            <a href="/displayborrowings">Display Borrowings</a>
            |
            <a href="/displaybookinfo">Display Book Info</a>
            |
            <a href="/addbook">Add Book</a>
            |
            <a href="/logout">Logout</a>
        </p>
    </header>
    <p style="color: red">${errorMessage}</p>
    <form method="post">
        Publisher Name: <input type="text" name="name"/>
        Username: <input type="text" name="username"/>
        Password: <input type="password" name="password"/>
        Password Again: <input type="password" name="password_again"/>
        <input type="submit" value="Save" />
    </form>
</body>
</html>
