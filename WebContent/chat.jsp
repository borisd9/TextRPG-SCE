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
			chatConsole.log('Error: WebSocket is not supported by this browser.');
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
			
			chatConsole.log("<font color='blue'>(" + time + ") " + " </font>" + message.data);
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
				chatConsole.log(font("red")+"<b>System: </b>You are muted.");			
			}
			else{
				//Check if mute command has been used
				if(msg.substring(0,5)=="/mute"){
					var mutee = msg.substring(6);
					//Check if user trying to mute himself
					if(mutee==document.getElementById('un').value)
						chatConsole.log(font("red")+"<b>System: </b>You cannot mute yourself!");
					//Check if a username has been entered
					else if(mutee!=""){
						//Mute user
						$.post("MuteServlet", {action: "addMutee", mutee: mutee, muter: document.getElementById('un').value}, 
						function(response){
							//If mute was successful
							if(response=="exists")
								chatConsole.log(font("red")+"<b>System: "+font("blue")+mutee+"</b></font> is already muted.");
							else if(response=="bad rank")
								chatConsole.log(font("red")+"<b>System: </b>You don't have the authority to use this command!");
							else if(response=="low rank")
								chatConsole.log(font("red")+"<b>System: </b>You cannot mute someone with higher authority!");
							else chatConsole.log(font("red")+"<b>System: "+font("blue")+mutee+"</b></font> is now muted.");
						});
					}
					else chatConsole.log(font("red")+"<b>System: </b>Please specify a user you want to mute.<br>Ex.: "+font("blue")+"<b>/mute [username]");
				}
				//Check if unmute command has been used
				else if(msg.substring(0,7)=="/unmute"){
					var mutee = msg.substring(8);
					//Check if a username has been entered
					if(mutee!=""){
						//Unmute user
						$.post("MuteServlet", {action: "removeMutee", mutee: mutee, muter: document.getElementById('un').value}, 
						function(response){
							//If unmute was successful
							if(response=="exists")
								chatConsole.log(font("red")+"<b>System: "+font("blue")+mutee+"</b></font> is not muted.");
							else if(response=="bad rank")
								chatConsole.log(font("red")+"<b>System: </b>You don't have the authority to use this command!");
							else chatConsole.log(font("red")+"<b>System: "+font("blue")+mutee+"</b></font> is able to chat again.");
						});
					}
					else chatConsole.log(font("red")+"<b>System: </b>Please specify a user you want to unmute.<br>Ex.: "+font("blue")+"<b>/unmute [username]");
				}
				//check if message is not empty
				else if (document.getElementById('chat2').value != '') {
					var message = "<font color='blue'>"	+ document.getElementById('un').value + ":   </font>"+ document.getElementById('chat2').value;
					chat2.socket.send(message);
				}
			}
			document.getElementById('chat2').value = '';
		}, 50);	
		
	});

	var chatConsole = {};

	//Adding the message to the console
	chatConsole.log = (function(message) {
		var chatConsole = document.getElementById('chatConsole2');
		var p = document.createElement('p');
		p.style.wordWrap = 'break-word';
		p.innerHTML = message;
		chatConsole.appendChild(p);
		while (chatConsole.childNodes.length > 25) {
			chatConsole.removeChild(chatConsole.firstChild);
		}
		chatConsole.scrollTop = chatConsole.scrollHeight;
	});

	chat2.initialize();
	
	var auto_refresh = setInterval(function() {
		$('#chatUsers').load('chat_users.jsp').fadeIn("slow");
	}, 30000); // autorefresh the content of the div after
	//every 30000 milliseconds(30sec)
</script>

<script type="text/javascript">
	
</script>
</head>
<body>
	<div>
		<div id="chatConsole-container">
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