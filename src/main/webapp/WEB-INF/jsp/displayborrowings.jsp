<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Display Borrowings</title>
</head>
<body>
<%
    String privilegeLevel = (String) session.getAttribute("level");
    if(privilegeLevel.equals("LibraryManager")) {
%>
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
        <a href="/removebook">Remove Book</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
    <table border="1">
        <tr>
            <th>Borrowing ID</th><th>Book ID</th><th>Title</th><th>User ID</th><th>User Name</th>
            <th>User Surname</th><th>Reserve Date</th><th>Return Date</th>
        </tr>
<%
    String[][] data = (String[][]) session.getAttribute("itemData");
    if(data != null)
    {
        for (String[] item : data)
        {
%>          <tr>
                <td> <%= item[0] %></td><td> <%= item[1] %></td><td> <%= item[2] %></td><td> <%= item[3] %></td><td> <%= item[4] %></td>
                <td> <%= item[5] %></td><td> <%= item[6] %></td><td> <%= item[7]==null ? "Not yet returned" : item[7] %></td>
            </tr>
<%
        }
    }
%>
    </table>
<%
    }else if(privilegeLevel.equals("RegularUser")) {
%>
<header>
    <p>
        <a href="/index">Main Page</a>
        |
        <a href="/displaybookinfo">Display Book Info</a>
        |
        <a href="/displayborrowings">Display Borrowings</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Reserve Date</th><th>Return Date</th>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        if(data != null)
        {
            for (String[] item : data)
            {
                if(session.getAttribute("userId").toString().equals(item[3])){
    %>
    <tr>
        <td> <%= item[1] %></td><td> <%= item[2] %></td><td>
        <%= item[6] %></td><td> <%= item[7]==null ? "Not yet returned" : item[7] %></td>
    </tr>
    <%          }
            }
        }
    %>
</table>
<%}%>
</body>
</html>
