<html>
<head>
<title>chat2</title>

<script type="text/javascript">
	var chat2 = {};

	chat2.socket = null;

	//Connect to websockets
	chat2.connect = (function(host) {
		//Check browser compatibility
		if ('WebSocket' in window) {
			chat2.socket = new WebSocket(host);
		} else if ('MozWebSocket' in window) {
			chat2.socket = new MozWebSocket(host);
		} else {
			chatConsole2.log('Error: WebSocket is not supported by this browser.');
			return;
		}

		//Once the socket is opened
		chat2.socket.onopen = function() {
			document.getElementById('chat2').onkeydown = function(event) {
				if (event.keyCode == 13) {
					chat2.sendMessage();
				}
			};
		};

		//Once the socket is closed
		chat2.socket.onclose = function() {
			document.getElementById('chat2').onkeydown = null;
		};

		//Once a message has been sent through the socket
		chat2.socket.onmessage = function(message) {
			//Message time
			var date = new Date();
			var time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
			
			chatConsole2.log("<font color='blue'>(" + time + ") " + " </font>" + message.data);
		};
	});

	//Chat initialization
	chat2.initialize = function() {
        if (window.location.protocol == 'http:') {
            chat2.connect('ws://' + window.location.host + '/text-rpg/ChatServlet');
        } else {
            chat2.connect('wss://' + window.location.host + '/text-rpg/ChatServlet');   
        }
	};

	//Sending message
	chat2.sendMessage = (function() {
		var msg = document.getElementById('chat2').value;
		
		var mutedList = [];
		
		//Get muted users list
		$.post("MuteServlet", {action: "getList"}, 
			function(responseJson){
				$.each(responseJson, function(index, value){
					mutedList[index] = value;
				});
		}, 'json');

		//Once muted list is retrieved
		setTimeout(function(){
			//if user is in the list
			if($.inArray(document.getElementById('un').value, mutedList) != -1){
				chatConsole2.log(font("red")+"<b>System: </b>You are muted.");
				document.getElementById('chat2').value = '';
			}
			else{
				//Check if mute command has been used
				if(msg.substring(0,5)=="/mute"){
					var mutee = msg.substring(6);
					$.post("MuteServlet", {action: "addMutee", mutee: mutee})
				}
				
				//check if message is not empty
				if (document.getElementById('chat2').value != '') {
					var message = "<font color='blue'>"	+ document.getElementById('un').value + ":   </font>"+ document.getElementById('chat2').value;
					chat2.socket.send(message);
					document.getElementById('chat2').value = '';
				}
			}
		}, 50);
		
		
		
		
	});

	var chatConsole2 = {};

	//Adding the message to the console
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
	var auto_refresh = setInterval(function() {
		$('#chatUsers').load('chat_users.jsp').fadeIn("slow");
	}, 30000); // autorefresh the content of the div after
	//every 30000 milliseconds(30sec)
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
						<%
							String loggedIn = (String) session.getAttribute("username");
							if (loggedIn != null) {
						%>
						<div id="chatUsers">
							<%@ include file="chat_users.jsp"%>
						</div> 
						<% } %>
					</td>
				</tr>
			</table>

		</div>
		<input id='un' type='hidden' value='${sessionScope.username}' />
		<%
			if (loggedIn != null) {
		%>
		<p>
			<input type="text" style="border: 2px solid"
				placeholder="type and press enter to chat." id="chat2" vlaue="">
		</p>
		<%
			}
		%>
	</div>
</body>
</html>