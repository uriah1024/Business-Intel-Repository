				/*
				 * Remove status codes from this template.
				 */
				function removeStatusOptions() {
				    var status = document.getElementById("propertyValue(tkcStatus)");
					if (status !== "undefined" && status !== null) {
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
					if (banner === "undefined") {
						banner.value == "";
					}
				    document.getElementById('toggleBanner').innerHTML = banner.value;
				    document.getElementById('propertyValue(relTkcOrgOidcl_orgFieldC004)-span').style.display = "none";
				    if (banner.value == null || banner.value == "") {
				        document.getElementById('alertBox').style.display = "none";
				        document.getElementById('toggleBanner').style.display = "none";
				    } else {
				        document.getElementById('toggleBanner').style.display = "block";
				    }
				}

				/*
				 * SIF button function
				 */
				function sifErrorChange() {
				    var errorCode = document.forms[0].elements['propertyValue(relTkcTktOid_tktFieldB007)'];
				    var buttonUrl = "window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide');"
				    if (errorCode.value == null || errorCode.value == "") {
				        buttonUrl = "window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide');"
				        document.getElementById("sifButton").setAttribute("onclick", buttonUrl);
				    } else {
				        buttonUrl = "window.open('http://aspenwiki.fss.follett.com/index.php/SIF_Error_Code_Troubleshooting_Guide#" + errorCode.value + "');"
				        document.getElementById("sifButton").setAttribute("onclick", buttonUrl);
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
					if (localStorage.getItem('theme') !== 'dark') {
						document.documentElement.setAttribute('data-theme', 'light');
						localStorage.setItem('theme', 'light');
						document.getElementById('darkStyle').setAttribute('media', "max-width: 1px");
					}

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
				        } else {
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
					removeStatusOptions();
					hideDefaultButtons();
				    scrollingNavBar();
				    darkMode();
				    toggle();
				    if (typeof(Storage) == "undefined") {
				        alert("Sorry, functions in this template will not work with your browser. Please use a different template or browser.")
				    }
				});