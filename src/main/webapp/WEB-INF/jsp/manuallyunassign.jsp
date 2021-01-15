<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manually Unassign</title>
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
        <a href="/manuallyunassign">Manually Unassign</a>
        |
        <a href="/displayoverdue">Display Overdue Books & Borrowers</a>
        |
        <a href="/statistics">Statistics</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<form method="post">
    <%
        String[][] itemData = (String[][]) session.getAttribute("itemData");
        if(itemData.length == 0){
    %>
    <p style="color: red">There is no borrowing to unassign</p>
    <%}else{%>
    Borrowing ID, Book ID, User ID
    <select name="borrowing_id">
        <% int i = 0; for(String[] item : itemData){ %>
        <option value="<%=i%>" name="<%=i%>"><%=item[0] + ", " + item[1] + ", " + item[2] %></option>
        <%++i; }%>
    </select>
    <input type="submit" value="Unassign"/>
    <%}%>
</form>
</body>
</html>
