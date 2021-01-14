<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
        <a href="/logout">Logout</a>
    </p>
</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher ID</th><th>Publisher Name</th><th>First Name</th><th>Last Name</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th><th>Remove Requested</th><th>Add Requested</th>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        for(String[] item : data)
        {
    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[2] %></td>  <td><%= item[3] %></td>
        <td><%= item[4] %></td><td> <%= item[5] %></td>
        <td><%= item[6] %></td> <td><%= item[7] %></td> <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
        <%= item[11].equals("1") ? "<td>Remove Requested</td>" : "<td>-</td>" %>
        <%= item[12].equals("1") ? "<td>-</td>" : "<td>Add Requested</td>" %>
    </tr>
    <%  } %>

</table>
<%
}else if(privilegeLevel.equals("Publisher")) {
%>
<header>
    <p>
        <a href="/index">Main Page</a>
        |
        <a href="/displaybookinfo">Display Book Info</a>
        |
        <a href="/addrequest">Add Book Request</a>
        |
        <a href="/removerequest">Remove Book Request</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher Name</th><th>Author Name</th><th>Author Surname</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th><th>Remove Requested</th><th>Add Requested</th>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        for(String[] item : data)
        {
            if(item[12].equals("0") && !(session.getAttribute("userId").toString().equals(item[2]))){ }
            else{
    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[3] %></td>
        <td><%= item[4] %></td> <td> <%= item[5] %></td>
        <td><%= item[6] %></td> <td><%= item[7] %></td> <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
        <%= item[11].equals("1") ? "<td>Remove Requested</td>" : "<td>-</td>" %>
        <%= item[12].equals("1") ? "<td>-</td>" : "<td>Add Requested</td>" %>
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
        <a href="/logout">Logout</a>
    </p>
</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher Name</th><th>Author Name</th><th>Author Surname</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        for(String[] item : data)
        {
            if(item[12].equals("0")){ }
            else
            {

    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[3] %></td>
        <td><%= item[4] %></td> <td> <%= item[5] %></td>
        <td><%= item[6] %></td> <td><%= item[7] %></td> <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
    </tr>
    <%
            }
        }
    %>
</table>
<%
}else if(privilegeLevel.equals("Author")){
%>
<header>

</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher Name</th><th>Author Name</th><th>Author Surname</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        for(String[] item : data)
        {
            if(item[12].equals("0")){ }
            else
            {

    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[3] %></td>
        <td><%= item[4] %></td> <td> <%= item[5] %></td>
        <td><%= item[6] %></td> <td><%= item[7] %></td> <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
    </tr>
    <%
            }
        }
    %>
</table>
<%}%>
</body>
</html>
