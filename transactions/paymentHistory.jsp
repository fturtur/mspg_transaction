<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags" %>
<%@page import="java.util.List" %>
<script type="text/javascript" src="javascript/effect.js"></script>
<script src="javascript/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="javascript/jquery.hotkeys.js"></script>

<link href="css/main.css" rel="stylesheet" type="text/css" />
<head>
<script language="javascript" type="text/javascript">
 function locationfun(){
	 var branch=$('#branch').val();
	 $.ajax({
		 type: "POST",
		 url: "branchLocation.action",
		 data: "branch="+branch,
		 dataType: "text",
		 async:true,
			success: function(data) {
				$('#locationDiv').html(data);
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
	 });
 }
</script>
<sj:head/>
<s:head theme="simple" />
</head>
<table id="tableItems" style="width:200px;">
<tr><td>
		<table width="800" border="0" align="center" cellpadding="2" cellspacing="2" id="payment" style="vertical-align:middle;">
			<tr>
				<td><strong class="style3 style4">PAYMENT HISTORY </strong></td>
			</tr>
			<tr>
				<td><hr /></td>
			</tr>
			<tr>
				<td>
					<table width="70%" border="0" cellspacing="0" cellpadding="0"
						align="center">
						<tr>
							<td valign="middle"><label></label></td>
							<td valign="middle"><label></label></td>
							<td valign="top">&nbsp;</td>
							<td valign="top">&nbsp;</td>
							<td valign="middle">&nbsp;</td>
							<td valign="top">&nbsp;</td>
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td width="13%" valign="middle"><label></label></td>
							<td width="30%" valign="middle"><label>Account
									Number: </label></td>
							<td width="22%" valign="top"><input id="actNum" type="text"
								name="textfield" /></td>
							<td width="7%" valign="top">&nbsp;</td>
							<td width="11%" valign="middle">Biller</td>
							<td> <label>
									<s:select theme="simple" id="biller" list="paymentVO.bpsBiller" listKey="billerId"  listValue="billerName" headerKey="0" headerValue="--please select--" ></s:select>
							</label> </td>
							<td width="14%" valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td valign="middle">&nbsp;</td>
						</tr>
						<tr>
							<td valign="middle">&nbsp;</td>
							<td width="20%" valign="top"><label>Date From</label></td>
								<td width="23%" valign="top">
									<sj:datepicker id='fdate' name='paymentVO.fdate'
										showOn="focus"></sj:datepicker>
								</td>
								<td width="5%" valign="top">&nbsp;</td>
							<td valign="middle">Branch</td>
							<td> 
							  <label>
							
						 <s:select theme="simple" id="branch"  list="paymentVO.bpsBranch" listKey="branchId" listValue="branchName" headerKey="0" headerValue="--please select--" onchange="locationfun();"></s:select>
							 </label> 
							</td> 
						</tr>
						<tr>
							<td valign="middle">&nbsp;</td>
						</tr>


							<tr>
								<td valign="middle">&nbsp;</td>
								<td width="20%" valign="top"><label>Date to</label></td>
								<td width="23%" valign="top">
									<sj:datepicker id='tdate' name='paymentVO.tdate'
										showOn="focus"></sj:datepicker>
								</td>
								<td width="5%" valign="top">&nbsp;</td>
								
								<td valign="middle">Location:</td>
								<td valign="top">
								<div id="locationDiv">
									<s:select theme="simple" headerKey="0" headerValue="--please select--" list="{}"/>
								</div>
								</td>
							
							<td valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td valign="middle">&nbsp;</td>
						</tr>
						<tr>
							<td valign="middle">&nbsp;</td>
							<td valign="middle">&nbsp;</td>
							<td valign="top"></td>
							<td valign="top">&nbsp;</td>
							<td valign="top">&nbsp;</td>
							<td valign="top"><span class="bler-process"> <input
									class="functionbutton" name="btnOK223" type="button"
									id="btnOK223" value="PROCESS" onclick="fetchPaymentHistory();"/>
							</span></td>
							<td valign="top">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td></tr></table>
