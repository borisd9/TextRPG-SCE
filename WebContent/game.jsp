<!DOCTYPE html>
<html >
<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="game">
  <jsp:include page="header.jsp"/>
  <div id="content">
  	<jsp:include page="sidebar.jsp"/>
  	<div id="left">
    <b> Game </b>
    <br/><br/>
    <b> Chat </b>
    <br/><br/>
    <%
    	String loggedIn = (String)session.getAttribute("username");
    	if(loggedIn != null){
    %>
    <div>
    	<jsp:include page="chat.jsp" />
	</div>
	<% } %>  
	<br/>

	<br/><br/><br/><br/><br/>
	</div>
	</div>
  <jsp:include page="footer.jsp" />
</div>
</body>

</html>
