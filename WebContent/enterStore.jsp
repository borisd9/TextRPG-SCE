<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>


<div id="main">
  <jsp:include page="header.jsp"/>
  <div id="content">
  	<%
    	String loggedIn = (String)session.getAttribute("username");
    	if(loggedIn != null){
    %>
    
    <br/><br/>
    <div>
		<jsp:include page="store.jsp" />
	</div>
  
    
	<% 
    	} else{
	%>  
	
	
	<b> You have to log in to purchase items from store! </b><br/>
	<b> Click <a href="login.jsp">here</a> to log in.</b>
	<center><h1>Online Store </h1></center>
	<center>  <img src="images/rsz_slots_club_iap.jpg"/></center>
	<% } %>

	
	</div>
	
		  <jsp:include page="footer.jsp" />
	
</div>
</body>
</html>