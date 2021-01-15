<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manually Assign</title>
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
        <a href="/manuallyassign">Manually Assign</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<form method="post">
    <%
        String[][] bookData = (String[][]) session.getAttribute("bookData");
        String[][] userData = (String[][]) session.getAttribute("userData");
        if(bookData.length == 0 && userData.length == 0){
    %>
    <p style="color: red">There is no book or user to assign</p>
    <%}else{%>
    Book ID
    <select name="book_id">
        <% int i = 0; for(String[] book : bookData){ %>
        <option value="<%=i%>" name="<%=i%>"><%=book[0]%></option>
        <%++i; }%>
    </select>
    User ID
    <select name="user_id">
        <% int j = 0; for(String[] user : userData){ %>
        <option value="<%=j%>" name="<%=j%>"><%=user[0]%></option>
        <%++j; }%>
    </select>
    <input type="submit" value="Assign"/>
    <%}%>
</form>
</body>
</html>
