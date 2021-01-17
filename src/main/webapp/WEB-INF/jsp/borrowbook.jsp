<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrow Book</title>
</head>
<body>
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
<form method="post">
    <% String[][] bookData = (String[][]) session.getAttribute("bookData");
        if(bookData.length == 0){
    %>
    <p style="color: red">There is no book to borrow</p>
    <%}else{%>
    Books
    <select name="book_id">
        <% int i = 0; for(String[] book : bookData){ if(book[1].equals("1")){ %>
        <option value="<%=i%>" name="<%=i%>"><%=book[0]%></option>
        <%} ++i; }%>
    </select>
    <input type="submit" value="Borrow"/>
    <%}%>
</form>
</body>
</html>
