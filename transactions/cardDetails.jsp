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
<script type="text/javascript" src="javascript/effect.js"></script>
<script type="text/javascript" src="javascript/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="javascript/pcsTransactionMain.js"></script>

</head>
<body>
	<table id="skuTable" >
				<%int i=1; String style=""; %>				
				<s:iterator  value="%{#session.skusVOList}" var="sku">
					 <%if(i%2==0){
						 	style = "#CFEFB6";
					 	}else{
					 		style = "#A5E074"; 
					 	}
					  %>
				
				   <tr id="sku_field_<%=i%>"  style="background:<%=style%>;" class="trClass">
	        		 <td align="center" width="15"><img src="images/delete.png" height="12" width="12" onclick="deleteSkuDetails('<%=i%>');" alt="delete" title="delete"/></td>	       
					 <td align="center" width="20"><%=i%></td>			
					 <td align="center" width="300" id="stockDesc_<%=i%>"><s:property value="stockDescription"/></td>
					 <td align="left" width="200"><s:property value="stockCode"/></td>
					 <td align="right" width="150">P<s:property value="amountDue"/></td>
					 <td align="right" width="130" class="serviceFee" id="serviceFee_<%=i%>">P<s:property value="serviceFee"/></td>
					 <td align="right" width="150">P<s:property value="totalDue"/></td>
						<%-- <script type="text/javascript">					 		
					 	  $(document).bind('keydown','<%=i%>',function (evt){       
					 		 if(!$('#editImg_'+<%=i%>).is(':hidden')){
					 			if($('#billerTable') && <%=i%> <= $('#billerTable tr').length){
						 	     	editBillerDetails('<%=i%>');
						 	     	return false;  	     
					 			}
					 		 }
					 	  });  
	 					</script> 	 --%>	
	 					<td>	
	 					<input type="hidden" name="resumeSku<%=i%>" class="resumeBiller" id="skuId<%=i%>" value="<s:property value='id'/>"/></td>		
 					</tr>						
			  		<%i++; %>
			   </s:iterator>
			    
			</table>

</body>
</html>