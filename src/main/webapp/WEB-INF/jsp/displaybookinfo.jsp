<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.tomcat.util.buf.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String[][] data = (String[][]) session.getAttribute("itemData");
    String privilegeLevel = (String) session.getAttribute("level");
    if(privilegeLevel.equals("LibraryManager")) {
%>
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
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher ID</th><th>Publisher Name</th><th>Author Name</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th><th>Remove Requested</th><th>Add Requested</th><th>Borrowed Times</th>
    </tr>
    <%
        int temp = 0;
        for(String[] item : data)
        {
            if(temp==Integer.parseInt(item[0])){ }
            else{
                temp = Integer.parseInt(item[0]);
                ArrayList<String> genres = new ArrayList<>();
                ArrayList<String> topics = new ArrayList<>();
                ArrayList<String> authors = new ArrayList<>();
                for(String[] it : data){
                    if(item[0].equals(it[0])){
                        if(!genres.contains(" "+it[7])){ genres.add(" "+it[7]); }
                        if(!topics.contains(" "+it[6])){ topics.add(" "+it[6]); }
                        if(!authors.contains(" "+it[4]+" "+it[5])){ authors.add(" "+it[4]+" "+it[5]); }
                    }
                }
    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[2] %></td>  <td><%= item[3] %></td>
        <td><%= StringUtils.join(authors, ',') %></td>
        <td><%= StringUtils.join(topics, ',') %></td> <td><%= StringUtils.join(genres, ',') %></td>
        <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
        <%= item[11].equals("1") ? "<td>Remove Requested</td>" : "<td>-</td>" %>
        <%= item[12].equals("1") ? "<td>-</td>" : "<td>Add Requested</td>" %>
        <td><%=item[13]%></td>
    </tr>
    <%
            }
        } %>

</table>
<%
}else if(privilegeLevel.equals("Publisher")) {
%>
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
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher Name</th><th>Author Name</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th><th>Remove Requested</th><th>Add Requested</th><th>Borrowed Times</th>
    </tr>
    <%
        int temp = 0;
        for(String[] item : data)
        {
            if(temp==Integer.parseInt(item[0])){ }
            else{
                temp = Integer.parseInt(item[0]);
                if(item[12].equals("0") && !(session.getAttribute("userId").toString().equals(item[2]))){  }
                else{
                    ArrayList<String> genres = new ArrayList<>();
                    ArrayList<String> topics = new ArrayList<>();
                    ArrayList<String> authors = new ArrayList<>();
                    for(String[] it : data){
                        if(item[0].equals(it[0])){
                            if(!genres.contains(" "+it[7])){ genres.add(" "+it[7]); }
                            if(!topics.contains(" "+it[6])){ topics.add(" "+it[6]); }
                            if(!authors.contains(" "+it[4]+" "+it[5])){ authors.add(" "+it[4]+" "+it[5]); }
                        }
                    }
    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[3] %></td>
        <td><%= StringUtils.join(authors, ',') %></td>
        <td><%= StringUtils.join(topics, ',') %></td> <td><%= StringUtils.join(genres, ',') %></td>
        <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
        <%= item[11].equals("1") ? "<td>Remove Requested</td>" : "<td>-</td>" %>
        <%= item[12].equals("1") ? "<td>-</td>" : "<td>Add Requested</td>" %>
        <%= session.getAttribute("userId").toString().equals(item[2]) ? "<td>" + item[13] + "</td>" : "<td>-</td>" %>
    </tr>
    <%          }
            }
        }
    %>
</table>
<%
}else if(privilegeLevel.equals("RegularUser")) {
%>
<header>
    <p>
        <a href="/index">Main Page</a>
        |
        <a href="/displaybookinfo">Display Book Info</a>
        |
        <a href="/displayborrowings">Display Borrowings</a>
        |
        <a href="/returnbook">Return a Book</a>
        |
        <a href="/logout">Logout</a>
    </p>
</header>
<table border="1">
    <tr>
        <th>Book ID</th><th>Title</th><th>Publisher Name</th><th>Author Name</th>
        <th>Topic Name</th><th>Genre Name</th><th>Publication Date</th><th>Availability Status</th>
        <th>Is Requested</th>
    </tr>
    <%
        int temp = 0;
        for(String[] item : data)
        {
            if(temp==Integer.parseInt(item[0])){ }
            else{
                temp = Integer.parseInt(item[0]);
                if(item[12].equals("0")){  }
                else{
                    ArrayList<String> genres = new ArrayList<>();
                    ArrayList<String> topics = new ArrayList<>();
                    ArrayList<String> authors = new ArrayList<>();
                    for(String[] it : data){
                        if(item[0].equals(it[0])){
                            if(!genres.contains(" "+it[7])){ genres.add(" "+it[7]); }
                            if(!topics.contains(" "+it[6])){ topics.add(" "+it[6]); }
                            if(!authors.contains(" "+it[4]+" "+it[5])){ authors.add(" "+it[4]+" "+it[5]); }
                        }
                    }
    %>
    <tr>
        <td><%= item[0] %></td> <td><%= item[1] %></td> <td><%= item[3] %></td>
        <td><%= StringUtils.join(authors, ',') %></td>
        <td><%= StringUtils.join(topics, ',') %></td> <td><%= StringUtils.join(genres, ',') %></td>
        </td> <td><%=item[8]%></td>
        <td><%= item[9].equals("1") ? "Available" : "Not Available" %></td>
        <%= item[10].equals("1") ? "<td>Requested</td>" : "<td>Not Requested</td>" %>
    </tr>
    <%
            }
        }
    }
    %>
</table>
<%}%>
</body>
</html>
