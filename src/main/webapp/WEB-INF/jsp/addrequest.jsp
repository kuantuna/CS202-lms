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
        <a href="/addrequest">Add Book Request</a>
        |
        <a href="/removerequest">Remove Book Request</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<p style="color: red">${errorMessage}</p>
<form method="post">
    Title <input type="text" name="title"/>
    Publication Date <input type="datetime-local" name="publication_date"/>

    <%// GENRES %>
    <% String[][] genreData = (String[][]) session.getAttribute("genreData");
        if(genreData.length == 0){
    %>
    <p style="color: red">There is no genre to add</p>
    <%}else{%>
    Genre
    <select name="genre_id" multiple>

        <% int i = 0; for(String[] item : genreData){ %>
        <option value="<%=i%>" name="<%=i%>"><%=item[0]%></option>
        <%++i; }%>
    </select>
    <%}%>

    <%// TOPICS %>
    <% String[][] topicData = (String[][]) session.getAttribute("topicData");
        if(topicData.length == 0){
    %>
    <p style="color: red">There is no topic to add</p>
    <%}else{%>
    Topic
    <select name="topic_id" multiple>

        <% int i = 0; for(String[] item : topicData){ %>
        <option value="<%=i%>" name="<%=i%>"><%=item[0]%></option>
        <%++i; }%>
    </select>
    <%}%>

    <%// AUTHORS %>
    <% String[][] authorData = (String[][]) session.getAttribute("authorData");
        if(authorData.length == 0){
    %>
    <p style="color: red">There is no author to add</p>
    <%}else{%>
    Author
    <select name="author_id" multiple>
        <% int i = 0; for(String[] item : authorData){ %>
        <option value="<%=i%>" name="<%=i%>"><%=item[0]%></option>
        <%++i; }%>
    </select>
    <%}%>

    <input type="submit" value="Submit" />
</form>
</body>
</html>
