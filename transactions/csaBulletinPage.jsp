<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SM Prepaid System - CSA BULLETIN</title>
<link href="css/pcsmain.css" rel="stylesheet" type="text/css" />
<link href="css/indexpage.css" rel="stylesheet" type="text/css" />
<link href="css/devStyles.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 14px}
.style2 {color: #FFFFFF}
.style5 {
	font-size: 14px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
-->
</style>
<script src="javascript/jquery-1.8.0.min.js"></script>
<script src="javascript/jquery-1.4.2.js"></script>

<script src="javascript/common.js" type="text/javascript"></script>
<script type="text/javascript" src="javascript/checkSession.js"></script>
<script src="javascript/pcsTransactionMain.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).bind('keydown', 'f5',function (evt){
	 var flag = false;
	 if(evt.which == 116 && !flag){
		 evt.preventDefault();
			 logout();
		 flag = true;
	 	return false;
	 }
});
allowedOperations='${session.userVO.allowedOperations}';
applicationType='${session.userVO.applicationType}';
itemDeclarationCompleted='${session.userVO.itemDeclarationCompleted}';
inPcsTerminal='N';
isBpsBusinessTime='${session.userVO.isBpsBusinessTime}';
bpsBusinessStartTime='${session.userVO.bpsBusinessStartTime}';
bpsBusinessCutoffTime='${session.userVO.bpsBusinessCutoffTime}';
</script>
</head>
<body style="background-image:url(images/indexgb.png); background-repeat:repeat-x;" id="objBody">

<input type="hidden" id="userType" value="<s:property value="#session.userVO.bpsUser.bpsRoles.roleName.toUpperCase()"/>" />
<input type="hidden"  id="mgrLoginInvokedFrom" />
<input type="hidden" name="terminalStatus" id="terminalStatus" />
<input type="hidden" id="terminalStatusUrl" value="<s:property value="#session.userVO.terminalStausCheckHoUrl"/>"/>
<input type="hidden" id="terminalId" value="<s:property value="#session.userVO.bpsTerminal.terminalId"/>"/>
<input type="hidden" id="mgrId" />
<input type="hidden" id="cashierId" value="<s:property value="#session.userVO.bpsUser.userId"/>"/>
<input type="hidden" id="firstLoginOfDay" value="<s:property value="#session.userVO.cashDeclarationCompleted"/>"/>
<input type="hidden" id="connectivityCheckInterval"  value="<s:property value="#session.userVO.connectivityChckInterval"/>"/>
<input type="hidden" id="voidTrxUrl"  value="<s:property value="#session.userVO.voidTrxUrl"/>"/>
<input type="hidden" id="checkPickupInterval_1"  value="<s:property value="#session.userVO.checkPickupInterval_1"/>"/>
<input type="hidden" id="checkPickupInterval_1_check"  />
<input type="hidden" id="checkPickupInterval_2"  value="<s:property value="#session.userVO.checkPickupInterval_2"/>"/>
<input type="hidden" id="checkPickupInterval_2_check"  />
<input type="hidden" id="resetPassword" value="<s:property value="#session.userVO.bpsUser.isFirstLogin"/>" />
<input type="hidden" id="suspendAndResumeBarcodeData" />
<input type="hidden" id="voidBarcodeData" />
<input type="hidden" id="billerCardProcessMode" />
<input type="hidden" id="cardProcessMode" />
<input type="hidden" id="collectionTreshold" value="<s:property value="#session.userVO.collectionThreshold"/>" />
<input type="hidden" id="cashInhand" value="<s:property value="#session.userVO.cashInhand"/>"/>
<input type="hidden" id="pickupCount"  value="<s:property value="#session.userVO.pickupCount"/>"/>
<input type="hidden" id="cashDeclarationCompleted" value="<s:property value="#session.userVO.cashDeclarationCompleted"/>"/>
<input type="hidden" id="trxProessed" />
<input type="hidden" id="trxCheckQty" value="<s:property value="#session.userVO.cashierVO.trxTotCheckQty"/>"/>
<input type="hidden" id="trxCheckAmt" value="<s:property value="#session.userVO.cashierVO.trxTotCheckAmt"/>"/>
<input type="hidden" id="checkDetails" value=""/>
<input type="hidden" id="trxAdditionInprogress" value="false"/>
<input type="hidden" id="deleteTrxLinesInProcess" value="false"/>
<input type="hidden" id="terminalOnlineStatus" value="<s:property value="#session.userVO.onlineStatus"/>"/>

<table width="1020" height="700" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td colspan="3" height="12%">
    <table height="80" width="1020" border="0" cellspacing="0" cellpadding="0" style="background-color: white;">
        <tr>
          <td class="bordertopleft"></td>
          <td class="bordertop"></td>
          <td class="bordertopright"></td>
        </tr>
        <tr>
          <td class="borderleft"></td>
          <td>
	          <table width="1000" height="80" border="0" cellpadding="0" cellspacing="0">
	       		<tr>
	        		<td width="67" rowspan="2" align="center" valign="middle">
		        
		        	<!-- <img src="images/SMLogo.png" alt="SM" /> -->
		       		<img src="images/NewSMStoreLogo.png" alt="SM" width="120" height="110"/>
	        		</td>
			        <td width="266" rowspan="2" id="banner">Prepaid System<br />
			          <s:property value="#session.userVO.bpsBranch.branchName"/><br />
			          <span class="style1"><s:property value="#session.userVO.locationName"/></span></td>
			        <td width="154" rowspan="2" id="bannersmall">Cashier: <s:property value="#session.userVO.bpsUser.userCode"/></td>
			        <td width="165" rowspan="2" id="bannersmall"><%-- <script language="JavaScript" type="text/javascript">GetCurrentDateAndTime();</script> --%>
			        <span id="terminalTime">&nbsp;&nbsp;</span><br />
			          Terminal Number: <s:property value="#session.userVO.bpsTerminal.terminalCode"/></td>
			        <td width="166" rowspan="2" id="bannersmall"><div align="right">V1.0</div>
			            <div id="updateNum" align="right"></div></td>
			        <td width="162" align="right" id="bannersmall">
			        	<s:if test="#session.userVO.allowedOperations=='BOTH'">
				        	<img src="images/pcs2bps_icon.png" alt="Bills Payment System" width="30" height="30" border="1" title="Bills Payment System"
			        		onclick="navigateBPS()" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'"/>
		        		</s:if>
			        	<img id="cashPickup" src="images/cashPickup.jpg" alt="Pick-Up" width="30" height="30" border="1" title="Pick-Up"/> 
			        	<img id="cashPickupAni" style="display: none;" src="images/cashPickupAnimated.gif" width="30" height="30" border="1" title="Pick-Up"/>
			        	<img id="checkPickup" src="images/checkPickup.jpg" alt="Sign-On Float" width="30" height="30" border="1" title="Sign-On Float"/> 
			        	<img id="checkPickupAni" style="display: none;" src="images/checkPickupAnimated.gif" width="30" height="30" border="1" title="Sign-On Float"/>
			        	<s:a action="initPcsTransactionPage" namespace="/">
			        		<img src="images/terminal.png" alt="Transaction Page" width="30" height="30" border="1" title="Terminal"/>
			        	</s:a>
			        </td>
		        	<td width="20" rowspan="2" id="bannersmall">&nbsp;</td>												
	      		</tr>
	      		<tr>
		        	<td valign="middle" id="bannersmall">
		        		<div align="right">
		        			<img class="onLineDiv" src="images/up.png" width="12" height="16"   style="display: none;" />&nbsp;&nbsp; <span class="onLineDiv" style="display: none;">ONLINE</span>
		         			<img src="images/down.png" class="offLineDiv" width="12" height="16" />&nbsp;&nbsp;<span class="offLineDiv" >OFFLINE</span>
		         		</div>
		        	</td>
	      		</tr>
	    	</table>
    	</td>
          <td class="borderright"></td>
        </tr>
        <tr>
          <td class="borderbottomleft"></td>
          <td class="borderbottom"></td>
          <td class="borderbottomright"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
          <td class="bordertopleft"></td>
          <td class="bordertop"></td>
          <td class="bordertopright"></td>
  </tr>
  <tr>
  	<td class="borderleft"></td>
   	<td>
   		<!-- <img alt="CSA BULLETIN" src="images/csa.jpg" height="600px" width="1005px"> -->
   		<img alt="CSA BULLETIN" src="<%=request.getContextPath()%>/transactions/csaBulletinImage.jsp" height="600px" width="1005px">
   	</td>
   	<td class="borderright"></td>
  </tr>
      <tr>
        <td class="borderbottomleft"></td>
        <td class="borderbottom"></td>
        <td class="borderbottomright"></td>
      </tr>
</table>
<div class="bpsOverlay" id="bpsMask"></div>


<s:include value="/transactions/commonDivs.jsp"></s:include>
</body>
</html>