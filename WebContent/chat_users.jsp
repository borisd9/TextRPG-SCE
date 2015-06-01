<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
    
<%@ page import = "General.SessionListener"%>
<%@ page import= "java.util.List" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="styles.css" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<title>Chat Users</title>

<style type="text/css">
         #online {
            border: 2px solid #CCCCCC;
            border-right-color: #999999;
            border-bottom-color: #999999;
            height: 170px;
            overflow-y: scroll;
            padding: 5px;
            width: 100px;
        }

</style>
</head>

<body>
<div id = "online">
<%

	SessionListener sl = (SessionListener) session.getAttribute("online");
	List<String> users = sl.getList();
	if(users!=null){
		for(String u: users){
			String Logout = "LogoutServlet?param="+u+"";
%>

  <ul class="nav nav-tabs">
    <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%=u %><span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a href="#">Kick</a></li>
        <li><a href="#">Ban</a></li>
        <li><a href="#">Battle</a></li>                        
      </ul>
    </li>
  </ul>

<%-- <button id="usersbtn" type="button" onclick="RightMouseDown()"><%= u %></button>
--%>
<%
		}
	}
	
%>
</div>


</body>
</html>