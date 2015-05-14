<!DOCTYPE html>
<html>

<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body style="color: black" onload='document.form1.email.focus()'>
<div id="main">
  <jsp:include page="header.jsp"/>
  
  <div id="content">
    <jsp:include page="sidebar.jsp"/>
    
    <div id="left">
      <center><h1>Please Enter The Following </h1></center>
      <br/>
          
        <form name="form1"  action="RegisterServlet" onsubmit="return validateForm()"   method="post">
 
		User name:<br> <input type="text" name="user"  style="background-color:#eeeeee; border:1px solid grey" />
		<br>
		Password:<br><input type="password" name="pwd"  style="background-color:#eeeeee; border:1px solid grey"/>
		<br>
		Email:<br> <input type="text" name='email'  id='email'  style="background-color:#eeeeee; border:1px solid grey"/>
		<br><br><br>
		<center><input style="border:1px solid grey" type="submit" value="Register" onclick="ValidateEmail(document.form1.email)"/></center>
<br/>
		
		</form>
      
    </div>
  </div>
  <jsp:include page="footer.jsp" />
</div>
<script src="validation.js"></script>
  </body>

</html>
