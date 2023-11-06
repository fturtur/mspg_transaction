<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="s" uri="/struts-tags" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script src="javascript/jquery-1.4.2.js"></script>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags" %>

<script src="javascript/tender.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

</script>
</head>
<body>
	
	<s:form action="confirmCashAmount" theme="simple" id="validateLogin">
	<table align="center" width="300" height="200px" border="0" cellspacing="0" cellpadding="0" >
	
		<tr><td align="center" ><b>Confirm Cash Loan Amount</b></td></tr>
		
		<tr><td align="center">Sign-on Float:<b>  Php <s:property value="#session.userVO.bpsUser.bpsBranch.initialFund" /></b></td></tr>
		<tr>
		<td>
			<s:submit label="OK"  />
		</td>
		<td><input class="functionbutton" name="OK" type="button"   value="NO" align="middle" onclick="logoutUser();"/></td></tr>
	</table>
	</s:form>
</body>
</html>
