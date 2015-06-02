
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
	        <li><a href="http://localhost/text-rpg/home.jsp">Home</a></li>
	        <% 
				if(loggedIn == null){%>  
			    
		
	        <li><a href="http://localhost/text-rpg/login.jsp">Login</a></li>
	       
	        <%} else { %>
	        	        <li><a href="http://localhost/text-rpg/login.jsp">Logout</a></li>
	        <%} %>
	        <li><a href="http://localhost/text-rpg/game.jsp">Game</a></li>
	        <li><a href="http://localhost/text-rpg/guide.jsp" >Game Guide</a></li>
	        <li><a href="http://localhost/text-rpg/enterStore.jsp" >Store</a></li>
	        <li><a href="http://localhost/text-rpg/about.jsp">About Us</a></li>
	        <li><a href="http://localhost/text-rpg/contact.jsp">Contact Us</a></li>
	      </ul>
	    </div>
	  </div>
	  
	  