<?xml version="1.0" encoding="UTF-8"?>
<template>
  <tab name="General">
    <row show-border="false">
      <block>
        <line border="none">
          <cell border="none" cell-span="0" line-span="0">	 
			<text>
				<![CDATA[
				<script language="Javascript">
				/*
				 * Remove status codes from this template.
				 */
				function removeStatusOptions() {
					var status = document.getElementById("propertyValue(tkcStatus)");
					for (var index = 0; index < status.length; index++) {
						var selectedValue = status.options[index].value;
						if (selectedValue == 'Assigned to Consult') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Awaiting Response') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Awaiting Response Ct') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Backlog') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Billed') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Consult Completed') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Dev Complete') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Dev in Process') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Need More Info') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Not Implementing') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Pending BA Review') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Obsolete') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Ready to be Billed') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Testing IP') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Under Development') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'Proposed Solution') {
							status.options.remove(index);
							index--;
						} else if (selectedValue == 'New') {
							status.options.remove(index);
							index--;
						}
					}
				}


				//$( "form" ).submit(function( event ) {
				//  event.preventDefault();
				//})
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
				* Side tab functions
				*/
				//$( "form" ).submit(function( event ) {
				 // event.preventDefault();
				//})
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
						document.getElementById('alertBox').style.display = "none";
						document.getElementById('toggleBanner').style.display = "none";
					}
					else {
						document.getElementById('toggleBanner').style.display = "block";
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

				function minorReload() {
					$('document').trigger('click');
					$('document').unbind('click');
					doParamSubmit(2030, document.forms['ticketDetailForm'], 0);
				}
				
				// Hide page save and cancel buttons to use CSS buttons instead.
				function hideDefaultButtons() {
					var parent = document.getElementById("topButtonBar")
					var bbb = document.getElementById("bottomButtonBar")
					//var sb = parent.getElementsByTagName("input")[0];
					var cb = parent.getElementsByTagName("input")[1];	
					//sb.style.display = "none";
					cb.style.display = "none";
					bbb.style.display = "none";				
					//sb.innerHTML = "";
					cb.innerHTML = "";				
				}	
				
				function darkMode() {
					const toggleSwitch = document.querySelector('.theme-switch input[type="checkbox"]');
					const currentTheme = localStorage.getItem('theme');

					if (currentTheme) {
						document.documentElement.setAttribute('data-theme', currentTheme);
					  
						if (currentTheme === 'dark') {
							toggleSwitch.checked = true;
						}
					}
					function switchTheme(e) {
						let styleEl = document.getElementById('darkStyle');
						if (e.target.checked) {
							document.documentElement.setAttribute('data-theme', 'dark');
							localStorage.setItem('theme', 'dark');
							styleEl.removeAttribute('media');
						}
						else {						
							document.documentElement.setAttribute('data-theme', 'light');
							localStorage.setItem('theme', 'light');
							styleEl.setAttribute('media', "max-width: 1px");
						}    
					}
					toggleSwitch.addEventListener('change', switchTheme, false);
				}
				
				// Contains on scroll function. Any functions relying on the page scrolling must go here.
				function scrollingNavBar() {
					var prevScrollpos = window.pageYOffset;
					window.onscroll = function() {
						var currentScrollPos = window.pageYOffset;
						if (prevScrollpos > currentScrollPos) {
							document.getElementById("topnavBar").style.top = "0";
						} else {
							document.getElementById("topnavBar").style.top = "-55px";
						}
						prevScrollpos = currentScrollPos;
						
						// On scroll, show or hide the save button
						if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
							stickySave.style.display = "block";
						} else {
							stickySave.style.display = "none";
						}

						// When the user clicks on the button, scroll to the top of the document
						function topFunction() {
							document.body.scrollTop = 0; // For Safari
							document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
						}						
					}					
				}

				// Execute functions on page load.
				document.addEventListener("DOMContentLoaded", function() {
					hideDefaultButtons();
					removeStatusOptions();
					scrollingNavBar();
					darkMode();
					toggle();
					if (typeof(Storage) == "undefined") {
						alert("Sorry, functions in this template will not work with your browser. Please use a different template or browser.")
					}
				});
				
				</script>
				]]>
			</text>				
			<text>
				<![CDATA[
				<style>
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

				<div id="mySidenav" class="sidenav">
				  <a href="javascript:void(0)" class="closebtn" onclick="checkSideTab()">
				  <a href="#">Common Issues</a>
				  <a href="#">Common Code</a>
				  <a href="#">Repository</a>
				  <a href="#">Known Bugs</a>
				</div>		
				]]>
			</text>			
			<text>
				<![CDATA[		
				<title>Aspen Technical Support Ticket</title>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
				<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
				<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
				<div class="wrap">
				<style id="darkStyle">
					.contentContainer, .contentPad {background-color: var(--darkest-color); color: var(--font-color); !important}
					.c1Background {background-color: var(--dark-color) !important} 
					.c2Background {background-color: var(--light-color) !important}
					.breadcrumbs, .templateTextMedium {color: var(--gray-color) !important}
					.verticalTabSelected {background-color: var(--darkest-color);}
					#mainTable, #chatDiv, #dataGridGroup, .detailProperty, .detailValue, .detailGroupHeader, .detailPropertyGutter, 
					.blobText, [name*="propertyValue"], [id*="chat"], [class*="list"]  {
						background-color: var(--dark-color); color: var(--font-color); !important}	
					.templateTabSelected {background-color: var(--select-color);}
					.templateTabText {color: var(--font-color);}
				</style>
				<style>
					.wrap {
						min-width: 600px;
					}
					html, body, h1, h2, h3, h4, h5 {
						font-family: "Open Sans", sans-serif;
					}					
					#topnavBar {
						transition: top 0.3s;
					}						
					em {
						margin-left: 40px;
						font-size: 1rem;
					}
					:root {}						
					[data-theme="dark"] {
						--darkest-color: #222629;
						--dark-color: #474B4F;
						--gray-color: #e6e6e6;
						--font-color: white;
						--light-color: #006080;
						--select-color: #008CBA;
					}						
					.theme-switch-wrapper {
						display: flex;
						align-items: center;
					}						
					.theme-switch {
					  position: relative;
					  display: inline-block;
					  width: 60px;
					  height: 34px;
					  left: 20px;
					}

					.theme-switch input { 
					  opacity: 0;
					  width: 0;
					  height: 0;
					}

					.slider {
					  position: absolute;
					  cursor: pointer;
					  top: 0;
					  left: 0;
					  right: 0;
					  bottom: 0;
					  background-color: #ccc;
					  -webkit-transition: .4s;
					  transition: .4s;
					}

					.slider:before {
					  position: absolute;
					  content: "";
					  height: 26px;
					  width: 26px;
					  left: 4px;
					  bottom: 4px;
					  background-color: white;
					  -webkit-transition: .4s;
					  transition: .4s;
					}

					input:checked + .slider {
					  background-color: #2196F3;
					}

					input:focus + .slider {
					  box-shadow: 0 0 1px #2196F3;
					}

					input:checked + .slider:before {
					  -webkit-transform: translateX(26px);
					  -ms-transform: translateX(26px);
					  transform: translateX(26px);
					}

					/* Rounded sliders */
					.slider.round {
					  border-radius: 34px;
					}

					.slider.round:before {
					  border-radius: 50%;
					}
					.modal-header {
						padding: 2px 16px;
						background-color: #5cb85c;
						color: white;
					}
					.modal-body {
						padding: 2px 16px; 
					}
					.modal-footer {
						padding: 2px 16px;
						background-color: #5cb85c;
						color: white;
					}
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
					}
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
					}
					@keyframes animatetop {
						from {top: -300px; opacity: 0}
						to {top: 0; opacity: 1}
					}
					.close {
						color: #aaa;
						float: right;
						font-size: 28px;
						font-weight: bold;
					}
					.close:hover, .close:focus {
						color: black;
						text-decoration: none;
						cursor: pointer;
					}
					#stickySave {
					  display: none; /* Hidden by default */
					  position: fixed; /* Fixed/sticky position */
					  bottom: 15px; /* Place the button at the bottom of the page */
					  left: 15px; /* Place the button 15px from the left */
					  z-index: 99; /* Make sure it does not overlap */
					  border: none; /* Remove borders */
					  outline: none; /* Remove outline */
					  background-color: #008CBA; /* Set a background color */
					  color: white; /* Text color */
					  cursor: pointer; /* Add a mouse pointer on hover */
					  padding: 15px; /* Some padding */
					  border-radius: 7px; /* Rounded corners */
					  font-size: 18px; /* Increase font size */
					}

					#stickySave:hover {
					  background-color: #555; /* Add a dark-grey background on hover */
					}						
				</style>				
				<body class="w3-theme-l5" bgcolor="#E6E6FA">
				<div id="topnavBar" class="w3-top">
					<div class="w3-bar w3-theme-dark w3-left-align w3-large" style="max-width:93%; height:52px">	
					 	<!-- Alert Box -->
						<div id="alertBox" class="w3-bar-block w3-container w3-display-container w3-round  w3-border w3-theme-border w3-margin-bottom w3-hide-small" style="background-color: #ffa31a">
							<span onclick="this.parentElement.style.display='none'" class="w3-button  w3-display-topright" style="background-color: #ffb84d">
								<i class="fa fa-check"></i>
							</span>
							<p><strong>Customer Warning</strong></p>
							<p id="toggleBanner"></p>
						</div>
						<div class="theme-switch-wrapper w3-left">
							<label class="theme-switch" for="darkbox" >
								<input type="checkbox" id="darkbox"/>
								<div class="slider round" ></div>
							</label>
							<em>Enable Dark Mode!</em>
						</div>						
					</div>
				</div>	

				<button class="button w3-hover-shadow w3-hover-aqua" onclick="doSubmit(140, this.form)" id="stickySave" title="Save">Save</button>
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
	  </column>
	  <column>
		<group header="Category">
			<property id="relTkcTktOid.tktType" label-short="false" />
			<property id="relTkcTktOid.tktProduct" label="Product Affected" />
			<property id="relTkcTktOid.tktFieldB006" label-short="false" required="true" />
			<property id="relTkcTktOid.tktFieldB008" label-short="false" />
			<property id="relTkcTktOid.tktFieldB007" label="SIF Error Code" onchange="sifErrorChange()" >
                          <condition action="display" expression="getCurrentDetail().getValue('relTkcTktOid.tktFieldB006').toString().matches('State Reporting - MA')" />
                        </property>
			<property id="tkcFieldB008" label="Number of records" >
                          <condition action="display" expression="getCurrentDetail().getValue('relTkcTktOid.tktFieldB006').toString().matches('State Reporting - MA')" />
                        </property>			
		</group>
	  </column>

	   <column>
		<group header="Settings">
			<property id="tkcStatus" label-display="false" /> <!--onchange="validateClose()"-->
			<property id="tkcPriority" label-short="false" />
			<property id="tkcFieldB006" label="Tech working?" >
                          <condition action="display" expression="getCurrentDetail().getValue('relTkcUsrResp.usrFieldA003').toString().matches('PTE')" />
                        </property>
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
			<property id="relTkcTktOid.tktFieldB009" label-short="false" required="true" /> <!--onchange="checkSideTab()"-->
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
            <property id="relTkcTktOid.tktFieldD004" label-display="hide" label-short="false" rows="13" />
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
          </cell>
        </line>
      </block>
    </row>
	<row>
	  <block>
	    <line>
		  <cell>
		    <text>
				<![CDATA[
				</div>
				]]>
			</text>
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