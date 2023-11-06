<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<style type="text/css">
.tabledata{
font-family: Arial,Helvetica,sans-serif;
font-size: 12px;
font-weight:normal;
}
</style>
<script type="text/javascript">
showPromotionCustDiv='${request.promotionCustInfoVOListSize}';
discountMessage='${request.discountMsg}';
negativeAmountAllowed='${session.negativeAmountAllowed}';
trxxAmt='${request.trxAmount}';
totalFreeItemAmount='${request.totalFreeItemAmount}';
</script>
</head>
<body>
	<table id="trxLineItems" >
				<%int i=1; String style=""; %>				
				<s:iterator  value="%{#session.trxLineItemVOList}" var="trxLineItem">
					 <%if(i%2==0){
						 	style = "#CFEFB6";
					 	}else{
					 		style = "#A5E074"; 
					 	}
					  %>
				
				   <tr id="trxLineItem<%=i%>"  style="background-color:<%=style%>;" class="trClass" ondblclick="changeRowColor('trxLineItem<%=i%>',<%=i%>);" onclick="backToRowColor('trxLineItem<%=i%>','<%=style%>');" ><!-- onmouseover="changeRowColor('trxLineItem<%=i%>');" onmouseout="backToRowColor('trxLineItem<%=i%>','<%=style%>');" -->
				   		<td width="18"><img src="images/delete.png" height="16" width="16" onclick="deleteItem('<%=i%>');" alt="delete" title="delete" class="deleteImgClass"/></td>
				       	<td width="20"><span><s:property value="trxLineNum"/></span></td>
				       	<td width="300"><span  id="stockDesc_<%=i%>"><s:property value="stockDesc"/></span></td>
				       	<td width="150" align="center"><span><s:property value="stockCode"/></span></td>
				 		<td width="95" align="center"><span><s:property value="promotionCode"/></span></td>
						<td width="50" align="right"><span><s:property value="quantity"/></span></td>
				    	<td width="115" align="right"><span>P <s:text name="format.money"><s:param value="discountedPrice"/></s:text></span></td>
				       	<td width="100" align="right"><span  id="serviceFee_<%=i%>">P <s:text name="format.money"><s:param value="serviceFee"/></s:text></span></td>
				       	<td width="115" align="right"><span id="sellingPrice<%=i%>">P <s:text name="format.money"><s:param value="sellingPrice"/></s:text></span></td>	
 					</tr>						
			  		<%i++; %>
			   </s:iterator>
			    
			</table>


			
<!-- Payment Div Start -->			
<div id="paymentDiv" style="display: none;">
	<s:form theme="simple" id="paymentProcess" onsubmit="return false;">
	<s:hidden name="totalAmount" id="totalAmount"/>
	<s:hidden name="creditBalance" id="creditBalance"/>
	<s:hidden name="creditBalanceType" id="creditBalanceType"/>
	<table align="center" width="660" border="0" cellpadding="1" cellspacing="1" id="tenders">
	 
	  <tr>
	    <td colspan="2">&nbsp;</td>
	    <td id="tenders"><div align="center"><strong>AMOUNT</strong></div></td>
	    <td colspan="3" id="tenders"><div align="center"><strong>DETAILS</strong></div></td>
	  </tr>
	  <tr>
	    <td height="10" colspan="6"><hr align="center" /></td>
	  </tr>
	  <%int index=1; %>
	  <s:if test="#session.trxExactPaymentVOList==null">
	  <s:iterator value="#request.activeTenders" var="activeTender" status="payment">
		  <s:if test="'Cash'.equalsIgnoreCase(value)">
			  <tr>
			    <td width="31" align="center" id="checkLine<s:property value='%{#payment.index}'/>"><%=index %>
			    	<s:hidden id="tenderID<s:text value='%{#payment.index}'/>" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
	  				<s:hidden id="paymentTpe<s:text value='%{#payment.index}'/>" name="paymentVOs[%{#payment.index}].paymentType" value='%{#activeTender.Value}'/>
			    </td>
			    <td width="72"><label>
			      <input id="tenderCash" name="tender" type="checkbox" class="tender" value="Cash" checked="checked" onclick="enableDisable(this);"/>
			    CASH</label></td>
			    <td width="120" align="center"><label>
			      Php
			      <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" maxlength="20" cssClass="amt" id="txtCash" cssStyle="width:73px;" onkeypress="return numbersOnly(event);"  onchange="currencyFormatSM(this);"/>
			    </label></td>
			    <td width="23" align="center"><label></label></td>
			    <td colspan="2" align="center">&nbsp;</td>
			  </tr>
			  <tr align="center">
			    <td height="10" colspan="6"><hr align="center" /></td>
			  </tr>
		  </s:if>
	<%-- 	  <s:if test="#session.trxType=='Sale'"> --%>
			  <s:if test="'Check'.equalsIgnoreCase(value)">
				  <tr>
				    <td width="31" align="center" id="checkSlNo"><%=index %>
				    </td>
				    <td width="72"><label>
				    	<s:hidden id="tenderID" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe" name="paymentVOs[%{#payment.index}].paymentType" value='%{#activeTender.Value}'/>
				      <input id="tenderCheck<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Check" onclick="enableDisable(this);"/>
				    CHECK</label></td>
				    <td align="center"><label>
				      Php
				      <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtCheck" cssStyle="width:73px;" maxlength="20"
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				    </label></td>
				    <td width="20" align="right" id="img"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addChequeRow(this,<%=index %>)" disabled="true"/>&nbsp;&nbsp;&nbsp;</td>
				    <td width="175" align="left">Check #
				    <s:textfield name="paymentVOs[%{#payment.index}].tenderRefNum" id="txtCheckNumber" maxlength="13" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  onchange="checkDigit(this,'Check')" disabled="true"/></td>
				    <td width="165" align="left">Bank:
				    	
				    	<s:select  id="checkBanks" name="paymentVOs[%{#payment.index}].bankId" list="#request.bankList" listKey="bankId" listValue="bankName" headerKey="0" headerValue="--Select Bank--" disabled="true"/>
				    
				    </td>
				  </tr>
				  <tr align="center">
				    <td height="10" colspan="6"><hr align="center" /></td>
				  </tr>
		  	</s:if>
		  	<s:if test="value.contains('Card')">
		  		<tr>
				    <td align="center" id="cardSlNo"><%=index %>
				    </td>
				    <td><label>
				    	<s:hidden id="tenderID%{#payment.index}" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe%{#payment.index}" name="paymentVOs[%{#payment.index}].paymentType" value='Card'/>
			  			<s:hidden id="cardProcessMode%{#payment.index}" name="paymentVOs[%{#payment.index}].cardProcessMode" value="online"/>
			  			<s:hidden id="cardTenderAccNum" name="paymentVOs[%{#payment.index}].tenderAccNum" />
			  			<s:hidden id="carsHostAuthCode" name="paymentVOs[%{#payment.index}].hostAuthCode" />
				      <input id="tenderCard<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Card" onclick="enableDisable(this);"/>
				    CARD</label></td>
				    <td align="center"><label>
				      Php
				      <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" maxlength="20" cssClass="amt" id="txtCard" cssStyle="width:73px;" 
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				    </label></td>
				    <td align="right" id="cardImg" style="display : none;"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addCardRow(this,<%=index-1 %>);"/>&nbsp;&nbsp;&nbsp;<label></label></td>
				    <td colspan="2" align="left"><label>
				    
				  		<input id="onlineRadio" name="rdoOnlineOffline%{#payment.index}" type="radio" value="online" checked="checked" onclick="setCardProcessMode(this,<%=index-1 %>);"/> 
				Online</label>
				      &nbsp;&nbsp;&nbsp;
				      <label>
				      <input id="onlineRadio" name="rdoOnlineOffline%{#payment.index}" type="radio" value="offline" onclick="setCardProcessMode(this,<%=index-1 %>);"/>
				Offline</label></td>
				  </tr>
				  <tr align="center">
				    <td height="10" colspan="6"><hr align="center" /></td>
				  </tr>
		  	</s:if>
		  	<s:if test="value.contains('Gift')">
		  		<tr>
				    <td align="center" id="giftSlNo"><%=index %>
				    </td>
				    <td>
				    	<s:hidden id="tenderID%{#payment.index}" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe%{#payment.index}" name="paymentVOs[%{#payment.index}].paymentType" value='Gift'/>
			  			<!-- <s:hidden id="creditBalance%{#payment.index}" name="paymentVOs[%{#payment.index}].creditBalance" value='0.00'/> -->
				    <input id="tenderGift<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Gift" onclick="enableDisable(this);"/>
				    GIFT PASS / SODEXO </td>
				    <td align="center"><label>
				    Php
				    <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtGift" cssStyle="width:73px;" maxlength="20"
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				   	</label> </td>
				    <td align="right" id="giftImg"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addGiftRow(this,<%=index-1 %>);"/>&nbsp;&nbsp;&nbsp;</td>
				    <td colspan="2" align="left">Reference  #
				    	<s:textfield name="paymentVOs[%{#payment.index}].tenderRefNum" id="txtGiftReferenceNumber" maxlength="13" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  onchange="checkDigit(this,'Reference')" disabled="true"/>
				    </td>
				</tr>
				 <tr>
				    <td height="10" colspan="6"><hr align="center" /></td>
				 </tr>
		  	</s:if>
		  	<s:if test="value.contains('Other')">
		  		 <tr>
				    <td width="31" align="center" id="otherSlNo"><%=index %>
				    </td>
				    <td><label>
				    	<s:hidden id="tenderID%{#payment.index}" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe%{#payment.index}" name="paymentVOs[%{#payment.index}].paymentType" value='Other'/>
				      <input id="tenderOther<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Other" onclick="enableDisable(this);"/>
				    OTHER</label></td>
				    <td align="center"><label>
				       Php
				       <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtOther" cssStyle="width:73px;" maxlength="20"
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				    </label></td>
				    <td width="20" align="right" id="otherImg"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addOtherRow(this,<%=index-1 %>);"/>&nbsp;&nbsp;&nbsp;</td>
				    <td width="175" align="left">Account  #
				    	<s:textfield name="paymentVOs[%{#payment.index}].tenderAccNum" id="txtAcountNumber" maxlength="20" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"   disabled="true"/>
				    </td>
				    <td width="170" align="left" valign="middle">Reference  #
				    	<s:textfield name="paymentVOs[%{#payment.index}].tenderRefNum" id="txtReferenceNumber" maxlength="3" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  disabled="true"/>
				    </td>
				 </tr>
				 <tr>
				    <td height="10" colspan="6"><hr align="center" /></td>
				 </tr>
		  	</s:if>
	<%--   	</s:if> --%>
	  <%index++; %>
	  </s:iterator>
	  </s:if>
	  
	 <%-- <s:else>
	  
	   <s:iterator value="#request.activeTenders" var="activeTender" status="tender">
		  <s:if test="'Cash'.equalsIgnoreCase(value)">
		  	<s:iterator value="#session.trxExactPaymentVOList" var="activePayment" status="payment">
				  <tr>
				    <td width="31" align="center" id="checkLine<s:property value='%{#payment.index}'/>"><%=index %>
				    	<s:hidden id="tenderID<s:text value='%{#payment.index}'/>" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
		  				<s:hidden id="paymentTpe<s:text value='%{#payment.index}'/>" name="paymentVOs[%{#payment.index}].paymentType" value='%{#activeTender.Value}'/>
				    </td>
				    <td width="72"><label>
				      <input id="tenderCash" name="tender" type="checkbox" class="tender" value="Cash" checked="checked" onclick="enableDisable(this);"/>
				    CASH</label></td>
				    <td width="120" align="center"><label>
				      Php
				      <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtCash" cssStyle="width:73px;" onkeypress="return numbersOnly(event);"  onchange="currencyFormatSM(this);"/>
				    </label></td>
				    <td width="23" align="center"><label></label></td>
				    <td colspan="2" align="center">&nbsp;</td>
				  </tr>
				  <tr align="center">
				    <td height="10" colspan="6"><hr align="center" /></td>
				  </tr>
			  </s:iterator>
		  </s:if>
		  <s:if test="#session.trxType=='Sale'">
			  <s:if test="'Check'.equalsIgnoreCase(value)">
				  <tr>
				    <td width="31" align="center" id="checkSlNo"><%=index %>
				    </td>
				    <td width="72"><label>
				    	<s:hidden id="tenderID" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe" name="paymentVOs[%{#payment.index}].paymentType" value='%{#activeTender.Value}'/>
				      <input id="tenderCheck<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Check" onclick="enableDisable(this);"/>
				    CHECK</label></td>
				    <td align="center"><label>
				      Php
				      <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtCheck" cssStyle="width:73px;" 
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				    </label></td>
				    <td width="20" align="right" id="img"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addChequeRow(this,<%=index %>)" disabled="true"/>&nbsp;&nbsp;&nbsp;</td>
				    <td width="175" align="left">Check #
				    <s:textfield name="paymentVOs[%{#payment.index}].tenderRefNum" id="txtCheckNumber" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  onchange="checkDigit(this)" disabled="true"/></td>
				    <td width="165" align="left">Bank:
				    	
				    	<s:select  id="checkBanks" name="paymentVOs[%{#payment.index}].bankId" list="#request.bankList" listKey="bankId" listValue="bankName" headerKey="0" headerValue="--Select--" disabled="true"/>
				    
				    </td>
				  </tr>
				  <tr align="center">
				    <td height="10" colspan="6"><hr align="center" /></td>
				  </tr>
		  	</s:if>
		  	<s:if test="value.contains('Card')">
		  		<tr>
				    <td align="center" id="cardSlNo"><%=index %>
				    </td>
				    <td><label>
				    	<s:hidden id="tenderID%{#payment.index}" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe%{#payment.index}" name="paymentVOs[%{#payment.index}].paymentType" value='Card'/>
			  			<s:hidden id="cardProcessMode%{#payment.index}" name="paymentVOs[%{#payment.index}].cardProcessMode" value="online"/>
				      <input id="tenderCard<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Card" onclick="enableDisable(this);"/>
				    CARD</label></td>
				    <td align="center"><label>
				      Php
				      <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtCard" cssStyle="width:73px;" 
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				    </label></td>
				    <td align="right" id="cardImg"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addCardRow(this,<%=index-1 %>);"/>&nbsp;&nbsp;&nbsp;<label></label></td>
				    <td colspan="2" align="left"><label>
				    
				  		<input id="onlineRadio" name="rdoOnlineOffline%{#payment.index}" type="radio" value="online" checked="checked" onclick="setCardProcessMode(this,<%=index %>);"/> 
				Online</label>
				      &nbsp;&nbsp;&nbsp;
				      <label>
				      <input id="onlineRadio" name="rdoOnlineOffline%{#payment.index}" type="radio" value="offline" onclick="setCardProcessMode(this,<%=index-1 %>);"/>
				Offline</label></td>
				  </tr>
				  <tr align="center">
				    <td height="10" colspan="6"><hr align="center" /></td>
				  </tr>
		  	</s:if>
		  	<s:if test="value.contains('Gift')">
		  		<tr>
				    <td align="center" id="giftSlNo"><%=index %>
				    </td>
				    <td>
				    	<s:hidden id="tenderID%{#payment.index}" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe%{#payment.index}" name="paymentVOs[%{#payment.index}].paymentType" value='Gift'/>
				    <input id="tenderGift<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Gift" onclick="enableDisable(this);"/>
				    GIFT PASS / SODEXO </td>
				    <td align="center"><label>
				    Php
				    <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtGift" cssStyle="width:73px;" 
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				   	</label> </td>
				    <td align="right" id="giftImg"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addGiftRow(this,<%=index-1 %>);"/>&nbsp;&nbsp;&nbsp;</td>
				    <td colspan="2" align="left">Reference  #
				    	<s:textfield name="paymentVOs[%{#payment.index}].tenderRefNum" id="txtGiftReferenceNumber" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  onchange="checkDigit(this)" disabled="true"/>
				    </td>
				</tr>
				 <tr>
				    <td height="10" colspan="6"><hr align="center" /></td>
				 </tr>
		  	</s:if>
		  	<s:if test="value.contains('Other')">
		  		 <tr>
				    <td width="31" align="center" id="otherSlNo"><%=index %>
				    </td>
				    <td><label>
				    	<s:hidden id="tenderID%{#payment.index}" name="paymentVOs[%{#payment.index}].tenderId" value='%{#activeTender.key}'/>
			  			<s:hidden id="paymentTpe%{#payment.index}" name="paymentVOs[%{#payment.index}].paymentType" value='Other'/>
				      <input id="tenderOther<s:property value='%{#payment.index}'/>" class="tender" name="tender" type="checkbox" value="Other" onclick="enableDisable(this);"/>
				    OTHER</label></td>
				    <td align="center"><label>
				       Php
				       <s:textfield name="paymentVOs[%{#payment.index}].paymentAmount" cssClass="amt" id="txtOther" cssStyle="width:73px;" 
				      		onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);" disabled="true"/>
				    </label></td>
				    <td width="20" align="right" id="otherImg"><img id="<s:property value='%{#payment.index}'/>" src="./images/add.png" width="16" height="16" onclick="addOtherRow(this,<%=index-1 %>);"/>&nbsp;&nbsp;&nbsp;</td>
				    <td width="175" align="left">Account  #
				    	<s:textfield name="paymentVOs[%{#payment.index}].tenderAccNum" id="txtAcountNumber" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  onchange="checkDigit(this)" disabled="true"/>
				    </td>
				    <td width="170" align="left" valign="middle">Reference  #
				    	<s:textfield name="paymentVOs[%{#payment.index}].tenderRefNum" id="txtReferenceNumber" onkeypress="return alphaNumericOnly(event);" cssStyle="width:100px;"  onchange="checkDigit(this)" disabled="true"/>
				    </td>
				 </tr>
				 <tr>
				    <td height="10" colspan="6"><hr align="center" /></td>
				 </tr>
		  	</s:if>
	  	</s:if>
	  <%index++; %>
	  </s:iterator>
	  
	  </s:else> --%>
	  
	  <tr>
	    <td colspan="6"><div align="right">
	      <label>
	      <input name="okButton" type="button" class="smallpagebutton" id="okButton" onclick="validatePaymentDetails();" value="     OK     " />&nbsp;&nbsp;&nbsp;
	      <input name="cancelButton" type="button" class="smallpagebutton" id="cancelButton" onclick="return cancelPaymentInfo();" value="Cancel" />
	      </label>
	    </div></td>
	  </tr>
	</table>
	</s:form>
</div>
<!-- Payment Div End -->
<!-- Promotion Customer Info Div START -->
<div id="promotionsCustInfoDiv" class="bpsPopup" style="width: 700px; max-height: 600px">
<s:form theme="simple" action="setPromotionCustInfo" id="promotionCustInfo">
	<table width="580" height="200" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color: white;">
	<tr>
          <td class="bordertopleft"></td>
          <td class="bordertop"></td>
          <td class="bordertopright"></td>
    </tr>
	<tr>
		<td class="borderleft"></td>
		<td><strong class="style3 style4">PROMOTION CUSTOMER INFORMATION</strong></td>
		<td class="borderright"></td>
	</tr>
	<tr>
		<td class="borderleft"></td>
	  	<td><hr /></td>
	  	<td class="borderright"></td>
	</tr>
	<tr>
	  <td class="borderleft"></td>
	  <td>
	  <div style="overflow-y: scroll; height: 250px">
	  
		  <table width="500" border="0" align="center" cellpadding="2" cellspacing="2" id="tenders" style="vertical-align:middle;">
			    <%int idx=1;int objIdx=0; %>
			    <s:iterator value="#request.promotionCustInfoVOList" var="promotionCustInfo" status="custInfo">
			    <tr>
			      <td colspan="3" align="left" valign="top" class="style3">
			      	<div align="left" class="style5"><%=idx %>. <strong><s:property value="promotionName"/><strong> </div>
			     	<s:hidden name="promotionCustInfoVOs[%{#custInfo.index}].promotionId" value='%{#promotionCustInfo.promotionId}'/>
			      </td>
			    </tr>
		    	<tr>
		    		<td colspan="3">&nbsp;</td>
		    	</tr>
			    <s:iterator value="promotionCustomerInfoVOList" var="promotionCustomerInfo" status="customerInfo">
				    <tr>
				      <td width="100px">
				      	<s:hidden name="promotionCustInfoVOs[%{#custInfo.index}].promotionCustomerInfoVOList[%{#customerInfo.index}].id" value='%{#promotionCustomerInfo.id}'/>
				      </td>
				      <td align="right" width="400px"><strong><s:property value="fieldName"/>:</strong> </td>
				      <td>
				      	<s:if test="#promotionCustomerInfo.fieldType=='text'">
				      		<s:textfield cssClass="pcustClass" name="promotionCustInfoVOs[%{#custInfo.index}].promotionCustomerInfoVOList[%{#customerInfo.index}].fieldValue" size="50" maxlength="30"/>
				      	</s:if>
				      	<s:if test="#promotionCustomerInfo.fieldType=='textarea'">
				      		<s:textarea cssClass="pcustClass" name="promotionCustInfoVOs[%{#custInfo.index}].promotionCustomerInfoVOList[%{#customerInfo.index}].fieldValue" rows="3" cols="50"/>
				      	</s:if>
				      </td>
				    </tr>
				    <%objIdx++; %>
			    </s:iterator>
			    
			    <tr>
			      <td align="right">&nbsp;</td>
			      <td></td>
			      <td>&nbsp;</td>
			    </tr>
			    <%idx++; %>
		    </s:iterator>
		    <tr>
		      <td colspan="3" align="right"><div align="right">
		          <input name="okButton" type="button" class="smallpagebutton" id="okButton" onclick="setPromotionCustInfo()" value="OK" />&nbsp;&nbsp;&nbsp;
				  <input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="closePromotionsCustInfo();"/>
		      </div></td>
		    </tr>
		    <tr>
		      <td colspan="3" align="right">&nbsp;</td>
		    </tr>
		  </table>
		  </div>
	  </td>
	  <td class="borderright"></td>
	</tr>
	 <tr>
          <td class="borderbottomleft"></td>
          <td class="borderbottom"></td>
          <td class="borderbottomright"></td>
     </tr>
	</table>
</s:form>
</div>
<!-- Promotion Customer Info Div END -->				
</body>
</html>