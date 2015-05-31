<!DOCTYPE html>
<html >
<head>
<title>TextBased RPG </title>
<style type="text/css">
        input#chat {
            width: 450px
        }

        #console-container {
            width: 441px;
        }

        #console {
            border: 2px solid #CCCCCC;
            border-right-color: #999999;
            border-bottom-color: #999999;
            height: 350px;
            overflow-y: scroll;
            padding: 5px;
            width: 100%;
        }

        #console p {
            padding: 0;
            margin: 0;
        }
    </style>
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
    <div id="left">
    <b> Game </b>
    <br/><br/>
    <div>
		<jsp:include page="game_console.jsp" />
	</div>
    <br/><b> Chat </b>
    <br/><br/>
    
    
	<% 
    	} else{
	%>  
	<b> You have to log in to chat and play the game! </b><br/>
	<b> Click <a href="login.jsp">here</a> to log in.</b>
	
	<% } %>
	<div>
		<jsp:include page="chat.jsp" />
	</div>
	<br/>
	<br/><br/><br/><br/><br/>
	</div>
	  <jsp:include page="footer.jsp" />
	</div>
</div>
</body>

</html>
