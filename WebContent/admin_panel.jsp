<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>

<!DOCTYPE html>


<html>

<head>




<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" language="java" />
<link href="styles.css" rel="stylesheet" type="text/css" />

<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.2.min.js"></script>

<script src="admin_panel.js"></script>


</head>


<body style="color: black" onload='document.form1.email.focus()'>
	<div id="main">
	  <jsp:include page="header.jsp"/>
	
	
	
		 <div class="tabbable">
			<ul class="tabs">  
				<li><a href="#tab1">Search user</a></li>
				<li><a href="#tab2">Popular</a></li>
				<li><a href="#tab3">Comments</a></li> 
			</ul> 
			<div class="tabcontent">
				<div  id="tab1" class="tab">
					<form name="form1"  action="Admin_Panel_Servlet"    method="post">
				        <center>
				        <input type="radio" name="Search_radio" value="box_radio" checked /> Search user:  
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
						
				        User name:<br> <input type="text" name="user" readonly style="background-color:#eeeeee; border:1px solid grey" value=${user} >
						<br>
						Email:<br><input type="text" name='email'  id='email'  style="background-color:#eeeeee; border:1px solid grey" value=${email}>
						<br>
						rank:<br><input type="text" name="rank" readonly style="background-color:#eeeeee; border:1px solid grey" value=${rank} >
						
						<%
						String err = null;
				   		err = (String)session.getAttribute("ranks");
				      	if(err!=null){
				      		if(err.equals("2")){
				   		%>
    					 <input style="border:1px solid grey" type="submit" value="change to Normal" name="submitAction"/>
    
						<%
					      	}
				      		else if(err.equals("1")){
				      	%>   
				      		<input style="border:1px solid grey" type="submit" value="change to Moderator" name="submitAction"/>
				      		
				      	<%
				      	      		} 
				      		}
						%>
						<br>
						activated:<br><input type="text" name='activated' readonly style="background-color:#eeeeee; border:1px solid grey" value=${activated} >
						<br><br><br>
						<center><input style="border:1px solid grey" type="submit" value="Search" name="submitAction"/></center>
						<br/>
					</form>
			  	</div>
		  		<div id="tab2" class="tab">
		  			
			  		<form name="form2"  action="Admin_Panel_Servlet"    method="post">
			  			User name:<br> <input type="text" name="ff"  style="background-color:#eeeeee; border:1px solid grey" value=${userr} >
			  		</form>
		  		</div>
			  	<div id="tab3" class="tab">
			  	
			  	</div>
			  		
			</div>
		 
	</div>
	


	<jsp:include page="footer.jsp" />
</div>
</body>


</html>