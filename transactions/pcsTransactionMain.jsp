<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SM Prepaid System - Transaction Main page</title>
<link href="css/pcsmain.css" rel="stylesheet" type="text/css" />
<link href="css/indexpage.css" rel="stylesheet" type="text/css" />
<link href="css/devStyles.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 14px}
.style2 {color: #FFFFFF}
.style5 {font-size: 12px}
-->
/* .style3 {
	font-size: 24px;
	font-weight: bold;
} */
</style>
<script src="javascript/jquery-1.8.0.min.js"></script>
<script src="javascript/jquery-1.4.2.js"></script>
<script type="text/javascript" src="javascript/checkSession.js"></script>
<script src="javascript/jqbarcodeandmsr.js"></script>
<script src="javascript/common.js" type="text/javascript"></script>
<script src="javascript/pcsTransactionMain.js" type="text/javascript"></script>
<script src="javascript/pcsTransactionBasket.js" type="text/javascript"></script>
<script src="javascript/pcsTransactionPayment.js" type="text/javascript"></script>
<script src="javascript/pcsShortcutKey.js" type="text/javascript"></script>
<script type="text/javascript">
allowedOperations='${session.userVO.allowedOperations}';
applicationType='${session.userVO.applicationType}';
itemDeclarationCompleted='${session.userVO.itemDeclarationCompleted}';
inPcsTerminal='Y';
isBpsBusinessTime='${session.userVO.isBpsBusinessTime}';
bpsBusinessStartTime='${session.userVO.bpsBusinessStartTime}';
bpsBusinessCutoffTime='${session.userVO.bpsBusinessCutoffTime}';
</script>

<!-- PCS Web Service -- START -->
<script type="text/javascript">
var pcsPostSubmitFlag=false;
var pcsPostValues;
var pcsPreSubmitFlag=false;
var pcsPreValues;

// -- PCS Online Processing - START -- // 
var pcsOnlineProcess="offline";
// -- PCS Online Processing - END -- //

</script>
<!-- PCS Web Service -- END -->

</head>
<body>
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
<!-- PCS Web Service -- START -->
<input type="hidden" id="cashierName" value="<s:property value="#session.userVO.bpsUser.firstName"/> <s:property value="#session.userVO.bpsUser.lastName"/>"/>
<input type="hidden" id="branchCode" value="<s:property value="#session.userVO.bpsBranch.branchCode"/>"/>
<input type="hidden" id="branchId" value="<s:property value="#session.userVO.bpsBranch.branchId"/>"/>
<input type="hidden" id="companyId" value="<s:property value="#session.userVO.bpsBranch.bpsCompany.companyId"/>"/>
<input type="hidden" id="companyCode" value="<s:property value="#session.userVO.bpsBranch.bpsCompany.companyCode"/>"/>
<input type="hidden" id="locationCode" value="<s:property value="#session.userVO.bpsTerminal.bpsLocation.locationCode"/>"/>
<input type="hidden" id="terminalCode" value="<s:property value="#session.userVO.bpsTerminal.terminalCode"/>"/>
<!-- PCS Web Service -- END -->
<!-- PCS Online Processing - START -->
<input type="hidden" id="pcsTransProcessingMode" />
<input type="hidden" id="pcsItemOnline" />
<!-- PCS Online Processing - END -->

<table align="center" width="1020" height="720px" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10" background="images/topleftframe.png" id="tablecorner"></td>
    <td colspan="4" background="images/topframe.png"></td>
    <td width="10" background="images/toprightframe.png" id="tablecorner"></td>
  </tr>
  <tr>
    <td background="images/leftframe.png"></td>
    <td height="80px" colspan="4">
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
			        		onclick="navigateToBPS()" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'"/>
			        	
		        	</s:if>
		        	<img id="cashPickup" src="images/cashPickup.jpg" alt="Pick-Up" width="30" height="30" border="1" title="Pick-Up"/> 
		        	<img id="cashPickupAni" style="display: none;" src="images/cashPickupAnimated.gif" width="30" height="30" border="1" title="Pick-Up"/>
		        	<img id="checkPickup" src="images/checkPickup.jpg" alt="Sign-On Float" width="30" height="30" border="1" title="Sign-On Float"/> 
		        	<img id="checkPickupAni" style="display: none;" src="images/checkPickupAnimated.gif" width="30" height="30" border="1" title="Sign-On Float"/>
		        	
		        	<img src="images/home.png" alt="Home Page" width="30" height="30" border="1" title="Home Page" onclick="navigateToHomePage()" 
		        			onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'"/>
		        	
		        </td>
	        	<td width="20" rowspan="2" id="bannersmall">&nbsp;</td>												
      		</tr>
      		<tr>
	        	<td valign="middle" id="bannersmall">
	        		<div align="right">
	        			<img class="onLineDiv" src="images/up.png" width="12" height="16"   style="display: none;" />&nbsp;&nbsp; <span class="onLineDiv" style="display: none;">ONLINE</span>
	         			<img src="images/down.png" class="offLineDiv" width="12" height="16"/>&nbsp;&nbsp;<span class="offLineDiv">OFFLINE</span>
	         		</div>
	        	</td>
      		</tr>
    	</table>
    </td>
    <td background="images/rightframe.png"></td>
  </tr>
  <tr>
    <td background="images/bottomleftframe.png" id="tablecorner"></td>
    <td colspan="4" background="images/bottomframe.png"></td>
    <td background="images/bottomrightframe.png" id="tablecorner"></td>
  </tr>
  <tr>
    <td background="images/topleftframe.png" id="tablecorner"></td>
    <td colspan="4" background="images/topframe.png"></td>
    <td background="images/toprightframe.png" id="tablecorner"></td>
  </tr>
  <tr>
    <td background="images/leftframe.png"></td>
    <td height="20px" colspan="4"><table align="left" height="20px" border="1" cellspacing="0" cellpadding="0">
      <tr id="tableheader">
       	<td width="18" bordercolor="#FFFFFF"><img src="images/delete.png" width="16" height="16" onclick="deleteAllItems();"/></td><!-- class="deleteImgClass" -->
        <td width="23" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">#</span></td>
        <td width="297" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Description</span></td>
        <td width="149" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Code</span></td>
  		<td width="95" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Promo</span></td>
		<td width="51" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Qty</span></td>
        <td width="115" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Amount Due </span></td>
        <td width="101" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Service Fee</span></td>
        <td width="115" bordercolor="#F0F0F0" bgcolor="#01243B"><span class="style2">Total Due </span></td>
        </tr>
    </table></td>
    <td background="images/rightframe.png"></td>
  </tr>
  <tr>
    <td background="images/leftframe.png"></td>
    <td height="200px" colspan="4">
    	<!-- <iframe id="billsframe" width="100%" height="100%" frameborder="0" scrolling="yes" src="pages/bills.html"></iframe> -->
    	<div style="overflow-y: scroll;overflow-x:hidden;height:200px;" id="tabledata">
    		<!-- <table align="left" id="pcsTransactionLinesTable" cellspacing="2" width="995px"></table> -->
    	</div>	
    </td>
    <td background="images/rightframe.png"></td>
  </tr>
  <tr>
    <td align="right" background="images/bottomleftframe.png"></td>
    <td height="10px" colspan="4" background="images/bottomframe.png"></td>
    <td background="images/bottomrightframe.png"></td>
  </tr>
  <tr>
    <td background="images/topleftframe.png"></td>
    <td height="10px" background="images/topframe.png"></td>
    <td background="images/toprightframe.png" id="tablecorner"></td>
    <td background="images/topleftframe.png" id="tablecorner"></td>
    <td height="10px" background="images/topframe.png"></td>
    <td background="images/toprightframe.png"></td>
  </tr>
  <tr>
    <td background="images/leftframe.png"></td>
    <td width="680" height="320px"><!--  <iframe src="pages/billers.html" id="billers" name="billers" width="100%" height="100%" frameborder="0" scrolling="yes"></iframe>-->
    	<div id="pcsTenderInfoDiv">
    	<table width="680px" height="320px" border="0" cellpadding="0" cellspacing="0" id="commonArea" style="display: none;">
    	</table>
    	<div id="paymentMethodsDiv"></div>
    	<table width="680px" height="320px" border="0" cellpadding="0" cellspacing="0" id="cards">
			  <tr>
			    <td width="150px" valign="top">
			    	<s:include value="/transactions/pcsSkuCategoriesScreen.jsp"></s:include>
			    </td>
			    <td width="500px" colspan="3" valign="top">
			    	<div style="padding:10px;overflow: auto;height: 260px;display:block;" id="cardsContainer" >	  	
		    		</div>
			    </td>
			  </tr>
			</table>
    	</div>
    </td>
    <td background="images/rightframe.png"></td>
    <td background="images/leftframe.png"></td>
    <td id="billerpagetext" width="300" valign="middle">
    	<div id="cardProfileArea" style="display: none;overflow-y: scroll;height: 300px;" ></div>
		<div id="paymentSummary" style="font-family:Arial, Helvetica, sans-serif; font-weight:normal; font-size:11px; text-align:left;"></div>
		<div id="paymentDetails"></div>
		<div id="status" style="vertical-align:bottom;"></div>
		<div id="cashtender" style="vertical-align:bottom;"></div>
	</td>
		
    <td background="images/rightframe.png"></td>
  </tr>
  <tr>
    <td background="images/bottomleftframe.png" id="tablecorner"></td>
    <td background="images/bottomframe.png"></td>
    <td id="tablecorner" background="images/bottomrightframe.png"></td>
    <td id="tablecorner" background="images/bottomleftframe.png"></td>
    <td background="images/bottomframe.png"></td>
    <td background="images/bottomrightframe.png" id="tablecorner"></td>
  </tr>
  <tr>
    <td background="images/topleftframe.png" id="tablecorner"></td>
    <td background="images/topframe.png"></td>
    <td background="images/toprightframe.png"></td>
    <td background="images/topleftframe.png"></td>
    <td background="images/topframe.png"></td>
    <td background="images/toprightframe.png" id="tablecorner"></td>
  </tr>
  <tr>
    <td background="images/leftframe.png"></td>
    <td height="50px">
	    <s:include value="/transactions/pcsFooterButtonsScreen.jsp"></s:include>
    </td>
    <td height="50px" background="images/rightframe.png">&nbsp;</td>
    <td height="50px" background="images/leftframe.png">&nbsp;</td>
    <td height="50px" id="banner" style="color:#FF0000"><div id="msgId"></div></td>
    <td align="right" background="images/rightframe.png"></td>
  </tr>
  <tr>
    <td background="images/bottomleftframe.png" id="tablecorner"></td>
    <td background="images/bottomframe.png"></td>
    <td background="images/bottomrightframe.png"></td>
    <td background="images/bottomleftframe.png"></td>
    <td background="images/bottomframe.png"></td>
    <td background="images/bottomrightframe.png" id="tablecorner"></td>
  </tr>
</table>
<s:include value="/transactions/commonDivs.jsp"></s:include>
<div id="itemDeclarationDiv" class="bpsPopup" style="width: 700px; max-height: 600px">
<!--PCS Web Service -- START-->
<div id="pcsPostScriptDiv">
</div>
<div id="pcsPreScriptDiv">
</div>
<!--PCS Web Service -- END-->
</div>
<input type="hidden" id="hid_trans_type" value="pcs"/>
</body>
</html>