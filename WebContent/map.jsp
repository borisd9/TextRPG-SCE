
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="Database.MapDB" %>
<% MapDB map = new MapDB();
map.update();
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="styles.css" rel="stylesheet" type="text/css" />
<title>Map</title>
</head>
<body>
<a href="home.jsp">Back to Home page</a>

<div style="background: url('images/worldMap.png'); width:450px; height:350px; position: relative;">
    <img src="images/pinV2.gif" title="<%= map.getLocation() %>" style="position: relative; top:<%= map.gety() %>px; left:<%= map.getx() %>px; width:90px; height:70px;">
</div>

For testing<br>
DB connections: <%= map.getDataSourceStats() %>

</body>
</html>
