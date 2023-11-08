/* This javascript file prevent the user from
 * logging in more than one tabs.
 * */

// Create cookie
var err = false;
function createCookie(name,value,days) { 
	if (days) { 
		var date = new Date(); date.setTime(date.getTime()+(days*24*60*60*1000)); 
		var expires = "; expires="+date.toGMTString();
	}
	else 
		var expires = ""; 
		document.cookie = name+"="+value+expires+"; path=/"; 
}
// Read cookie
function readCookie(name) { 
	var nameEQ = name + "="; 
	var ca = document.cookie.split(';'); 
	for(var i=0;i < ca.length;i++) { 
		var c = ca[i]; 
		while (c.charAt(0)==' ') 
			c = c.substring(1,c.length); 
		if (c.indexOf(nameEQ) == 0) 
			return c.substring(nameEQ.length,c.length); 
	} 
	return null; 
} 

// Delete cookie
function eraseCookie(name) { 
	createCookie(name,"",-1);
}
function windowOnLoad(){
	
	var hasSessionId = false;

	 if(window.name == ''){
	   // Get sessionid from cookie
		hasSessionId = false;
		var pairs = document.cookie.split(";"); 
		//alert("cookie9 " + pairs);
		var cookies = {};
		for (var i=0; i<pairs.length; i++){
			// Make sure cookie name=value is not empty
			if(!pairs[i] || pairs[i]==null) continue;
			
			var pair = pairs[i].split("=");
		 	if(pair[0].replace(/\s/g,"")=="testcookie" && pair[1].length>0  && pair[1]=="1234") {
			 	hasSessionId=true;
			 	break;
		  	 }
		 }
		
		if(hasSessionId==false){
	 	//Set Name to Catch New Tab/Window
	 		window.name = 'myWinName';
	 		createCookie("testcookie","1234",10);
   		} else {
   			err = true;
			window.location = "validateLogin?errcode=loggedin";
			//hasSessionId=true;
   		}
	 }
}	 
// When user copy and paste the url, load the window
$(window).load(function() {
	windowOnLoad();
});
// Called by logout
function windowOnBeforeUnload(){
	var e = e || window.event;
	  if(window.name=="myWinName") {
			// clear cookie here...
		  		eraseCookie("JSESSIONID");
				eraseCookie("testcookie");
				window.name = "";
				hasSessionId=false;
				window.location = "${pageContext.request.contextPath}/logout";

	  }
}


// Called by Closing Window including Logout-because when you logout, you are also unloading the window
window.addEventListener("beforeunload", function (e) {
	
	if(err != true){
		eraseCookie("JSESSIONID");
		eraseCookie("testcookie");
		window.name = "";
		hasSessionId=false;
	}
	
});