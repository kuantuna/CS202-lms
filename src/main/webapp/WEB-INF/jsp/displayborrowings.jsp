<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Display Borrowings</title>
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
            <a href="/logout">Logout</a>
        </p>
    </header>
    <table border="1">
        <tr>
            <th>Borrowing ID</th><th>Book ID</th><th>Title</th><th>User ID</th><th>First Name</th>
            <th>Last Name</th><th>Reserve Date</th><th>Due Date</th><th>Return Date</th>
        </tr>
<%
    String[][] data = (String[][]) session.getAttribute("itemData");
    if(data != null)
    {
        for (String[] item : data)
        {
%>          <tr>
                <td> <%= item[0] %></td><td> <%= item[1] %></td><td> <%= item[2] %></td><td> <%= item[3] %></td><td> <%= item[4] %></td>
                <td> <%= item[5] %></td><td> <%= item[6] %></td><td> <%= item[7] %></td><td> <%= item[8]==null ? "Not yet returned" : item[8] %></td>
            </tr>
<%
        }
    }
%>
    </table>
</body>
</html>
