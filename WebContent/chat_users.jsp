<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
    
<%@ page import = "General.SessionListener"%>
<%@ page import= "java.util.List" %>
<%@ page import= "java.util.ArrayList" %>
<%@ page import= "General.MuteList" %>
<%@ page import= "Database.MuteDB" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="styles.css" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<title>Chat Users</title>

<style type="text/css">
         #online {
            border: 2px solid #CCCCCC;
            border-right-color: #999999;
            border-bottom-color: #999999;
            height: 170px;
            overflow-y: scroll;
            padding: 5px;
            width: 100px;
        }

</style>

<script type="text/javascript">


$(document).ready(function() {
    $('.mutebtn').click(function() {
        var name = ($(this).attr("value"));
        $.get("MuteServlet", {name : name});
       

    });
});



</script>
</head>

<body>

<div id = "online">
<%
	MuteDB md = new MuteDB();
	SessionListener sl = (SessionListener) session.getAttribute("online");
	List<String> users = sl.getList();
	if(users!=null){
		if(md.isAdmin(session.getAttribute("username").toString())){
			for(String u: users){
%>
  <ul class="nav nav-tabs">
    <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%=u %><span class="caret"></span></a>
      <ul class="dropdown-menu">     
        <li><form>
			<button id="un" class="mutebtn" value='<%=u %>' onclick="return false;">mute</button>
			</form> </li>
      </ul>
    </li>
  </ul>
<%
			}
		}
		else{
			for(String u: users){
%>
		<div><%=u %></div><br>
<%
			}
		}
	}
	
%>
</div>


<% Thread.sleep(1000);
ArrayList<String> test = MuteList.getList();
for(String s : test){
	out.println("~~~~~~"+s);
}	
	%>

</body>
</html>