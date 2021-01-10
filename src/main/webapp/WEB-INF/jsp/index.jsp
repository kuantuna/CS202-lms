<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LibraryManagementSystem</title>
</head>
<%
    String privilegeLevel = (String) session.getAttribute("level");
    if(privilegeLevel.equals("LibraryManager")) {
%>
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
    <p>Hello Library Manager!</p>
</body>
<%
    } else if(privilegeLevel.equals("Publisher")){
%>
<body>
    <header>
        <p>
            <a href="/index">Main Page</a>
            |
            <a href="/displaybookinfo">Display Book Info</a>
            |
            <a href="/logout">Logout</a>
        </p>
    </header>
    <p>Hello Publisher!</p>
    <a href="/logout">Logout</a>
</body>
<%
    } else{
%>
<body>
    <header>
        <p>
            <a href="/index">Main Page</a>
            |
            <a href="/displaybookinfo">Display Book Info</a>
            |
            <a href="/logout">Logout</a>
        </p>
    </header>
    <p>Hello Regular User!</p>
    <a href="/logout">Logout</a>
</body>
<%
    }
%>
</html>
