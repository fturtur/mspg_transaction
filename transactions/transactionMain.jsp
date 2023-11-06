<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="s" uri="/struts-tags" %>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SM Bills Payment System - Transaction Main page</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<link href="css/devStyles.css" rel="stylesheet" type="text/css" />
<script src="javascript/jquery-1.8.0.min.js"></script>
<script src="javascript/jquery-1.4.2.js"></script>
<script type="text/javascript" src="javascript/checkSession.js"></script>
<script src="<%=request.getContextPath() %>/javascript/jqbarcodeandmsr.js"></script>
<!--Cebu Pacific Webservice Integration - START-->
<script type="text/javascript">
var postSubmitFlag=false;
var billerFieldList;
//PreSubmit Before Save - START//
var preSubmitFlag=false;
//PreSubmit Before Save - END//
</script>
<!--Cebu Pacific Webservice Integration - END-->

<script type="text/javascript">
var isTenderPageOpen=false;
</script>

<script src="javascript/upload.js" type="text/javascript"></script>
<script src="javascript/common.js" type="text/javascript"></script>
<script src="javascript/biller.js" type="text/javascript"></script>
<script src="javascript/tender.js" type="text/javascript"></script>
<script src="javascript/transactionMain.js" type="text/javascript" />
<s:head theme="simple" />
</head>
<body>

<s:form action="showLoginPage" id="billerTranForm" theme="simple">

<input type="hidden" name="billerIndex" id="billerIndex" />
<input type="hidden" name="billerId" id="billerId"/>
<input type="hidden" name="tenderIndex" id="tenderIndex"/>
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
<!-- CORRECTION FOR OFFLINE TRANSACTION - START -->
<input type="hidden" id="billerProcessingMode" />
<!-- CORRECTION FOR OFFLINE TRANSACTION - END -->
<!-- Mixed Online and Offline Biller fix - START -->
<input type="hidden" id="billerTransProcessingMode" />
<!-- Mixed Online and Offline Biller fix - END -->
<input type="hidden" id="cardProcessMode" />
<input type="hidden" id="collectionTreshold" value="<s:property value="#session.userVO.collectionThreshold"/>" />
<input type="hidden" id="cashInhand" value="<s:property value="#session.userVO.cashInhand"/>"/>
<input type="hidden" id="pickupCount"  value="<s:property value="#session.userVO.pickupCount"/>"/>
<input type="hidden" id="billerBarcodeVal" value=""/>
<input type="hidden" id="msrGlobalId" value="" />
<input type="hidden" id="cashDeclarationCompleted" value="<s:property value="#session.userVO.cashDeclarationCompleted"/>"/>
<input type="hidden" id="trxProessed" />
<input type="hidden" id="trxCheckQty" value="<s:property value="#session.userVO.cashierVO.trxTotCheckQty"/>"/>
<input type="hidden" id="trxCheckAmt" value="<s:property value="#session.userVO.cashierVO.trxTotCheckAmt"/>"/>
<input type="hidden" id="checkDetails" value=""/>
<input type="hidden" id="otherDetails" value=""/>
<input type="hidden" id="trxAdditionInprogress" value="false"/>
<input type="hidden" id="deleteTrxLinesInProcess" value="false"/>
<input type="hidden" id="terminalOnlineStatus" value="<s:property value="#session.userVO.onlineStatus"/>"/>
<input type="hidden" id="eFlag" value="N"/>
<!--Cebu Pacific Webservice Integration - START-->
<input type="hidden" id="cashierName" value="<s:property value="#session.userVO.bpsUser.firstName"/> <s:property value="#session.userVO.bpsUser.lastName"/>"/>
<input type="hidden" id="branchCode" value="<s:property value="#session.userVO.bpsBranch.branchCode"/>"/>
<input type="hidden" id="locationCode" value="<s:property value="#session.userVO.bpsTerminal.bpsLocation.locationCode"/>"/>
<input type="hidden" id="terminalCode" value="<s:property value="#session.userVO.bpsTerminal.terminalCode"/>"/>
<!--Cebu Pacific Webservice Integration - END-->
<table align="center" width="1020" height="720px" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10" background="images/topleftframe.png" id="tablecorner"></td>
    <td colspan="4" background="images/topframe.png"></td>
    <td width="10" background="images/toprightframe.png" id="tablecorner"></td>
  </tr>
  
  <tr>
    <td background="images/leftframe.png">&nbsp;&nbsp;</td>
    <td height="80px" colspan="4">
      	<table width="1000" height="80" border="0" cellpadding="0" cellspacing="0">
       		<tr>
        		<td width="67" rowspan="2" align="center" valign="middle">
	        	<img src="images/NewSMStoreLogo.png" alt="SM" width="120" height="110"/>
	       
        		</td>
		        <td width="266" rowspan="2" id="banner">Bills Payment System<br />
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
			        	
			        		<img src="images/bps2pcs_icon.png" alt="Prepaid System" width="30" height="30" border="1" title="Prepaid System"
			        		onclick="navigateToPCS()" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'"/>
			        	
		        	</s:if>
		        	<img id="cashPickup" src="images/cashPickup.jpg" alt="Pick-Up" width="30" height="30" border="1" title="Pick-Up"/> 
		        	<img id="cashPickupAni" style="display: none;" src="images/cashPickupAnimated.gif" width="30" height="30" border="1" title="Pick-Up"/>
		        	<img id="checkPickup" src="images/checkPickup.jpg" alt="Sign-On Float" width="30" height="30" border="1" title="Sign-On Float"/> 
		        	<img id="checkPickupAni" style="display: none;" src="images/checkPickupAnimated.gif" width="30" height="30" border="1" title="Sign-On Float"/>
		        	<s:if test="#session.userVO.allowedOperations=='BOTH'">
			        	<s:a action="csaBulletin" namespace="/">
			        		<img src="images/home.png" alt="Home Page" width="30" height="30" border="1" title="Home Page" onclick="return navigateToHomePage()" 
		        			onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'"/>
			        	</s:a>
		        	</s:if>
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
    <td background="images/rightframe.png">&nbsp;&nbsp;</td>
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
  <tr >
    <td background="images/leftframe.png"></td>    
    <td height="20px" colspan="4" valign="top">    
    <table align="left" height="20px" border="1" cellspacing="0" cellpadding="0">
           
           <tr id="tableheader">
		        <td width="18" bordercolor="#FFFFFF" id="intRowNumber" title="0"></td>
		        <td width="15" bordercolor="#FFFFFF"><img src="images/delete.png" height="12" width="12" onclick="deleteTrxDetails();" alt="deleteAll" title="delete all" /></td>
		        <td width="20" bgcolor="#FFCC66">#</td>
		        <td width="150" bgcolor="#FFCC66">Biller Name</td>
		        <td width="200" bgcolor="#FFCC66">Reference / Account Number</td>
		        <td width="115" bgcolor="#FFCC66">Amount Due </td>
		        <td width="80" bgcolor="#FFCC66">Service Fee</td>
		        <td width="115" bgcolor="#FFCC66">Total Due</td>
		        <td width="15" bordercolor="#FFFFFF">&nbsp;</td>
		        <td width="115" bgcolor="#FFCC66">Payment Type</td>
		        <td width="115" bgcolor="#FFCC66">Amount Paid </td>
       	  </tr>   
    </table>  
    <div style="overflow-y: scroll;overflow-x:hidden;height:200px;width:995px;">  
       <table id="centertablePanel" align="left"></table>
    </div>
    </td>
    <td  height="210px" background="images/rightframe.png"></td>
  </tr>
 
   <tr id="panelrow"></tr>
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
    <td width="680" height="300px">
    <table width="680px" height="300px" border="0" cellpadding="0" cellspacing="0" id="commonArea" style="display: none;">
    </table>
   <table width="680px" height="300px" border="0" cellpadding="0" cellspacing="0" id="billers" >
   
	  <tr  id="tenderRow">
	    <td width="150px" valign="top">
	    <table width="100%" border="0" cellspacing="0" cellpadding="1">
	      <tr>
	        <td><label>
	          <input type="text" name="searchText" id="searchText" style="width:110px" onkeyup="autoComplete();" />
	          <img src="images/search.png" width="16" height="16" onclick="autoComplete();"/></label>
<!-- 	          <div id="autoComConainer" style="display: none; border: solid black 1px;position: absolute; font-family:Arial, Helvetica, sans-serif; text-align: justify; font-size: 12px; width: 135px;"></div>
 -->	    </td>
	          
	        <td rowspan="12" bgcolor="#CCCCCC">&nbsp;</td>
	      </tr>
	      <tr>
     	<td>
     		<div style="overflow-y: scroll;height: 300px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="1">
					<s:iterator value="billerCategories" var="billCat">
				      <tr>
				        <td align="left" valign="middle">
				        	<s:a href="javascript:getBillers('%{categoryId}');" ><img src="images/bullet.png" width="16" height="16" border="0" /><s:property value="categoryName"/>  </s:a>
				        </td>
				        </tr>
				    </s:iterator>
				</table>
			</div>
     	</td>
     </tr>
	    </table>	    
	    </td>
	    
	    <td width="500px" colspan="3" valign="top">	    	
		    <div style="padding:10px;overflow: auto;height: 260px;display:block;" id="billersContainer" >		    	
		    </div>		    	  
	    </td>	        
	  </tr>	 
	  <!-- Tender details div -->
	  <tr id="dynamicTenderTable"></tr>
	</table>
    </td>
    
    <td background="images/rightframe.png"></td>
    <td background="images/leftframe.png"></td>
    <td id="billerpagetext" width="500" valign="middle">
		<div id="summary" style="font-family:Arial, Helvetica, sans-serif; font-style:normal; font-size:12px; text-align:left;"></div>
		<div id="details"></div>
		<div id="status" style="vertical-align:bottom;"></div>
		<div id="cashtender" style="vertical-align:bottom;"></div>
				
		<!-- Biller policies div -->
		<div  id="billersPolicies"></div>	
		
		<!-- Total Amount div -->
	 	<div id="totalAmount" align="center" style="display:none;"></div>
	</td>
	
    <td background="images/rightframe.png"></td>
  </tr>
		    
  <tr>
    <td background="images/bottomleftframe.png" id="tablecorner"></td>
    <td background="images/bottomframe.png"></td>
    <td background="images/bottomrightframe.png"></td>
    <td background="images/bottomleftframe.png"></td>
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
    <td height="50px"><table width="680" height="50" border="0" cellspacing="0" cellpadding="0">
      <tr id="managerButtons">
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="signOut" type="button" id="signOut" value="[F5]&#10;Sign Out" onclick="logout();"/></td>
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK22" type="button" id="btnOK22" value="[F6]&#10;Functions" onclick="showManagerFunctions();"/></td>
        <td align="center" valign="middle" width="12.5%">
        	<input class="functionbutton" name="btnOK222" type="button" id="suspendId" value="[F7]&#10;Suspend" onclick="showSuspendDiv();" style="display: none;"/>
        	<input class="functionbutton" name="btnOK222" type="button" id="resumeId" value="[F7]&#10;Resume" onclick="resumeTrx();" />
        </td>
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK22" type="button" id="btnOK22" value="[F8]&#10;Void" onclick="cashierVoidTrx();"/></td>
         <s:if test="'store cashier'.equalsIgnoreCase(#session.userVO.bpsUser.bpsRoles.roleName)">
       			 <td align="center" valign="middle"><input class="functionbutton" name="btnOK2" type="button" id="pickUpButton" value="[F9]&#10;Pick-Up" onclick="pickup();" /></td>
         </s:if>
         <s:else>
         <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>
         	 <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK2" type="button" id="pickUpButton" style="display: none;" value="[F9]&#10;Pick-Up" onclick="pickup();"/></td>
         </s:else> 
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK23" type="button" id="btnOK23" value="[F10]&#10;Pre-Comm" onclick="precommit();" /></td>
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK3" type="button" id="btnOK3" value="[F11]&#10;SMAC" onclick="smacInfo();"/></td>        
		<!-- 6152 - START -->
        <td align="center" valign="middle" width="12.5%"><input onclick="callRenderPaymentArea();" class="functionbutton" name="btnOK" type="button" id="btnOK" value="[F12]&#10;Submit" /></td>
        <td align="center" valign="middle" width="12.5%"><input onclick="upload();" class="functionbutton" name="btnUpload" type="button" id="btnUpload" value="Upload" /></td>
		<!-- 6152 - END -->
      </tr>
      <tr id="managerButtons1" style="display:none;">
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK223" type="button" id="btnOK223" value="[F6]&#10;Back" onclick="hideManagerFunctions();"/></td>
	    <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>
   	  	<td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>
   	    <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>
   	     <s:if test="'store cashier'.equalsIgnoreCase(#session.userVO.bpsUser.bpsRoles.roleName)">
       		<td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK22" type="button" id="btnOK22" value="Reprint" onclick="cashierReprintTrx();"/></td>
         </s:if>
         <s:else>
         	  <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK22" type="button" id="btnOK22" value="Reprint" onclick="reprintTrx();"/></td>  
         </s:else> 
        
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK3" type="button" id="btnOK3" value="Zero Rated" onclick="zeroRated();"/></td>
         <s:if test="'store cashier'.equalsIgnoreCase(#session.userVO.bpsUser.bpsRoles.roleName)">
       			   <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK3" type="button" id="btnOK3" value="Reconcile" onclick="saveTerminalReconciliation();"/></td>
         </s:if>
         <s:else>
         	 <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>  
         </s:else> 
     
         
      </tr>
   
    </table></td>
     <td height="50px" background="images/rightframe.png">&nbsp;</td>
    <td height="50px" background="images/leftframe.png">&nbsp;</td>
    <td height="50px" id="banner" style="color:#FF0000"> <div id="msgId"></div></td>
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
<div id="meralco" billername="Meralco" servicefee="000" style="position:absolute; visibility:hidden;"></div>
<div id="sss" billername="SSS" servicefee="2000" style="position:absolute; visibility:hidden;"></div>
<div id="pldt" billername="PLDT" servicefee="000" style="position:absolute; visibility:hidden;"></div>
<div id="globe" billername="Globe" servicefee="000" style="position:absolute; visibility:hidden;"></div>
<div id="manilawater" billername="Manila Water" servicefee="000" style="position:absolute; visibility:hidden;"></div>
<div id="total" totalvalue="0" balancevalue="0" cash="0" check="0" card="0" other="0" style="position:absolute; visibility:hidden;"></div>
<div id="showtender" cash="0" check="0" card="0" other="0" currentrow="-1" endrow="0" style="position:absolute; visibility:hidden;"></div>
<div id="processtender" cash="0" style="position:absolute; visibility:hidden;"></div>


	


<s:include value="/transactions/commonDivs.jsp"></s:include>	

</s:form>
<!--Cebu Pacific Webservice Integration - START-->
<div id="postScriptDiv">
						
</div>
<!--Cebu Pacific Webservice Integration - END-->
<!--PreSubmit Before Save - START-->
<div id="preScriptDiv">
						
</div>
<!--PreSubmit Before Save - END-->
</body>
</html>
