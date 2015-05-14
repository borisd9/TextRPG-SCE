<!DOCTYPE html>
<html >
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
    <br>
      <center><h1>Contact Us</h1></center>
      <br/>
	  <p>Finding yourself in need for assistance?
	  <br>Got feedback? Got improvement suggestions?
	  <br><br>Feel free to send us any questions/feedback using the form below.
	  <br>We will get back to you in no time!</p>
		<%
	   		String err = request.getParameter("err");
	      	if(err!=null){
	      		if(err.equals("1")){
	    %>
	    <font color="red"><b>Email and message fields cannot be empty!</b></font>
	    <br><br>
		<%
	      		}
	      	}
	    %>
	   <br>Name: <br><input type="text" name="name"  style="background-color:#eeeeee; border:1px solid grey"/>
	   <br>Subject: <br><input type="text" name="subject"  style="background-color:#eeeeee; border:1px solid grey"/>
       <br>E-Mail: <br><input type="text" name="email"  style="background-color:#eeeeee; border:1px solid grey"/>
       <br>Message: <br><textarea rows="6" cols="50" name="message" style="background-color:#eeeeee; border:1px solid grey"></textarea><br />
       <br>
       <input type="submit" value="Send" style="background-color:#eeeeee; border:1px solid grey;"/>
       <br>
       <%
	   		String ok = request.getParameter("ok");
	      	if(ok!=null){
	      		if(ok.equals("1")){
	    %>
	    <font color="blue"><b>Your message was sent, we will get in touch with you as soon as possible!</b></font>
	    <br><br>
	    <%
	      		}
	      	}
	    %>
    </div>
  </div>
  <jsp:include page="footer.jsp" />
</div>
  </body>

</html>
