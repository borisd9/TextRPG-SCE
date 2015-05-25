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
	 	//need to check position
	 	//Home
	 	else if (msg == "/act1"){
	 		//Look For Helping Items
	 		Console.log("<b>"+font("#33aaaa")+"No item has been found");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Travel The Garden
	 		Console.log("<b>"+font("#33aaaa")+"Nothing in the garden");
	 	}
	 	
	 	//The Hawks Cliff
		else if (msg == "/act1"){
	 		//Fight a Hawk
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"No helping item has been found at the house");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Travel Around
	 		//rand function
	 		//if(rand>100)
	 		Console.log("<b>"+font("#33aaaa")+"You found the <b>"+font("blue") +"The Blue Ring!");
	 		//else
	 		Console.log("<b>"+font("#33aaaa")+"Nothing has been found around");
	 	}
		
	 	//The Amaya Throng
	 	else if (msg == "/act1"){
	 		//Cross The River
	 		Console.log("<b>"+font("#33aaaa")+"Having fun? Why won't you try that again?");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Fight The Amaya Manster
	 		//rand function
	 		//if(rand>200)
	 		Console.log("<b>"+font("#33aaaa")+"You Won The Manster!");
	 		Console.log("<b>"+font("#33aaaa")+"You earned 35 exp and 15 HP");
	 		Console.log("<b>"+font("#33aaaa")+"Your character earned 15 attack skill, 5 defense and 5 speed");
	 		//need to update the DB
	 		//else
	 		Console.log("<b>"+font("#33aaaa")+"Oh No! You could not beat the Manster!");
	 		Console.log("<b>"+font("#33aaaa")+"You lost 15 exp and your character lost 25 defense!");
	 		Console.log("<b>"+font("#33aaaa")+"You has been send to the hospital to patch your character's injuries");
	 		Console.log("<b>"+font("#33aaaa")+"The treatment cost you 100 coins. Don't warry - if you didn't have that sum - nothing won't be taken from you. Take Care!");
	 		//need to update the DB
	 	}
	 	else if (msg == "/act3"){
	 		//Jump To The Throng
	 		Console.log("<b>"+font("#33aaaa")+"You lost 1 life. You should not try it again.");
	 		//need to update the DB
	 	}
	 	0
	 	//Green City
	 	else if (msg == "/act1"){
	 		//Go To Greenvas Store
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Visit Fortune A  Teller
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Visit The Local Casino
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//Torchwood
	 	else if (msg == "/act1"){
	 		//Go To Torch Hotel
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Go To Woodens Store
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Go To Yammi Restaurant
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//The Silent Woods
	 	else if (msg == "/act1"){
	 		//Walk Slowly Around
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Walk Loudly Around
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Fight The Trees
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act4"){
	 		//Try To Find The Treasure
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//The Zygons Tribe
	 	else if (msg == "/act1"){
	 		//Fight A Zygon
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Talk To The Tribe Chief
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//Seamol City
	 	else if (msg == "/act1"){
	 		//Consult The Mayer
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Help The Poor People Of The City
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Go To Pak Store
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act4"){
	 		//Kill Some People Around
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//Crocodile Bridge
	 	else if (msg == "/act1"){
	 		//Jump From The Bridge
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Fight The Enormous Crocodile
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Swim Around
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//Coconut Forest
	 	else if (msg == "/act1"){
	 		//Fight The Coco Manster
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Travel Around
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
		//Chimaki Hospital
	 	else if (msg == "/act1"){
	 		if location == map.getlaspfk && act1.ispossible
	 		print khaflksahfla
	 		//Return To The Last Place You've Been
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Get An Injection
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Buy A Potion
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act4"){
	 		//Take A pill
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
	 	//The Ghosts Casle
	 	else if (msg == "/act1"){
	 		//Fight A Ghost
	 		//rand function
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Scare The Ghosts
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	
		//The Screamers Prison
	 	else if (msg == "/act1"){
	 		//Return To The Last Place You've Been
	 		Console.log("<b>"+font("#33aaaa")+"");	 				
	 	}
	 	else if (msg == "/act2"){
	 		//Clean Your Cell
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act3"){
	 		//Do What The Screamers Tells You
	 		Console.log("<b>"+font("#33aaaa")+"");
	 	}
	 	else if (msg == "/act4"){
	 		//Ask For Pardon
	 		Console.log("<b>"+font("#33aaaa")+"");
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
		else
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
					if(mapInfo.get("up")!= null)
						Console.log(font("#009700")+"Type /up to go to <b>"+font("blue") + mapInfo.get("up"));
					if(mapInfo.get("down")!= null)
						Console.log(font("#009700")+"Type /down to go to <b>"+font("blue") + mapInfo.get("down"));
					if(mapInfo.get("left")!= null)
						Console.log(font("#009700")+"Type /left to go to <b>"+font("blue") + mapInfo.get("left"));
					if(mapInfo.get("right")!= null)
						Console.log(font("#009700")+"Type /right to go to <b>"+font("blue") + mapInfo.get("right"));
					if(mapInfo.get("act1")!= null)
						Console.log(font("#009700")+"Type /act1 to <b>"+font("#cc33cc") + mapInfo.get("act1"));
					if(mapInfo.get("act2")!= null)
						Console.log(font("#009700")+"Type /act2 to <b>"+font("#cc33cc") + mapInfo.get("act2"));
					if(mapInfo.get("act3")!= null)
						Console.log(font("#009700")+"Type /act3 to <b>"+font("#cc33cc") + mapInfo.get("act3"));
					if(mapInfo.get("act4")!= null)
						Console.log(font("#009700")+"Type /act4 to <b>"+font("#cc33cc") + mapInfo.get("act4"));
					Console.log(font("#009700")+"Type /location for more details on your surroundings <b>");
				}, 
				'json');
		
		//display map
		document.getElementById("mapDisplay").style.visibility = "visible";
		
		//mode="move";
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