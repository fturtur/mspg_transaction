<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ taglib prefix="s" uri="/struts-tags" %>
<script src="javascript/main.js"></script>
<script src="javascript/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
var gChIndex = 0;
var gCaIndex = 0;
var gOtIndex = 0;

	$(document).ready(function() {	
	/*6152 START*/
		isTenderPageOpen = true;
		if(removeTableTriggered == true){
			validateValues();
			removeTableTriggered=false;
		}
		$(document).bind('keydown','ctrl+A',function(e){
	/*6152 END*/	
			if(e.ctrlKey && e.which==65){
		
				if (e.preventDefault){ // Firefox
		            e.preventDefault();
		            e.stopPropagation();
		        }
		        // Internet Explorer
		        else if (e.keyCode){
		            e.keyCode = 0;
		            e.returnValue = false;
		            e.cancelBubble = true;
		        }
				alert('ctrl+A is clicked');
			}	
		});
	});
</script>
<s:head theme="simple" />
</head>

<body>

<div id = "tenderfieldsDiv">
	<table align="center" width="650" height="300" border="0"
		cellpadding="1" cellspacing="1" id="tenders">
		<tr>
		    <td colspan="2">&nbsp;</td>
		    <td id="tenders"><div align="center"><strong>AMOUNT</strong></div></td>
		    <td colspan="3" id="tenders"><div align="center"><strong>DETAILS</strong></div></td>
  		</tr>		
		<tr>
			<td height="10" colspan="10"><hr align="center" /></td>
		</tr>
		<% int i=0,j=0,k=0,count=0;%>	
		<tr>
			<td>
				<input type="hidden" name="mixedTenderAllowed"	id="mixedTenderAllowed" value="<s:property value='lineItemVO.tenderVO.mixedTrxAllowed'/>">	
			
 				<input type="hidden" name="allCombinations"	id="allCombinations" value="<s:property value='lineItemVO.tenderVO.allCombinations'/>">	
				<input type="hidden" name="exactPayment" id="exactPayment" value="<s:property value='lineItemVO.billerVO.exactPayment'/>">	
				<input type="hidden" name="overPayment" id="overPayment" value="<s:property value='lineItemVO.billerVO.overPayment'/>">	
				<input type="hidden" name="underPayment" id="underPayment" value="<s:property value='lineItemVO.billerVO.underPayment'/>">	
				<input type="hidden" name="totaldue" id="totaldue" value="<s:property value='lineItemVO.totaldue'/>">				
			</td>
		</tr>
			
		<s:iterator value="lineItemVO.tenderFields" var="tenders" status="fieldStatus">
						
				<s:if test="'cash'.equalsIgnoreCase(#tenders.paymentMode) ">
				<input type="hidden" name="cashTenderId" id="cashTenderId" value="<s:property value='tenderId'/>">
				<input type="hidden" name="cashCombinationId" id="cashCombinationId" value="<s:property value='combinationId'/>"/>
				 <tr class="cashClass" id="cashId">
				    <td width="31" align="center"></td>
				    <td width="72"><label>
				      <input name="tender" class="cashCss" type="checkbox" onclick="enableDisable(0,'cash');" value="Cash" id="cashcheck" checked="checked"/>
				    CASH</label></td>
				    <td width="120" align="center">
				      <label>Php<input name="cashtext" type="text" id="cashtext" disabled="true" style="width:73px;" onblur="currencyFormatSM(this);" value="<s:property value='paidAmount'/>" />
				    </label></td>
				    <td width="23" align="center"><label></label></td>
				    <td colspan="2" align="center">&nbsp;</td>
				  </tr>				  
				 <tr>
    				<td height="10" colspan="8"><hr align="center" /></td>
  				</tr>
				  <script type="text/javascript">				 
				  	if($('#cashcheck')){
				  		if($('#cashtext').val()!=''){
				  			$('#cashcheck').attr('checked','checked');
				  			$('#cashtext').attr('disabled',false);
				  		}else
				  			$('#cashcheck').attr('checked',false);
				  	}
				  </script>
				</s:if>

				<s:elseif test="'check'.equalsIgnoreCase(#tenders.paymentMode)">
				<input type="hidden" name="checkTenderId" id="checkTenderId" value="<s:property value='tenderId'/>">
				<input type="hidden" name="checkCombinationId" id="checkCombinationId" value="<s:property value='combinationId'/>"/>
				<tr class="chequeClass" id="chequeRow<%=i%>">
				    <td align="center"></td>
				    <td><label id="tenders">
				      <input name="tender" class="chequeCss" type="checkbox" value="Check" onclick="enableDisable('<%=i%>','cheque');" id="chequecheck<%=i%>"/>
				    CHECK</label></td>
				    <td align="center">
				    <label>Php<input name="cheque" type="text" id="chequeAmount<%=i%>" disabled="true"  style="width:73px;" onblur="currencyFormatSM(this);" onkeypress="return numbersOnly(event);" onchange="deductCashAmt(this)" value="<s:property value='paidAmount'/>"/>
				    </label></td>
				    <td align="right"><img id="chequeImg<%=i %>" onmouseover="setCursorByID('addcheck');" src="images/add.png" width="16" height="16" onclick="addChequeRow();" />&nbsp;&nbsp;&nbsp;</td>
				    <td width="176" align="left">CHECK #<input name="checkNumber" type="text" disabled="true" id="chequeRef<%=i%>"   onkeypress="return alphaNumericOnly(event);" value="<s:property value='checkNum'/>" /></td>
				    <td width="159" align="left"><div id="bankListId<%=i%>">Bank: 
				      <s:select list="#tenders.bankList" headerValue="--Select---" headerKey="0" listKey="bankId" listValue="bankName" name="bankId" theme="simple" cssClass="selectTemp" >
				     </s:select>
				     
				     </div>
				    </td>
 				 </tr> 				 
				 <tr>
    				<td height="10" colspan="8"><hr align="center" /></td>
  				</tr>
 				 <script type="text/javascript">
				  	if($('#chequecheck'+<%=i%>)){
				  		if($('#chequeAmount'+<%=i%>).val()!='' && $('#chequeRef'+<%=i%>).val()!=''){
				  			$('#chequeAmount'+<%=i%>).attr('disabled',false);
				  			$('#chequeRef'+<%=i%>).attr('disabled',false);
				  			$('#chequecheck'+<%=i%>).attr('checked','checked');
				  		}	
				  	}
				  </script>
 				 <%i++; %> 				
				</s:elseif>

				<s:elseif test="'card'.equalsIgnoreCase(#tenders.paymentMode)">
				<input type="hidden" name="cardTenderId" id="cardTenderId" value="<s:property value='tenderId'/>">
				<input type="hidden" name="cardCombinationId" id="cardCombinationId" value="<s:property value='combinationId'/>"/>
				 <tr class="cardClass" id="cardRow<%=j%>">
				    <td align="center"></td>
				    <td><label id="tenders">
				      <input name="tender" class="cardCss" type="checkbox" value="Card" onclick="enableDisable('<%=j%>','card');"  id="cardcheck<%=j%>"/>
				    CARD</label></td>
				    <td align="center">
				    <label>Php<input name="card" type="text" id="cardAmount<%=j %>" disabled="true" style="width:73px;" onblur="currencyFormatSM(this);" onkeypress="return numbersOnly(event);" onchange="deductCashAmt(this);" value="<s:property value='paidAmount'/>"/>
				    </label></td>
				    <td align="right"><img id="cardImg<%=j%>" onmouseover="setCursorByID('addcard');" src="images/add.png" width="16" height="16" onclick="addCardRow()"/>&nbsp;&nbsp;&nbsp;<label></label></td>
				    <td colspan="2" align="left">
				    
				    	<s:if test="cardModeValue=='online'">
				    		<label><input name="rdoOnlineOffline" type="radio" value="online" checked="checked" id="card<%=j%>" />
								Online</label>
							</s:if>
						<s:else>
							<label><input name="rdoOnlineOffline" type="radio" value="online"  id="card<%=j%>"/>
								Online</label>
						</s:else>
				      &nbsp;&nbsp;&nbsp;
				      <s:if test="cardModeValue=='offline'">
				      	<label><input name="rdoOnlineOffline" type="radio" value="offline" checked="checked" onclick="smacInfo();"  id="card<%=j%>"/>
					  	Offline</label>
					  </s:if>
					  <s:else>
					  	<label><input name="rdoOnlineOffline" type="radio" value=offline id="card<%=j%>"/>
					  	Offline</label>
					  </s:else>
					</td>
  				</tr>  				
				 <tr>
    				<td height="10" colspan="8"><hr align="center" /></td>
  				</tr>
  				<script type="text/javascript">
				  	if($('#cardcheck'+<%=j%>)){
				  		if($('#cardAmount'+<%=j%>).val()!=''){
				  			$('#cardAmount'+<%=j%>).attr('disabled',false);				  			
				  			$('#cardcheck'+<%=j%>).attr('checked','checked');
				  		}	
				  	}
				  </script>
  				<%j++; %>  				
				</s:elseif>
				<s:elseif test="'credit'.equalsIgnoreCase(#tenders.paymentMode)">
				<input type="hidden" name="cardTenderId" id="cardTenderId" value="<s:property value='tenderId'/>">
				<input type="hidden" name="cardCombinationId" id="cardCombinationId" value="<s:property value='combinationId'/>"/>
				 <tr class="cardClass" id="cardRow<%=j%>">
				    <td align="center"></td>
				    <td><label id="tenders">
				      <input name="tender" class="creditCss" type="checkbox" value="Card" onclick="enableDisable('<%=j%>','card');"  id="cardcheck<%=j%>"/>
				    CARD</label></td>
				    <td align="center">
				    <label>Php<input name="card" type="text" id="cardAmount<%=j %>" disabled="true" style="width:73px;" onblur="currencyFormatSM(this);" onkeypress="return numbersOnly(event);" onchange="deductCashAmt(this);" value="<s:property value='paidAmount'/>"/>
				    </label></td>
				    <td align="right"><img id="cardImg<%=j%>" onmouseover="setCursorByID('addcard');" src="images/add.png" width="16" height="16" onclick="addCardRow()"/>&nbsp;&nbsp;&nbsp;<label></label></td>
				    <td colspan="2" align="left">
				    
				    	<s:if test="cardModeValue=='online'">
				    		<label><input name="rdoOnlineOffline" type="radio" value="online" checked="checked" id="card<%=j%>" />
								Online</label>
							</s:if>
						<s:else>
							<label><input name="rdoOnlineOffline" type="radio" value="online"  id="card<%=j%>"/>
								Online</label>
						</s:else>
				      &nbsp;&nbsp;&nbsp;
				      <s:if test="cardModeValue=='offline'">
				      	<label><input name="rdoOnlineOffline" type="radio" value="offline" checked="checked"  id="card<%=j%>"/>
					  	Offline</label>
					  </s:if>
					  <s:else>
					  	<label><input name="rdoOnlineOffline" type="radio" value=offline id="card<%=j%>"/>
					  	Offline</label>
					  </s:else>
					</td>
  				</tr>  				
				 <tr>
    				<td height="10" colspan="8"><hr align="center" /></td>
  				</tr>
  				<script type="text/javascript">
				  	if($('#cardcheck'+<%=j%>)){
				  		if($('#cardAmount'+<%=j%>).val()!=''){
				  			$('#cardAmount'+<%=j%>).attr('disabled',false);				  			
				  			$('#cardcheck'+<%=j%>).attr('checked','checked');
				  		}	
				  	}
				  </script>
  				<%j++; %>  				
				</s:elseif>
				<s:elseif  test="'other'.equalsIgnoreCase(#tenders.paymentMode)">				
				<input type="hidden" name="otherTenderId" id="otherTenderId" value="<s:property value='tenderId'/>">
				<input type="hidden" name="otherCombinationId" id="otherCombinationId" value="<s:property value='combinationId'/>"/>
				 <tr class="otherClass" id="otherRow<%=k%>">
				    <td align="center"></td>
				    <td><label id="tenders">
				      <input name="tender" class="othersCss" type="checkbox" value="Other" onclick="enableDisable('<%=k%>','other');" id="othercheck<%=k%>"/>
				    OTHER</label></td>
				    <td align="center">
				       <label>Php<input name="other" type="text" id="otherAmount<%=k%>" disabled="true" style="width:73px;" onblur="currencyFormatSM(this);" onkeypress="return numbersOnly(event);" onchange="deductCashAmt(this);" value="<s:property value='paidAmount'/>"/>
				    </label></td>
				    <td align="right"><img id="otherImg<%=k%>" onmouseover="setCursorByID('addother');" src="images/add.png" width="16" height="16" onclick="addOtherRow();"/>&nbsp;&nbsp;&nbsp;</td>
				    <td colspan="2" align="left">Reference  #
				    <input name="othersref" type="text" id="otherRef<%=k%>" onkeypress="return alphaNumericOnly(event);" value="<s:property value='otherNum'/>" /></td>
			  	</tr>			  	
				 <tr>
    				<td height="10" colspan="8"><hr align="center" /></td>
  				</tr>
			  	<script type="text/javascript">
				  	if($('#othercheck'+<%=k%>)){
				  		if($('#otherAmount'+<%=k%>).val()!='' && $('#otherRef'+<%=k%>).val()!=''){
				  			$('#otherAmount'+<%=k%>).attr('disabled',false);
				  			$('#otherRef'+<%=k%>).attr('disabled',false);
				  			$('#othercheck'+<%=k%>).attr('checked','checked');
				  		}	
				  	}
				  </script>
			  	<%k++; %>			  
				</s:elseif>
				
		</s:iterator>
		
		<s:if  test="lineItemVO.tenderVO.discountValue != 'null'">
		<s:if  test="lineItemVO.tenderVO.discountValue >0">
		
			<s:if test="lineItemVO.tenderVO.discountFlag==true">
				<script type="text/javascript">
					$('#discount').attr('checked','checked');
				</script>
			</s:if>
			<tr>
				<td align="center"></td>
				<td colspan="2"><input name="discount" id="discount" type="checkbox" value="<s:property value="lineItemVO.tenderVO.discountValue"/>" onclick="enableDisable();" />
				     APPLY DISCOUNT 
				     <strong>Php 
				     <s:property value="lineItemVO.tenderVO.discountValue"/>
				     <s:if test="lineItemVO.tenderVO.discountType == 'PERCENT'">
				     	%
				     </s:if>
				     </strong> 
				 </td>
				<td align="right">&nbsp;</td>
				<td colspan="2" align="left">&nbsp;</td>
			 </tr>
			 <tr>
    			<td height="10" colspan="8"><hr align="center" /></td>
  			</tr>
		</s:if>
	  	</s:if>
		<tr>
			<td colspan="6"><div align="right">
					<label> <input name="okButton" type="button"
						class="smallpagebutton" id="okButton" onclick="validateValues();"
						value="     OK     " />
					</label>
				</div></td>
		</tr>
		
	</table>		
	</div>
</body>
<script type="text/javascript">
function addChequeRow(){
	
	var index = '<%=(i-1)%>';
	gChIndex = parseInt(gChIndex)+parseInt(index);
	var i = parseInt(gChIndex)+1;
	var $curRow = $("#chequeRow"+gChIndex);
	$newRow = $curRow.clone().attr('id','chequeRow'+i);
	$newRow.find('input:checkbox').attr('id','chequecheck'+i);
	$newRow.find('input:checkbox').attr('checked',false);
	$newRow.find('#chequeAmount'+gChIndex).attr('id','chequeAmount'+i);
	$newRow.find('#chequeRef'+gChIndex).attr('id','chequeRef'+i);
	$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value',' ');
	$newRow.find('input:checkbox').click(function(){enableDisable(i,'cheque');});
	$newRow.find('#bankListId'+gChIndex).attr('id','bankListId'+i);
	
	$curRow.after($newRow);
	$curRow.after("<tr ><td height='10' colspan='10'><hr align=3'center' /></td></tr>");
	
	gChIndex = i;
}
function addCardRow(){
	
	var index = '<%=(j-1)%>';
	gCaIndex = parseInt(gCaIndex)+parseInt(index);
	var i = parseInt(gCaIndex)+1;
	var $curRow = $("#cardRow"+gCaIndex);
	$newRow = $curRow.clone().attr('id', 'cardRow'+i);
	$newRow.find('input:checkbox').attr('id','cardcheck'+i);
	$newRow.find('input:checkbox').attr('checked',false);
	$newRow.find('#cardAmount'+gCaIndex).attr('id','cardAmount'+i);
	$newRow.find('#cardoffline'+gCaIndex).attr('id','cardoffline'+i);
	$newRow.find('#cardonline'+gCaIndex).attr('id','cardonline'+i);
	$newRow.find('input:radio').attr('name','cardradio'+i);
	$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value',' ');
	$newRow.find('input:checkbox').click(function(){enableDisable(i,'card');});
	$curRow.after($newRow);
	$curRow.after("<tr ><td height='10' colspan='10'><hr align='center' /></td></tr>");
	
	gCaIndex = i;
}

function addOtherRow(){
	
	var index = '<%=(k-1)%>';
	gOtIndex = parseInt(gOtIndex)+parseInt(index);
	var i = parseInt(gOtIndex)+1;			
	var $curRow = $("#otherRow"+gOtIndex);
	$newRow = $curRow.clone(true).attr('id', 'otherRow'+i);
	$newRow.find('input:checkbox').attr('id','othercheck'+i);
	$newRow.find('input:checkbox').attr('checked',false);
	$newRow.find('#otherAmount'+gOtIndex).attr('id','otherAmount'+i);
	$newRow.find('#otherRef'+gOtIndex).attr('id','otherRef'+i);
	$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value',' ');
	$newRow.find('input:checkbox').click(function(){enableDisable(i,'other');});
	$curRow.after($newRow);
	$curRow.after("<tr ><td height='10' colspan='10'><hr align='center' /></td></tr>");
	
	gOtIndex = i;
}	
</script>
</html>