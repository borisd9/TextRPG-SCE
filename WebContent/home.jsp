<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="main">
  <jsp:include page="header.jsp"/>
  
  <div id="content">
    <jsp:include page="sidebar.jsp"/>
    <div id="left">
    
    <%
   		String err = request.getParameter("err");
      	if(err!=null){
      		if(err.equals("1")){
    %>
    <font color="green"><b>You have successfully logged out!!</b></font>
    <br>
    <br>
	<%  
      		}
      	}
    %>
  
      <center><h1>Welcome to TextRPG!<br/>A Free Online RPG</h1></center>
      <br/>
      <div>
        <p>Text RPG has been a gathering place for fans since April 2015. It is a free role playing game (RPG), where players can catch, train, and trade their own characters. Players can also challenge other players to battles in order to earn points, attempt to conquer the Champions Tournament, obtain rare promotional characters, and train their characters to levels above 100! Also, players can purchase premium items from our Online Store. Here at Text RPG, the impossible becomes possible!  <br />
          <br/>
          Don't forget to sign up on our website, and join the chat. Also check out the Game Guide for information about the game! <br />
		  So what are you waiting for? Sign up and start your journey today!

      </div>
      <br/><br/><br/> 
      <a style="font-size: 100%" href="register.jsp">New User? Register Here</a>
    </div>
  </div>
  
  <jsp:include page="footer.jsp" />
</div>
</html>
