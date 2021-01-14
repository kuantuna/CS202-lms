<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Book</title>
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
        Title <input type="text" name="title"/>
        Author <input type="text" name="author"/>
        Topic <input type="text" name="topic"/>
        Genre <input type="text" name="genre"/>
        Publisher Id <input type="text" name="publisher_id"/>
        <input type="submit" value="Add">
    </form>
</body>
</html>
