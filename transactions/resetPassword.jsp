<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="s" uri="/struts-tags" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script src="javascript/jquery-1.4.2.js"></script>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags" %>

<%-- <script language="javascript" type="text/javascript">
	
	 function validate(){
		
		var invalid = " "; // Invalid character is a space
		var minLength = 7; // Minimum length
		var maxLength = 12;
		var alphaNumericPattern =  "^[a-zA-Z0-9/_/$]{" + minLength + "," + maxLength + "}";
		var regExpr = new RegExp(alphaNumericPattern);
		var message1 = "Password must be a combination of alphabets and numbers";
		var message = message1 + "\n and must be between " + minLength + 
		           " and " + maxLength + " chars.";
		 var newPassword = "";
		 var confirmPassword = "";
		
		 newPassword =  document.getElementById('newPwd').value;
		 confirmPassword =  document.getElementById('confirmPwd').value;
		 
		 var flag=false;	
		 if(newPassword==null || confirmPassword==null || newPassword=="" || confirmPassword==""){
				alert("newPassword/confirmPassword is empty");
				return flag;
		 }
		 else if(newPassword.length < minLength || 
				 newPassword.length > maxLength){
		  alert(message);
		  newPassword.focus();
		  return flag;
		 }
		 else if (!regExpr.test(newPassword)) {
			  alert(message);
			  newPassword.focus();
			  return flag;
			 }
		
		 else if (newPassword.indexOf(invalid) > -1) {
			alert("Sorry, spaces are not allowed.");
			newPassword.focus();
			return flag;
		 }	
		else if(newPassword!=confirmPassword){
			alert("newPassword and confirmPassword is not match");
			newPassword.focus();
			return flag;
		}else{
			document.getElementById('resetPwd').action="<%= request.getContextPath()%>/resetPwd.action";
			document.getElementById('resetPwd').submit();
			 $('#validateLogin').attr('action',validateLogin.action);
			$('#validateLogin').submit();		
			return true; 
		}
		 if (flag){
			 clear();
		 }
	} 
	function clear(){
		
		 document.getElementById('newPwd').value="";
		 document.getElementById('confirmPwd').value="";
		 document.getElementById('oldPwd').focus();
			
	 }
	
</script> --%>
</head>
<body >
	<s:form action="resetPwd" theme="simple" id="resetPwd">
	<table align="center" width="300" height="200px" border="0" cellspacing="0" cellpadding="0">
	
	<tr><td>
	New Password</td><td align="center">
	<s:password name="newPassword" id="newPwd" ></s:password></td></tr>
	<tr><td>
	Confirm Password</td>
	<td align="center">
	<s:password name="confirmPassword" id="confirmPwd" ></s:password></td></tr>
	<tr><td align="center">
	<input onclick="validateLogin()" class="functionbutton" name="OK" type="button" id="OK" value="OK"/></td></tr>

	
	</table>
	</s:form>

</body>
</html>