<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Book</title>
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
        <a href="/logout">Logout</a>
    </p>
</header>
    <p style="color: red">${errorMessage}</p>
    <form method="post">
        Title <input type="text" name="title"/>

        <% String[][] publisherData = (String[][]) session.getAttribute("publisherData");
            if(publisherData.length == 0){
        %>
        <p style="color: red">There is no publisher to add</p>
        <%}else{%>
        Publisher Name
        <select name="publisher_id">

            <% int i = 0; for(String[] item : publisherData){ %>
            <option value="<%=i%>" name="<%=i%>"><%=item[0]%></option>
            <%++i; }%>
        </select>
        <%}%>

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
        <input type="submit" value="Add">
    </form>
</body>
</html>
