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

<%
    String[][] infoOfUsersWhoBorrowedMostBorrowedBook = (String[][]) session.getAttribute("infoOfUsersWhoBorrowedMostBorrowedBook");
    if(mostBorrowedPublishers==null){ }
    else{
%>
<h1>Information of Users Who Borrowed the Most Borrowed Books:</h1><br>
<table border="1">
    <tr>
        <th>User ID</th><th>First Name</th><th>Last Name</th>
    </tr>
    <%
        for(String[] item : infoOfUsersWhoBorrowedMostBorrowedBook){
    %>
    <tr>
        <td><%=item[0]%></td><td><%=item[1]%></td><td><%=item[2]%></td>
    </tr>
    <%}%>
</table>
<%}%>

<%
    String[][] countOfBookOverdue = (String[][]) session.getAttribute("countOfBookOverdue");
    if(countOfBookOverdue==null){ }
    else{
%>
<h1>Count of Book Overdue:</h1><br>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Count</th>
    </tr>
    <%
        for(String[] item : countOfBookOverdue){
    %>
    <tr>
        <td><%=item[0]%></td><td><%=item[1]%></td><td><%=item[2]%></td>
    </tr>
    <%}%>
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
<%
    String numberOfOverdueBooks = (String) session.getAttribute("numberOfOverdueBooks");
    if(numberOfOverdueBooks==null){ }
    else{
%>
<h1>Total number of books that are and were overdue:</h1><br>
<table border="1">
    <tr>
        <th>Count</th>
    </tr>
    <tr>
        <td><%=numberOfOverdueBooks%></td>
    </tr>
</table>
<%}%>

<%
    String numberOfBooksBooked = (String) session.getAttribute("numberOfBooksBooked");
    if(numberOfBooksBooked==null){ }
    else{
%>
<h1>Total number of books that are booked:</h1><br>
<table border="1">
    <tr>
        <th>Count</th>
    </tr>
    <tr>
        <td><%=numberOfBooksBooked%></td>
    </tr>
</table>
<%}%>

<%
    String[][] favouriteGenreInfo = (String[][]) session.getAttribute("favouriteGenreInfo");
    if(favouriteGenreInfo==null){ }
    else{
%>
<h1>Count of Book Overdue:</h1><br>
<table border="1">
    <tr>
        <th>Genre ID</th><th>Genre Name</th><th>Count</th>
    </tr>
    <%
        for(String[] item : favouriteGenreInfo){
    %>
    <tr>
        <td><%=item[0]%></td><td><%=item[1]%></td><td><%=item[2]%></td>
    </tr>
    <%}%>
</table>
<%}%>

<% } %>
</body>
</html>
