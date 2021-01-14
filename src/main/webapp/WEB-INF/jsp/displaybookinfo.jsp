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
        <a href="/displaybookinfo">Display Borrowings</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher Name</th><th>First Name</th><th>Last Name</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th><th>Remove Requested</th><th>Add Requested</th>
    </tr>
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        for(String[] item : data)
        {
    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[2] %></td> <td><%= item[3] %></td><td> <%= item[4] %></td>
        <td><%= item[5] %></td> <td><%= item[6] %></td> <td><%=item[7]%></td>
        <td><%= item[8].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[9].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
        <%= item[10].equals("1") ? "<td>Remove Requested</td>" : "<td>-</td>" %>
        <%= item[11].equals("1") ? "<td>-</td>" : "<td>Add Requested</td>" %>
    </tr>
    <%  } %>

</table>
<%
}else if(privilegeLevel.equals("Publisher")) {
%>

<%
}else if(privilegeLevel.equals("RegularUser")) {
%>

<%
}else if(privilegeLevel.equals("Author")){
%>

<%}%>
</body>
</html>
