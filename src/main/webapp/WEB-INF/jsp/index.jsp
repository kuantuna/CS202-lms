<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LibraryManagementSystem</title>
</head>
<%
    String privilegeLevel = (String) session.getAttribute("level");
    if(privilegeLevel.equals("LibraryManager")) {
%>
<body>
    <p>Hello Library Manager!</p>
    <a href="/logout">Logout</a>
</body>
<%
    } else if(privilegeLevel.equals("Publisher")){
%>
<body>
    <p>Hello Publisher!</p>
    <a href="/logout">Logout</a>
</body>
<%
    } else{
%>
<body>
    <p>Hello Regular User!</p>
    <a href="/logout">Logout</a>
</body>
<%
    }
%>
</html>
