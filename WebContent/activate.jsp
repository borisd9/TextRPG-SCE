<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>TextBased RPG</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<title>Account activation</title>
</head>


<body>
	<div id="main">
		<jsp:include page="header.jsp" />

		<div id="content">
			<jsp:include page="sidebar.jsp" />

			<div id="left">
				<br>
				<center>
					<h1>Activation Succeeded!</h1>
				</center>
				<br />

				<form id="auth" action="AuthenticationServlet" method="POST">
					<input type="hidden" value="<%=request.getParameter("code")%>"
						name="code" />
				</form>
				<p>
					Hello
					<%=request.getParameter("username")%>! <br> Your account has
					been successfully activated. Enjoy your stay!
				</p>
				<br>
				<br>
				<p>What would you like to do now?</p>
				<br>
				<center>
					<a href="game.jsp">Play the game</a>
				</center>
				<br>
				<center>
					<a href="guide.jsp">Check out the game guide</a>
				</center>
				
				<script>
					//Send form to servlet as soon as user enter this page
				    window.onload = function() {
				    	var code = "<%=request.getParameter("code")%>";
						if (code != "null") {
							document.getElementById("auth").submit();
						}
					}
				</script>
				
			</div>
		</div>

		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>