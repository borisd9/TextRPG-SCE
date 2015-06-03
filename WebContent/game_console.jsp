
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
	var premItemsPrice=[];
	var premItems=[];
	var flag="";

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
		var msg = input.replace(/ /g,'').toLowerCase();
	
		
	 	///////////////////////////////////////	 	
		switch(msg){
		
		//command list//
		case "/cmd": 
			displayCommands();
			break;
			
				
		//Start game//
		case "/start":			
	 		//if game has already started
	 		if(mode == "started"){
			 	Console.log(font("red")+"The game has already been started.<br>Type <b>"+font("blue")+"/location</b></font> to check your current whereabouts."); 		
			 	<% 
					boolean doesExist = false;
					if(username!=null)
						doesExist = gdb.doesExist(username);
				%>
	 		} else {
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
	 		
	 		break;
		 		
	 		
		case "/act1":
			if(mapInfo.get("act1")!= null){
				switch (mapInfo.get("location")){
					case "Home":
						//Look For Helping Items
				 		Console.log("<b>"+font("#33aaaa")+"No helping item has been found at the house");
						break;
					case "The Hawks Cliff":
						//Fight a Hawk
				 		//rand function
				 		Console.log("<b>"+font("#33aaaa")+"");	
						break;
					case "The Amaya Throng":
						//Cross The River
				 		Console.log("<b>"+font("#33aaaa")+"Having fun? Why won't you try that again?");	
						break;
					case "Green City":
						//Go To Greenvas Store
						
				 		Console.log("<b>"+font("#33aaaa")+"");	 
						break;
					case "Torchwood":
						//Go To Torch Hotel
				 		Console.log("<b>"+font("#33aaaa")+"");	 
						break;
					case "The Silent Woods":
						//Walk Slowly Around
				 		Console.log("<b>"+font("#33aaaa")+"");	
						break;
					case "The Zygons Tribe":
						//Fight A Zygon
				 		//rand function
				 		Console.log("<b>"+font("#33aaaa")+"");
						break;
					case "Seamol City":
						//Consult The Mayer
				 		Console.log("<b>"+font("#33aaaa")+"");	
						break;
					case "Crocodile Bridge":
						//Jump From The Bridge
				 		Console.log("<b>"+font("#33aaaa")+"");
						break;
					case "Coconut Forest":
						//Fight The Coco Manster
				 		//rand function
				 		Console.log("<b>"+font("#33aaaa")+"");	
						break;
					case "Chimaki Hospital":
						//Return To The Last Place You've Been
				 		Console.log("<b>"+font("#33aaaa")+"");	
						break;
					case "The Ghosts Casle":
						//Fight A Ghost
				 		//rand function
				 		Console.log("<b>"+font("#33aaaa")+"");	 
						break;
					case "The Screamers Prison":
						//Return To The Last Place You've Been
				 		Console.log("<b>"+font("#33aaaa")+"");	
						break;
				}
				break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	 			 			
	 		
		case "/act2":
			if(mapInfo.get("act2")!= null){
				switch (mapInfo.get("location")){
				case "Home":
					//Travel The Garden
			 		Console.log("<b>"+font("#33aaaa")+"Nothing in the garden");
					break;
				case "The Hawks Cliff":
					//Travel Around
			 		//rand function
			 		//if(rand>100)
			 		Console.log("<b>"+font("#33aaaa")+"You found the <b>"+font("blue") +"The Blue Ring!");
			 		//else
			 		Console.log("<b>"+font("#33aaaa")+"Nothing has been found around");
					break;
				case "The Amaya Throng":
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
					break;
				case "Green City":
					//Visit Fortune A  Teller
			 		//rand function
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Torchwood":
					//Go To Woodens Store
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Silent Woods":
					//Walk Loudly Around
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Zygons Tribe":
					//Talk To The Tribe Chief
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Seamol City":
					//Help The Poor People Of The City
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Crocodile Bridge":
					//Fight The Enormous Crocodile
			 		//rand function
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Coconut Forest":
					//Travel Around
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Chimaki Hospital":
					//Get An Injection
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Ghosts Casle":
					//Scare The Ghosts
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Screamers Prison":
					//Clean Your Cell
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
			
			}
			break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	 		
		case "/act3":
			if(mapInfo.get("act3")!= null){
				switch (mapInfo.get("location")){
				case "The Amaya Throng":
					//Jump To The Throng
			 		Console.log("<b>"+font("#33aaaa")+"You lost 1 life. You should not try it again.");
			 		//need to update the DB
					break;
				case "Green City":
					//Visit The Local Casino
			 		//rand function
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Torchwood":
					//Go To Yammi Restaurant
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Silent Woods":
					//Fight The Trees
			 		//rand function
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Seamol City":
					//Go To Pak Store
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Crocodile Bridge":
					//Swim Around
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Chimaki Hospital":
					//Buy A Potion
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Screamers Prison":
					//Do What The Screamers Tells You
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
			}
			break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	 			 		 		
		case "/act4":
			if(mapInfo.get("act4")!= null){
				switch (mapInfo.get("location")){
					case "The Silent Woods":
						//Try To Find The Treasure
				 		Console.log("<b>"+font("#33aaaa")+"");
						break;
					case "Seamol City":
						//Kill Some People Around
				 		Console.log("<b>"+font("#33aaaa")+"");
						break;
					case "Chimaki Hospital":
						//Take A pill
				 		Console.log("<b>"+font("#33aaaa")+"");
						break;
					case "The Screamers Prison":
						//Ask For Pardon
				 		Console.log("<b>"+font("#33aaaa")+"");
						break;
			}
			break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
 			
	 		
	 	//view location
		case "/location":	
			//check if game has started
			if(mode != "started"){
	    		Console.log(font("red")+"You can't check your location before you start the game!<br>Type <b>"+
	    					font("blue")+"/startGame</font></b> to start the game.");
			}
			else displayLocation();
			break;
			
		
			
	 	//view character information//
	 	case "/char":
			//check if game has started
			if(mode != "started"){
	    		Console.log(font("red")+"You can't check your character before you start the game!<br>Type <b>"+
	    					font("blue")+"/startGame</font></b> to start the game.");
			} else{
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
			break;
					
		//move up//	
	 	case "/up":
	 		if(mapInfo.get("up")!= null){
		 		//Sending AJAX to update map DB	
				$.get('gameservlet', { action: "moveTo", direction: msg}, 
						function(responseJson){
					displayLocation();
				}
				);
	 		}
	 		break;
	 		
	 	//move down//	
	 	case "/down":
	 		if(mapInfo.get("down")!= null){
		 		//Sending AJAX to update map DB	
				$.get('gameservlet', { action: "moveTo", direction: msg}, 
						function(responseJson){
					displayLocation();
				}
				);
	 		}
	 		break;
	 		
	 	//move left//	
	 	case "/left":
	 		if(mapInfo.get("left")!= null){
		 		//Sending AJAX to update map DB	
				$.get('gameservlet', { action: "moveTo", direction: msg}, 
						function(responseJson){
					displayLocation();
				}
				);
	 		}
	 		break;
	 		
	 		 		
	 	//move right//
	 	case "/right":
	 		if(mapInfo.get("right")!= null){
		 		//Sending AJAX to update map DB	
				$.get('gameservlet', { action: "moveTo", direction: msg}, 
						function(responseJson){
					displayLocation();
				}
				);
	 		}

		
	 	//buy premium items
	 	case "/premium":
	 		newItem();
			break;
	 		

		default: 
			//If player is new, he must select a character
			if(mode=="new" && isNum(msg)){
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
			//if player pressed for premium store
			else if(mode=="premium" && isNum(msg)){     
				<%
				int itemsCount = gdb.PremiumItemsCount();
				int price=0;
				rs = gdb.getPremiumItems();
				String itemName=null;
				for(int j=1; rs.next(); j++){
					itemName = rs.getString(1);
					 price=gdb.getItemPrice(itemName);
				}
				%>
				
				
				
				
					
				//checking if legal character number has been selected
				 if(msg > 0 && msg <= <%=itemsCount%>+1){
					
					if(msg==<%=itemsCount%>+1){
						mode="started";
						displayLocation();
					}
					else{
				    //read updated coins of user after buying using ajax
					 $.get('gameservlet', { action: "getMoney", username: '<%=username%>',price: premItemsPrice[msg-1]}, 
					function(responseJson){
						$.each(responseJson, function(key, value){
							if(value=="1"){
								Console.log(font("red")+key+"<b>");	
							}
							
							else if(value!="1"){
					            Console.log(font("#009700")+"You have purchased <b>" + font("blue") + premItems[msg-1] + "</b></font>! ");
								//Sending data to servlet, to be inserted into DB
								$.get('gameservlet', { action: "premItem", price: premItemsPrice[msg-1], username: '<%=username%>' ,item:premItems[msg-1] });
								Console.log(font("red")+key+" <b>"+font("orange")+value+"$");
							}
						});
					}, 
					'json');		
					mode="started";
					displayLocation();
					}
				}
				else
					Console.log(font("red")+"Item #"+msg+" does not exist!<br>");
					
				
				
				
			}
			else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
				
	
		}//switch
		
	 }//chat.sendMessage
	
		
	 
	//function Add new item from premium store
	 function  newItem(){
	     <%int cash=gdb.getPlayerMoney(username); %>
		 Console.log("you can select one of the following premium items:");
		 if(flag=="")
		 	Console.log(font("red")+"Money you have: "+" <b>"+font("orange")+<%= cash%>+"$");
		 flag="1";
								 
		//Print premium items and price from DB and add to arrays
		<%
		int j;
		rs = gdb.getPremiumItems();
		for(j=1; rs.next(); j++){
			String item = rs.getString(1);
			int Price=gdb.getItemPrice(item);
		%>
		 
		Console.log(font("blue")+"<%=j%></font> - <b> <%=item%> ,price=<%= Price%> $</b>");
		
		premItemsPrice.push("<%=Price%>");
		premItems.push("<%=item%>");
		
		
		<%
		}
		
			
		%>
			Console.log(font("blue")+"<%=j%></font> - <b> "+'Cancel');

		
		Console.log("You can select  item by typing the relevant number");
		mode="premium";
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
		Console.log(font("blue")+"<b>/premium</b></font>"+font("#FF69B4")+" : to buy items from premium store");

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
			
			//update map pin coordinates and pin title
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
			Console.log("");
		
		}, 'json');
		//display map
		document.getElementById("mapDisplay").style.visibility = "visible";
		
	}//display location
    
</script>
    
</head>
<body>
<div id="content">
	<font color='blue'><b>To start the game, please type <font color='red'>/start</font> in the box below.</b><br/>
	<b>To see the list of possible commands, type <font color='red'>/cmd</font></b><br/><br/>
	<b>Enjoy your gaming!</b><br/><br/><br/></font>
	
	<div id="right">	
	
		<div id="mapDisplay" style="background: url('images/worldMap.png'); width: 300px; height:350px; position: relative; left:-10px; visibility: hidden; ">
	    <img id="pin" src="images/pin.gif" style="width:90px; height:70px;position: relative;">
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