<%@ page import="Database.GameDB" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<head>
		<title>Battle</title>

		<style type="text/css">
			#battleBoxPosition{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;
			}
			.battleBoxWrapper{
				width: 550px; margin: 50px auto; text-align: left;
			}
			.battleBoxContent{
				background-color: #FFF; padding: 15px;
			}
			input#battleMsg {
            	width: 450px
	        }
	
	        #battle-container {
	            width: 441px;
	        }
	
	        #battle {
	            border: 2px solid #CCCCCC;
	            border-right-color: #999999;
	            border-bottom-color: #999999;
	            height: 300px;
	            overflow-y: scroll;
	            padding: 5px;
	            width: 100%;
	        }
	
	        #battle p {
	            padding: 0;
	            margin: 0;
	        }
		</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>		
<script type="text/javascript">
	window.chat = {};
	var battle = {};
	var system = "<font color=red><b>System:</b> </font>";
	var p1 = {};
	var p2 = {};
	var phase = "";
	var turn = 1;
	
	<%
	GameDB gdb = new GameDB();
	String username = (String)session.getAttribute("username");
	ResultSet rs;
	String opponent = gdb.getOpponent(username);
	String my_char="", opp_char="";
	%>
	
	var opponent = '<%=opponent%>';
	var username = '<%=username%>';
	
	
	//open/close battle popup
	function toggle_visibility(id) {
		var e = document.getElementById(id);
		//If battle window is open
		if(e.style.display == 'block'){
			if(phase=="over") 
				e.style.display = 'none';
			else{
				var exit_text = "Closing the game will count as a lose.\nAre you sure you want to exit?";
				if(window.confirm(exit_text))
					e.style.display = 'none';
			}	
		}
		//If battle window is closed
		else
			e.style.display = 'block';
	}
	    
	//returns a colored message
	function font(color, msg){
		return "<font color="+color+">";
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
	
	//Starts listening for messages
	onload = function() {
		chat.startListen();
		startBattle();
	};
	 
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
	chat.startListen = function () {
		document.getElementById('battleMsg').onkeydown = function(event) { 		
			//Listening for Enter Key 
			if (event.keyCode == 13) {	 	 			
				input = document.getElementById('battleMsg').value;
				
				//clear cmd line
				document.getElementById('battleMsg').value = ""; 	 	
				
				chat.sendMessage();
			}
		};
	};
	
	//Command handler
	chat.sendMessage = function () { 
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
			var exp = (100/(opp["level"] * me["level"])).toFixed(2);
			var levelup;
			if(me["exp"] + exp >= 100){
				levelup = "true";
				exp = 100 - exp;
			}
			else levelup = "false";
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

		<div id="battleBoxPosition">
			<div class="battleBoxWrapper">
				<div class="battleBoxContent">
					<h3>Battle Scene</h3>
					<div id="battle-container">
						<div id="battle"></div>
					</div>
					<input name='un' id='un' type='hidden' value='${sessionScope.username}'/>
					<p>
						<input type="text" style="border:2px solid" placeholder="type your commands here." id="battleMsg">
					</p>
					<p><input id="exit" type="button" onclick="toggle_visibility('battleBoxPosition');" value="Forfeit"/></p>
				</div>
			</div>
		</div>

		<div id="wrapper">
			<center><input type="button" onclick="toggle_visibility('battleBoxPosition');" value="Battle!"/></center>
		</div><!-- wrapper end -->

	</body>

</html>