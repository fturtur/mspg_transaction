<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- Pickup Div START -->
<table id="cashpickupDiv" style="display: none;">
		
  <tr>    
    <td height="80px" colspan="4" style="background-color: #ffffff;">
    	<table width="680" height="300" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td><strong class="style3 style4">CASH AND CHECK PICK-UP</strong></td>
			</tr>
			<!-- <tr>
			  <td><hr /></td>
			</tr> -->
			<tr>
			  <td><div  id="ccHeadersDiv">
			  <table width="680" height="20" border="0" align="center" cellpadding="1" cellspacing="1" id="tenders" style="vertical-align:middle;">
			
			    <tr>
		      <td colspan="13" align="left"><hr /></td>
		    </tr>
		    <tr>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Denomination</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Quantity</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Amount</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Denomination</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Quantity</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Amount</strong></td>
		    </tr>
		    <tr>
		      <td colspan="6" align="center"><hr align="center" /></td>
		      <td align="center"></td>
		      <td colspan="6" align="center"><hr align="center" /></td>
		    </tr>
			    
			  </table>
			  </div></td>
			</tr>
			
			<!-- new cash pickup activity start -->
			  <tr>
			    <td colspan="13">
				   <div  id="cashDetailsDiv">
				    <table width="680" border="0" align="center" cellpadding="1" cellspacing="1" id="tenders" style="vertical-align:middle;"> 
				    <tr>
				      <td align="center"><strong>CASH</strong></td>
				      <td align="right">Php 1,000</td>
				      <td align="right"> x </td>
				      <td align="center"><label>
				        <input name="textfield" type="text" tabindex="1" id="p1000" size="5" onblur="calcPickUpAmt(1000, this, '1000TD');"  onkeypress="return  AllowOnlyDigits(event);"/>
				      </label></td>
				      <td align="center">=</td>
				      <td align="right" id="1000TD">Php 0.00 </td>
				      <td align="center">&nbsp;</td>
				      <td align="center"><strong>CASH</strong></td>
				      <td align="right">Php 10 </td>
				      <td align="right"> x </td>
				      <td align="center"><label>
				        <input name="textfield2" type="text" tabindex="7" id="p10" size="5" onblur="calcPickUpAmt(10, this, '10TD');" onkeypress=" return  AllowOnlyDigits(event);"/>
				      </label></td>
				      <td align="center">=</td>
				      <td align="right" id="10TD">Php 0.00 </td>
				    </tr>
				    <tr>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 500</td>
				      <td align="right"> x </td>
				      <td align="center"><input name="textfield2" tabindex="2" id="p500" type="text" size="5" onblur="calcPickUpAmt(500, this, '500TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="500TD">Php 0.00 </td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 5 </td>
				      <td align="right"> x </td>
				      <td align="center"><input name="textfield2" type="text" tabindex="8" id="p5" size="5" onblur="calcPickUpAmt(5, this, '5TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="5TD">Php 0.00 </td>
				    </tr>
				    <tr>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 200 </td>
				      <td align="right"> x</td>
				      <td align="center"><input name="textfield3" type="text" tabindex="3" id="p200" size="5" onblur="calcPickUpAmt(200, this, '200TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="200TD">Php 0.00</td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 1 </td>
				      <td align="right"> x</td>
				      <td align="center"><input name="textfield3" type="text" tabindex="9" id="p1" size="5" onblur="calcPickUpAmt(1, this, '1TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="1TD">Php 0.00</td>
				    </tr>
				    <tr>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 100</td>
				      <td align="right"> x </td>
				      <td align="center"><input name="textfield4" type="text" tabindex="4" size="5" id="p100" onblur="calcPickUpAmt(100, this, '100TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="100TD">Php 0.00</td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 0.25 </td>
				      <td align="right"> x </td>
				      <td align="center"><input name="textfield4" type="text" tabindex="10" size="5" id="p0_25" onblur="calcPickUpAmt(0.25, this, '0_25TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="0_25TD">Php 0.00</td>
				    </tr>
				    <tr>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 50 </td>
				      <td align="right">x</td>
				      <td align="center"><input name="textfield42" type="text" tabindex="5" size="5" id="p50" onblur="calcPickUpAmt(50, this, '50TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="50TD">Php 0.00</td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 0.1 </td>
				      <td align="right">x</td>
				      <td align="center"><input name="textfield42" type="text" tabindex="11" size="5" id="p0_1" onblur="calcPickUpAmt(0.1, this, '0_1TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="0_1TD">Php 0.00</td>
				    </tr>
				    <tr>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 20 </td>
				      <td align="right">x</td>
				      <td align="center"><input name="textfield42" type="text" tabindex="6" size="5" id="p20" onblur="calcPickUpAmt(20, this, '20TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="20TD">Php 0.00</td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 0.05 </td>
				      <td align="right">x</td>
				      <td align="center"><input name="textfield42" type="text" tabindex="12" size="5" id="p0_05" onblur="calcPickUpAmt(0.05, this, '0_05TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="0_05TD">Php 0.00</td>
				    </tr>
				    
				    <tr>
				      <td align="right">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="center">&nbsp;</td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="center">&nbsp;</td>
				      <td align="right">&nbsp;</td>
				      <td align="right">Php 0.01 </td>
				      <td align="right">x</td>
				      <td align="center"><input name="textfield42" type="text" tabindex="12" size="5" id="p0_01" onblur="calcPickUpAmt(0.01, this, '0_01TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
				      <td align="center">=</td>
				      <td align="right" id="0_01TD">Php 0.00</td>
				    </tr>
				    
					 <tr>
		      			<td colspan="13" align="left"><hr align="center" /></td>
		    		</tr>			    
				    </table>
				  </div> 
			      </td>
			    </tr>
			    <!-- new cash pickup activity end -->
			    
			 <!-- new check pickup activity start -->
			   <tr>
				    <td colspan="13">
					    <div  id="checkDetailsDiv" style ="display: none;"> 
						    <table width="680"  border="0" align="center" cellpadding="1" cellspacing="1" id="tenders" style="vertical-align:middle;">
							   <tr>
							      <td width="130" align="left">&nbsp;</td>
							      <td width="30" align="right">&nbsp;</td>
							      <td width="30" align="right">&nbsp;</td>
							      <td width="30" align="center">&nbsp;</td>
							      <td width="30"align="right">&nbsp;</td>
							      <td width="30" align="right">&nbsp;</td>
							      <td width="50" align="center">&nbsp;</td>
							      <td align="center"><strong>CHECK</strong></td>
							      <td width="40" align="right">&nbsp;</td>
							      <td width="40" align="right">&nbsp;</td>
							      <td width="40" align="right"><span id="checkQty">0</span></td>
							      <td align="right">&nbsp;</td>
							      <td align="right">Php <span id="checkAmt">0.00</span></td>
							    </tr>
							    <tr>
							      <td colspan="13" align="right"><hr align="center" /></td>
							    </tr>		    
						    </table>
					 </div> 
				    </td>
			     </tr>
			    <!--  new check pickup activity end -->
			    
			  <tr>
			     <td colspan="13"><div align="right">
			          <input name="okButton" type="button" class="smallpagebutton" id="pickupButton" onclick="saveCashorCheckPickup();" value="OK" />&nbsp;&nbsp;&nbsp;
					  <input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="hideDivForPickups();"/>
			     </div></td>
			  </tr>
			    
			</table>
    </td>
  </tr>
	</table>
<!-- Pickup Div END -->

<!-- Pre-Commit Div START -->
<table id="precomitDiv" style="display: none;">
		
		  <tr>
		    <td height="80px" colspan="4" style="background-color: #ffffff;">
		    <table width="680" height="1" border="0" align="center" cellpadding="1" cellspacing="1" id="tenders">
		    <tr>
		      <td colspan="13" align="left"><span class="style3"><strong>TENDER DECLARATION</strong></span></td>
		    </tr>
		    <tr>
		      <td colspan="13" align="left"><hr /></td>
		    </tr>
		    <tr>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Denomination</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Quantity</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Amount</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Denomination</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Quantity</strong></td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>Amount</strong></td>
		    </tr>
		    <tr>
		      <td colspan="6" align="center"><hr align="center" /></td>
		      <td align="center"></td>
		      <td colspan="6" align="center"><hr align="center" /></td>
		    </tr>
		    <tr>
		      <td align="center"><strong>CASH</strong></td>
		      <td align="right">Php 1,000</td>
		      <td align="right"> x </td>
		      <td align="center"><label>
		        <input name="textfield" type="text" tabindex="1" id="p1000" size="5" onblur="calcPickUpAmt(1000, this, '1000TD');"  onkeypress="return  AllowOnlyDigits(event);"/>
		      </label></td>
		      <td align="center">=</td>
		      <td align="right" id="1000TD">Php 0.00 </td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>CASH</strong></td>
		      <td align="right">Php 10 </td>
		      <td align="right"> x </td>
		      <td align="center"><label>
		        <input name="textfield2" type="text" tabindex="7" id="p10" size="5" onblur="calcPickUpAmt(10, this, '10TD');" onkeypress=" return  AllowOnlyDigits(event);"/>
		      </label></td>
		      <td align="center">=</td>
		      <td align="right" id="10TD">Php 0.00 </td>
		    </tr>
		    <tr>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 500</td>
		      <td align="right"> x </td>
		      <td align="center"><input name="textfield2" tabindex="2" id="p500" type="text" size="5" onblur="calcPickUpAmt(500, this, '500TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="500TD">Php 0.00 </td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 5 </td>
		      <td align="right"> x </td>
		      <td align="center"><input name="textfield2" type="text" tabindex="8" id="p5" size="5" onblur="calcPickUpAmt(5, this, '5TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="5TD">Php 0.00 </td>
		    </tr>
		    <tr>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 200 </td>
		      <td align="right"> x</td>
		      <td align="center"><input name="textfield3" type="text" tabindex="3" id="p200" size="5" onblur="calcPickUpAmt(200, this, '200TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="200TD">Php 0.00</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 1 </td>
		      <td align="right"> x</td>
		      <td align="center"><input name="textfield3" type="text" tabindex="9" id="p1" size="5" onblur="calcPickUpAmt(1, this, '1TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="1TD">Php 0.00</td>
		    </tr>
		    <tr>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 100</td>
		      <td align="right"> x </td>
		      <td align="center"><input name="textfield4" type="text" tabindex="4" size="5" id="p100" onblur="calcPickUpAmt(100, this, '100TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="100TD">Php 0.00</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 0.25 </td>
		      <td align="right"> x </td>
		      <td align="center"><input name="textfield4" type="text" tabindex="10" size="5" id="p0_25" onblur="calcPickUpAmt(0.25, this, '0_25TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="0_25TD">Php 0.00</td>
		    </tr>
		    <tr>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 50 </td>
		      <td align="right">x</td>
		      <td align="center"><input name="textfield42" type="text" tabindex="5" size="5" id="p50" onblur="calcPickUpAmt(50, this, '50TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="50TD">Php 0.00</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 0.1 </td>
		      <td align="right">x</td>
		      <td align="center"><input name="textfield42" type="text" tabindex="11" size="5" id="p0_1" onblur="calcPickUpAmt(0.1, this, '0_1TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="0_1TD">Php 0.00</td>
		    </tr>
		    <tr>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 20 </td>
		      <td align="right">x</td>
		      <td align="center"><input name="textfield42" type="text" tabindex="6" size="5" id="p20" onblur="calcPickUpAmt(20, this, '20TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="20TD">Php 0.00</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 0.05 </td>
		      <td align="right">x</td>
		      <td align="center"><input name="textfield42" type="text" tabindex="12" size="5" id="p0_05" onblur="calcPickUpAmt(0.05, this, '0_05TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="0_05TD">Php 0.00</td>
		    </tr>
		    
		    <tr>
		      <td align="right">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php 0.01 </td>
		      <td align="right">x</td>
		      <td align="center"><input name="textfield42" type="text" tabindex="12" size="5" id="p0_01" onblur="calcPickUpAmt(0.01, this, '0_01TD');" onkeypress=" return  AllowOnlyDigits(event);"/></td>
		      <td align="center">=</td>
		      <td align="right" id="0_01TD">Php 0.00</td>
		    </tr>
		    
		    <tr>
		      <td colspan="13" align="left"><hr align="center" /></td>
		    </tr>
		    <tr>
		      <td align="left">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="center">&nbsp;</td>
		      <td align="center"><strong>CHECK</strong></td>
		      <td align="right">&nbsp;</td>
		      <td align="right">&nbsp;</td>
		      <td align="center"><span id="pCheckQty">0</span></td>
		      <td align="right">&nbsp;</td>
		      <td align="right">Php <span id="pCheckAmt">0.00</span></td>
		    </tr>
		    <tr>
		      <td colspan="13" align="right"><hr align="center" /></td>
		    </tr>
		    <tr>
		      <td colspan="13"><div align="right">
		      	<!--<s:if test="#session.userVO.applicationType=='BPS'">
		          	<input name="okButton" type="button" class="smallpagebutton" id="okButton" onclick="savePrecommit();" value="OK" />&nbsp;&nbsp;&nbsp;
				  	<input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="hideDiv();" />
		     	</s:if>
		     	<s:else>
		     		<input name="okButton" type="button" class="smallpagebutton" id="okButton" onclick="" value="OK" />&nbsp;&nbsp;&nbsp;
				  	<input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="hideDiv();" />
		     	</s:else>-->
		     	<input name="okButton" type="button" class="smallpagebutton" id="precommitButton" onclick="savePrecommit();" value="OK" />&nbsp;&nbsp;&nbsp;
				<input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="hideDiv();" />
		      </div></td>
		    </tr>
		  </table>
		    </td>
		  </tr>
	</table>
<!-- Pre-Commit Div END -->

<!-- Void Transaction Div START -->
<table id="voidTrxDiv" style="display: none;">
	<tr>
	<td><strong class="style3 style4">TRANSACTION VOID </strong></td>
	</tr>
	<tr>
	  <td><hr /></td>
	</tr>
	<tr>
	  <td><table width="500" border="0" align="center" cellpadding="2" cellspacing="2" id="tenders" style="vertical-align:middle;">
	    <tr>
	      <td colspan="3" align="left" valign="top" class="style3"><p>&nbsp;</p>          </td>
	    </tr>
	    
	    <tr>
	      <td align="right">Store Code<font color="red">*</font> : </td>
	      <td></td>
	      <td><input name="textfield4" type="text" size="15" maxlength="7" id="trxStoreCode" /></td>
	    </tr>
	    <tr>
	      <td width="260" align="right">Terminal Number<font color="red">*</font> :</td>
	      <td width="10"></td>
	      <td width="367"><label>
	        <input name="textfield" type="text" size="10" maxlength="3" id="trxTerminalId" />
	      </label></td>
	    </tr>
	    <tr>
	      <td align="right">Transaction Number<font color="red">*</font> : </td>
	      <td></td>
	      <td><label>
	        <input type="text" name="textfield2"  maxlength="9" id="trxTransactionId"/>
	      </label></td>
	    </tr>
	    <tr>
	      <td align="right">Reason<font color="red">*</font> :</td>
	      <td></td>
	      <td><label>
	        <s:select list="reasonCodes" listKey="reasonCodeId" listValue="reasonCodeType" id="trxReasonId" theme="simple"/>
	      </label></td>
	    </tr>
	    <tr id="trxStatusTr" style="display: none;">
	      <td align="right">Transaction Status:</td>
	      <td></td>
	      <td><label>
	        	<div id="trxStatusMsg"></div>
	      </label></td>
	    </tr>
	    <tr>
	      <td align="right">&nbsp;</td>
	      <td></td>
	      <td>&nbsp;</td>
	    </tr>
	    <tr>
	      <td colspan="3" align="right">
	      <div align="right" >
	          <input name="okButton" id="trxButton1" type="button" class="smallpagebutton"  onclick="voidTrx();" value="OK" />
	          <input name="okButton" type="button" class="smallpagebutton" style="display: none;" id="trxButton2" onclick="voidTrx();" value="Refresh" />
	          <input name="okButton" type="button" class="smallpagebutton" style="display: none;" id="trxButton3" onclick="saveVoidTrx();" value="Void" />
	          &nbsp;&nbsp;&nbsp;<input name="cancelButton" type="button" class="smallpagebutton"  value="Cancel" onclick="hideDiv();"/>
	      </div>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="3" align="right">&nbsp;</td>
	    </tr>
	  </table></td>
	</tr>
</table>
<!-- Void Transaction Div END -->

<div class="bpsOverlay" id="bpsMask"></div>

<div id="loginDiv" class="bpsPopup">
	<table width="400" height="150" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr style="background-color: white;">
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3" align="center" valign="middle"><strong>Scan / Enter Manager Username and Password </strong></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr style="background-color: white;">
      <td colspan="3" align="center" valign="middle"><hr align="center" /><div id="failureMsg" style="color: red;"></div></td>
    </tr>
    <tr style="background-color: white;">
      <td width="151" align="right" valign="middle">Username:</td>
      <td width="4" align="left" valign="middle"><label></label></td>
      <td width="225" align="left" valign="middle"><s:textfield name="employeeNum" id="mgrNum" theme="simple" value=""/></td>
    </tr>
    <tr style="background-color: white;">
      <td align="right" valign="middle">Password: </td>
      <td align="left" valign="middle"><label></label></td>
      <td align="left" valign="middle"><s:password name="password" id="mgrPassword" theme="simple" value=""/></td>
    </tr>
    <tr style="background-color: white;">
      <td align="right" valign="middle"><input onclick="managerLogin();" name="Submit32" type="button" class="functionbutton" value="Yes" /></td>
      <td align="center" valign="middle">&nbsp;</td>
      <td align="center" valign="middle" ><input onclick="closeMgrLogin();" name="Submit22" type="button" class="functionbutton" value="No" /></td>
    </tr>
    <tr style="background-color: white;">
      <td colspan="3" align="right" valign="middle"></td>
    </tr>
    <tr style="background-color: white;">
      <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
      <td height="10" colspan="3" align="right" valign="middle" background="images/bottomframe.png"></td>
      <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
    </tr>
  </table>
</div>

<!-- For Terminal Reconcilation START-->
<div id="loginDivForTerminalReconcilation" class="bpsPopup">
	
	<table width="400" height="150" border="0" cellpadding="0" cellspacing="0" id="tenders">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr style="background-color: white;">
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3" align="center" valign="middle"><strong>Scan / Enter Username and Password </strong></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr style="background-color: white;">
      <td colspan="3" align="center" valign="middle"><hr align="center" /><div id="failureMsg" style="color: red;"></div></td>
    </tr>
    <tr style="background-color: white;">
      <td width="151" align="right" valign="middle">Username:</td>
      <td width="4" align="left" valign="middle"><label></label></td>
      <td width="225" align="left" valign="middle"><s:textfield name="employeeNum" id="employeeNumber" theme="simple" value=""/></td>
    </tr>
    <tr style="background-color: white;">
      <td align="right" valign="middle">Password: </td>
      <td align="left" valign="middle"><label></label></td>
      <td align="left" valign="middle"><s:password name="password" id="employeePassword" theme="simple" value=""/></td>
    </tr>
    <tr style="background-color: white;">
      <td align="right" valign="middle"><input onclick="terminalReconciliationLogin();" name="Submit321" type="button" class="functionbutton" value="Yes" /></td>
      <td align="center" valign="middle">&nbsp;</td>
      <td align="center" valign="middle" ><input onclick="closeTerminalReconciliationLogin();"name="Submit221" type="button" class="functionbutton" value="No" /></td>
    </tr>
    <tr style="background-color: white;">
      <td colspan="3" align="right" valign="middle"></td>
    </tr>
    <tr style="background-color: white;">
      <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
      <td height="10" colspan="3" align="right" valign="middle" background="images/bottomframe.png"></td>
      <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
    </tr>
  </table>
</div>

 <div id="reconcilation" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"></td>
      <td width="3" align="left" valign="middle"></td>
      <td width="216" align="left" valign="middle" ></td>
    </tr>
    <tr>
      <td colspan="3">
      <table align="center" width="100%">
      		<tr>
      			<td  align="center">
      				<div id="trxRecMsg" style="color: #6666FF;font-size: 18px;" >
			      		Terminal reconciliation in progress...
			      	</div> 	
      			</td>      			
      		</tr>
      </table>
      </td>
      <td></td>
      <td></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle">
       
      </td>
	</tr>
    <tr>
      <td align="right" valign="middle">
      	
      </td>
      <td align="center" valign="middle"></td>
      <td align="center" valign="middle" ></td>
    </tr>
    <tr>
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
<!-- For Terminal Reconcilation END-->
<div id="smacDiv" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"><strong>Swipe Card Details</strong>:</td>
      <td width="3" align="left" valign="middle"><label></label></td>
      <td width="216" align="left" valign="middle" ><input type="text" name="smacNum" maxlength="20" style="width:200px"  id="smacNum" onkeypress="return  AllowOnlyDigits(event);" readonly/><!-- readonly --></td>
    </tr>
    <tr style="display:none;" id="errorSmac">
      <td align="right" valign="middle"><label></label></td>
      <td align="left" valign="middle"><label></label></td>
      <td align="left" valign="middle"><label id="smacNum1" style="color: red;"></label></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle"><hr align="center" /></td>
	</tr>
    <tr>
      <td align="right" valign="middle"><input onclick="saveSmacInfo();" id="Submit32" name="Submit32" type="button" class="functionbutton" value="OK" /></td>
      <td align="center" valign="middle">&nbsp;</td>
      <td align="center" valign="middle" ><input onclick="closeSmacDiv();" id="Submit22" name="Submit22" type="button" class="functionbutton" value="Cancel" border="none"/></td>
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
<div id="resumeTrx" style="display: none;">
	<table width="680" height="300" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td><strong class="style3 style4">TRANSACTION RESUME </strong></td>
	</tr>
	<tr>
	  <td><hr /></td>
	</tr>
	<tr>
	  <td><table width="500" border="0" align="center" cellpadding="2" cellspacing="2" id="tenders" style="vertical-align:middle;">
	    <tr>
	      <td colspan="3" align="left" valign="top" class="style3"><p>&nbsp;</p>          </td>
	    </tr>
	    <tr>
	      <td width="260" align="right">Terminal Number:</td>
	      <td width="10"></td>
	      <td width="367"><label>
	        <input name="textfield" type="text" size="10" maxlength="3" id="terminalNum" />
	      </label></td>
	    </tr>
	    <tr>
	      <td align="right">Transaction Number: </td>
	      <td></td>
	      <td><label>
	        <input type="text" name="textfield2" id="trxNumRes" maxlength="9"/>
	      </label></td>
	    </tr>
	    <tr style="display:none;">
	      <td align="right">Reason:</td>
	      <td></td>
	      <td><label>
	        <s:select list="reasonCodes" listKey="reasonCodeId" listValue="reasonCodeType" id="reasonId" theme="simple"/>
	      </label></td>
	    </tr>
	    <tr>
	      <td align="right">&nbsp;</td>
	      <td></td>
	      <td>&nbsp;</td>
	    </tr>
	    <tr>
	      <td colspan="3" align="right"><div align="right">
	          <input name="okButton" type="button" class="smallpagebutton" id="okButton" onclick="getTrxData();" value="OK" />&nbsp;&nbsp;&nbsp;
			  <input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="closeResumeDiv();" />
	      </div></td>
	    </tr>
	    <tr>
	      <td colspan="3" align="right">&nbsp;</td>
	    </tr>
	  </table></td>
	</tr>
	</table>
</div>

<div id="suspendDiv" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"></td>
      <td width="3" align="left" valign="middle"></td>
      <td width="216" align="left" valign="middle" ></td>
    </tr>
    <tr>
      <td colspan="3">
      <table align="center" width="100%">
      		<tr>
      			<td  align="center">
      				
      				<div id="suspendMsgDiv" style="color: #6666FF;font-size: 18px;" >
			      		Suspend transaction in progress...
			      	</div>
      			</td>
      		</tr>
      </table>
      </td>
      <td></td>
      <td></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle">
       <input type="button" id="closeSuspendButton" class="smallpagebutton" value="Close" name="Close" onclick="closeSuspendDiv();" style="display: none;" />
      </td>
	</tr>
    <tr>
      <td align="right" valign="middle">
      	
      </td>
      <td align="center" valign="middle"></td>
      <td align="center" valign="middle" ></td>
    </tr>
    <tr>
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
  <div id="saveTrxDiv" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"></td>
      <td width="3" align="left" valign="middle"></td>
      <td width="216" align="left" valign="middle" ></td>
    </tr>
    <tr>
      <td colspan="3">
      <table align="center" width="100%">
      		<tr>
      			<td  align="center">
      				<div id="trxMsgDiv" style="color: #6666FF;font-size: 18px;" >
			      		Saving transaction in progress...
			      	</div>
			      	<div id="trxMsgDiv_success" style="color: green;font-size: 18px;display: none;">
			      		Saving transaction in progress...
			      	</div>	
			      	<div id="trxMsgDiv_error" style="color: red;font-size: 18px;display: none;">
			      		Saving transaction in progress...
			      	</div>
			      	
      			</td>
      		</tr>
      </table>
      </td>
      <td></td>
      <td></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle">
       <input type="button" id="closeSaveTrxErrorButton" class="smallpagebutton" value="Close" name="Close" onclick="closeOnlineErrorDiv();" style="display: none;" />
      </td>
	</tr>
    <tr>
      <td align="right" valign="middle">
      	
      </td>
      <td align="center" valign="middle"></td>

      <td align="center" valign="middle" >
      	<input type="button" id="closeTrxDiv" class="smallpagebutton" value="Close" name="Close" onclick="closeTrx();" style="display: none;" />
      	<input type="button" id="closeTrxDiv1" class="smallpagebutton" value="Close" name="Close" onclick="closeTrxxDiv();" style="display: none;" />
      	<input type="button" id="closeItemDiv" class="smallpagebutton" value="Close" name="Close" onclick="closeItemDiv();" style="display: none;" />
      </td>
    </tr>
    <tr>
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

<div id="confirmCashDiv" class="bpsPopup">
	<table width="400" height="160" border="0" cellpadding="0" cellspacing="0" id="tenders" >
	  <tr>
	    <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
	    <td height="10" colspan="2" align="center" valign="middle" background="images/topframe.png"></td>
	    <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td width="10" rowspan="4" align="center" valign="middle" background="images/leftframe.png"></td>
	    <td colspan="2" align="center" valign="middle"><p><strong>Confirm Cash Loan Amount </strong><hr align="center" /></p></td>
	    <td style="border-bottom:medium; border-bottom-style:solid; border-bottom-color:#666666; background-repeat:repeat-y;" width="10" rowspan="4" align="center" valign="middle" background="images/rightframe.png" ></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td colspan="2" align="center" valign="middle"><p><strong>Sign-on Float Php <s:property value="#session.userVO.initialFundAmt"/></strong></p></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td height="8" colspan="2" align="center" valign="middle"><hr align="center" /></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;" id="buttonDivSCC">
	    <td align="center" valign="middle"><input onclick="saveConfirmCash();"  name="Submit3" type="button" class="functionbutton" value="Yes" /></td>
	    <td align="center" valign="middle"><input onclick="logout();"name="Submit2" type="button" class="functionbutton" value="No" /></td>
	  </tr>
	  <tr>
	    <td colspan="2" align="right" valign="middle"></td>
	    </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
	    <td height="10" colspan="2" align="right" valign="middle" background="images/bottomframe.png"></td>
	    <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
	  </tr>
	</table>
</div>
<div id="voidProcessDiv" style="display: none;"></div>

<div id="resetPasswordDiv" class="bpsPopup">
	<table width="400" height="160" border="0" cellpadding="0" cellspacing="0" id="tenders" >
	  <tr>
	    <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
	    <td height="10" colspan="2" align="center" valign="middle" background="images/topframe.png"></td>
	    <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td width="10" rowspan="4" align="center" valign="middle" background="images/leftframe.png"></td>
	    <td colspan="2" align="center" valign="middle"><p><strong>New Password :</strong>  <s:password name="newPassword" id="newPwd" theme="simple"></s:password></p></td>
	    <td style="border-bottom:medium; border-bottom-style:solid; border-bottom-color:#666666; background-repeat:repeat-y;" width="10" rowspan="4" align="center" valign="middle" background="images/rightframe.png" ></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td colspan="2" align="center" valign="middle">
	    	<p><strong>Confirm Password : <s:password name="confirmPassword" id="confirmPwd" theme="simple"></s:password></strong></p>
	    	<p id="loginErrorMsg" style="display: none;"></p>
	    </td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td height="8" colspan="2" align="center" valign="middle"><hr align="center" /></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td align="center" valign="middle"><input onclick="validateLogin();" name="Submit3" type="button" class="functionbutton" value="Ok" /></td>
	    <td align="center" valign="middle" ><input onclick="logout();"name="Submit2" type="button" class="functionbutton" value="Cancel" /></td>
	  </tr>
	  <tr>
	    <td colspan="2" align="right" valign="middle"></td>
	    </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
	    <td height="10" colspan="2" align="right" valign="middle" background="images/bottomframe.png"></td>
	    <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
	  </tr>
	</table>
</div>
<div id="barcodeDiv" class="bpsPopup">
	<table width="400" height="160" border="0" cellpadding="0" cellspacing="0" id="tenders" >
	  <tr>
	    <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
	    <td height="10" colspan="2" align="center" valign="middle" background="images/topframe.png"></td>
	    <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td width="10" rowspan="4" align="center" valign="middle" background="images/leftframe.png"></td>
	    <td colspan="2" align="center" valign="middle"><p><strong>Please scan barcode...</strong> </p></td>
	    <td style="border-bottom:medium; border-bottom-color:#666666; background-repeat:repeat-y;" width="10" rowspan="4" align="center" valign="middle" background="images/rightframe.png" ></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td colspan="2" align="center" valign="middle">
	    	<img src="images/loader.gif" alt="" style="" width="20px" height="20px"/>
	    </td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td colspan="2" align="center" valign="middle"></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td align="center" valign="middle"></td>
	    <td align="center" valign="middle" ></td>
	  </tr>
	  <tr>
	    <td colspan="2" align="right" valign="middle"></td>
	  </tr>
	  <tr style="background-color: #FFFFFF;">
	    <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
	    <td height="10" colspan="2" align="right" valign="middle" background="images/bottomframe.png"></td>
	    <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
	  </tr>
	</table>
</div>
<div id="resumeTrxDiv" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"></td>
      <td width="3" align="left" valign="middle"></td>
      <td width="216" align="left" valign="middle" ></td>
    </tr>
    <tr>
      <td colspan="3">
      <table align="center" width="100%">
      		<tr>
      			<td  align="center">
      				
      				<div id="suspendMsgDiv" style="color: #6666FF;font-size: 18px;" >
			      		Resume transaction in progress...
			      	</div>
      			</td>
      		</tr>
      </table>
      </td>
      <td></td>
      <td></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle">
       <input type="button" id="closeSuspendButton" class="smallpagebutton" value="Close" name="Close" onclick="closeSuspendDiv();" style="display: none;" />
      </td>
	</tr>
    <tr>
      <td align="right" valign="middle">
      	
      </td>
      <td align="center" valign="middle"></td>
      <td align="center" valign="middle" ></td>
    </tr>
    <tr>
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
  <div id="billerBarcode" class="bpsPopup">
		<table width="400" height="160" border="0" cellpadding="0" cellspacing="0"  >
		  <tr>
		    <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
		    <td height="10" colspan="2" align="center" valign="middle" background="images/topframe.png"></td>
		    <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
		  </tr>
		  <tr style="background-color: #FFFFFF;">
		    <td width="10" rowspan="4" align="center" valign="middle" background="images/leftframe.png"></td>
		    <td colspan="2" align="center" valign="middle"><p><strong>Please scan biller barcode <span id="barcodeCount"></span>...</strong> 
		       </p><input type="hidden" id="totalNumOfBarcodes"/>
		       			    	
		       </td>
		    <td style="border-bottom:medium; border-bottom-style:solid; border-bottom-color:#666666; background-repeat:repeat-y;" width="10" rowspan="4" align="center" valign="middle" background="images/rightframe.png" ></td>
		  </tr>
		  <tr style="background-color: #FFFFFF;">
		    <td colspan="2" align="center" valigns="middle">
					<input type="text" id="barCodeStr" onkeypress="if(event.keyCode==13){saveBillerBarcode(this);}" />
		    </td>
		  </tr>
		  <tr style="background-color: #FFFFFF;">
		    <td height="8" colspan="2" align="center" valign="middle"></td>
		  </tr>
		  <tr style="background-color: #FFFFFF;">
		    <td align="center" valign="middle">
		    </td>
		    <td align="center" valign="middle" ></td>
		  </tr>
		  <tr>
		    <td colspan="2" align="right" valign="middle"></td>
		    </tr>
		  <tr style="background-color: #FFFFFF;">
		    <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
		    <td height="10" colspan="2" align="right" valign="middle" background="images/bottomframe.png"></td>
		    <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
		  </tr>
		</table>
	</div>
	
<div id="suspendTrxDiv" style="display: none;">
	<table width="680" height="300" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td><strong class="style3 style4">SUSPEND TRANSACTION</strong></td>
	</tr>
	<tr>
	  <td><hr /></td>
	</tr>
	<tr>
	  <td><table width="500" border="0" align="center" cellpadding="2" cellspacing="2" id="tenders" style="vertical-align:middle;">
	    <tr>
	      <td colspan="3" align="left" valign="top" class="style3"><p>&nbsp;</p>          </td>
	    </tr>
	    <tr>
	      <td align="right">Reason:</td>
	      <td></td>
	      <td><label>
	        <s:select list="reasonCodes" listKey="reasonCodeId" listValue="reasonCodeType" id="suspendResId" theme="simple"/>
	      </label></td>
	    </tr>
	    <tr>
	      <td align="right">&nbsp;</td>
	      <td></td>
	      <td>&nbsp;</td>
	    </tr>
	    <tr>
	      <td colspan="3" align="right"><div align="right">
	          <input name="okButton" type="button" class="smallpagebutton" id="suspendButton" onclick="suspend();" value="OK" />&nbsp;&nbsp;&nbsp;
			  <input name="cancelButton" type="button" class="smallpagebutton" id="okButton" value="Cancel" onclick="closeSuspendDiv();" />
	      </div></td>
	    </tr>
	    <tr>
	      <td colspan="3" align="right">&nbsp;</td>
	    </tr>
	  </table></td>
	</tr>
	</table>
</div>
<div id="reprintLastTrx" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"></td>
      <td width="3" align="left" valign="middle"></td>
      <td width="216" align="left" valign="middle" ></td>
    </tr>
    <tr>
      <td colspan="3">
      <table align="center" width="100%">
      		<tr>
      			<td  align="center">
      				
      				<div id="reprintMsgDiv" style="color: #6666FF;font-size: 18px;" >
			      		Reprinting last valid transaction reciept...
			      	</div>
      			</td>
      		</tr>
      </table>
      </td>
      <td></td>
      <td></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle">
       <input type="button" id="closeReptintButton" style="display: none;" class="smallpagebutton" value="Close" name="Close" onclick="closeReprintDiv();" style="display: none;" />
      </td>
	</tr>
    <tr>
      <td align="right" valign="middle">
      	
      </td>
      <td align="center" valign="middle"></td>
      <td align="center" valign="middle" ></td>
    </tr>
    <tr>
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
  
  
<!-- Card Offline Div - START -->
<div id="cardOfflineDiv" class="bpsPopup">
<table width="400" height="150" border="0" cellpadding="0" cellspacing="0" id="cardOffline" style="background-color: white;">
<input type="hidden" id="cardProcessMode" />
<input type="hidden" id="paymentId" />
<input type="hidden" id="cardAmount" />
<input type="hidden" id="cardAmount" />
<input type="hidden" id="tenderRefNum" />
<input type="hidden" id="apprCode" />
  <tr>
    <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
    <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
    <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
  </tr>
  <tr class="offlineClass">
    <td width="10" rowspan="4" align="center" valign="middle" background="images/leftframe.png"></td>
    <td align="right" valign="middle"><p><strong>Swipe/Enter Card Number:</strong></p>      </td>
    <td width="10" align="left" valign="middle">&nbsp;</td>
    <td align="left" valign="middle"><strong>
      <input id="cardNo" name="textfield32" type="text" size="16" maxlength="16" style="width:150px" onkeypress="return  AllowOnlyDigits(event);"/>
    </strong></td>
    <td width="10" rowspan="4" align="center" valign="middle" background="images/rightframe.png"></td>
  </tr>
  <tr class="offlineClass">
    <td align="right" valign="middle"><strong>Enter Approval Code: 
        <label></label>
    </strong></td>
    <td width="10" align="left" valign="middle">&nbsp;</td>
    <td align="left" valign="middle"><strong>
      <input id="approvalCode" name="textfield3" type="text" size="6" maxlength="6" style="width:80px" onkeypress="return  AllowOnlyDigits(event);"/>
    </strong></td>
  </tr>
  <tr class="onlineClass" style="display: none;">
    <td width="10" align="center" valign="middle" background="images/leftframe.png"></td>
    <td align="right" valign="middle"><p align="center"><strong id="onlineMsg">Please swipe Credit Card</strong></p></td>
    <td width="10" align="center" valign="middle" background="images/rightframe.png"></td>
  </tr>
  <tr class="errorClass" style="display: none;">
    <td width="10" align="center" valign="middle" background="images/leftframe.png"></td>
    <td align="right" valign="middle" colspan="3"><p align="center"><strong id="errorMsg">Payment Declined.<br>Transaction cannot be completed</strong></p></td>
    <td width="10" align="center" valign="middle" background="images/rightframe.png"></td>
  </tr>
  <tr class="offlineClass">
    <td colspan="3" align="right" valign="middle"><hr align="center" /></td>
  </tr>
  <tr class="offlineClass">
    <td colspan="3" align="center" valign="middle"><div align="right">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center"><input name="Submit23" type="button" class="smallpagebutton" value="OK" onclick="setCardOfflineDetails();"/></td>
          <td align="center"><input name="Submit232" type="button" class="smallpagebutton" value="Cancel" onclick="closeCardOfflineDiv();"/></td>
        </tr>
      </table>
      </div></td>
    </tr>
    <tr class="errorClass" style="display: none;">
    	 <td width="10" align="center" valign="middle" background="images/leftframe.png"></td>
	    <td colspan="3" align="center" valign="middle"><div align="right">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td align="center"><input name="Submit23" type="button" class="smallpagebutton" value="OK" onclick="closeTrx();"/></td>
	        </tr>
	      </table>
	      </div>
	    </td>
	    <td width="10" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
  <tr>
    <td width="10" height="10" align="right" valign="middle" background="images/bottomleftframe.png"></td>
    <td height="10" colspan="3" align="right" valign="middle" background="images/bottomframe.png"></td>
    <td width="10" height="10" align="right" valign="middle" background="images/bottomrightframe.png"></td>
  </tr>
</table>
</div>
<!-- Card Offline Div - END -->

<!-- Manual Discount  Div - START -->
<table width="680" height="400" border="0" align="center" cellpadding="0" cellspacing="0" id="manualDiscountDiv" style="display: none;">
	<tr>
		<td><strong class="style3 style4">MANUAL DISCOUNT </strong></td>
	</tr>
	<tr>
		<td><hr /></td>
	</tr>
	<tr>
		<td><table width="500" border="0" align="center" cellpadding="2"
				cellspacing="2" id="tenders" style="vertical-align: middle;">
				<tr>
					<td colspan="3" align="left" valign="top" class="style3"><p>&nbsp;</p>
					</td>
				</tr>

				<tr>
					<td align="right">Discount Type:
						<input id="discountType" type="hidden" value="flat"/>
					</td>
					<td></td>
					<td>
						<input id="discountTypeRadio" name="radiobutton" type="radio" value="flat" checked="checked" onclick="setDiscountType(this);"/>
						Amount
					</td>
				</tr>
				<tr>
					<td align="right">&nbsp;</td>
					<td></td>
					<td>
						<input id="discountTypeRadio" name="radiobutton" type="radio" value="percent" onclick="setDiscountType(this);"/> 
						Percentage
					</td>
				</tr>
				<tr>
					<td width="260" align="right">Enter Discount:</td>
					<td width="10"></td>
					<td width="367"><label> <input name="textfield" id="discountValue" type="text" size="50" maxlength="6" 
					onkeypress='return numbersOnlyWithf12(event);' onchange="currencyFormatSM(this);"/>
					</label></td>
				</tr>
				<tr>
					<td align="right">Reference Number:</td>
					<td></td>
					<td><label> <input name="textfield2" type="text" id="discountRefNumber"
							size="50" maxlength="13" onkeypress='return numbersOnlyWithf12(event);'/>
					</label></td>
				</tr>

				<tr>
					<td colspan="3" align="right">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3" align="right"><div align="right">
							<input name="okButton" type="button" class="smallpagebutton"
								id="okButton" onclick="applyManualDiscount();" value="OK" />&nbsp;&nbsp;&nbsp;
							<input name="cancelButton" type="button" class="smallpagebutton"
								id="okButton" value="Cancel" onclick="hideDivForPickups();"/>
						</div></td>
				</tr>
				<tr>
					<td colspan="3" align="right">&nbsp;</td>
				</tr>
			</table></td>
	</tr>
</table>
<!-- Manual Discount  Div - END -->

<!-- Free Dept Item Div - START -->

  <div id="freeDeptItemDiv" class="bpsPopup">
	<table width="425" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="161" align="right" valign="middle"></td>
      <td width="3" align="left" valign="middle"></td>
      <td width="216" align="left" valign="middle" ></td>
    </tr>
    <tr>
      <td colspan="3">
      <table align="center" width="100%">
      		<tr>
      			<td  align="center">
      				<div id="freeDeptItemMsgDiv" style="color: #6666FF;font-size: 18px;" >
      					There is no item with entered/scanned barcode/stock code.<br>
      					Do you want to treat this as free dept item?
			      	</div>
      			</td>
      		</tr>
      </table>
      </td>
      <td></td>
      <td></td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle">
       
      </td>
	</tr>
    <tr>
      <td align="right" valign="middle">
      	<input type="button" id="renderFreeDeptItemDiv" class="smallpagebutton" value="Ok" name="Ok" onclick="renderFreeDeptItem();" />
      </td>
      <td align="center" valign="middle">
      	
      </td>
      <td align="center" valign="middle" >
      	<input type="button" id="closeFreeDeptItemDiv" class="smallpagebutton" value="Close" name="Close" onclick="closeFreeDeptItemDiv();"/>
      </td>
    </tr>
    <tr>
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


<!-- Free Dept Item Div - END -->

<!-- Promotion Coupon Scan Div - START -->
<div id="promoCouponDiv" class="bpsPopup">
	<table width="400" height="143" border="0" cellpadding="0" cellspacing="0" id="tenders" style="background-color: white;">
    <tr>
      <td width="10" height="10" align="center" valign="middle" background="images/topleftframe.png"></td>
      <td height="10" colspan="3" align="center" valign="middle" background="images/topframe.png"></td>
      <td width="10" height="10" align="center" valign="middle" background="images/toprightframe.png"></td>
    </tr>
    <tr>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/leftframe.png"></td>
      <td colspan="3"></td>
      <td width="10" rowspan="6" align="center" valign="middle" background="images/rightframe.png"></td>
    </tr>
    <tr>
      <td height="15" colspan="3" align="center" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td width="130" align="left" valign="middle"><strong>Scan Coupon Code</strong>:</td>
      <td width="3" align="left" valign="middle"><label></label></td>
      <td width="216" align="left" valign="middle" >
      	<input type="text" name="couponCode" maxlength="20" style="width:190px"  id="couponCode" onkeypress="return  AllowOnlyDigits(event);" /><!-- readonly -->
      	<a onclick="clearCouponCode();" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'">Clear</a>
      	</td>
    </tr>
	<tr>
      <td height="8" colspan="3" align="center" valign="middle"><hr align="center" /></td>
	</tr>
    <tr>
      <td align="right" valign="middle"><input onclick="saveCouponInfo();" id="Submit32" name="Submit32" type="button" class="functionbutton" value="OK" /></td>
      <td align="center" valign="middle">&nbsp;</td>
      <td align="center" valign="middle" ><input onclick="closeCouponDiv();" id="Submit22" name="Submit22" type="button" class="functionbutton" value="Cancel" border="none"/></td>
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
<!-- Promotion Coupon Scan Div - END -->