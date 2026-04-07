<?xml version="1.0" encoding="UTF-8"?>
<template>
  <tab name="General">
    <row show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">	 
			<text>
				<![CDATA[
				<script language="Javascript">

				$( "form" ).submit(function( event ) {
				  event.preventDefault();
				})
				/*
				* Check to see if we're closing the ticket. If so, then display alert.
				*/
				function validateClose() {
					// Get the modal
					var modal = document.getElementById('myModal');

					// Get the <span> element that closes the modal
					var span = document.getElementsByClassName("close")[0];
				
					var status = document.getElementById("propertyValue(tkcStatus)");
					var selectedValue = status.options[status.selectedIndex].value;
					if (selectedValue == "Closed") {
						// When the user clicks on the button, open the modal 
						modal.style.display = "block";

						// When the user clicks on <span> (x), close the modal
						span.onclick = function() {
							modal.style.display = "none";
						}

						// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						if (event.target == modal) {
							modal.style.display = "none";
							}
						}
					}
				}
				
				/*
				* Counter function
				*/
				// Set the date/time we're counting down from
				//var countDownDate = new Date("Jan 5, 2021 15:37:25").getTime();
				var dateTime = new Date();
				dateTime.setMinutes(dateTime.getMinutes()+25);
				var countDownDate = dateTime;

				// Update the count down every 1 second
				var countdownfunction = setInterval(function() {

				  // Get todays date and time
				  var now = new Date().getTime();
				  
				  // Find the distance between now an the count down date
				  var distance = countDownDate - now;
				  
				  // Time calculations for days, hours, minutes and seconds
				  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
				  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
				  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
				  
				  // Output the result in an element with id="demo"
				  document.getElementById("countDown").innerHTML = "  " + days + "d " + hours + "h "
				  + minutes + "m " + seconds + "s ";
				  
				  // If the count down is over, write some text 
				  if (distance < 0) {
					clearInterval(countdownfunction);
					document.getElementById("countDown").innerHTML = "  TAKE A BREAK";
				  }
				}, 1000);				
				
				/*
				* Timer for effort
				*/
				var startTime = Math.floor(Date.now() / 1000); //Get the starting time (right now) in seconds
				localStorage.setItem("startTime", startTime); // Store it if I want to restart the timer on the next page
				
				function startTimeCounter() {
					var now = Math.floor(Date.now() / 1000); // get the time now
					var diff = now - startTime; // diff in seconds between now and start
					var m = Math.floor(diff / 60); // get minutes value (quotient of diff)
					var s = Math.floor(diff % 60); // get seconds value (remainder of diff)
					m = checkTime(m); // add a leading zero if it's single digit
					s = checkTime(s); // add a leading zero if it's single digit
					document.getElementById("clock").innerHTML = "  " + m + ":" + s; // update the element where the timer will appear
					var t = setTimeout(startTimeCounter, 500); // set a timeout to update the timer
				}

				function checkTime(i) {
					if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
					return i;
				}
				
				/*
				* Side tab functions
				*/
				$( "form" ).submit(function( event ) {
				  event.preventDefault();
				})
				/*
				* Check to see what the side tab was set to. 
				* Display modified side bar to match.
				*/
				function checkSideTab() {
					// Get the <closebtn> element that closes the side bar
					var closebtn = document.getElementsByClassName("closebtn")[0];
				
					var sideTabField = document.getElementById("propertyValue(relTkcTktOid_tktFieldB009)");
					var selectedValue = sideTabField.options[sideTabField.selectedIndex].value;
					if (selectedValue == "Reports") {
						document.getElementById("mySidenav").style.width = "250px";
						document.body.style.backgroundColor = "rgba(0,0,0,0.4)";

						// When the user clicks on <closebtn> (x), close the side bar
						closebtn.onclick = function() {
							document.getElementById("mySidenav").style.width = "0";
							document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
						}
					}
				}
				
				/*
				 * Banner toggle function
				 */
	            function toggle() {
					var banner = document.forms[0].elements['propertyValue(relTkcOrgOidcl_orgFieldC004)'];
					document.getElementById('toggleBanner').innerHTML = banner.value;
					document.getElementById('propertyValue(relTkcOrgOidcl_orgFieldC004)-span').style.display ="none";
					if(banner.value == null || banner.value == "") {
						document.getElementById('toggleBanner').style.display = "none";
					}
    	            else {
						document.getElementById('toggleBanner').style.display = "block";
	                }
	            }		
				
				/*
				* JS enabler function. Enables features to be utilized for CSS page.
				*/
				function enabler() {
					// Client Organization Name
					var orgName = document.forms[0].elements["propertyValue(relTkcOrgOidcl_orgName)"];
					document.getElementById('orgNameDisplay').innerHTML = orgName.value.bold();
					
					// Client Contact Name
					var conName = document.forms[0].elements["propertyValue(relTkcConOid_conNameView)"];
					document.getElementById('conNameDisplay').innerHTML = conName.value.bold();
					
					// Client Email Address
					var conEmail = document.forms[0].elements["propertyValue(relTkcConOid_relConPsnOid_psnEmail01)"];
					var cliEmail = document.createTextNode(conEmail.value);
					document.getElementById('conEmailDisplay').appendChild(cliEmail);	

					// Client Phone Number
					var conPhone1 = document.forms[0].elements["propertyValue(relTkcConOid_relConPsnOid_psnPhone01)"];
					var cliPhone1 = document.createTextNode(conPhone1.value);
					document.getElementById('conPhoneDisplay').appendChild(cliPhone1);					
					
					// Client Working Job Title
					var conTitle = document.forms[0].elements["propertyValue(relTkcConOid_conFieldC002)"];
					var title = document.createTextNode(conTitle.value);
					document.getElementById('conTitleDisplay').appendChild(title);
					
					// Client Aspen Version
					var version = document.forms[0].elements["propertyValue(relTkcTktOid_tktFieldB014)"];
					var verNum = document.createTextNode(version.value);
					document.getElementById('versionDisplay').appendChild(verNum);
					
					// Client Organization CRM Assignment
					var crmAssignment = document.forms[0].elements["viewFieldContainerpropertyValue(relTkcOrgOidcl_relOrgOraOid_oraFieldC007)"];
					var crmName = document.createTextNode(crmAssignment.value);
					document.getElementById('crmNameDisplay').appendChild(crmName);
					
					// Ticket Description
					var ticketSummary = document.getElementsByName("propertyValue(relTkcTktOid_tktSummary)").value;
					var ticketDesc = document.getElementsByName("propertyValue(relTkcTktOid_tktDescription)").value;
					if (ticketDesc == "") {
						document.getElementById('descDisplay').appendChild(ticketSummary);
					} else {
						document.getElementById('descDisplay').appendChild(ticketDesc);
					}
					
					var formDesc = document.getElementById('descDisplay').value;
					if (formDesc != null) {
						ticketDesc.appendChild(formDesc);
					}
				}

				/*
				* SIF button function
				*/
				function sifErrorChange()
				{
					var errorCode = document.forms[0].elements['propertyValue(relTkcTktOid_tktFieldB007)'];
					var buttonUrl = "window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide');"
					if(errorCode.value == null || errorCode.value == "") {
						buttonUrl = "window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide');"
						document.getElementById("sifButton").setAttribute( "onclick", buttonUrl );
					}
					else {
						buttonUrl = "window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide#" + errorCode.value + "');"
						document.getElementById("sifButton").setAttribute( "onclick", buttonUrl );
					}
				}

				/*
				* Template Page Test js
				*/
				// Accordion
				function myFunction(id) {
				  var x = document.getElementById(id);
				  if (x.className.indexOf("w3-show") == -1) {
					x.className += " w3-show";
					x.previousElementSibling.className += " w3-theme-d1";
				  } else { 
					x.className = x.className.replace("w3-show", "");
					x.previousElementSibling.className = 
					x.previousElementSibling.className.replace(" w3-theme-d1", "");
				  }
				}

				// Used to toggle the menu on smaller screens when clicking on the menu button
				function openNav() {
				    var x = document.getElementById("navDemo");
				    if (x.className.indexOf("w3-show") == -1) {
					  x.className += " w3-show";
				    } else { 
					  x.className = x.className.replace(" w3-show", "");
				    }
				}
				
				// Open another window/tab to customer SIS URL.
				function openSisUrl() {
					var cliSite = document.forms[0].elements["propertyValue(relTkcOrgOidcl_orgFieldC001)"];					
					var redirectWindow = window.open(cliSite.value, '_blank');
					redirectWindow.location;
				}
				
				// Execute functions on page load.
				document.addEventListener("DOMContentLoaded", function() {
				  hideDefaultButtons();
				  startTimeCounter();
				  enabler();
				  toggle();
				  if (typeof(Storage) == "undefined") {
					  alert("Sorry, functions in this template will not work with your browser. Please use a different template or browser.")
				  }
				});
				
				// Hide page save and cancel buttons to use CSS buttons instead.
				function hideDefaultButtons() {
					var parent = document.getElementById("topButtonBar")
					var sb = parent.getElementsByTagName("input")[0];
					var cb = parent.getElementsByTagName("input")[1];
					sb.style.display = "none";
				    cb.style.display = "none";
					sb.innerHTML = "";
					cb.innerHTML = "";
				}				
				
				</script>
				]]>
			</text>				
			<text>
				<![CDATA[
				<html>
				<head>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
					<script>
					$(document).ready(function(){
					  $("notiButton").click(function(){
						  alert("Error: ");
						$("#noti").load("/pando/ticketListSimple.do?navkey=services.tickets.list", function(responseTxt, statusTxt, xhr){
							if(statusTxt == "success")
								alert("External content loaded successfully!");
							else
								alert("Error: " + xhr.status + ": " + xhr.statusText);
						});
					  });
					});
					</script>
				</head>				
				<title>W3.CSS Template</title>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
				<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
				<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
				<style>
				html, body, h1, h2, h3, h4, h5 {font-family: "Open Sans", sans-serif}
				</style>
				<body class="w3-theme-l5" bgcolor="#E6E6FA">
				
				<!-- Navbar -->
				<div class="w3-top">
				 <div class="w3-bar w3-theme-d2 w3-left-align w3-large" style="width:1405px; height:52px ">
				  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
				  <a href="#" class="w3-bar-item w3-button w3-padding-large w3-theme-d4"><i class="fa fa-home w3-margin-right"></i>Pando</a>
				  <a href="javascript:openSisUrl();" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Production Site"><i class="fa fa-globe"></i></a>
				  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Account Settings"><i class="fa fa-user"></i></a>
				  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Messages"><i class="fa fa-envelope"></i></a>
				  <div class="w3-dropdown-hover w3-hide-small">
					<button id="notiButton" class="w3-button w3-padding-large" title="Notifications"><i class="fa fa-bell"></i><span class="w3-badge w3-right w3-small w3-red">3</span></button>     
					<div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width:300px">
					  <a href="#" id="noti" class="w3-bar-item w3-button">New HIGH Chicago Ticket</a>
					  <a href="#" class="w3-bar-item w3-button">New CRITICAL Chicago Ticket</a>
					  <a href="#" class="w3-bar-item w3-button">New MEDIUM Chicago Ticket</a>
					</div>	
				  </div>
					<a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="My Account">
						<img src="https://www.w3schools.com/w3images/avatar2.png" class="w3-circle" style="height:23px;width:23px" alt="Avatar">
				    </a>	
					<a href="#" class="w3-bar-item w3-button w3-right w3-hover-white" title="Countdown"><i id="clock" class="fa fa-clock-o">  </i></a>					
				 </div>
				</div>

				<!-- Navbar on small screens -->
				<div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium w3-large">
				  <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 1</a>
				  <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 2</a>
				  <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 3</a>
				  <a href="#" class="w3-bar-item w3-button w3-padding-large">My Profile</a>
				</div>				
				
				<!-- Page Container -->
				<div class="w3-container w3-content" style="max-width:1403px;margin-top:3px">    
				  <!-- The Grid -->
				  <div class="w3-row">
				  
					<!-- Left Column -->
					<div class="w3-col m3">
					
					  <!-- Alert Box -->
					  <div class="w3-container w3-display-container w3-round  w3-border w3-theme-border w3-margin-bottom w3-hide-small" style="background-color: #ffa31a">
						<span onclick="this.parentElement.style.display='none'" class="w3-button  w3-display-topright" style="background-color: #ffb84d">
						  <i class="fa fa-check"></i>
						</span>
						<p><strong>Customer Warning</strong></p>
						<p id="toggleBanner"></p>
					  </div>
					  
					  <!-- Profile -->
					  <div class="w3-card w3-round w3-white">
						<div class="w3-container">
						 <h4 class="w3-center w3-theme-d3 w3-hover-shadow" id="orgNameDisplay" onclick="openSisUrl()" style="cursor: pointer"></h4>
						 <p class="w3-center"><img src="https://www.w3schools.com/w3images/avatar3.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
						 <p class="w3-center" id="conNameDisplay"></p>
						 <hr>
						 <p id="conEmailDisplay"><i class="fa fa-envelope-o fa-fw w3-margin-right w3-text-theme"></i>Email: </p>
						 <p id="conPhoneDisplay"><i class="fa fa-phone fa-fw w3-margin-right w3-text-theme"></i>Phone: </p>
						 <p id="conTitleDisplay"><i class="fa fa-user fa-fw w3-margin-right w3-text-theme"></i>Title: </p>
						 <p id="versionDisplay"><i class="fa fa-leaf fa-fw w3-margin-right w3-text-theme"></i>Aspen Version # </p>
						</div>
					  </div>
					  <br>
					  
					  <!-- Accordion -->
					  <div class="w3-card w3-round">
						<div class="w3-white">
						  <button onclick="myFunction('Demo1')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> Recent Tickets</button>
						  <div id="Demo1" class="w3-hide w3-container">
							<p>Some text..</p>
						  </div>
						  <button onclick="myFunction('Demo2')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> Recent Tasks</button>
						  <div id="Demo2" class="w3-hide w3-container">
							<p>Some other text..</p>
						  </div>
						  <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-users fa-fw w3-margin-right"></i> What Else</button>
						  <div id="Demo3" class="w3-hide w3-container">
						 <div class="w3-row-padding">
						 <br>
						   <div class="w3-half">
							 <img src="https://www.w3schools.com/w3images/lights.jpg" style="width:100%" class="w3-margin-bottom">
						   </div>
						   <div class="w3-half">
							 <img src="https://www.w3schools.com/w3images/nature.jpg" style="width:100%" class="w3-margin-bottom">
						   </div>
						   <div class="w3-half">
							 <img src="https://www.w3schools.com/w3images/mountains.jpg" style="width:100%" class="w3-margin-bottom">
						   </div>
						   <div class="w3-half">
							 <img src="https://www.w3schools.com/w3images/forest.jpg" style="width:100%" class="w3-margin-bottom">
						   </div>
						   <div class="w3-half">
							 <img src="https://www.w3schools.com/w3images/nature.jpg" style="width:100%" class="w3-margin-bottom">
						   </div>
						   <div class="w3-half">
							 <img src="https://www.w3schools.com/w3images/snow.jpg" style="width:100%" class="w3-margin-bottom">
						   </div>
						 </div>
						  </div>
						</div>      
					  </div>
					  <br>
					  
					  <!-- Interests --> 
					  <div class="w3-card w3-round w3-white w3-hide-small">
						<div class="w3-container">
						  <p>Could this be a useful card?</p>
						  <p>
							<span class="w3-tag w3-small w3-theme-d5">Thing 1</span>
							<span class="w3-tag w3-small w3-theme-d4">Thing 2</span>
							<span class="w3-tag w3-small w3-theme-d3">Thing 3</span>
							<span class="w3-tag w3-small w3-theme-d2">Thing 4</span>
							<span class="w3-tag w3-small w3-theme-d1">Thing 5</span>
							<span class="w3-tag w3-small w3-theme">Thing 6</span>
							<span class="w3-tag w3-small w3-theme-l1">Thing 7</span>
							<span class="w3-tag w3-small w3-theme-l2">Thing 8</span>
							<span class="w3-tag w3-small w3-theme-l3">Thing 9</span>
							<span class="w3-tag w3-small w3-theme-l4">Thing 10</span>
							<span class="w3-tag w3-small w3-theme-l5">Thing 11</span>
						  </p>
						</div>
					  </div>
					  <br>
					
					<!-- End Left Column -->
					</div>
					
					<!-- Middle Column -->
					<div class="w3-col m7">
					
					  <div class="w3-row-padding">
						<div class="w3-col m12">
						  <div class="w3-card w3-round w3-white">
							<div class="w3-container w3-padding">
							  <h6 class="w3-opacity">Describe the issue with examples and steps to reproduce</h6>
							  <textarea 
							    id="descDisplay"
								rows="9" 
								cols="107" 
								wrap="soft" 
								contenteditable="true" 
								style="font-size: 10pt"
								class="w3-border w3-padding" 
								placeholder="Issue: &#10;&#10;---How to Reproduce---&#10;Navigation: &#10;Example: &#10;Tool Name [ID]: &#10;Tool Input List: &#10;&#10;Error/Exception:"></textarea>
							  <button type="button" class="w3-button w3-theme"><i class="fa fa-pencil"></i>  Post</button> 
							</div>
						  </div>
						</div>
					  </div>
					  
					  <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
						<img src="https://www.w3schools.com/w3images/avatar2.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
						<span class="w3-right w3-opacity">1 min</span>
						<h4>John Doe</h4><br>
						<hr class="w3-clear">
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
						  <div class="w3-row-padding" style="margin:0 -16px">
							<div class="w3-half">
							  <img src="https://www.w3schools.com/w3images/lights.jpg" style="width:100%" alt="Northern Lights" class="w3-margin-bottom">
							</div>
							<div class="w3-half">
							  <img src="https://www.w3schools.com/w3images/nature.jpg" style="width:100%" alt="Nature" class="w3-margin-bottom">
						  </div>
						</div>
						<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button> 
						<button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>  Comment</button> 
					  </div>
					  
					  <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
						<img src="https://www.w3schools.com/w3images/avatar5.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
						<span class="w3-right w3-opacity">16 min</span>
						<h4>Jane Doe</h4><br>
						<hr class="w3-clear">
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
						<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button> 
						<button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>  Comment</button> 
					  </div>  

					  <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
						<img src="https://www.w3schools.com/w3images/avatar6.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
						<span class="w3-right w3-opacity">32 min</span>
						<h4>Angie Jane</h4><br>
						<hr class="w3-clear">
						<p>Have you seen this?</p>
						<img src="https://www.w3schools.com/w3images/nature.jpg" style="width:100%" class="w3-margin-bottom">
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
						<button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button> 
						<button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>  Comment</button> 
					  </div> 
					  
					<!-- End Middle Column -->
					</div>
					
					<!-- Right Column -->
					<style>
						.button {
						  background-color: #008CBA; /* Green */
						  border: none;
						  color: white;
						  padding: 15px 32px;
						  text-align: center;
						  text-decoration: none;
						  display: inline-block;
						  font-size: 16px;
						  margin: 4px 2px;
						  cursor: pointer;
						}

						.button2 {background-color: #e7e7e7; color: black;} /* Blue */
					</style>
					<button class="button w3-hover-shadow" onclick="doSubmit(140, this.form)">Save</button>
					<button class="button button2 w3-hover-shadow w3-hover-red" onclick="doSubmit(940, this.form);return false;">Cancel</button>


					<div class="w3-col m2">
					  <div class="w3-card w3-round w3-white w3-center">
						<div class="w3-container">
						  <p>Upcoming Events:</p>
						  <img src="https://www.w3schools.com/w3images/forest.jpg" alt="Forest" style="width:100%;">
						  <p><strong>Holiday</strong></p>
						  <p>Friday 15:00</p>
						  <p><button class="w3-button w3-block w3-theme-l4">Info</button></p>
						</div>
					  </div>
					  <br>
					  
					  <div class="w3-card w3-round w3-white w3-center">
						<div class="w3-container">
						  <p>Assigned CRM</p>
						  <img src="https://www.w3schools.com/w3images/avatar6.png" alt="Avatar" style="width:50%"><br>
						  <p id="crmNameDisplay"></p>
						  <div class="w3-row w3-opacity">
							<div class="w3-half">
							  <button class="w3-button w3-block w3-green w3-section" title="Accept"><i class="fa fa-check"></i></button>
							</div>
							<div class="w3-half">
							  <button class="w3-button w3-block w3-red w3-section" title="Decline"><i class="fa fa-remove"></i></button>
							</div>
						  </div>
						</div>
					  </div>
					  <br>
					  
					  <div class="w3-card w3-round w3-white w3-padding-16 w3-center">
						<p>ADS</p>
					  </div>
					  <br>
					  
					  <div class="w3-card w3-round w3-white w3-padding-32 w3-center">
						<p><i class="fa fa-bug w3-xxlarge"></i></p>
					  </div>
					  
					<!-- End Right Column -->
					</div>
					
				  <!-- End Grid -->
				  </div>
				  
				<!-- End Page Container -->
				</div>
				<br>

				<!-- Footer -->
				<footer class="w3-container w3-theme-d3 w3-padding-16">
				  <h5>Related Tickets --- Work In Progress</h5>
				  <script lang="Javascript">
					/*
					 * Resizes the linked tickets list.
					 */
					function resizeGroupGrid()
					{
						var form = document.forms[0];
						var div = document.getElementById("dataGridGroup");
						
						var windowWidth = getWindowWidth() - 150;
						var divWidth = div.offsetWidth;
						
						if (divWidth > windowWidth && windowWidth < 680)
						{
							div.style.width = 680;
						}
						else
						{
							div.style.width = windowWidth;
						}
					}
				  </script>
				  <head>
					<style>
					#customers {
					  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
					  border-collapse: collapse;
					  width: 100%;
					}

					#customers td, #customers th {
					  border: 1px solid #ddd;
					  padding: 8px;
					}

					#customers tr:nth-child(even){background-color: #f2f2f2;}

					#customers tr:hover {background-color: #ddd;}

					#customers th {
					  padding-top: 12px;
					  padding-bottom: 12px;
					  text-align: left;
					  background-color: #4CAF50;
					  color: white;
					}
					</style>
					</head>
					<div id="dataGridGroup" overflow: auto; width: 1385px;">
						<table id="customers" width="100%" cellspacing="1" border="0">
						  <td >&nbsp;</td>
						  <td>
						   ID
						  </td>
						  <td>
						   LogDate
						  </td>
						  <td>
						   ClientOrg &gt; Name
						  </td>
						  <td>
						   Contact &gt; Name
						  </td>
						  <td>
						   Type
						  </td>
						  <td>
						   Module
						  </td>
						  <td>
						   Summary
						  </td>
						  <td>
						   Status
						  </td>  
						 </tr>
						 
						  <tr class="listCell">
						   <td width="1">
							<input type="checkbox" id="TKC000000LAPu2TKG" name="selectedOids" value="TKC000000LAPu2" onclick="selectMultipleRow('ticketDetailForm', 'allRows', 'TKC000000LAPu2TKG', 'false');">
						   </td>
						   <td>
							<a href="javascript:doParamSubmit(2370,%20document.forms['ticketDetailForm'],'TKC000000LAPu2')">
							 T30334615
							</a>
						   </td>
						   <td >
							8/30/2016
						   </td>
						   <td >
							El Monte City School District
						   </td>
						   <td>
							Melendez, Roy  
						   </td>
						   <td>
							Config/setup
						   </td>
						   <td>
							Tools
						   </td>
						   <td >
							Destiny export failing
						   </td>
						   <td>
							Closed
						   </td>   
						  </tr>
					</table>
					</div>
				</footer>

				<footer class="w3-container w3-theme-d5">
				  <p>Made by the most awesome Tech Lead on the planet.</p>
				</footer>				
				</body>
				</html> 
				]]>
			</text>
			<!-- Below section for both HTML and CSS for modal function &amp;nbsp;-->
            <text>
				<![CDATA[ 
				
				<style>
				.modal-header {
					padding: 2px 16px;
					background-color: #5cb85c;
					color: white;
				}</style>

				<style>
				.modal-body {
					padding: 2px 16px; 
				}</style>

				<style>
				.modal-footer {
					padding: 2px 16px;
					background-color: #5cb85c;
					color: white;
				}</style>

				<style>
				.modal {
					display: none;
					position: fixed;
					z-index: 1;
					left: 0;
					top: 0;
					width: 100%;
					height: 100%;
					overflow: auto;
					background-color: rgb(0,0,0);
					background-color: rgba(0,0,0,0.4);
				}</style>

				<style>
				.modal-content {
					position: relative;					
					background-color: #fefefe;
					margin: auto;
					padding: 0;
					border: 1px solid #888;
					width: 80%;
					box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
					animation-name: animatetop;
					animation-duration: 0.4s
				}</style>
				
				<style>
				@keyframes animatetop {
					from {top: -300px; opacity: 0}
					to {top: 0; opacity: 1}
				}</style>
		
				<style>
				.close {
					color: #aaa;
					float: right;
					font-size: 28px;
					font-weight: bold;
				}</style>

				<style>
				.close:hover,
				.close:focus {
					color: black;
					text-decoration: none;
					cursor: pointer;
				}</style>
				
				<!-- The Modal -->
				<div id="myModal" class="modal">
				
				<!-- Modal content -->
				<div class="modal-content">
				  <div class="modal-header" align="center">
					<span class="close">&times;</span>
					<h2>NOTICE: Please read before closing!</h2>
				  </div>
				  <div class="modal-body" align="center">
					<p style="font-size:16px">Prior to closing your ticket, please ensure the same data elements are doubled checked as you would before escalating</p>
					<p style="font-size:16px">Taking this final step ensures both customers and our team have an excellent resource to reference in the future.</p>
				  </div>
				  <div class="modal-footer" align="center">
					<h3>Thank you!</h3>
				  </div>
				</div>
				  
				</div>
				]]>
			</text>
		  <!-- Side Bar Information & Navigation-->
		  <text>
				<![CDATA[
				<head>
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<style>
				body {
					font-family: "Lato", sans-serif;
					transition: background-color .5s;
				}

				.sidenav {
					height: 100%;
					width: 0;
					position: fixed;
					z-index: 1;
					top: 0;
					left: 0;
					background-color: #111;
					overflow-x: hidden;
					transition: 0.5s;
					padding-top: 60px;
				}

				.sidenav a {
					padding: 8px 8px 8px 32px;
					text-decoration: none;
					font-size: 25px;
					color: #818181;
					display: block;
					transition: 0.3s;
				}

				.sidenav a:hover {
					color: #f1f1f1;
				}

				.sidenav .closebtn {
					position: absolute;
					top: 0;
					right: 25px;
					font-size: 36px;
					margin-left: 50px;
				}

				#main {
					transition: margin-left .5s;
					padding: 16px;
				}

				@media screen and (max-height: 450px) {
				  .sidenav {padding-top: 15px;}
				  .sidenav a {font-size: 18px;}
				}
				</style>
				</head>
				<body>

				<div id="mySidenav" class="sidenav">
				  <a href="javascript:void(0)" class="closebtn" onclick="checkSideTab()">&times;</a>
				  <a href="#">Common Issues</a>
				  <a href="#">Common Code</a>
				  <a href="#">Repository</a>
				  <a href="#">Known Bugs</a>
				</div>
				</body>			
				]]>
		  </text>
          </cell>
        </line>
      </block>
    </row>
	
	<row collapsible="false">
      <column>
        <property id="relTkcOrgOidcl.orgName" label="District Name" label-short="false" onchange="toggle()">
			<picklist relationship="relTkcOrgOidcl" required="true">
				<field id="orgID" />
				<field id="orgName" sort="true" />
				<filter connector="and" field="orgDisabledInd" operator="equals" source="constant" value="false" />
			</picklist>
        </property>
        <property id="tkcFieldB013">
          <condition action="display" expression="getCurrentDetail().getValue('relTkcOrgOidcl.orgName').toString().startsWith('Fujitsu')" />
        </property>
        <property id="relTkcConOid.conNameView" label="Contact Name">
			<picklist relationship="relTkcConOid" width="600" required="true">
				<field id="conNameView" sort="true" />
				<field id="conTitle" />
				<field id="conFieldC003" />
				<field id="conFieldA002" />
				<field id="conPrimaryInd" />
				<field id="relConPsnOid.psnPhone01" />
				<field id="relConPsnOid.psnEmail01" />
				<filter connector="and" field="conOrgOIDOwner" operator="equals" source="detail" value="tkcOrgOIDCli" />
				<filter connector="and" field="conInactiveInd" operator="equals" source="constant" value="false" />
			</picklist>
        </property>
        
        <property id="relTkcOrgOidcl.orgFieldC001" label-short="false" prefix-display="hide" />
        <property id="relTkcTktOid.tktSummary" label-short="false" size="55" />
		<property id="relTkcTktOid.tktFieldB014" label-display="false"  />
		<property id="relTkcTktOid.tktID" label="Ticket #" />		
	  </column>
	  <column>
		<group header="Category">
			<property id="relTkcTktOid.tktType" label-short="false" />
			<property id="relTkcTktOid.tktProduct" label="Product Affected" />
			<property id="relTkcTktOid.tktFieldB006" label-short="false" required="true" />
			<property id="relTkcTktOid.tktFieldB008" label-short="false" />
			<property id="relTkcTktOid.tktFieldB007" label="SIF Error Code" onchange="sifErrorChange()" />
			<property id="tkcFieldB008" label="Number of records" />			
		</group>
	  </column>

	   <column>
		<group header="Settings">
			<property id="tkcStatus" label-display="false" onchange="validateClose()" />
			<property id="tkcPriority" label-short="false" />
			<property id="tkcFieldB006" label="Tech working?" />
			<property id="tkcFieldB009" label="Email Customer Last Public?" />
			<property id="tkcFieldB002" label="Last Emailed Date:" read-only="true" />

			<line>
				<cell border="none">
					<text bold="true" font-size="large">
					<![CDATA[
						<style> p {
							margin-top: 0px; 
							margin-bottom: 0px; 
							margin-left: 0px;}
						</style><p>
						<button 
							type="button" 
							id="sifButton" 
							onclick="window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide');">SIF Wiki
						</button></p>
					]]>
					</text>
				</cell>
			</line>
		</group>
	  </column>
	  
	  <column>
		<group header="Navigation">
			<property id="relTkcTktOid.tktFieldB015" label-short="false" required="true" />
			<property id="relTkcTktOid.tktFieldB005" label-short="false" required="true" />
			<property id="relTkcTktOid.tktFieldB009" label-short="false" required="true" onchange="checkSideTab()" />
			<property id="relTkcTktOid.tktFieldC010" label-short="false" size="25" />
		</group>
	  </column>
    </row>
			
	<row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text source="constant" bold="true" font-size="medium">Describe the issue with examples and steps to reproduce</text>
          </cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <property id="relTkcTktOid.tktDescription" label-display="hide" label-short="false" rows="13" 
						default-value-source="constant" 
						default-value="Issue: &#xD;&#xD;---How to Reproduce---&#xD;Navigation: &#xD;Example: &#xD;Tool Name [ID]: &#xD;Tool Input List: &#xD;&#xD;Error/Exception: " />
          </cell>
        </line>
      </block>

      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text source="constant" bold="true" font-size="medium">Expected Results: How will we know this is resolved?</text>
          </cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <property id="relTkcTktOid.tktFieldD004" label-display="hide" label-short="false" rows="13"
						default-value-source="constant" 
						default-value="Example: &#xD;&#xD;
										Navigation: School View, Grades > GPA > Reports&#xD;
										School: Best High School&#xD;
										Student: Smith, John&#xD;
										Tool Name [ID]: Grade Point Averages [SYS-GPA-RPT]&#xD;
										Year: 2018 &#xD;
										GPA: BHS Weighted GPA &#xD;
										Rest Defaults&#xD;&#xD;
										When the report is run in this location, the student GPA should read on report as 3.46 instead of 3.13" />
          </cell>
        </line>
      </block>
    </row>
	
	<!--Blank-->
    <row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text source="constant" bold="true" font-size="medium">Activity</text>
          </cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <page build-row="false" path="../../crm/embeddedListChat.jsp" />
          </cell>
        </line>
      </block>
    </row>
    <row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text source="constant" bold="true" font-size="medium">Related Tickets</text>
          </cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <page build-row="false" path="../../crm/ticketGroup.jsp" />
          </cell>
        </line>
      </block>
    </row>
    <row show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <property id="relTkcOrgOidcl.orgFieldC004" label-display="hide" label-short="false" />
			<property id="relTkcConOid.conFieldC002" label-display="hide" label-short="false" />
			<property id="relTkcConOid.relConPsnOid.psnEmail01" label-display="hide" label-short="false" />
			<property id="relTkcConOid.relConPsnOid.psnPhone01" label-display="hide" label-short="false" />
			<property id="relTkcOrgOidcl.relOrgOraOid.oraFieldC007" label-display="hide" label-short="false" />
			<property id="tkcActEffort" label-display="hide" label-short="false" />
          </cell>
        </line>

      </block>
    </row>
  </tab>

  <tab name="Search&amp;nbsp;Tickets">
    <page build-row="false" path="../../crm/ticketSearch.jsp" />
    <row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text source="constant" bold="true" font-size="medium">Linked Tickets</text>
          </cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <page build-row="false" path="../../crm/ticketGroup.jsp" />
          </cell>
        </line>
      </block>
    </row>
  </tab>
  <tab name="Related&amp;nbsp;Tasks">
    <row collapsible="true" show-border="false">
          <block>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text source="constant" bold="true" font-size="medium">Related Tasks</text>
          </cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <page build-row="false" path="../../crm/relatedTasks.jsp" />
          </cell>
        </line>
      </block>
    </row>
  </tab>
  
  <tab name="Escalate">
    <row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell align="center" border="none" cell-span="1" line-span="1">
            <text bold="true" font-size="large">Escalating To Tiers 2 or 3</text>
          </cell>
        </line>
      </block>
    </row>
	
    <row show-border="false">
      <block>
        <line border="none">
          <cell align="left" border="none" cell-span="1" line-span="1">
            <text bold="true" font-size="large">
			<![CDATA[
				<span style="color:#C36E00;">Please fill out the following fields to escalate to the appropriate level:</span>
			]]>
		   </text>
		  </cell>
		 </line>
		 
		 <line border="none">
			 <cell cell-span="15" border="bottom">
				<spacer />
			 </cell>
		 </line>
		 
		 <line border="none">
			<cell shaded="#d1fafa" border="left,right" cell-span="2">
				<text bold="true">Responsible > Initials</text>
			</cell>
			<cell border="right" cell-span="7" >
				<property id="relTkcUsrResp.usrFieldA003" label-display="false">
					<picklist relationship="relTkcUsrResp" required="true">
						<field alias="initials" sort="true" />
						<field id="usrViewName" />
						<filter connector="and" field="usrFieldA001" operator="equals" source="constant" value="true" />
					</picklist>
				</property>
			</cell>
        </line>
		
		<line border="none">
				<cell shaded="#d1fafa" border="left,right" cell-span="2">
					<text bold="true">Due Date</text>
				</cell>
				<cell border="right" align="center">
					<property id="tkcDueDate" label-display="false" />
				</cell>
        </line>
		
		<line border="none">
				<cell shaded="#d1fafa" border="left,right" cell-span="2">
					<text bold="true">Time Due</text>
				</cell>
				<cell border="right" align="center">
					<property id="tkcFieldA013" label-display="false" />
				</cell>
		</line>
		
        <line border="none">
				<cell shaded="#d1fafa" border="left,right" cell-span="2">
					<text bold="true">Escalation need</text>
				</cell>
				<cell border="right" cell-span="7">
					<property id="tkcFieldB025" label-display="false" />
				</cell>
        </line>
		
        <line border="none">
				<cell shaded="#d1fafa" border="left,right" cell-span="2">
					<text bold="true">Escalation reason</text>
				</cell>
				<cell border="right" cell-span="7">
					<property id="tkcFieldB007" label-display="false" />
				</cell>
        </line>
		
		<line border="none">
				<cell shaded="#d1fafa" border="left,right" cell-span="2">
					<text bold="true">Request emailed solution</text>
				</cell>
				<cell border="right" align="center">
					<property id="tkcFieldA004" label-display="false" />
				</cell>
		</line>
				 			<line border="none">
				<cell cell-span="15" border="top">
					<spacer />
				</cell>
		</line>
		
      </block>
    </row>
	<switched-include context="dynamic.escalationFeedback" read-only="false" id="tkcFieldB025" alias="escalation-need" show-border="false" show-selector="false" />
  </tab>
  
  
  <tab name="Feedback">
    <row collapsible="true" show-border="false">
      <block>
	  
        <line border="none">
          <cell align="center" border="none" cell-span="1" line-span="1">
            <text bold="true" underline="true" font-size="large">Escalation Feedback</text>
          </cell>
        </line>
		
      </block>
    </row>
    <row show-border="false">
      <block>
	  
        <line border="none">
          <cell align="center" border="none" cell-span="1" line-span="1">
            <text bold="true" font-size="large">
			<![CDATA[
				<span style="color:#C36E00;">Before closing a ticket, take a moment to rate the escalation</span>
			]]>
		   </text>
		  </cell>
		 </line>
		 
		 <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text bold="true" font-size="medium">Each ticket ought to be reviewed for accuracy in detail and feedback provided for the previous analyst who escalated the ticket. This provides accountability, coaching opportunity, and quality data for future review.</text>
          </cell>
        </line>
		
      </block>
    </row>
	
	<row>
	 <block>
	 
	    <line border="none">
          <cell border="bottom" cell-span="1" line-span="1">
            <text font-size="medium">Use the following box to mark any items in which the previous analyst had failed to accurately notate. Keep in mind that on each escalation, they are prompted to check all of the available items from this list. If no marks can be found, then mark the ticket as a Good ticket, unless the analyst displayed an effort to go above and beyond their tier expectations, in which case mark the ticket as great.</text>
          </cell>
        </line>
		
		<line border="none">
			<cell shaded="#d1fafa" border="left,right" cell-span="2">
				<text bold="true">Escalation feedback</text>
			</cell>
			<cell border="right" cell-span="7">
				<property id="tkcFieldD002" label-display="false" />
					<picklist relationship="tkcFieldD002" required="true" multiple="true">
						<field id="tkcFieldD002" />
					</picklist>
			</cell>
			<cell cell-span="1">
				<spacer />
			</cell>
			<cell shaded="#d1fafa" border="left,right" cell-span="2">
				<text bold="true">Escalation feedback (T3)</text>
			</cell>
			<cell border="right" cell-span="7">
				<property id="tkcFieldD001" label-display="false" />
					<picklist relationship="tkcFieldD001" required="true" multiple="true">
						<field id="tkcFieldD001" />
					</picklist>
			</cell>
        </line>
		
	 </block>
	</row>
	
	<row>
	 <block>
	 	<line border="none">
			<cell shaded="#d1fafa" border="left,right" cell-span="2">
				<text bold="true">Escalation feedback notes</text>
			</cell>
			<cell border="right" cell-span="7">
				<property id="tkcFieldD004" label-display="false" />
			</cell>
			<cell cell-span="1">
				<spacer />
			</cell>
			<cell shaded="#d1fafa" border="left,right" cell-span="2">
				<text bold="true">Escalation feedback notes (T3)</text>
			</cell>
			<cell border="right" cell-span="7">
				<property id="tkcFieldD005" label-display="false" />
			</cell>
        </line>
	 </block>
	</row>
	
    <row>
      <block>
	  
        <line align="center" border="bottom" shaded="#d1fafa">
          <text bold="true" font-size="large">Resolution Feedback</text>
        </line>
		
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text bold="true" underline="true" font-size="medium">Notes from the technician who issued a resolution can provide additional information here:</text>
          </cell>
        </line>
		
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <spacer height="10" />
          </cell>
        </line>
		
        <line border="none">
				<cell border="none" cell-span="7">
					<property id="tkcFieldD003" label-display="false" />
				</cell>
        </line>
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <spacer height="5" />
          </cell>
        </line>
		
      </block>
    </row>
	
    <row show-border="false">
      <block>
	  
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <text> </text>
          </cell>
        </line>
		
        <line border="none">
          <cell border="none" cell-span="1" line-span="1">
            <spacer height="5" />
          </cell>
        </line>
		
      </block>
    </row>
	
  </tab>
  
  <tab name="Admin&amp;nbsp;Panel">
	
    <row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell align="center" border="none" cell-span="1" line-span="1">
            <text bold="true" font-size="large">Administrative fields for ticket:</text>
          </cell>
        </line>
      </block>
    </row>
	
	<row collapsible="true">
      <column>
        <property id="relTkcUsrLog.usrFieldA003" label-short="false">
          <picklist relationship="relTkcUsrLog" required="true">
            <field alias="initials" sort="true" />
            <field id="usrViewName" />
            <filter connector="and" field="usrFieldA001" operator="equals" source="constant" value="true" />
          </picklist>
        </property>
        <property id="tkcOpenDate" label-short="false" />
        <property id="tkcSource" label-short="false" />
        <property id="tkcPriority" label-short="false" />
        <property id="tkcDueDate" label-short="false" />
        <property id="tkcFieldA013" label-short="false" />
        <property id="tkcCloseDate" label-short="false" />
        <property id="tkcFieldA024" label-short="false" />
      </column>
      <column>
        <property id="tkcFieldA009" label-short="false" />
        <property id="tkcFieldA010" label-short="false" />
        <property id="tkcFieldA011" label-short="false" />
        <property id="tkcActEffort" label-short="false" />
        <property id="tkcFieldA001" label-short="false" />
        <property id="tkcFieldA002" label-short="false" />
        <property id="tkcFieldB025" label-short="false" />
        <property id="tkcFieldA004" label="Request Emailed Solution" label-short="false" />
      </column>
    </row>
	
	<row collapsible="true" show-border="false">
      <block>
        <line border="none">
          <cell align="center" border="none" cell-span="1" line-span="1">
            <text bold="true" font-size="large">For Supervisor Review:</text>
          </cell>
        </line>
      </block>
    </row>
	
	<row>
	 <column>
	    <property id="relTkcTktOid.tktFieldA019" label-short="false" />
        <property id="tkcFieldA003" label-short="false" />
		<property id="tktFieldD005" label-short="false" />
	 </column>
	</row> 
	
  </tab>
</template>