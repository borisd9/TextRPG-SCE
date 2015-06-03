<%@ page import="Database.GameDB"%>
<%@ page import="Database.MapDB"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Game Console</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script async="async">
	//Variables
	window.chat = {};
	var Console = {};
	var system = "<font color=red><b>System:</b> </font>";
	var mode = "";
	var startChars = [];
	var itemsChars = [];
	var input = "";
	var mapInfo = new Map();
	var countcell=0;
	var flagcell=0;
	var hasmap=0;
	var flagdo=0;
	var flagprison=0;
	var pardonflag=0;
	var flaghome=0;
	var premItemsPrice=[];
	var premItems=[];
	var flag="";
	window.battlechat = {};
	var battle = {};
	var system = "<font color=red><b>System:</b> </font>";
	var p1 = {};
	var p2 = {};
	var phase = "";
	var turn = 1;

	//Init GameDB object and MapDB, and get username from session
	<%
			int atk;
			int defense;
			int speed;
			int hp;
			int exp;

			GameDB gdb = new GameDB();
			String username = (String) session.getAttribute("username");
			ResultSet rs;
			MapDB map = new MapDB();

			String opponent = gdb.getOpponent(username);
			String my_char = "", opp_char = "";
	%>
	
	var opponent = '<%=opponent%>';
	var username = '<%=username%>';
	
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
			 	<%boolean doesExist = false;
			if (username != null)
				doesExist = gdb.doesExist(username);%>
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
						//Look For Helping Items V
				 		Console.log("<b>"+font("#33aaaa")+"No helping item has been found at the house");
						break;
					case "The Hawks Cliff":
						//Fight a Hawk U
						fightmanster(10,51,205,"Hawk",35,50,15,50);
						break;
					case "The Amaya Throng":
						//Cross The River V
				 		Console.log("<b>"+font("#33aaaa")+"Having fun? Why won't you try that again?");	
						break;
					case "Green City":
						//Go To Greenvas Store X
						displayStore();
				 		Console.log("<b>"+font("#33aaaa")+"");	 
						break;
					case "Torchwood":
						//Go To Torch Hotel U
				 		Console.log("<b>"+font("#33aaaa")+"You enjoyed one night at the Tourch Hotel. <br> "+font("White")+"System: "+font("#33aaaa")+"It costed you 80 coins.");
						//update DB
						break;
					case "The Silent Woods":
						//Walk Slowly Around V
				 		Console.log("<b>"+font("#33aaaa")+"You found a map! I wonder where it leads to...");	
				 		hasmap=1;
						break;
					case "The Zygons Tribe":
						//Fight A Zygon X
						fightmanster(20,61,300,"Zygon",40,50,15,80);
						break;
					case "Seamol City":
						//Consult The Mayer V
				 		Console.log("<b>"+font("#33aaaa")+"The Mayer says you should go and fight the Coco Manster.");	
						break;
					case "Crocodile Bridge":
						//Jump From The Bridge U
				 		Console.log("<b>"+font("#33aaaa")+"HA HA! The crocodiles ate you! <br> "+font("White")+"System: "+font("#33aaaa")+
				 				"Who's that crazy that jumps from the bridge?!<br> "+font("White")+"System: "+font("#33aaaa")+
				 				"You has been send to the hospital to patch your character's <br> "+font("White")+"System: "+font("#33aaaa")+ "injuries."+
				 				"The treatment cost you 100 coins. Don't warry - if <br> "+font("White")+"System: "+font("#33aaaa")+"you didn't have that sum - nothing won't be taken <br> "+font("White")+"System: "+font("#33aaaa")+"from you. Take Care!");
				 		//update DB
						break;
					case "Coconut Forest":
						//Fight The Coco Manster X
				 		fightmanster(20,61,1000,"Coco",80,700,70,300);
						break;
					case "Chimaki Hospital":
						//Return Home U
				 		Console.log("<b>"+font("#33aaaa")+"You returned home in safety.");	
				 		$.get('gameservlet', { action: "moveto", direction: "Home"}, 
								function(responseJson){
							displayLocation();
						}
						);
				 		//update DB
						break;
					case "The Ghosts Casle":
						//Fight A Ghost X
				 		fightmanster(20,61,300,"Ghost",35,40,15,60);	 
						break;
					case "The Screamers Prison":
						//Return Home U
						//Console.log("<b>"+font("#33aaaa")+flagprison);
						if((countcell>=3 && flagdo==1) || pardonflag==1){
							if(pardonflag==1){
								Console.log("<b>"+font("#33aaaa")+"Thanks to your pardon you are free to go home!");	
								pardonflag=0;
							}
							else Console.log("<b>"+font("#33aaaa")+"You cleaned your cell 3 times and did all <br> "+font("White")+"System: "+font("#33aaaa")+
									"what the screamers told you to do. <br> "+font("White")+"System: "+font("#33aaaa")+"You are free to go home!");
				 			Console.log("<b>"+font("#33aaaa")+"You returned home in safety.");	
				 			$.get('gameservlet', { action: "moveto", direction: "Home"}, 
									function(responseJson){
								displayLocation();
							}
							);
				 			flaghome=1;
				 			flagprison=0;
						}
						if(flagprison==0)
						{
							if(flaghome==0)
								Console.log("<b>"+font("#33aaaa")+"You are only a visitor - you can walk on your own.");	
						}
						else if(flagprison==1){
							Console.log("<b>"+font("#33aaaa")+"Hold on! Not so fast!<br> "+font("White")+"System: "+font("#33aaaa")+
									"In order to go back home you should clean your cell<br> "+font("White")+"System: "+font("#33aaaa")+
									"at least 3 times and do what the screamers tells you to do.");	
						}
				 		//update DB
						break;
				}
				break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	 			 			
	 		
		case "/act2":
			if(mapInfo.get("act2")!= null){
				switch (mapInfo.get("location")){
				case "Home":
					//Travel The Garden V
			 		Console.log("<b>"+font("#33aaaa")+"Nothing in the garden");
					break;
				case "The Hawks Cliff":
					//Travel Around V
			 		Console.log("<b>"+font("#33aaaa")+"You found the <b>"+font("blue") +"The Blue Ring!<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"That amulet adds you 5 exp and 25 hp!");
					break;
				case "The Amaya Throng":
					//Fight The Amaya Manster X
			 		fightmanster(20,61,300,"Amaya",35,40,15,60);	
					break;
				case "Green City":
					//Visit A Fortune Teller V
			 		Console.log("<b>"+font("#33aaaa")+"The fortune teller says there is a lot of money in your way..<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"In order to get it you need find a mystery object..");
					break;
				case "Torchwood":
					//Go To Woodens Store 
					displayStore();
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "The Silent Woods":
					//Walk Loudly Around U
			 		Console.log("<b>"+font("#33aaaa")+"Great! Now you waked up these trees! <br> "+font("White")+"System: "+font("#33aaaa")+ 
			 				"And they are very mad about you! RUN!!!<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"You ran to Torchwood. You lost 5 attack. <br> "+font("White")+"System: "+font("#33aaaa")+
			 				"DON'T YOU WAKE THEM UP AGAIN!");
			 		//update DB
					break;
				case "The Zygons Tribe":
					//Talk To The Tribe Chief X
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Seamol City":
					//Help The Poor People Of The City U
			 		Console.log("<b>"+font("#33aaaa")+"You helped the poor people in town by giving up<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"150 coins of your money.<br> "+font("White")+"System: "+font("#33aaaa")+"Because of your generosity you earned 30 exp!");
			 		//update DB
					break;
				case "Crocodile Bridge":
					//Fight The Enormous Crocodile X
			 		fightmanster(20,61,300,"Enormous Crocodile",35,40,15,60);	
					break;
				case "Coconut Forest":
					//Travel Around X
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Chimaki Hospital":
					//Get An Injection U
			 		Console.log("<b>"+font("#33aaaa")+"Aouch! That hurts! It costed you 150 coins.");
			 		//update DB
					break;
				case "The Ghosts Casle":
					//Scare The Ghosts U
			 		Console.log("<b>"+font("#33aaaa")+"You scared the ghosts and you found <b>"+font("blue") +"The Steel Sword!<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"That amulet adds you 30 exp and 35 hp!");
					//update DB
					break;
				case "The Screamers Prison":
					//Clean Your Cell V
					if(flagcell==0){
						countcell=0;
						flagcell=1;
					}
					countcell++;
					if (countcell==1)
						Console.log("<b>"+font("#33aaaa")+"Yuck! You cleaned all the spider miners in your cell.");
					else if(countcell==2)
						Console.log("<b>"+font("#33aaaa")+"You organized all of your stuff in your cell.");
					else if(countcell==3)
						Console.log("<b>"+font("#33aaaa")+"You polished your cell and you are exhausted.");
					else if(countcell>=4)
						Console.log("<b>"+font("#33aaaa")+"Your cell shines! Stop cleaning it!");
					break;
			}
			break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	 		
		case "/act3":
			if(mapInfo.get("act3")!= null){
				switch (mapInfo.get("location")){
				case "The Amaya Throng":
					//Jump To The Throng U
			 		Console.log("<b>"+font("#33aaaa")+"You injured very badly because of rocks in the throng.<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"What have you been thinking?! Have you lost your mind?!<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"You has been send to the hospital to patch your character's <br> "+font("White")+"System: "+font("#33aaaa")+ "injuries. "+
			 				"The treatment cost you 100 coins. Don't warry - if <br> "+font("White")+"System: "+font("#33aaaa")+"you didn't have that sum - nothing won't be taken <br> "+font("White")+"System: "+font("#33aaaa")+"from you. Take Care!");
			 		//need to update the DB
					//send to hospital
					$.get('gameservlet', { action: "moveto", direction: "Chimaki Hospital"}, 
							function(responseJson){
						displayLocation();
					}
					);
					break;
				case "Green City":
					//Visit The Local Casino X
			 		//rand function
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Torchwood":
					//Go To Yammi Restaurant U
			 		Console.log("<b>"+font("#33aaaa")+"Yammi! You enjoyed a tasty meal in the Yammi Restaurant. <br> "+font("White")+"System: "+font("#33aaaa")+"It costed you 50 coins.");
					//update DB
					break;
				case "The Silent Woods":
					//Fight The Trees X
			 		fightmanster(20,61,300,"Trees",35,40,15,60);
					break;
				case "Seamol City":
					//Go To Pak Store
					displayStore();
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Crocodile Bridge":
					//Swim Around X
			 		Console.log("<b>"+font("#33aaaa")+"");
					break;
				case "Chimaki Hospital":
					//Buy A Potion U
			 		Console.log("<b>"+font("#33aaaa")+"You drank the potion. It costs 150 coins.");
					//update DB
					break;
				case "The Screamers Prison":
					//Do What The Screamers Tells You
			 		Console.log("<b>"+font("#33aaaa")+"They shouted at you and hited you but you did it!<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"You did all what they wanted you to do - cleaned there<br> "+font("White")+"System: "+font("#33aaaa")+
			 				"cells, run in circles in the beat down sun and you even<br>"+font("White")+"System: "+font("#33aaaa")+"made them laugh!");
					flagdo=1;
					break;
			}
			break;
			}else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
	 			 		 		
		case "/act4":
			if(mapInfo.get("act4")!= null){
				switch (mapInfo.get("location")){
					case "The Silent Woods":
						//Try To Find The Treasure U
						if(hasmap==1){
				 			Console.log("<b>"+font("#33aaaa")+"WOW! YOU FOUND THE TREAURE!<br> "+font("White")+"System: "+font("#33aaaa")+
				 					"You found 1000 coins!");
				 			hasmap=2;
						}
						else if(hasmap==0)
							Console.log("<b>"+font("#33aaaa")+"You can't find the treasure without the map.<br> "+font("White")+"System: "+font("#33aaaa")+
									"Look for the map first.");
						else Console.log("<b>"+font("#33aaaa")+"You already found the treasure!");
						//update DB
						break;
					case "Seamol City":
						//Kill Some People Around
				 		Console.log("<b>"+font("#33aaaa")+"What have you done?! Are you crazy?!<br> "+font("White")+"System: "+font("#33aaaa")+
				 				"Now you are going to Jail!");
				 		$.get('gameservlet', { action: "moveto", direction: "The Screamers Prison"}, 
								function(responseJson){
							displayLocation();
						}
						);
				 		//update DB
				 		flaghome=0;
				 		flagprison=1;
				 		flagcell=0;
				 		pardonflag=0;
				 		
						break;
					case "Chimaki Hospital":
						//Take A pill U
				 		Console.log("<b>"+font("#33aaaa")+"You took a power pill! It costed you 100 coins.");
						//update DB
						break;
					case "The Screamers Prison":
						//Ask For Pardon X
				 		Console.log("<b>"+font("#33aaaa")+"The court of law forgive you.<br>"+font("White")+"System: "+font("#33aaaa")+
				 				"You can now leave the prison.");
				 		pardonflag=1;
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
	 			//Console.log("<b>"+font("orange")+flagprison);
	 			if((flagprison==0 && mapInfo.get("location")==("The Screamers Prison")) || mapInfo.get("location")!="The Screamers Prison"){
			 		//Sending AJAX to update map DB	
					$.get('gameservlet', { action: "moveTo", direction: msg}, 
							function(responseJson){
						displayLocation();
					}
					);
		 		}
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

	 		break;


	 	//buy premium items
	 	case "/premium":
	 		newItem();
			break;
		
	 	case "/battle":
	 		toggle_visibility('battleBoxPosition');
	 		document.getElementById("exit").value = "Forfeit";
	 		break;		
		default:
			if (isNum(msg) && mode=="store"){
	 		<%System.out.println("test");
			int numOfItems = gdb.getItemsCount(username);%>
			
			//checking if legal character number has been selected
			if(msg > 0 && msg <= <%=numOfItems%> && <%=numOfItems%>!=-1){
			
				
				$.get('gameservlet', { action: "buyFromStore", username: '<%=username%>', itemsChars: itemsChars[msg-1]}, 
				function(responseAns){
					if(ans==1){
						Console.log(font("#009700")+"</font>!your purchase was successful!");
					}
					else{
						Console.log(font("#009700")+"</font>!You do not have enough money!");
					}
				});
				mode = "started";
				itemsChars=[];
				displayLocation();
				
				} else {
				Console.log(font("red")+"item #"+msg+" does not exist!<br>");
			
				}
			}

			//If player is new, he must select a character
			else if(mode=="new" && isNum(msg)){
				<%int numOfChars = gdb.charCount();%>
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
				<%int itemsCount = gdb.PremiumItemsCount();
			int price = 0;
			rs = gdb.getPremiumItems();
			String itemName = null;
			for (int j = 1; rs.next(); j++) {
				itemName = rs.getString(1);
				price = gdb.getItemPrice(itemName);
			}%>
				
				//checking if legal character number has been selected
				if(msg > 0 && msg <= <%=itemsCount%>){
				
				    //read updated coins of user after buying using ajax
					 $.get('gameservlet', { action: "getMoney", username: '<%=username%>',price: premItemsPrice[msg-1]}, 
					function(responseJson){
						$.each(responseJson, function(key, value){
							if(value=="1"){
								Console.log(font("red")+key+"<b>");	
							}
							
							else if(value!="1"){
					            Console.log(font("#009700")+"You have selected <b>" + font("blue") + premItems[msg-1] + "</b></font>! ");
								//Sending data to servlet, to be inserted into DB
								$.get('gameservlet', { action: "premItem", price: premItemsPrice[msg-1], username: '<%=username%>' ,item:premItems[msg-1] });
								Console.log(font("red")+key+" <b>"+font("orange")+value+"$");
							}
						});
					}, 
					'json');		
					mode="started";
				}
				else
					Console.log(font("red")+"Item #"+msg+" does not exist!<br>");
					
				
			}
			else 
	 			Console.log(font("red")+"'"+input+"' is not a valid command.<br>Type /cmd to see the available commands.");
			
	
		}//switch
		
	 } //chat.sendMessage
	
		
	 
	//function Add new item from premium store
	 function  newItem(){
	     <%int cash = gdb.getPlayerMoney(username);%>
		 Console.log("you can select one of the following premium items:");
		 if(flag=="")
		 	Console.log(font("red")+"Money you have: "+" <b>"+font("orange")+<%=cash%>+"$");
		 flag="1";
								 
		//Print premium items and price from DB and add to arrays
		<%rs = gdb.getPremiumItems();
			for (int i = 1; rs.next(); i++) {
				String item = rs.getString(1);
				int Price = gdb.getItemPrice(item);%>
		 
		Console.log(font("blue")+"<%=i%></font> - <b> <%=item%> ,price=<%=Price%> $</b>");
		premItemsPrice.push("<%=Price%>");
		premItems.push("<%=item%>");
		
		<%}%>
		Console.log("You can select  item by typing the relevant number");
		mode="premium";
	}
	 
	 
	 
	//Add new player
	function newPlayer(username){
		Console.log("First, you must select one of the following characters:");
	
		//Print selectable chars and add to array
		<%int i;
			rs = gdb.getChars();
			String character;
			for (i = 1; rs.next(); i++) {
				character = rs.getString(1);%>
		Console.log(font("blue")+"<%=i%></font> - <b><%=character%></b>");
		startChars.push("<%=character%>");
		<%}%>
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
		
 		mapInfo.clear();
		
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
		
	} //display location
	
	function displayStore(){
		itemsChars=[];
		<%rs = gdb.getStoreItems(username);

			String item_name;
			String item_description;
			String item_bonus1;
			String item_bonus2;
			String item_price;

			for (i = 1; rs.next(); i++) {
				item_name = rs.getString("item");
				item_description = rs.getString("description");
				item_bonus1 = rs.getString("bonus1");
				item_bonus2 = rs.getString("bonus2");
				item_price = rs.getString("price");
				//if ther is two bonus to the item

				if (item_bonus2 != null) {%>
				
				Console.log(font("blue")+"<%=i%></font> - <b><%=item_name%> &nbsp;&nbsp;  bonus1: <%=item_bonus1%> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bonus2: <%=item_bonus2%> &nbsp;&nbsp; itme_price: <%=item_price%><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;item description: <%=item_description%></b>");
				
				<%//if ther is one bonus to the item
				} else {%>
				Console.log(font("blue")+"<%=i%></font> - <b><%=item_name%> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bonus1: <%=item_bonus1%> &nbsp;&nbsp; itme_price: <%=item_price%><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;item description: <%=item_description%></b>");
				<%}%>

			itemsChars.push("<%=item_name%>");
		<%}%>
		
		mode="store";
	}
	
	
	function fightmanster(min,max,value,name,exptoadd,coinstoadd,exptolose,coinstolose)
	{
		<%atk = gdb.getatk(username);
			defense = gdb.getdefense(username);
			speed = gdb.getspeed(username);
			hp = gdb.gethp(username);
			exp = gdb.getexp(username);%>
		
		//rand function
		var randomNum = Math.floor((Math.random() * max) + min); 
		//Console.log("<b>"+font("#33aaaa")+(<%=atk%>)+ " "+(<%=defense%>)+ " "+(<%=speed%>)+ " "+(<%=hp%>)+ " "+(<%=exp%>)+ " "+randomNum+ " "+ (<%=atk%>+<%=defense%>+<%=speed%>+<%=hp%>+<%=exp%>+randomNum));
		if(<%=atk%>+<%=defense%>+<%=speed%>+<%=hp%>+<%=exp%>+randomNum>value){
			Console.log("<b>"+font("#33aaaa")+"You have defeated the "+name+" Monster!<br> "+font("White")+"System: "+font("#33aaaa")+
					"You earned "+exptoadd+" exp and "+coinstoadd+" coins.");
 			//update DB
			$.get('gameservlet', { action: "updatefight", username: '<%=username%>',expto: exptoadd, coinsto: coinstoadd, flag: 1});
 	
		}
		else {
			Console.log("<b>"+font("#33aaaa")+"Oh No! <br> "+font("White")+"System: "+font("#33aaaa")+
					"You could not beat the "+name+" Monster!<br> "+font("White")+"System: "+font("#33aaaa")+
					"You lost "+exptolose+" exp and your character lost "+coinstolose+" coins!<br> "+font("White")+"System: "+font("#33aaaa")+
					"You has been send to the hospital to patch your character's <br> "+font("White")+"System: "+font("#33aaaa")+ "injuries."+
	 				"The treatment cost you 100 coins. Don't warry - if <br> "+font("White")+"System: "+font("#33aaaa")+"you didn't have that sum - nothing won't be taken <br> "+font("White")+"System: "+font("#33aaaa")+"from you. Take Care!");
			//send to hospital
			$.get('gameservlet', { action: "moveto", direction: "Chimaki Hospital"}, 
					function(responseJson){
				displayLocation();
			}
			);
		
			//update DB
			$.get('gameservlet', { action: "updatefight", username: '<%=username%>',
				expto : exptolose,
				coinsto : coinstolose,
				flag : 0
			});

		}
	}
	
	//////////////////
	//Battle Section//
	/////////////////
	
	//open/close battle popup
	function toggle_visibility(id) {
		var e = document.getElementById(id);
		//If battle window is open
		if(e.style.display == 'block'){
			if(phase=="over") {
				e.style.display = 'none';
				clearBattleLog();
			}
			else{
				var exit_text = "Closing the game will count as a lose.\nAre you sure you want to exit?";
				if(window.confirm(exit_text)){
					e.style.display = 'none';
					clearBattleLog();
					endGame(opponent, username, 0, false);
				}
			}	
		}
		//If battle window is closed
		else{
			e.style.display = 'block';
			battlechat.startListen();
			startBattle();
		}
	}
	
	//Cleans the battle window
	function clearBattleLog(){
		var battle = document.getElementById('battle');
		while (battle.firstChild)
			battle.removeChild(battle.firstChild);
	}
	
	//Writes messages into battle
	battle.log = (function(message) {
		var battle = document.getElementById('battle');
		var p = document.createElement('p');
		p.style.wordWrap = 'break-word';
		p.innerHTML = (message=="") ? "<br>" : system+message;
		battle.appendChild(p);
		while (battle.childNodes.length > 25) {
			battle.removeChild(battle.firstChild);
		}
		battle.scrollTop = battle.scrollHeight;
	});
	 
	//initializing character information
	function initChars() {
		//player 1 character
		<%
		rs = gdb.getCharacterInfo(username);
		if(rs.next()){
			my_char = rs.getString("character");
		%>
		p1["char"] = '<%=my_char%>';
		p1["level"] = <%=rs.getString("level")%>;
		p1["attack"] = <%=rs.getString("attack")%>;
		p1["defense"] = <%=rs.getString("defense")%>;
		p1["speed"] = <%=rs.getString("speed")%>;
		p1["hp"] = <%=rs.getString("hp")%>;
		p1["exp"] = <%=rs.getString("exp")%>;
		<%
		}
		rs = gdb.getCharAttacks(my_char);
		if(rs.next()){
		%>
		p1["atk1"] = '<%=rs.getString("atk1")%>';
		p1["atk2"] = '<%=rs.getString("atk2")%>';
		<% } %>
		
		//player 2 character
		<%
		rs = gdb.getCharacterInfo(opponent);
		if(rs.next()){
			opp_char = rs.getString("character");
		%>
		p2["char"] = '<%=opp_char%>';
		p2["level"] = <%=rs.getString("level")%>;
		p2["attack"] = <%=rs.getString("attack")%>;
		p2["defense"] = <%=rs.getString("defense")%>;
		p2["speed"] = <%=rs.getString("speed")%>;
		p2["hp"] = <%=rs.getString("hp")%>;
		p2["exp"] = <%=rs.getString("exp")%>;
		<%
		}
		rs = gdb.getCharAttacks(opp_char);
		if(rs.next()){
		%>
		p2["atk1"] = '<%=rs.getString("atk1")%>';
		p2["atk2"] = '<%=rs.getString("atk2")%>';
		<% } %>
		
	}
	
	//starting battle mode
	function startBattle() {
		initChars();
		battle.log(font("#551A8B")+"<b>The battle is starting!");
		battle.log("Your opponent is <b>"+font("blue")+opponent);
		battle.log("Your <b>"+font("blue")+'<%=my_char%>'+"</font> "+font("orange")+"(Level "+p1["level"]+")</font></b> VS <b>"+
				font("blue")+opponent+"</b></font>'s <b>"+font("blue")+'<%=opp_char%>'+"</font> "+font("orange")+"(Level "+p2["level"]+")");
		battle.log("<b>In each turn, you must select an attack.");
		battle.log("<b>First one to reach 0 HP loses.")
		battle.log("");
		//battle.log("")
		//wait for 1.8 seconds and start player1's turn
		setTimeout(myTurn, 1800);
	}
	
	
	//If Enter key has been pressed
	battlechat.startListen = function () {
		document.getElementById('battleMsg').onkeydown = function(event) { 		
			//Listening for Enter Key 
			if (event.keyCode == 13) {	 	 			
				input = document.getElementById('battleMsg').value;
				
				//clear cmd line
				document.getElementById('battleMsg').value = ""; 	 	
				
				battlechat.sendMessage();
			}
		};
	};
	
	//Command handler
	battlechat.sendMessage = function () { 
		var msg = input.replace(/ /g,'').toLowerCase();
		
		if(phase=="turn"){
			var move;	
			if(msg=="1"){
				move = p1["atk1"];
				Attack(move, username);
			}
			else if(msg==2){
				move = p1["atk2"];
				Attack(move, username);
			}
			else
				battle.log(font("red")+"'"+input+"' is not a valid attack.");	
		}
		else if(phase=="over")
			battle.log(font("red")+"The game has already ended!");
		else
			battle.log(font("red")+"'"+input+"' is not a valid command.");
	};
	
	//player 1's turn
	function myTurn(){
		phase="turn";
		battle.log(font("#009700")+"<b>Your move!")
		battle.log("Select one of your available attacks by typing its number.");
		battle.log(font("blue")+"1</font> - <b>"+font("#FF69B4")+p1["atk1"]);
		battle.log(font("blue")+"2</font> - <b>"+font("#FF69B4")+p1["atk2"]);
	}
	
	//unleash an attack
	function Attack(move, attacker){
		battle.log(font("#009700")+"<b>Turn #" + turn++);
		if(attacker == username){
			battle.log(username+"'s <b>"+font("blue")+'<%=my_char%>'+"</b></font> used <b>"+font("blue")+move+"</b></font> on "+
						opponent+"'s <b>"+font("blue")+'<%=opp_char%>');
			Damage('<%=opp_char%>');
			var rand = Math.floor(Math.random() * 100) + 1;
			if(phase!="over") 
				Attack(rand, opponent);
		}
		else{
			if(move%2==0)
				move = p2["atk1"];
			else move = p2["atk2"];
			battle.log(opponent+"'s <b>"+font("blue")+'<%=opp_char%>'+"</b></font> used <b>"+font("blue")+move+"</b></font> on "+
					username+"'s <b>"+font("blue")+'<%=my_char%>');
			Damage('<%=my_char%>');
			if(phase!="over") 
				myTurn();
		}	
	}
	
	//Damage function
	function Damage(target){
		var me,opp;
		
		//initialization
		if(target=='<%=my_char%>'){
			me = p2;
			opp = p1;
		}
		else{
			me = p1;
			opp = p2;
		}
		
		//Calculating damage formula
		var rand = (Math.random() * 100) + 1;
		var critical = (rand <= 8) ? 2 : 1;
		rand = (Math.random() * 1) + 0.85;
		var modifier = rand * critical;
		var damage_formula = Math.floor((((2 * me["level"] + 10) / 250) * (me["attack"]/opp["defense"]) * 50 + 2) * modifier);	
		
		//Printing battle log
		if(critical == 2) battle.log(font("red")+"<b>Critical hit!");
		battle.log("The attack has dealt <b>"+font("red")+damage_formula+"</b></font> damage to <b>"+font("blue")+target);
		opp["hp"]-=damage_formula;
		battle.log("<b>"+font("blue")+target+"</b></font>'s current HP is <b>"+font("orange")+Math.max(opp["hp"],0));
		battle.log("");
		
		//If battle is over
		if(opp["hp"] <= 0){
			var winner = (target=='<%=my_char%>') ? opponent : username;
			var loser = (target=='<%=my_char%>') ? username : opponent;
			battle.log(font("blue")+"<b>"+target+"</font> has no HP left."); 
			battle.log("<b>"+font("#009700")+winner+"</font> is the winner!");
			battle.log("");
			var exp = (100/(opp["level"] * me["level"]));
			var levelup;
			battle.log("exp gain: "+exp+" current exp: "+me["exp"]);
			var new_exp = exp + me["exp"];
			battle.log("new exp: "+ new_exp);
			if(new_exp >= 100){
				levelup = "true";
				exp = new_exp - 100;
				me["exp"] = exp;
				me["level"]++;
			}
			else{
				levelup = "false";
				me["exp"] += exp;
			}
			phase="over";
			endGame(winner,loser,exp,levelup);
		}
	}
	    
	//End of game, updating databases
	function endGame(win,lose,exp,lvlup){
		document.getElementById("exit").value = "Exit";
		$.get('gameservlet', { action: "battleOver", winner: win, loser: lose, exp: exp, levelup: lvlup});
	}
	
</script>

</head>
<body>
	<div id="content">
		<font color='blue'><b>To start the game, please type <font
				color='red'>/start</font> in the box below.
		</b><br /> <b>To see the list of possible commands, type <font
				color='red'>/cmd</font></b><br /> <br /> <b>To access the premium
				store, type <font color='red'>/premium</font>
		</b><br /> <b>Enjoy your gaming!</b><br /> <br /> <br /></font>

		<div id="right">

			<div id="mapDisplay"
				style="background: url('images/worldMap.png'); width: 280px; height: 360px; border: thick; border-style: dotted solid; border-color: black; position: relative; left: -10px; visibility: hidden;">
				<img id="pin" src="images/pin.gif"
					style="width: 90px; height: 70px; position: relative;">
			</div>

		</div>

		<div id="battleBoxPosition">
			<div class="battleBoxWrapper">
				<div class="battleBoxContent">
					<h3>Battle Scene</h3>
					<div id="battle-container">
						<div id="battle"></div>
					</div>
					<input name='un' id='un' type='hidden'
						value='${sessionScope.username}' />
					<p>
						<input type="text" style="border: 2px solid"
							placeholder="type your commands here." id="battleMsg">
					</p>
					<p>
						<input id="exit" type="button"
							onclick="toggle_visibility('battleBoxPosition');" value="Forfeit" />
					</p>
				</div>
			</div>
		</div>

		<div id="console-container">
			<div id="console"></div>
		</div>
		<input name='un' id='un' type='hidden'
			value='${sessionScope.username}' />
		<p>
			<input type="text" style="border: 2px solid"
				placeholder="type your commands here." id="chat" name="msg">
		</p>


	</div>

</body>
</html>