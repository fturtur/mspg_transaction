<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="/struts-tags" prefix="s"%>
<head>
<title>SM Bills Payment System</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script src="javascript/jquery-1.4.2.js">
<%@ taglib uri="/struts-dojo-tags" prefix="sd" %>
<%@ taglib uri="/struts-jquery-tags" prefix="sj"%>
</script>
<sj:head compressed='false' jqueryui="true" />
<s:head theme="simple" />
<script language="javascript" type="text/javascript">
	
	function validateValues(){
			
		var storeCode="";
		storeCode = document.getElementById('storeCode').value;
		var terminalNumber="";
		terminalNumber = document.getElementById('terminalNumber').value;
		var transactionNumber="";
		transactionNumber = document.getElementById('transactionNumber').value;
		var reason="";
		reason = document.getElementById('reason').value;
		
		if(storeCode==""||storeCode==null||terminalNumber==""||terminalNumber==null||transactionNumber==""||transactionNumber==null||reason==""||reason==null){
			alert("storeCode/terminalNumber/transactionNumber/reason is empty");
		}
		else{
			document.getElementById('voidTransactionPage').action="<%=request.getContextPath()%>/voidTransactionPage.action";
			document.getElementById('voidTransactionPage').submit();
		}

	}
</script>


</head>
<body>
	<s:form action="voidTransactionPage" theme="simple"
		id="voidTransactionPage">
		<table width="680" height="300" border="0" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td><strong class="style3 style4">TRANSACTION VOID </strong></td>
			</tr>
			<tr>
				<td><hr /></td>
			</tr>
			<tr>
				<td><table width="500" border="0" align="center"
						cellpadding="2" cellspacing="2" id="tenders"
						style="vertical-align: middle;">
						<tr>
							<td colspan="3" align="left" valign="top" class="style3"><p>&nbsp;</p>
							</td>
						</tr>

						<tr>
							<td align="right">Store Code :</td>
							<td></td>
							<td><input name="textfield4" type="text" size="15"
								maxlength="3" id="storeCode" /></td>
						</tr>
						<tr>
							<td width="260" align="right">Terminal Number:</td>
							<td width="10"></td>
							<td width="367"><label> <input name="textfield"
									type="text" size="10" maxlength="3" id="terminalNumber" />
							</label></td>
						</tr>
						<tr>
							<td align="right">Transaction Number:</td>
							<td></td>
							<td><label> <input type="text" name="textfield2"
									id="transactionNumber" />
							</label></td>
						</tr>
						<tr>
							<td align="right">Reason:</td>
							<td></td>
							<td><label> <%-- <select name="select" id="reason">
          <option>&lt;Select Reason&gt;</option>
        </select> --%> <s:select headerKey="-1"
										headerValue="Select Reason"
										list="{'Erroneous Entry of Amount',
		'Erroneous Process of Payment',
		'Acceptance of Erroneous Check',
		'Failure to Follow Billers Acceptance Policies',
		'Wrong Payment Stub Validated',
		'Discount Error',
		'Charge Transaction Error',
		'Printer Error'}"
										id="reason"></s:select>
							</label></td>
						</tr>
						<tr>
							<td align="right">&nbsp;</td>
							<td></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="3" align="right"><div align="right">
									<input name="okButton" type="button" class="smallpagebutton"
										id="okButton" onclick="validateValues();" value="OK" />&nbsp;&nbsp;&nbsp;
									<input name="cancelButton" type="button"
										class="smallpagebutton" id="okButton" value="Cancel" />
								</div></td>
						</tr>
						<tr>
							<td colspan="3" align="right">&nbsp;</td>
						</tr>
					</table></td>
			</tr>
		</table>
		<%-- <table align="center" width="500" height="200px" border="0"
			cellspacing="0" cellpadding="0">
			<tr>
				<td>Store Code</td>
				<td><s:textfield name="storeCode" id="storeCode"></s:textfield>
				</td>
			</tr>
			<tr>
				<td>Terminal Number</td>
				<td><s:textfield name="terminalNumber" id="terminalNumber"></s:textfield>
				</td>
			</tr>
			<tr>
				<td>Transaction Number</td>
				<td><s:textfield name="transactionNumber"
						id="transactionNumber"></s:textfield></td>
			</tr>
			<tr>
				<td>Reason</td>
				<td>
					<s:if>
						<s:select list="reasoncodes" name="reasonCodes.reasonCodeDescription"
						headerKey="-1" headerValue="Select Reason"
							 listValue="reasoncodes" 
							value="%{reasoncodes.reasonCodeDescription}" />
					
					</s:if> <s:select headerKey="-1" headerValue="Select Reason"
						list="{'Erroneous Entry of Amount',
		'Erroneous Process of Payment',
		'Acceptance of Erroneous Check',
		'Failure to Follow Billers Acceptance Policies',
		'Wrong Payment Stub Validated',
		'Discount Error',
		'Charge Transaction Error',
		'Printer Error'}"
						id="reason"></s:select>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="left"><input onclick="validate();"
					class="functionbutton" name="OK" type="button" id="OK"
					value="Click" /></td>
			</tr>
		</table> --%>
	</s:form>
</body>
</html>