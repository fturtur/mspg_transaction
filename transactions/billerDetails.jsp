<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.List" %>
<head>
<style type="text/css">
.tabledata{
font-family: Arial,Helvetica,sans-serif;
font-size: 12px;
font-weight:normal;
}
</style>
</head>
<script type="text/javascript" src="javascript/effect.js"></script>
<script type="text/javascript" src="javascript/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="javascript/jquery.hotkeys.js"></script>
<script type="text/javascript" src="javascript/biller.js"></script>
<script type="text/javascript" src="javascript/tender.js"></script>

<table id="tableItems" style="width:987px;" class="tabledata">		
       
       <tr>		
       
       <!-- Biller details ::: start -->
		<td>
			<table id="billerTable"  style="left:-5px;position:relative;width:732px;">
				<%int i=1; String style=""; %>				
				<s:iterator  value="%{#session.billerList}" var="biller">
					 <%if(i%2==0){
						 	style = "#FFFFCC";
					 	}else{
					 		style = "#FFFF99"; 
					 	}
					  %>
				
				   <tr id="biller_field_<%=i%>"  style="background:<%=style%>;" class="trClass">
					 <td align="center" width="15"><img src="images/edit.png" height="10" width="10" class="imgClass" id="editImg_<%=i%>" onclick="editBillerDetails('<%=i%>');" alt="edit" title="edit"/></td>
	        		 <td align="center" width="15"><img src="images/delete.png" height="12" width="12" onclick="deleteBillerDetails('<%=i%>');" alt="delete" title="delete"/></td>	       
					 <td align="center" width="20"><%=i%></td>			
					 <td align="center" width="150" id="billerName_<%=i%>"><s:property value="billerName"/></td>
					 <td align="left" width="200"><s:property value="accountNum"/></td>
					 <td align="right" width="115">P<s:property value="amount"/></td>
					 <td align="right" width="80" class="serviceFee" id="serviceFee_<%=i%>">P<s:property value="serviceFee"/></td>
					 <td align="right" width="115">P<s:property value="totaldue"/></td>
						<script type="text/javascript">					 		
					 	  $(document).bind('keydown','<%=i%>',function (evt){       
					 		 if(!$('#editImg_'+<%=i%>).is(':hidden')){
					 			if($('#billerTable') && <%=i%> <= $('#billerTable tr').length){
						 	     	editBillerDetails('<%=i%>');
						 	     	return false;  	     
					 			}
					 		 }
					 	  });  
	 					</script> 					
 					</tr>						
						
					<input type="hidden" name="mixedTrxAllowed" id="mixedTrxAllowed" value="<s:property value='%{#biller.billerVO.mixedTrxAllowed}'/>"/>
					<input type="hidden" name="resumeBiller<%=i%>" class="resumeBiller" id="resumeBiller<%=i%>" value="<s:property value='billerId'/>"/>	
			  		<%i++; %>
			   </s:iterator>
			    
			</table>
			
			 <!--check edit line item  -->			   
			   	<input type="hidden" name="editLineFlag" id="editLineFlag" value="<%=session.getAttribute("editLineFlag")%>">
			   	<input type="hidden" name="editLineNum" id="editLineNum" value="<%=session.getAttribute("editLineNum")%>">
			 
		</td>
		
		<!-- Biller details ::: end -->
		
		<!-- Tender details ::: start -->
		<td valign="top">
			
			<table id="tenderTable" style="left:-12px;position:relative;width:255px;">
				<%int k=1; String tenderStyle=""; %>
			  
				<s:iterator  value="%{#session.billerList}" var="tender">
					 <%if(k%2==0){
						 tenderStyle = "#FFFFCC";
					 	}else{
					 		tenderStyle = "#FFFF99"; 
					 	}
					  %>
				
				  <s:if test="#tender.paymentType != null">
				   <tr id="tender_field_<%=k%>"  style="background:<%=tenderStyle%>;">
					 <td align="center"width="15"><img src="images/edit.png" class="imgClass" id="editTenderImg_<%=k%>" height="10" width="10" onclick="editTenderDetails('<%=k%>');"/></td>
					 <td align="center" width="115">
					 <div style="display: none;">
					 	<input type="hidden" id="checkDetails_<%=k%>" class="printCheckDetails" value="<s:property value="tendersToPrint"/>">
					 	<input type="hidden" id="otherDetails_<%=k%>" class="printOtherDetails" value="<s:property value="othersToPrint"/>">
					 </div>
					 <s:property value="paymentType"/>
					 </td>
					 <td align="right" width="115">
					 	<div style="padding-right: 10px;">P<s:property value="amountPaid"/></div>
					 </td>					 
						
					<script type="text/javascript">
					 	 	$(document).bind('keydown', 'Ctrl+<%=k%>',function (evt){
					 	 		
					 	 		if(!$('#editTenderImg_'+<%=k%>).is(':hidden')){
					 	 			if($('#billerTable') && <%=k%> <= $('#billerTable tr').length){
						 	 			editTenderDetails('<%=k%>');
					 	       			return false;	
					 	 			}
					 	 		}
					 	 		 
					 	    });
					 	 	
	 				</script> 
						
 					</tr>						
						<%k++; %>
					</s:if>	
			   </s:iterator>
			 
			</table>			
		</td>
		
		<!--  Tender details ::: end -->
	</tr>
	
	<!-- Total Amount div ::: start -->
	<tr>
		<td>
			<div id="totalAmtDiv" align="center" style="display:none;">
			<table width='100%' height='100%' border='0' cellpadding='0' cellspacing='0' id="totAmtTable">			
			<tr>	
				<td>&nbsp;</td>										
				<td align="left">Qty</td>							
				<td align="right">Amount</td>
			</tr>
			
			<tr>
				<td height="10" colspan="10"><hr align="center" /></td>
			</tr>
			
			<s:if test="lineItemVO.otherQty >0">
			<tr>
				<td><strong>OTHER:</strong></td>
				<td><strong><s:property value="lineItemVO.otherQty"/></strong></td>
				<td align='right'><strong>P<s:property value="lineItemVO.otherAmt"/></strong></td>
			</tr>
			</s:if>
			
			<s:if test="lineItemVO.cardQty >0">
			<tr>
				<td><strong>CARD:</strong></td>
				<td><strong><s:property value="lineItemVO.cardQty"/></strong></td>
				<td align='right'><strong>P<s:property value="lineItemVO.cardAmt"/></strong></td>
			</tr>
			</s:if>
			
			<s:if test="lineItemVO.chequeQty >0">			
			<tr>
				<td><strong>CHECK:</strong></td>
				<td><strong><s:property value="lineItemVO.chequeQty"/></strong></td>
				<td align='right'><strong>P<s:property value="lineItemVO.chequeAmt"/></strong></td>
			</tr>
			</s:if>	
			
			<s:if test="lineItemVO.cashAmt!='0.00'">		
			<tr>
				<td><strong>CASH:</strong></td>
				<td>&nbsp;</td>
				<td align='right'>
					<strong>P<s:property value="lineItemVO.cashAmt"/></strong>
					<input type="hidden" id="totalCashAmt" value="<s:property value="lineItemVO.cashAmt"/>" />
				</td>
			</tr>
			</s:if>
			
			<s:if test="lineItemVO.discountValue>0">
			<tr>
				<td><strong>DISCOUNT:</strong></td>
				<td>&nbsp;</td>
				<td align='right'>
					<strong>P<s:property value="lineItemVO.discountValue"/></strong>
					<input type="hidden" id="discountAmt" value="<s:property value="lineItemVO.discountValue"/>" />
				</td>
			</tr>
			</s:if>			
			
			<tr>
				<td ><font color='red'><strong>BALANCE:</strong></font></td>
				<td>&nbsp;</td>
				<td align='right'><font color='red'><strong>P<s:property value="lineItemVO.balance"/></strong></font></td>
			</tr>
			
			<tr><td colspan='3'><hr /></td></tr>
			
			<tr><td colspan='2'><strong>TOTAL AMOUNT:</strong></td>
			<td align='right'><strong>P<s:property value="lineItemVO.totalAmount"/></strong></td>
			</tr>
			
			<tr><td>
			<div id="changeDiv" style="display:none;">
			<table>			
				<s:if test="lineItemVO.totalAmount!='0.00'">
				<input type="hidden" name="totalAmt" id="totalAmt" value="<s:property value="lineItemVO.totalAmount"/>"/>
					<tr><td colspan='2'><strong>Change:</strong></td>
					<td align='right'><strong>P<span id="changeId">0.00</span></strong></td>
					</tr>
			<input type="hidden" name="casAmt" id="casAmt" value='<s:property value="lineItemVO.cashAmt"/>'/>
					<s:if test="lineItemVO.cashAmt!='0.00'" > 
					<tr><td colspan='3'><hr /></td></tr>
					<tr>
						<td colspan='2'><strong>Enter Cash:</strong></td>
						<td align='right'><input type='text' id="enterCash" onkeypress='return numbersOnlyWithf12(event);' onchange="currencyFormatSM(this);calculateChangeAmt(this);"  style='align:right;' /></td>
					</tr>
					<tr><td colspan='3'><hr /></td></tr>
					
					<tr>
						<td colspan='2' align='right'><input id='submitButton' name='Submit' type='button' onclick="saveTransaction();" class='smallpagebutton' value='OK' /></td>
					</tr></s:if>
				</s:if>	
			</table>
			</div>
			</td></tr>	
					
			</table>			
		</div>
		</td>		
	</tr>
	<!-- Total Amount div ::: end -->	
	
</table> 

