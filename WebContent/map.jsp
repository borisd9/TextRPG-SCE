<!DOCTYPE html>
<%@page import="Database.MapDB"%>
<% MapDB map = new MapDB();
map.test();
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="styles.css" rel="stylesheet" type="text/css" />
<title>Map</title>
</head>
<body>
<a href="home.jsp">Back to Home page</a>

<div style="background: url('images/worldMap.png'); width:650px; height:500px; position: relative;">
    <img src="images/pin.gif" title="<%= map.location %>" style="position: relative; top:<%= map.y %>px; left:<%= map.x %>px; width:90px; height:70px;">
</div>

For testing<br>
DB connections: <%= map.printDataSourceStats() %>

</body>
</html>
