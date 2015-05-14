<html>
<head>
    <title>Chat</title>
    <style type="text/css">
        input#chat {
            width: 400px
        }

        #console-container {
            width: 490px;
        }

        #console {
            border: 2px solid #CCCCCC;
            border-right-color: #999999;
            border-bottom-color: #999999;
            height: 300px;
            overflow-y: scroll;
            padding: 5px;
            width: 100%;
        }

        #console p {
            padding: 0;
            margin: 0;
        }
    </style>
    <script type="text/javascript">
    
        var Chat = {};
		        
        Chat.socket = null;

        Chat.connect = (function(host) {
            if ('WebSocket' in window) {
                Chat.socket = new WebSocket(host);
            } else if ('MozWebSocket' in window) {
                Chat.socket = new MozWebSocket(host);
            } else {
                Console.log('Error: WebSocket is not supported by this browser.');
                return;
            }

            Chat.socket.onopen = function () {
                document.getElementById('chat').onkeydown = function(event) {
                    if (event.keyCode == 13) {
                        Chat.sendMessage();
                    }
                };
            };

            Chat.socket.onclose = function () {
                document.getElementById('chat').onkeydown = null;
            };

            Chat.socket.onmessage = function (message) {
            	var username = document.getElementById('un').value;
				var date = new Date();
				var time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                Console.log("<font color='blue'>("+ time + ") " + username + ": </font>" + message.data);
            };
        });

        Chat.initialize = function() {
            if (window.location.protocol == 'http:') {
                Chat.connect('ws://localhost:80/text-rpg/ChatServlet');
            } else {
                Chat.connect('ws://localhost:80/text-rpg/ChatServlet');   
            }
        };

        Chat.sendMessage = (function() {
            var message = document.getElementById('chat').value;
            if (message != '') {
                Chat.socket.send(message);
                document.getElementById('chat').value = '';
            }
        });

        var Console = {};

        Console.log = (function(message) {
            var console = document.getElementById('console');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.innerHTML = message;
            console.appendChild(p);
            while (console.childNodes.length > 25) {
                console.removeChild(console.firstChild);
            }
            console.scrollTop = console.scrollHeight;
        });

        Chat.initialize();

    </script>
</head>
<body>
<div>
    <div id="console-container">
        <div id="console"></div>
    </div>
    <input id='un' type='hidden' value='${sessionScope.username}'/>
    <p>
        <input type="text" style="border:2px solid" placeholder="type and press enter to chat" id="chat">
    </p>
</div>
</body>
</html>