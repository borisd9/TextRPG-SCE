<html>
<head>
<meta http-equiv="content-type"content="text/html; charset=utf-8" />
<link href="../styles.css" rel="stylesheet" type="text/css" />
</head>
<body style="color: black" ><font color="black">
<h1>Order Submitted Successfully!
<br>
Thank you for your order. Your order confirmation number is:
</font>
<pre>
<%=request.getParameter("confirmationNumber")%>
</pre>
</h1>
<p>
<br>
<form action="../store.jsp">
    <input type="submit" value="Back to Store">
</form>

</body>
</html>