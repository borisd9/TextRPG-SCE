<!DOCTYPE html>
<html >
<head>
<title>TextBased RPG </title>
<style type="text/css">
        input#chat {
            width: 560px
        }

        #console-container {
            width: 550px;
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
    
		#battleBoxPosition{
			top: 0; left: 0; position: fixed; width: 100%; height: 120%;
			background-color: rgba(0,0,0,0.7); display: none;
		}
		.battleBoxWrapper{
			width: 550px; margin: 50px auto; text-align: left;
		}
		.battleBoxContent{
			background-color: #FFF; padding: 15px;
		}
		input#battleMsg {
           	width: 450px
        }

        #battle-container {
            width: 441px;
        }

        #battle {
            border: 2px solid #CCCCCC;
            border-right-color: #999999;
            border-bottom-color: #999999;
            height: 300px;
            overflow-y: scroll;
            padding: 5px;
            width: 100%;
        }

        #battle p {
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
		<% Thread.sleep(500); %>
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
