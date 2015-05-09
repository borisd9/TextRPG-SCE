<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>


<html>

<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" language="java" %/>
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
	
		<ul class="tabs" data-tab>
			<li class="tab-title active"><a href="#tab1">Search user</a></li>
			<li class="tab-title"><a href="#tab2">Tab 2</a></li>
		</ul>
	
	
	
		
				<div id="search">
			  		<center><h1>Search user </h1></center>
			  	  	
			        <form name="form1"  action="Admin_Panel_Servlet"    method="post">
				        <center>
				        <input type="radio" name="Search_radio" value="box_radio" checked> Search user:  
				        <input type="text" name="Search"  style="background-color:#eeeeee; border:1px solid grey" />
					        
					        <input type="radio" name="Search_radio" value="dropdown_radio" />Select user: 
						        <select name="userlist">
							        <option value=""></option>
							        <% 

									Database.DbConnectionAPI db = new Database.DbConnectionAPI();
									
									java.sql.Connection con=null;
									java.sql.ResultSet rs=null;
									
									
									String query = "SELECT username FROM Users";
									
									rs = db.readFromDatabase(query);
									
									while(rs.next()){
										String name = rs.getString("username");
										%>
										          <option value="<%=name%>"><%=name%></option>
										<%
									}
									%>
						        </select>
					        
					        <br>
				        </center>
						
				        User name:<br> <input type="text" name="user"  style="background-color:#eeeeee; border:1px solid grey" value=${user} >
						<br>
				        Password:<br><input type="text" name="pwd"  style="background-color:#eeeeee; border:1px solid grey" value=${pwd}>
						<br>
						Email:<br><input type="text" name='email'  id='email'  style="background-color:#eeeeee; border:1px solid grey" value=${email}>
						<br>
						rank:<br><input type="text" name="rank"  style="background-color:#eeeeee; border:1px solid grey" value=${rank}>
						<br>
						activated:<br><input type="text" name='activated'  style="background-color:#eeeeee; border:1px solid grey" value=${activated}>
						<br><br><br>
						<center><input style="border:1px solid grey" type="submit" value="Search" name="submitAction"/></center>
						<br/>
			        </form>
		  		</div>
			</div>
			
		
	


	<div id="footer">
	  <p>Copyright &copy; 2015. Designed by SCE-Project-Team-8
	</div>
</div>
</body>


</html>