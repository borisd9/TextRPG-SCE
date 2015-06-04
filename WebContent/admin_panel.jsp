<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>

<!DOCTYPE html>


<html>
<head>

<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" language="java" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<%@ page language="java" import="java.sql.*" errorPage="" %>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.2.min.js"></script>


</head>



<body style="color: black" onload='document.form1.email.focus()'>
	<div id="main">
	  <jsp:include page="header.jsp"/>
	  <br>
      <center><h1>Admin panel</h1></center>
      <br/>
      <div>
		<form name="form1"  action="Admin_Panel_Servlet"    method="post">
	        <center>
	        <%
		    	
		   		String err = request.getParameter("err");
		      	if(err!=null){
		      		if(err.equals("1")){
		    
		    %>
		    <font color="red"><b>You must enter a username!</b></font>
		    <br><br>
			<%
		      		}
		      		else if(err.equals("2")){
			%>   
			<font color="red"><b>User name doesn't exist!</b></font>
			<br><br>
			<%
      				}
		      	}
		    %>
			Search user:
	        <input type="text" name="Search"  style="background-color:#eeeeee; border:1px solid grey" />
		    <br>
		    <br>
			Select user: 
		        <select name="userlist" onchange="this.form.submit()" >
			        <option value="-1">--</option>
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
		        <br>
	        </center>
			
	        &nbsp;&nbsp;User name:<br>&nbsp;&nbsp;<input type="text" name="user" readonly style="background-color:#eeeeee; border:1px solid grey" value=${user} >
			<br>
			&nbsp;&nbsp;Email:<br>&nbsp;&nbsp;<input type="text" name='email'  id='email'  style="background-color:#eeeeee; border:1px solid grey" value=${email}>
			<br>
			&nbsp;&nbsp;rank:<br>&nbsp;&nbsp;<input type="text" name="rank" readonly style="background-color:#eeeeee; border:1px solid grey" value=${rank} >
			
			<%
			String ranks = null;
	   		ranks = (String)session.getAttribute("ranks");
	      	if(ranks!=null){
	      		if(ranks.equals("2")){
	   		%>
 					 <input style="border:1px solid grey" type="submit" value="change to Normal" name="submitAction"/>
 
			<%
		      	}
	      		else if(ranks.equals("1")){
	      	%>   
	      		<input style="border:1px solid grey" type="submit" value="change to Moderator" name="submitAction"/>
	      		
	      	<%
	      	      		} 
	      		}
			%>
			<br>
			&nbsp;&nbsp;activated:<br>&nbsp;&nbsp;<input type="text" name='activated' readonly style="background-color:#eeeeee; border:1px solid grey" value=${activated} >
			<br><br><br>
			<center><input style="border:1px solid grey" type="submit" value="Search" name="submitAction"/></center>
			<br/>
		</form>
	</div>
  		
			  	
			  	
	<jsp:include page="footer.jsp" />
</div>
</body>


</html>