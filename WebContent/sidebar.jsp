<div id="right">
      <div id="sidebar">
        <ul>
          <li>
           	  <%
              String loggedIn = (String)session.getAttribute("username");
              if(loggedIn!=null){
              %>
            <h2>Player Options</h2>
            <ul>
             
              <li><a href="changePassword.jsp">Change password</a>
              <li><a href="ForgotPassword.jsp">Forgot Password?</a>
              <%
              }
              %>
            </ul>
          </li>
          
        </ul>
      </div>
    </div>