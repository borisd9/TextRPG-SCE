
<div id="header"> 
	    <div id="buttons">
	      <ul>
	        <li class="first">
	        <%
	        String loggedIn = (String)session.getAttribute("username");
			String rank = (String)session.getAttribute("rank_check");
	        if(rank!=null){
	      		if(rank.equals("2")){
			%>
	        <li><a href="admin_panel.jsp">Admin panel</a></li>
	        <%
      	      		} 
      		}
			%>
	        <li><a href="home.jsp">Home</a></li>
	        <% 
				if(loggedIn == null){%>  
			    
		
	        <li><a href="login.jsp">Login</a></li>
	       
	        <%} else { %>
	        	        <li><a href="login.jsp">Logout</a></li>
	        <%} %>
	        <li><a href="game.jsp">Game</a></li>
	        <li><a href="guide.jsp" >Game Guide</a></li>
	        <li><a href="enterStore.jsp" >Store</a></li>
	        <li><a href="about.jsp">About Us</a></li>
	        <li><a href="contact.jsp">Contact Us</a></li>
	      </ul>
	    </div>
	  </div>
	  
	  