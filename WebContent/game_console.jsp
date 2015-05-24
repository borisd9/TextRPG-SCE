<%@ page import="Database.GameDB"%>
<%@ page import="Database.MapDB" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Game Console</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	//Variables
	window.chat = {};
	var Console = {};
	var system = "<font color=red><b>System:</b> </font>";
	var mode = "";
	var startChars = [];
	var itemsChars = [];
	var input = "";
	var mapInfo = new Map();

	//Init GameDB object and MapDB, and get username from session
	<%
	  	GameDB gdb = new GameDB();
		String username = (String)session.getAttribute("username");
		
		ResultSet rs;
		MapDB map = new MapDB();
	%>
	 
	 //returns a colored message
	 function font(color, msg){
	 	return "<font color="+color+">";
	 }
	 
	//IsNumber
	 function isNum(n) {
			return !isNaN(parseFloat(n)) && isFinite(n);
	 }
	 
	 //Writes messages into Console
	 Console.log = (function(message) {
	     var console = document.getElementById('console');
	     var p = document.createElement('p');
	     p.style.wordWrap = 'break-word';
	     p.innerHTML = (message=="") ? "<br>" : system+message;
	     console.appendChild(p);
	     while (console.childNodes.length > 25) {
	         console.removeChild(console.firstChild);
	     }
	     console.scrollTop = console.scrollHeight;
	 });
	
	 //Starts listening for messages
	 onload = function() {
	 	chat.startListen();
	 };
	
	 //If Enter key has been pressed
	 chat.startListen = function () {
	 	document.getElementById('chat').onkeydown = function(event) { 		
	        //Listening for Enter Key 
	 		if (event.keyCode == 13) {	 	 			
	 			input = document.getElementById('chat').value;
	 			
		 		//clear cmd line
		 		document.getElementById('chat').value = ""; 	 	
		 		
	 			chat.sendMessage();
	         }
	     };
	 };
	
	 
	 //Command handler
	 chat.sendMessage = function () {
	 	var username = document.getElementById('un').value;
	 	
		//remove spaces and change input to lowercase	 
		msg = input.replace(/ /g,'').toLowerCase();
	 	
	 	///////////////////////////////////////
	 	//command list
	 	if(msg == "/cmd"){
	 		displayCommands();
	 	}
	 	//Start game
	 	else if (msg == "/start"){
	 		
	 		//if game has already started
		 	if(mode=="started"){
		 		Console.log(font("red")+"The game has already been started.<br>Type <b>"+font("blue")+"/location</b></font> to check your current whereabouts.")
		 	}
		 	else{
			 	<% 
					boolean doesExist = false;
					if(username!=null)
						doesExist = gdb.doesExist(username);
				%>
				
				//If player has never started a game
				if(<%=doesExist%>==false){
					Console.log(font("#009700")+"Welcome <b>"+font("blue")+username+"</font></b>! Get ready to start your journey!");
					newPlayer(username);
					
				}
				//If player has already started a game
				else{
					Console.log("Welcome back <b>"+font("blue")+username+"</b></font>!");
					displayLocation();
					mode = "started";
				}
			
		 	}
		 	
		}
	 	//view location
		else if(msg == "/location") {
	 		
			//check if game has started
			if(mode != "started"){
	    		Console.log(font("red")+"You can't check your location before you start the game!<br>Type <b>"+
	    					font("blue")+"/startGame</font></b> to start the game.")
			}
			else displayLocation();
		}
	 	//view character information
		else if(msg == "/char"){
	 		
			//check if game has started
			if(mode != "started"){
	    		Console.log(font("red")+"You can't check your character before you start the game!<br>Type <b>"+
	    					font("blue")+"/startGame</font></b> to start the game.")
			}

			else{
				Console.log("");
				Console.log(font("#009700")+"Character information:");
				
				//Getting Json object containing HashMap with character status
				$.get('gameservlet', { action: "getCharStatus", username: '<%=username%>'}, 
				function(responseJson){
					var i=0;
					$.each(responseJson, function(key, value){
						if(i==0){ 
							i++;
							Console.log(font("blue")+"<b>"+value);
						}
						Console.log(key+": <b>"+font("orange")+value);
					});
				}, 
				'json');
				
			}

		}else if(msg=="/store"){
			
			//check if game has started
			if(mode != "started"){
				Console.log(font("red")+"You can't go to the Store before you start the game!<br>Type <b>"+
    					font("blue")+"/startGame</font></b> to start the game.")
			}
			else	displayStore();
		}
		//If player is new, he must select a character
		else if (mode=="new" && isNum(msg)){
			<%
			int numOfChars = gdb.charCount();
			%>
			//checking if legal character number has been selected
			if(msg > 0 && msg <= <%=numOfChars%>){
				//Sending data to servlet, to be inserted into DB
				$.get('gameservlet', { action: "newPlayer", username: '<%=username%>', charName: startChars[msg-1] });				

				Console.log(font("#009700")+"You have selected <b>" + font("blue") + startChars[msg-1] + "</b></font>! Have a safe journey!");
				mode = "started";
				displayLocation();				
			}
			else{
				Console.log(font("red")+"Character #"+msg+" does not exist!<br>");
				newPlayer();
			}
		}
	 	//If player wont to buy an item
		else if (mode=="store" && isNum(msg)){
	 		<%
			int numOfItems=gdb.getItemsCount(map.getLocation());
			%>
			//checking if legal character number has been selected
			if(msg > 0 && msg <= <%=numOfItems%>){
			
				
				$.get('gameservlet', { action: "buyFromStore", username: '<%=username%>', itemsChars: itemsChars[msg-1], 
				function(responseAns){
					if(ans==1){
						Console.log(font("#009700")+"</font>!your purchase was successful!");
					}
					else{
						Console.log(font("#009700")+"</font>!You do not have enough money!");
					}
				});
				mode = "started";
				displayLocation();
			}
			else{
				Console.log(font("red")+"item #"+msg+" does not exist!<br>");
			}
		}else
			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	}
	
	//Add new player
	function newPlayer(username){
		Console.log("First, you must select one of the following characters:");
	
		//Print selectable chars and add to array
		<%
		int i;
		rs = gdb.getChars();
		String character;
		for(i=1; rs.next(); i++){
			character = rs.getString(1);
		%>
		Console.log(font("blue")+"<%=i%></font> - <b><%=character%></b>");
		startChars.push("<%=character%>");
		<%
		}
		%>
		Console.log("You can select it by typing the relevant number");
		mode="new";
	}
	
	//display available commands
	function displayCommands(){
 		Console.log("");
		Console.log(font("#009700")+"Below is a list of available commands:");
		Console.log(font("blue")+"<b>/start</b></font>"+font("#FF69B4")+" : to start the game.");
		Console.log(font("blue")+"<b>/char</b></font>"+font("#FF69B4")+" : to check your character's information");
		Console.log(font("blue")+"<b>/location</b></font>"+font("#FF69B4")+" : to see your current location");
		Console.log(font("blue")+"<b>/store</b></font>"+font("#FF69B4")+" : to see the items in the store");
	}
	
	//display current location and options
	function displayLocation(){
		//TODO//
	 	//Getting Json object containing HashMap with map info, and inputing info to mapInfo object
				$.get('gameservlet', { action: "getMapStatus", username: '<%=username%>'}, 
				function(responseJson){
					$.each(responseJson, function(key, value){									
						mapInfo.set(key,value);												
					});	
					
					//update map pin coordinates
					document.getElementById('pin').setAttribute('title', mapInfo.get("location"));
					document.getElementById('pin').style.top = mapInfo.get("y") + "px";
					document.getElementById('pin').style.left = mapInfo.get("x") + "px";
					
					//print to console current location
					Console.log(font("#009700")+"You are now in <b>"+font("blue") + mapInfo.get("location"));
					Console.log(font("#009700")+"What would you like to do?");
					Console.log(font("#009700")+"Type /location for more details on your surroundings <b>");
				}, 
				'json');
		
		//display map
		document.getElementById("mapDisplay").style.visibility = "visible";
		
		//mode="move";
	}
	//display store items
	function displayStore(){
		<%
			rs= gdb.getStoreItems(map.getLocation());
			
			String item_name;
			String item_description;
			String item_bonus1;
			String item_bonus2;
			String item_price;
			
			for(i=1; rs.next(); i++){
				item_name=rs.getString("item");
				item_description=rs.getString("description");
				item_bonus1=rs.getString("bonus1");
				item_bonus2=rs.getString("bonus2");
				item_price=rs.getString("price");
				//if ther is tow bonus to the item
				if(item_bonus2!=null){
				%>
				Console.log(font("blue")+"<%=i%></font> - <b><%=item_name%>   bonus1:<%=item_bonus1%>   bonus2:<%=item_bonus2%>  itme_price:<%=item_price%></b>");
				<%
				//if ther is one bonus to the item
				}else{
				%>
				Console.log(font("blue")+"<%=i%></font> - <b><%=item_name%>   bonus1:<%=item_bonus1%>   itme_price:<%=item_price%></b>");
				<%
				}
			%>
			Console.log(font("blue")+"</font><b>     itme description:<%=item_description%>");
			itemsChars.push("<%=item_name%>");
		<%
			}
		%>
		mode="store";
	}
    
</script>
    
</head>
<body>
<div id="content">
	<font color='blue'><b>To start the game, please type <font color='red'>/start</font> in the box below.</b><br/>
	<b>To see the list of possible commands, type <font color='red'>/cmd</font></b><br/><br/>
	<b>Enjoy your gaming!</b><br/><br/><br/></font>
	
	<div id="right">	
		<div id="mapDisplay" style="background: url('images/worldMap.png'); width: 300px; height:350px; position: relative; left:-10px; visibility: hidden; ">
	    <img id="pin" src="images/pin.gif" style="position: relative; width:90px; height:70px;">
		</div>
	
	For testing DB connections:<br>
	<%= map.getDataSourceStats() %>	
	</div>

	
	<div id="console-container">
		<div id="console"></div>
	</div>
	<input name='un' id='un' type='hidden' value='${sessionScope.username}'/>
	<p>
		<input type="text" style="border:2px solid" placeholder="type your commands here." id="chat" name="msg">
	</p>

	
</div>

</body>
</html>