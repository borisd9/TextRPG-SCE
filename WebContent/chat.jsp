<html>
<head>
    <title>chat2</title>
    <style type="text/css">
        input#chat2 {
            width: 400px
        }

        #chatConsole2-container {
            width: 600px;
        }

        #chatConsole2 {
            border: 2px solid #CCCCCC;
            border-right-color: #999999;
            border-bottom-color: #999999;
            height: 170px;
            overflow-y: scroll;
            padding: 5px;
            width: 400px;
        }

        #chatConsole2 p {
            padding: 0;
            margin: 0;
        }
    </style>
    <script type="text/javascript">
    
        var chat2 = {};
		        
        chat2.socket = null;

        chat2.connect = (function(host) {
            if ('WebSocket' in window) {
                chat2.socket = new WebSocket(host);
            } else if ('MozWebSocket' in window) {
                chat2.socket = new MozWebSocket(host);
            } else {
                chatConsole2.log('Error: WebSocket is not supported by this browser.');
                return;
            }

            chat2.socket.onopen = function () {
                document.getElementById('chat2').onkeydown = function(event) {
                    if (event.keyCode == 13) {
                        chat2.sendMessage();
                    }
                };
            };

            chat2.socket.onclose = function () {
                document.getElementById('chat2').onkeydown = null;
            };

            chat2.socket.onmessage = function (message) {
            	var username = document.getElementById('un').value;
				var date = new Date();
				var time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                chatConsole2.log("<font color='blue'>("+ time + ") " + username + ": </font>" + message.data);
            };
        });

        chat2.initialize = function() {
            if (window.location.protocol == 'http:') {
                chat2.connect('ws://localhost:80/text-rpg/ChatServlet');
            } else {
                chat2.connect('ws://localhost:80/text-rpg/ChatServlet');   
            }
        };

        chat2.sendMessage = (function() {
            var message = document.getElementById('chat2').value;
            if (message != '') {
                chat2.socket.send(message);
                document.getElementById('chat2').value = '';
            }
        });

        
        
        
        var chatConsole2 = {};

        chatConsole2.log = (function(message) {
            var chatConsole2 = document.getElementById('chatConsole2');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.innerHTML = message;
            chatConsole2.appendChild(p);
            while (chatConsole2.childNodes.length > 25) {
                chatConsole2.removeChild(chatConsole2.firstChild);
            }
            chatConsole2.scrollTop = chatConsole2.scrollHeight;
        });

        chat2.initialize();

    </script>
    
   <script type="text/javascript">
        var auto_refresh = setInterval(
        function ()
        {
        $('#chatUsers').load('chat_users.jsp').fadeIn("slow");
        }, 30000); // autorefresh the content of the div after
                   //every 1000 milliseconds(1sec)
        </script>
</head>
<body>
<div>
    <div id="chatConsole2-container">
    <table>
    <tr>
    <td>
    <div id="chatConsole2"></div>
    </td>
    <td>
    <div id= "chatUsers"> <%@ include file= "chat_users.jsp" %> </div>
    </td>
    </tr>
    </table>
        
    </div>
    <input id='un' type='hidden' value='${sessionScope.username}'/>
    <%
    	String loggedIn = (String)session.getAttribute("username");
    	if(loggedIn != null){
    %>
    <p>
        <input type="text" style="border:2px solid" placeholder="type and press enter to chat." id="chat2">
    </p>
    <% } %>
</div>
</body>
</html>