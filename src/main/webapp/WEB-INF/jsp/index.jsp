<%--
  Created by IntelliJ IDEA.
  User: Tuna
  Date: 1/4/2021
  Time: 2:31 PM
  To change this template use File | Settings | File Templates.
--%>
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
<% }
    else if(privilegeLevel.equals("Publisher")){
%>
<body>
<p>Hello Publisher!</p>
<a href="/logout">Logout</a>
</body>
<%
    }
    else{
%>
<body>
<p>Hello Regular User!</p>
<a href="/logout">Logout</a>
</body>
<%
    }
%>
</html>
