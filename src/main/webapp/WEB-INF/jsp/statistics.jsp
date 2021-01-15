<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Statistics</title>
</head>
<body>
<%
    String privilegeLevel = (String) session.getAttribute("level");
    if(privilegeLevel.equals("LibraryManager")){
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
        <a href="/manuallyassign">Manually Assign</a>
        |
        <a href="/manuallyunassign">Manually Unassign</a>
        |
        <a href="/displayoverdue">Display Overdue Books & Borrowers</a>
        |
        <a href="/statistics">Statistics</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<%
    String[][] mostBorrowedGenres = (String[][]) session.getAttribute("mostBorrowedGenres");
    if(mostBorrowedGenres==null){ }
    else{
%>
<h1>Most Borrowed Book Genres:</h1><br>
<table border="1">
    <tr>
        <th>Genre</th><th>Borrowed Times</th>
    </tr>
    <%
        for(String[] item : mostBorrowedGenres){
    %>
    <tr>
        <td><%=item[0]%></td><td><%=item[1]%></td>
    </tr>
    <%}%>
</table>
<%}%>

<%
    String[][] mostBorrowedBooks3m = (String[][]) session.getAttribute("mostBorrowedBooks3m");
    if(mostBorrowedGenres==null){ }
    else{
%>
<h1>Most Borrowed Books on last 3 months:</h1><br>
<table border="1">
    <tr>
        <th>Book Name</th><th>Borrowed Times</th>
    </tr>
    <%
        for(String[] item : mostBorrowedBooks3m){
    %>
    <tr>
        <td><%=item[0]%></td><td><%=item[1]%></td>
    </tr>
    <%}%>
</table>
<%}%>

<%
    String[][] mostBorrowedPublishers = (String[][]) session.getAttribute("mostBorrowedPublishers");
    if(mostBorrowedPublishers==null){ }
    else{
%>
<h1>Most Borrowed Publishers:</h1><br>
<table border="1">
    <tr>
        <th>Publisher Name</th><th>Borrowed Times</th>
    </tr>
    <%
        for(String[] item : mostBorrowedPublishers){
    %>
    <tr>
        <td><%=item[0]%></td><td><%=item[1]%></td>
    </tr>
    <%}%>
</table>
<%}%>

<%
    String numberOfOverdueBooks = (String) session.getAttribute("numberOfOverdueBooks");
    if(numberOfOverdueBooks==null){ }
    else{
%>
<h1>Number of overdue Books:</h1><br>
<table border="1">
    <tr>
        <th>Count</th>
    </tr>
    <tr>
        <td><%=numberOfOverdueBooks%></td>
    </tr>
</table>
<%}%>

<% }else if(privilegeLevel.equals("RegularUser")){ %>
<header>
    <p>
        <a href="/index">Main Page</a>
        |
        <a href="/displaybookinfo">Display Book Info</a>
        |
        <a href="/displayborrowings">Display Borrowings</a>
        |
        <a href="/borrowbook">Borrow a Book</a>
        |
        <a href="/returnbook">Return a Book</a>
        |
        <a href="/statistics">Statistics</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<% } %>
</body>
</html>
