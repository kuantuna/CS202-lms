<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Request Book Addition</title>
</head>
<body>
<header>
    <p>
        <a href="/index">Main Page</a>
        |
        <a href="/displaybookinfo">Display Book Info</a>
        |
        <a href="/addrequest">Add Request</a>
        |
        <a href="/removerequest">Remove Request</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<p style="color: red">${errorMessage}</p>
<form method="post">
    <%
        String[][] data = (String[][]) session.getAttribute("itemData");
        if(data.length==0){
    %>
    <p style="color: red">There is no book to remove request</p>
    <%}else{%>
    <label>Choose a Book which you want to remove :</label>
    <select name="removeRequestedBook" id="book">
        <%  int i=0; for(String[] item : data)
        {
        %>
        <option value="<%=i%>" name="<%=i%>"><%=item[0]%></option>
        <%++i;%>
        <%  } %>
    </select>
    <br><br>
    <input type="submit" value="Submit" />
    <%}%>
</form>
</body>
</html>