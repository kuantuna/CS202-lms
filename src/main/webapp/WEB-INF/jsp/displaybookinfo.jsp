<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Display Book Information</title>
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
            <a href="/displaybookinfo">Display Borrowings</a>
            |
            <a href="/logout">Logout</a>
        </p>
    </header>
<% } else if(privilegeLevel.equals("Publisher")) {%>
    <header>
        <p>
            <a href="/index">Main Page</a>
            |
            <a href="/displaybookinfo">Display Borrowings</a>
            |
            <a href="/logout">Logout</a>
        </p>
    </header>
<% } else { %>
    <header>
        <p>
            <a href="/index">Main Page</a>
            |
            <a href="/displaybookinfo">Display Book Info</a>
            |
            <a href="/logout">Logout</a>
        </p>
    </header>
<% } %>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Author</th><th>Topic</th><th>Genre</th>
        <th>Publication Date</th><th>Availability Status</th><th>Requested Status</th>
        <%= privilegeLevel.equals("LibraryManager") ?  "<th>Add Requested</th><th>Remove Requested</th>" : "" %>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        if(data!=null)
        {
            for(String[] item : data)
            {
                if(item[8].equals("1"))
                {
    %>
        <tr>
            <td> <%= item[0] %></td><td> <%= item[1] %></td><td> <%= item[2] %></td><td> <%= item[3] %></td><td> <%= item[4] %></td>
            <td> <%= item[5] %></td><td> <%= item[6].equals("1") ? "Available" : "Not Available" %></td>
            <td> <%= item[7].equals("1") ? "Requested" : "Not Requested" %></td>
            <%= privilegeLevel.equals("LibraryManager") ? "<td>-</td>" : ""%>
            <%= privilegeLevel.equals("LibraryManager") ? (item[9].equals("1") ? "<td>Requested</td>" : "<td>-</td>"): ""%>
        </tr>
    <%          }
                else if(privilegeLevel.equals("LibraryManager")){ // If enters here, then it means that book doesn't exist, it is add requested.
    %>
        <tr>
            <td> <%= item[0] %></td><td> <%= item[1] %></td><td> <%= item[2] %></td><td> <%= item[3] %></td><td> <%= item[4] %></td>
            <td> <%= item[5] %></td><td> <%= item[6].equals("1") ? "Available" : "Not Available" %></td>
            <td> <%= item[7].equals("1") ? "Requested" : "Not Requested" %> </td> <td>Add Requested</td>
            <td> <%= item[9].equals("1") ? "Remove Requested" : "-" %> </td>
        </tr>
    <%
                }
            }
        }
    %>
</table>
</body>
</html>
