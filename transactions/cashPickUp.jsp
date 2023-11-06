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
	function validateValues(){
		var qty1000=0;
		var qty500=0;
		var qty200=0;
		var qty100=0;
		 var numbers = /^[0-9]+$/;
		 var regExpr = new RegExp(numbers);
		qty1000=document.getElementById('cash1000').value;
		qty500=document.getElementById('cash500').value;
		qty200=document.getElementById('cash200').value;
		qty100=document.getElementById('cash100').value;
		var php1000 = 1000;
		var php500 = 500;
		var php200 = 200;
		var php100 = 100;
		var tot1000=0;
		var tot500=0;
		var tot200=0;
		var tot100=0;
		var total=0;
		
		if(qty1000==""||qty500==""||qty200==""||qty100==""||qty1000==null||qty500==null|qty200==null||qty100==null){
			alert("quantity should not be empty");
			return false;
		}
		if((!regExpr.test(qty1000))||(!regExpr.test(qty500))||(!regExpr.test(qty200))||(!regExpr.test(qty100))){
			alert("quantity should be numeric only");
			return false;
		}
		else{
			tot1000=qty1000*php1000;
			alert("tot1000"+tot1000);
			
			tot500=qty500*php500;
			alert("tot500"+tot500);
			
			tot200=qty200*php200;
			alert("tot200"+tot200);
			
			tot100=qty100*php100;
			alert("tot100"+tot100);
			
			total =tot1000+tot500+tot200+tot100;
			alert("total"+total);
			
			document.getElementById('cashPickUp').action="<%= request.getContextPath()%>/cashPickUp.action?total="+total;
			document.getElementById('cashPickUp').submit();
			/* $('#cashPickUp').attr('action', cashPickUp.action);
			$('#cashPickUp').submit(); */
			
		}
	} 
	
	function cancel(){
		total=0;
		alert("total"+total);
		document.getElementById('cashPickUp').action="<%= request.getContextPath()%>/cashPickUp.action?total="+total;
		document.getElementById('cashPickUp').submit();
		/* $('#cashPickUp').attr('action', cashPickUp.action);
		$('#cashPickUp').submit(); */
	}
</script>
</head>
<body>
	<s:form action="/cashPickUp" theme="simple" id="cashPickUp">

		<table width="680" height="300" border="0" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td><strong class="style3 style4">CASH PICK-UP</strong></td>
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
									type="text" size="5" id="cash1000" />
							</label></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="2" align="right">Php 500</td>
							<td align="center">x</td>
							<td align="center"><input name="textfield2" type="text"
								size="5" id="cash500"/></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="2" align="right">Php 200</td>
							<td align="center">x</td>
							<td align="center"><input name="textfield3" type="text"
								size="5" id="cash200"/></td>
							<td align="center">=</td>
							<td align="right">Php 0.00</td>
						</tr>
						<tr>
							<td colspan="2" align="right">Php 100</td>
							<td align="center">x</td>
							<td align="center"><input name="textfield4" type="text"
								size="5" id="cash100" /></td>
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
									<input onclick="cancel();" name="cancelButton" type="button"
										class="smallpagebutton" id="okButton" value="Cancel" />
								</div></td>
						</tr>
					</table></td>
			</tr>
		</table>
	</s:form>

</body>
</html>