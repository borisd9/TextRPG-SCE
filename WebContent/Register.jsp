<!DOCTYPE html>
<html>

<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body style="color: black" onload='document.form1.email.focus()'>
<div id="main">
  <div id="header"> 
    <div id="buttons">
      <ul>
        <li class="first">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="view_game.jsp">View Game</a></li>
        <li><a href="guide.jsp" >Game Guide</a></li>
        <li><a href="store.jsp" >Store</a></li>
        <li><a href="about.jsp">About Us</a></li>
        <li><a href="contact.jsp">Contact Us</a></li>
      </ul>
    </div>
  </div>
  <div id="content">
    <div id="right">
      <div id="sidebar">
        <ul>
          <li>
            <h2>Game Options</h2>
            <ul>
              <li><a href="Map.jsp">Map</a> 
              <li><a href="Items.jsp">Items</a> 
              <li><a href="Characters.jsp">Characters</a> 
              <li><a href="players.jsp">Users/Players</a>
            </ul>
          </li>
          
        </ul>
      </div>
    </div>
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
  <div id="footer">
    <p>Copyright &copy; 2015. Designed by SCE-Project-Team-8
  </div>
</div>
<script src="validation.js"></script>
  </body>

</html>
