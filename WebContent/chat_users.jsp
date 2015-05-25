<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
    
<%@ page import = "General.SessionListener"%>
<%@ page import="java.util.List" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


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


<body>

 <script language="javascript" type="text/javascript">

document.oncontextmenu=RightMouseDown;
document.onmousedown = mouseDown;


function mouseDown(e) {
    if (e.which==3) {//righClick
    	var myWindow = window.open("http://localhost:80/text-rpg/menu.jsp", "", "width=200, height=100, top= 300, left= 300");
    }
}


function RightMouseDown() { return false; }

</script>
</head>
<body>
<div id = "online">
<%

	SessionListener sl = (SessionListener) session.getAttribute("online");
	List<String> users = sl.getList();
	if(users!=null){
		for(String u: users){
%>

<button id="usersbtn" type="button" onclick="RightMouseDown()"><%= u %></button>

<%
		}
	}
	
%>
</div>


</body>
</html>