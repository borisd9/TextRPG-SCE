<div id="right">
      <div id="sidebar">
        <ul>
          <li>
            <h2>Game Options</h2>
            <ul>
              <li><a href="Items.jsp">Items</a> 
              <li><a href="Characters.jsp">Characters</a> 
              <li><a href="players.jsp">Users/Players</a>
              <%
              String loggedIn = (String)session.getAttribute("username");
              if(loggedIn!=null){
              %>
              <li><a href="changePassword.jsp">Change password</a>
              <%
              }
              %>
            </ul>
          </li>
          
        </ul>
      </div>
    </div>