<!DOCTYPE html>
<html >
<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
    <br>
      <center><h1>Contact Us</h1></center>
      <br/>
	  <p>Have you bump into a problem in the game?
	  <br>Need some help? Have some improvement suggestions?
	  <br><br>Our E-Mail: info_rpg@gmail.com
	  <br>You can also fill the fields below and we will contact you.</p>

	   <br>Full name: <br><input type="text" name="user"  style="background-color:#eeeeee; border:1px solid grey"/>
	   <br>Phone: <br><input type="tel" name="usrtel"  style="background-color:#eeeeee; border:1px solid grey"/>
       <br>E-Mail: <br><input type="text" name="user"  style="background-color:#eeeeee; border:1px solid grey"/>
       <br>Message: <br><input type="text" name="user" maxlength="120" size="120" style="background-color:#eeeeee; border:1px solid grey"/>
       <br><br><br>
       <center><input type="submit" value="Send" style="background-color:#eeeeee; border:1px solid grey; "/></center>
    </div>
  </div>
  <div id="footer">
    <p>Copyright &copy; 2015. Designed by SCE-Project-Team-8
  </div>
</div>
  </body>

</html>
