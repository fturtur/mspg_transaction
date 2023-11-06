<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
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
	
</script>
</head>
<body>
	<s:form>

		<table width="680" height="300" border="0" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td><strong class="style3 style4">CHECK PICK-UP</strong></td>
			</tr>
			<tr>
				<td><hr /></td>
			</tr>
			<tr>
				<td><table width="500" height="20" border="0" align="center"
						cellpadding="1" cellspacing="1" id="tenders"
						style="vertical-align: middle;">

						<tr>
							<td align="center">&nbsp;</td>
							<td align="center"><strong>Denomination</strong></td>
							<td align="center">&nbsp;</td>
							<td align="center"><strong>Quantity</strong></td>
							<td align="center">&nbsp;</td>
							<td align="center"><strong>Amount</strong></td>
						</tr>
						<tr>
							<td colspan="6" align="center"><hr align="center" /></td>
						</tr>
						<tr>
							<td align="center"><strong>CASH</strong></td>
							<td align="right">Php 1,000</td>
							<td align="center">x</td>
							<td align="center"><label> <input name="textfield"
									type="text" size="5" />
							</label></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="2" align="right">Php 500</td>
							<td align="center">x</td>
							<td align="center"><input name="textfield2" type="text"
								size="5" /></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="2" align="right">Php 200</td>
							<td align="center">x</td>
							<td align="center"><input name="textfield3" type="text"
								size="5" /></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="2" align="right">Php 100</td>
							<td align="center">x</td>
							<td align="center"><input name="textfield4" type="text"
								size="5" /></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr align="center">
							<td colspan="6"><hr align="center" /></td>
						</tr>
						<tr>
							<td align="center"><strong>CHECK</strong></td>
							<td align="right">&nbsp;</td>
							<td align="right">&nbsp;</td>
							<td align="center">0</td>
							<td align="right">&nbsp;</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="6" align="right"><hr align="center" /></td>
						</tr>
						<tr>
							<td colspan="6"><div align="right">
									<input name="okButton" type="button" class="smallpagebutton"
										id="okButton" onclick="validateValues();" value="OK" />&nbsp;&nbsp;&nbsp;
									<input name="cancelButton" type="button"
										class="smallpagebutton" id="okButton" value="Cancel" />
								</div></td>
						</tr>
					</table></td>
			</tr>
		</table>
	</s:form>

</body>
</html>