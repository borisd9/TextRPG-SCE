<%@ page import="General.SessionHandler" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	SessionHandler handler = (SessionHandler) session.getAttribute("online");
	List<String> users = handler.getList();
%>
<font color="red"><b><%=users.size()%> online users:</b></font> <br>
<%
	for(int i=0; i<users.size(); i++){
%>
<font color="blue"><%=users.get(i)%></font><br>
<% } %>
</body>
</html>