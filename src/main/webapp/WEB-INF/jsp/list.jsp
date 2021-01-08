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
