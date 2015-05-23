<!DOCTYPE html>
<html >
<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="main">
  <jsp:include page="header.jsp"/>
  
  <div id="content">
    <jsp:include page="sidebar.jsp"/>
    <div id="left">
    <br>
      <center><h1>Game Guide </h1></center>
      <br/>
      <p>Table of contents:</p><br>
      - <a href="#General" style="color: blue">General</A><br>
      - <a href="#Item_list" style="color: blue">Item list</A><br>
      - <a href="#Map" style="color: blue">Map</A><br>
      - <a href="#Characters" style="color: blue">Characters</A><br>
      - <a href="#Chat_rules" style="color: blue">Chat rules</A><br>
    <br><br>
    <h3 style="color: black"><u><A NAME=General>General:</A></u></h3>
    This text based RPG is being developed for players who want to enjoy a strategy game combining social chat that communicates between players.
    The players can play a single player game, to advance their figures on the game map, to reach higher level, achieve higher score or obtain new items.
    In addition, the players can participate in battles with another players, their 'strength' is determined by their achievements in the single player game, the players can chat in the chat room and send private messages to each other.
    <br><br>
    <p></p>
    <h3 style="color: black"><u><A NAME=Item_list>Item list:</A></u></h3>
    This is a <b>Blue Amulet</b>.<br>An amulet that increase your attack by 20, your exp by 15% and your HP by 15.<br>
    You can buy this item from "Pak" Store in "Seamol City", it's price is: 180 coins.
    <img src="images/Blue_Amulet.jpg" alt="Blue Amulet" style="width:250px;height:228px"/> <br>
    This is a <b>Blue Ring</b>.<br>A Ring that increase your defense by 15, your exp by 5% and your HP by 25.<br>
    You can buy this item from "Pak" Store in "Seamol City", it's price is: 75 coins.
    <img src="images/Blue_Ring.jpg" alt="Blue Ring" style="width:220px;height:200px"/> <br>
    This is a <b>Green Dragon Amulet</b>.<br>An amulet that decrease your enemy's attack by 30,<br>increase your exp by 28% and your HP by 10.<br>
    You can buy this item from "Woodens" Store in "Torchwood", it's price is: 270 coins.
    <img src="images/Green_Dragon_Amulet.jpg" alt="Green Dragon Amulet" style="width:290;height:250px"/> <br>
    This is a <b>Red Key</b>.<br>A key that increase your speed by 15,your exp by 10% and your HP by 28.<br>
    You can buy this item from "Greenvas" Store in "Green City", it's price is: 100 coins.
    <img src="images/Red_Key.jpg" alt="Red Key" style="width:300px;height:228px"/> <br>
    This is a <b>Steel Sword</b>.<br>An item that increase your attack by 45, your exp by 30% and your HP by 35.<br>
    You can buy this item from "Woodens" Store in "Torchwood", it's price is: 300 coins.
    <img src="images/Steel_Sword.jpg" alt="Steel Sword" style="width:250px;height:228px"/> <br>
    <p></p>
    <h3 style="color: black"><u><A NAME=Map>Map:</A></u></h3>
    <img src="images/worldMapcor.jpg" alt="Map"/> <br>
    1. This is <b>Home</b>. Your starting point to begin your journey.<br>
    2. This is <b>The Hawks Cliff</b>.<br>
    3. This is <b>The Amaya Throng</b>.<br>
    4. This is <b>Green City</b>.<br>
    5. This is <b>Torchwood</b>.<br>
    6. This is <b>The Silent Woods</b>.<br>
    7. This is <b>The Zygons Tribe</b>.<br>
    8. This is <b>Seamol City</b>.<br>
    9. This is <b>Crocodole Bridge</b>.<br>
    10. This is <b>Coconut  Forest</b>.<br>
    11. This is <b>"Chimaki" Hospital</b>.<br>
    12. This is <b>The Ghosts Castle</b>.<br>
    13. This is <b>The "Screamers" Prison</b>.<br>
    <br>
    <p></p>
    <h3 style="color: black"><u><A NAME=Characters>Characters:</A></u></h3>
    This is <b>Growlmon</b>. It has 60 Attack, 40 Defense, 55 Speed and 45 HP.<br>
    His Attacks are: "Dino Kick", "Fire Breath".
    <br>
    <img src="images/Growlmon.gif" alt="Growlmon"/> 
    <br>
    This is <b>Garurumon</b>. It has 55 Attack, 35 Defense, 60 Speed and 40 HP.<br>
    His Attacks are: "Freeze Fang", "Claw Attack".
    <br>
    <img src="images/Grorumon.gif" alt="Garurumon"/> 
    <br>
    This is <b>Angemon</b>. It has 70 Attack, 50 Defense, 35 Speed and 45 HP.<br>
    His Attacks are: "Angel Slam", "Air Blast".
    <br>
    <img src="images/Angemon.jpg" alt="Angemon"/> 
    <h3 style="color: black"><u><A NAME=Chat_rules>Chat rules:</A></u></h3>
    <b><u>Global message windows:</u></b><br>
    There is a global chat, where everything that is written by any player, is displayed to all the other players with the following format:
	"HH:MM Username: Message".
	The chat box will be viewable by all types of users.<br>
    <b>Curses are not allowed! A player that will be found hurting other players will be kicked off the chat (for a while) and in the worse case he will ban off the game for good!</b>
    <br><br><b><u>Private message windows:</u></b><br>
	Users are able to send private messages to other online players. This option is available to users by right-clicking any of the online users in the Online player box and clicking on Private Message. Another option would be using a command (/pm <username>).
	After selecting to send a private message, a window will pop-up and the private chat will be conducted there.

    <p></p>
      
    </div>
  </div>
  
  <jsp:include page="footer.jsp" />
</div>
  </body>

</html>
