<%@ page import="Database.BattleDB" %>
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
		
<script type="text/javascript">
	window.chat = {};
	var battle = {};
	var system = "<font color=red><b>System:</b> </font>";
	var p1 = {};
	var p2 = {};
	var phase = "";
	
	<%
  	BattleDB bdb = new BattleDB();
	String username = (String)session.getAttribute("username");
	ResultSet rs;
	String opponent = bdb.getOpponent(username);
	String my_char="", opp_char="";
	%>
	
	
	//open/close battle popup
	function toggle_visibility(id) {
		var e = document.getElementById(id);
		if(e.style.display == 'block')
			e.style.display = 'none';
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
		rs = bdb.getCharacterInfo(username);
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
		rs = bdb.getCharAttacks(my_char);
		if(rs.next()){
		%>
		p1["atk1"] = '<%=rs.getString("atk1")%>';
		p1["atk2"] = '<%=rs.getString("atk2")%>';
		<% } %>
		
		//player 2 character
		<%
		rs = bdb.getCharacterInfo(opponent);
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
		rs = bdb.getCharAttacks(opp_char);
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
		battle.log("Your opponent is <b>"+font("blue")+'<%=opponent%>');
		battle.log("Your character <b>"+font("blue")+'<%=my_char%>'+"</b></font> will be facing <b>"+
				font("blue")+'<%=opponent%>'+"</b></font>'s <b>"+font("blue")+'<%=opp_char%>');
		battle.log("<b>In each turn, you have to select an attack. First one to reach 0 HP loses.");
		battle.log("");
		myTurn();
	}
	
	//player 1's turn
	function myTurn(){
		phase="turn";
		battle.log(font("#009700")+"<b>Your move!")
		battle.log("Select one of your available attacks by typing its number.");
		battle.log(font("blue")+"1</font> - <b>"+font("#FF69B4")+p1["atk1"]);
		battle.log(font("blue")+"2</font> - <b>"+font("#FF69B4")+p1["atk2"]);
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
			var attack;
			
			if(msg=="1")
				attack = p1["atk1"];
			else if(msg==2)
				attack = p1["atk2"];
			else
				Console.log(font("red")+"'"+input+"' is not a valid attack.");	
			
		}
	};
	    
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
					<p>Click <a href="javascript:void(0)" onclick="toggle_visibility('battleBoxPosition');">here</a> to close.</p>
				</div>
			</div>
		</div>

		<div id="wrapper">

			<center><p>Click <a href="javascript:void(0)" onclick="toggle_visibility('battleBoxPosition');">here</a> to open the battle window.</p>
			</center>
			
		</div><!-- wrapper end -->

	</body>

</html>