<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Book</title>
</head>
<body>
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
