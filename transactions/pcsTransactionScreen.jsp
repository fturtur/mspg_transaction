<%@ taglib prefix="s" uri="/struts-tags" %>

<script type="text/javascript">
hasSecondBarcode='${request.skusVO.hasSecondBarcode}';
barcode2='${request.skusVO.barcode2}';
pcsPreSubmitFlag=false;
pcsPostSubmitFlag=false;

</script>

<!-- Second Barcode Scan Div - START -->
<div id="secondBarcodeDiv" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="5" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="5" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">
      	<font color="red">
      		<p id="secondBarcodeError" style="display: none;"></p>
      	</font>
      </td>
    </tr>
    <tr>
      <td width="120" align="left" valign="middle" colspan="2"><strong>Scan Barcode Code</strong>:</td>
      <!-- <td width="3" align="left" valign="middle"><label></label></td> -->
      <td width="250" align="left" valign="middle" >
      	<input type="text" name="secondBarcode" maxlength="15" style="width:190px"  id="secondBarcode" onkeypress="return  AllowOnlyDigits(event);" onkeyup="checkSecondBarcode(this);" ><!-- readonly -->
      	<a onclick="clearSecondBarcode();" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'">Clear</a>
      	</td>
    </tr>
	<tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3" align="right" valign="middle"></td>
    </tr>
    <tr>
      <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
      <td height="10" colspan="3" align="right" valign="middle" background="images/bottomframe.png"></td>
      <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
    </tr>
  </table>
</div>
<!-- Second Barcode Scan Div - END -->

<!-- Sale Transaction Div START -->
<s:if test="#request.skusVO!=null">
<table width="500" border="0" cellspacing="1" cellpadding="4" style="font:12px Arial, Helvetica, sans-serif" id="cardTransactionTab">
<s:if test="#request.trxType=='Sale'">
	<script type="text/javascript">
		pcsPreSubmitFlag=false;
		pcsPostSubmitFlag=false;
	</script>
  <tr>
    <td colspan="2" align="center" valign="middle"><p align="left"><strong>Item Details </strong></p> 
    	<s:hidden name="#request.skusVO.id" id="skuId"/>
    	<s:hidden name="#request.skusVO.barcode" id="barCode"/> 
    	<s:hidden name="#request.skusVO.rcptType" id="rcptType"/> 
    	<s:hidden name="#request.skusVO.hasSecondBarcode" id="hasSecondBarcode"/> 
    	<s:hidden name="#request.skusVO.barcode2" id="barcode2"/> 
    	<input type="hidden" name="trxType" id="trxType" value="Sale"/>
    	<input type="hidden" name="scannedBarcode2" id="scannedBarcode2"/>
       </td>
  </tr>
  <s:if test="#request.skusVO.pcsSkuBarcodes!=null">
	  <tr>
	    <td width="150" align="left" valign="middle"><div align="right"><strong>Item Barcode: </strong></div></td>
	    <td align="left" valign="middle"><div><s:select list="#request.skusVO.pcsSkuBarcodes" listKey="barcode" 
	    	listValue="barcode" theme="simple" cssStyle="width: 135px;" onchange="setBarcode(this);" id="selectBarcode"
	    	headerKey="-1" headerValue="--Select--"/></div>
	    </td>
	  </tr>
  </s:if>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Item Code: </strong></div></td>
    <td align="left" valign="middle"><div><s:property value="#request.skusVO.stockCode"/></div>
    	<s:hidden name="lineItemVO.stockCode" value="#request.skusVO.stockCode"/>
    </td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Item Description:</strong></div></td>
    <td align="left" valign="middle"><s:property value="#request.skusVO.stockDescription"/> </td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Amount:</strong></div></td>
    <td align="left" valign="middle">P <s:text name="format.money"><s:param value="#request.skusVO.unitRetail"/></s:text>
    <s:hidden name="#request.skusVO.unitRetail" id="amount"/></td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Quantity<font color="red">*</font></strong></div></td>
    <td align="left" valign="middle"><input type="text" value="1" name="textfield3" maxlength="4" id="quantity"  onkeypress="return numbersOnly(event);" /></td><!-- onkeypress="return  AllowOnlyDigits(event);" -->
  </tr>
   <tr>
    <td colspan="2" align="left" valign="middle"><div align="center"><hr /></div></td>
  </tr>
  <s:if test="#request.skusVO.promotionName!=null">
	 <tr>
	    <td colspan="2" align="left" valign="middle"><div align="left">Promotion:</div>
	    <s:hidden name="#request.skusVO.couponCount" id="couponCount"/></td>
	    </td>
	  </tr>
	  <tr>
	    <td width="150" align="left" valign="middle"><div align="right"><strong>Promotion Name: </strong></div></td>
	    <td align="left" valign="middle"><s:property value="#request.skusVO.promotionName" /></td>
	  </tr>
	  <tr>
	    <td width="150" align="left" valign="middle"><div align="right"><strong>Promotion Description: </strong></div></td>
		<td align="left" valign="middle"><s:property value="#request.skusVO.promotionDescription" /></td>
	  </tr>
	  <tr>
	    <td align="left" valign="middle"><div align="right"><strong>Enable / Disable:</strong></div>
	    <s:hidden name="enDisPromo" id="enDisPromo" value="enabled"/>
	    </td>
	    <td align="left" valign="middle"><input id="en_dis_promo" name="checkbox" type="checkbox" value="checkbox" checked="checked" onclick="enableDisablePromotion();" />
	      <span id="en_dis_promo_label" style="color: #009900;">Enabled</span></td>
	  </tr>
	</s:if>
</s:if>  
<s:if test="#request.trxType=='Service'">
	<tr>
	    <td colspan="3" align="center" valign="middle"><p align="left"><strong>Details </strong></p> 
	    	<s:hidden name="#request.skusVO.id" id="skuId"/>
	    	<s:hidden name="#request.skusVO.quantityInto" id="quantityIntoId"/>
	    	<s:hidden name="#request.skusVO.barcode" id="barCode"/>
	    	<s:hidden name="#request.skusVO.rcptType" id="rcptType"/>  
	    	<s:hidden name="#request.skusVO.serviceFeeRcptType" id="serviceFeeRcptType"/>
	    	<s:hidden name="#request.skusVO.negativeAmountAllowed" id="negativeAmountAllowed"/>
	    	<input type="hidden" name="trxType" id="trxType" value="Service"/>
	    </td>
	  </tr>
	  <tr>
	    <td width="150" align="left" valign="middle"><div align="right"><strong>Code: </strong></div></td>
	    <td align="left" valign="middle" colspan="2"><div><s:property value="#request.skusVO.stockCode"/></div>
	    	<s:hidden name="lineItemVO.stockCode" value="#request.skusVO.stockCode"/>
	    </td>
	  </tr>
	  <tr>
	    <td width="150" align="left" valign="middle"><div align="right"><strong>Description:</strong></div></td>
	    <td align="left" valign="middle" colspan="2"><s:property value="#request.skusVO.stockDescription"/> </td>
	  </tr>
	   <s:if test="%{#request.skusVO.rcptType.equalsIgnoreCase('NONE')}">
	   		<s:hidden id="amount" value="0.00"/>
	   </s:if>
	   <s:else>
		   <tr>
		    <td width="150" align="left" valign="middle"><div align="right"><strong>Amount:</strong></div></td>
		    <%-- <td align="left" valign="middle">P <s:text name="format.money"><s:param value="#request.skusVO.unitRetail"/></s:text>
		    <s:hidden name="#request.skusVO.unitRetail" id="amount"/></td> --%>
		    <td>P</td>
		    <td align="left" valign="middle"> 
		    	<!-- <input type="text" name="textfield3" id="amount" onkeypress="return numbersOnly(event);" maxlength="19" onchange="currencyFormatSM(this);"/> -->
		    	<s:if test="#request.skusVO.unitRetail!=null">
		    		<s:text name="format.money"><s:param value="#request.skusVO.unitRetail"/></s:text>
		    		<s:hidden name="#request.skusVO.unitRetail" id="amount"/>
		    	</s:if>
		    	<s:else>
		    		<input type="text" name="textfield3" id="amount" maxlength="19" onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);"/>
		    	</s:else>
		    </td>
		  </tr>
	   </s:else>
	   <s:if test="%{#request.skusVO.serviceFeeRcptType.equalsIgnoreCase('NONE')}">
	   		<s:hidden id="serviceFee" value="0.00"/>
	   </s:if>
	   <s:else>
		  <tr>
		    <td width="150" align="left" valign="middle"><div align="right"><strong>Service Fee:</strong></div></td>
		    <td>P</td>
		    <td align="left" valign="middle"> 
		    	<s:if test="#request.skusVO.serviceFee!=null">
		    		<s:text name="format.money"><s:param value="#request.skusVO.serviceFee"/></s:text>
		    		<s:hidden name="#request.skusVO.serviceFee" id="serviceFee"/>
		    	</s:if>
		    	<s:else>
		    		<input type="text" name="textfield3" id="serviceFee" maxlength="19" onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);"/>
		    	</s:else>
		    </td>
		  </tr>
	   </s:else>
	  <s:if test="%{#request.skusVO.dataEntryAllowed.equalsIgnoreCase('Y')}">
		  <tr>
		    <td width="150" align="left" valign="middle"><div align="right"><strong><s:property value="#request.skusVO.dataEntryLabel"/>:</strong></div></td>
		    <td width="5">
		    	<s:hidden id="dataEntryLabel" name="#request.skusVO.dataEntryLabel"/>
		    </td>
		    <td align="left" valign="middle"><input type="text" name="textfield3" id="dataEntryVal" maxlength="30"/></td>
		  </tr>
	  </s:if>
	  <!-- PCS Web Service -- START -->
	  
	  <s:if test="%{#request.skusVO.dataEntryAllowedTwo.equalsIgnoreCase('Y')}">
	  	<tr>
  			<td width="150" align="left" valign="middle"><div align="right"><strong><s:property value="#request.skusVO.dataEntryLabelTwo"/>:</strong></div></td>
		    <td width="5">
		    	<s:hidden id="dataEntryLabelTwo" name="#request.skusVO.dataEntryLabelTwo"/>
		    </td>
	  			<s:if test="%{#request.skusVO.dataEntryListTwo.equalsIgnoreCase('Y')}">
					<td align="left" valign="middle">
						<div>
							<s:select list="#request.skusVO.pcsDataLists" listKey="dataListValue" 
						    	listValue="dataListValue" theme="simple" cssStyle="width: 135px;" onchange="setdatalist(this);" id="dataEntryValTwo"
						    	headerKey="-1" headerValue="--Select--"/>
				    	</div>
				    </td>
			
	  			</s:if>
	  			<s:else>
			    	<td align="left" valign="middle"><input type="text" name="textfield3" id="dataEntryValTwo" maxlength="30"/></td>
				</s:else>
		</tr>
	  </s:if>
	  <s:if test="%{#request.skusVO.webService.equalsIgnoreCase('Y')}">	
	  	 <script type="text/javascript">
	  		pcsPostSubmitFlag=true;
		 </script>
	  	 <tr>
	  	 	<td>
		    	<s:hidden id="webService" name="#request.skusVO.webService"/>  
	  	 	</td>
	  	 </tr>
	  	 <s:if test="#request.skusVO.webAlgorithm!=NULL">	
	  	 <s:if test="#request.skusVO.webAlgorithm!=''">			
			<input type="hidden" id="callPcsPostSubmit" value="Y" />
			 <div class="pcsPostSubmitDiv" style="display: none;">
			 function fun_pcsPostSubmit(){
				<s:property value="%{#request.skusVO.webAlgorithm}" />
				}
			</div>
		</s:if>	
		</s:if>									
	  </s:if>
	  <s:else>
	  	<script type="text/javascript">
	  		pcsPostSubmitFlag=false;
		 </script>
	  </s:else>
	  <s:if test="%{#request.skusVO.preWebService.equalsIgnoreCase('Y')}">	
	  	 <script type="text/javascript">
	  		pcsPreSubmitFlag=true;
		 </script>
	  	 <tr>
	  	 	<td>
		    	<s:hidden id="preWebService" name="#request.skusVO.preWebService"/>  
	  	 	</td>
	  	 </tr>
	  	 <s:if test="#request.skusVO.preWebAlgorithm!=NULL">	
	  	 <s:if test="#request.skusVO.preWebAlgorithm!=''">			
			<input type="hidden" id="callPcsPreSubmit" value="Y" />
			 <div class="pcsPreSubmitDiv" style="display: none;">
			 function fun_pcsPreSubmit(){
				<s:property value="%{#request.skusVO.preWebAlgorithm}" />
				}
			</div>
		</s:if>	
		</s:if>									
	  </s:if>
	  <s:else>
	  	<script type="text/javascript">
	  		pcsPreSubmitFlag=false;
		 </script>
	  </s:else>
	  <!-- PCS Web Service -- END -->
	  <tr>
	    <td width="150" align="left" valign="middle"><div align="right"><strong>Quantity:</strong></div></td>
	    <td width="5"></td>
	    <td align="left" valign="middle">
	    	<s:if test="#request.skusVO.quantityInto!=3">
	    		<input type="text" value="1" name="textfield3" id="quantity" maxlength="4" onkeypress="return numbersOnly(event);"/>
	    	</s:if>
	    	<s:else>
	    		<s:hidden id="quantity" value="1"/>
	    		1
	    	</s:else>
	    </td>
	  </tr> 
	   <tr>
	    <td colspan="3" align="left" valign="middle"><div align="center"><hr /></div></td>
	  </tr>
</s:if>
  
  <tr>
    <td colspan="3 align="center" valign="top">
      <div align="right"><a>
        <input class="smallpagebutton" type="button" value="     OK     "  onclick="showCouponScanDiv();"/>
      </a></div>
    </td>
  </tr>
</table>

<!-- Sale Transaction Div END -->
<div id="skuProfile" style="display: none;">
<table style="font:12px Arial, Helvetica, sans-serif" >
			<tr>
				<td><p><strong><font size='+1'>Product Profile</font></strong></p></td>
			</tr>
			<tr ><td>				
					<s:if test="#request.skusVO.ppcProfile!=NULL">				
						<s:text name="#request.skusVO.ppcProfile"/>
					</s:if>
			</td></tr>
</table>
</div>
</s:if>
<s:if test="%{#request.freeDeptItem.equalsIgnoreCase('Y')}">
<script type="text/javascript">
	pcsPreSubmitFlag=false;
	pcsPostSubmitFlag=false;
</script>
<table width="500" border="0" cellspacing="1" cellpadding="4" style="font:12px Arial, Helvetica, sans-serif" id="cardTransactionTab">
	<tr>
     	<td colspan="3" align="center" valign="middle"><p align="left"><strong>Item Details </strong></p> 
	    	<s:hidden name="#request.freeItemBarcode" id="barCode"/> 
	    	<s:hidden name="#request.rcptType" id="rcptType"/> 
	    	<input type="hidden" name="trxType" id="trxType" value="Sale"/>
    	</td>
  </tr>
  <tr>
    	<td width="150" align="left" valign="middle"><div align="right"><strong>Item Barcode: </strong></div></td>
    	<td width="5"></td>
    	<td align="left" valign="middle"><div><s:property value="#request.freeItemBarcode"/></div></td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Item Code: </strong></div></td>
    <td width="5"></td>
    <td align="left" valign="middle"><div>86</div></td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Item Description:</strong></div></td>
    <td width="5"></td>
    <td align="left" valign="middle"></td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Amount<font color="red">*</font>:</strong></div></td>
    <td>P</td>
    <td align="left" valign="middle"><input type="text" name="textfield3" maxlength="8" id="amount"  onkeypress="return numbersOnly(event);" onchange="currencyFormatSM(this);"/>
    </td>
  </tr>
  <tr>
    <td width="150" align="left" valign="middle"><div align="right"><strong>Quantity<font color="red">*</font>:</strong></div></td>
    <td width="5"></td>
    <td align="left" valign="middle">  <input type="text" value="1" name="textfield3" maxlength="4" id="quantity"  onkeypress="return numbersOnly(event);" /></td>
  </tr>
   <tr>
    <td colspan="3" align="left" valign="middle"><div align="center"><hr /></div></td>
  </tr>
   <tr>
    <td colspan="3 align="center" valign="top">
      <div align="right"><a>
        <input class="smallpagebutton" type="button" value="     OK     "  onclick="addItem();"/>
      </a></div>
    </td>
  </tr>
</table>
</s:if>

<s:if test="%{#request.freeDeptItem.equalsIgnoreCase('N')}">
	<div align="center"><h2><span style="color: red;">No products found </span></h2></div>
</s:if>



