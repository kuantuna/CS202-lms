<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5.01.2021
  Time: 00:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>List Items Page</title>
</head>
<body>
<%
    String[][] data = (String[][]) session.getAttribute("itemData");

    if(data != null)
    {
        for (String[] item : data)
        {
%>
            <p> <%= item[0] %> : <%= item[1] %> </p>
<%
        }
    }

%>
</body>
</html>
