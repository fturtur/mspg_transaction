<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.List" %>
<script type="text/javascript" src="javascript/effect.js"></script>
<script src="javascript/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="javascript/jquery.hotkeys.js"></script>
<script type="text/javascript" src="javascript/biller.js"></script>

<link href="css/main.css" rel="stylesheet" type="text/css" />
<s:head theme="simple"/>
<table align="left" height="20px" border="1" cellspacing="0"
	cellpadding="0">
	<tr id="tableheader">
		<td width="150" bgcolor="#FFCC66">Biller Name</td>
		<td width="200" bgcolor="#FFCC66">Reference / Account Number</td>
		<td width="115" bgcolor="#FFCC66">Amount Paid</td>
	</tr>


	<s:iterator value="bpsTrxLines">
		<tr>
			<td><s:property value="bpsBiller.billerName" /></td>
			<td><s:property value="soaReferenceNum" /></td>
			<td><s:property value="amountPaid" /></td>
		</tr>
	</s:iterator>
</table>