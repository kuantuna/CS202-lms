<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove Book</title>
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
        <a href="/removebook">Remove Book</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<form method="post">
    <% String[][] bookData = (String[][]) session.getAttribute("bookData");
        if(bookData.length == 0){
    %>
    <p style="color: red">There is no book to remove</p>
    <%}else{%>
    Books
    <select name="book_id">
        <% int i = 0; for(String[] book : bookData){ %>
        <option value="<%=i%>" name="<%=i%>"><%=book[0]%></option>
        <%++i; }%>
    </select>
    <input type="submit" value="Remove"/>
    <%}%>
</form>
</body>
</html>
