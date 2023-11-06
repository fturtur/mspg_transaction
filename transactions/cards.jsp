<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="jq" uri="/struts-jquery-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%int index=0; %>
 <s:iterator value="#session.skus" var="sku" status="skuIndex">
	 <s:if test="'SKU'.equalsIgnoreCase(itemType)">
		<span style="padding:10px;">	
		<a href="javascript:fetchTransactionScreen('<s:property value="id"/>');"> 
	 		<s:if test="skuConfigurationVO.skuIcon.length>0">
		 		<img src="<%=request.getContextPath()%>/transactions/cardImages.jsp?id=<s:property value="id"/>"  
		 				alt="card logo" border="1" height="49" width="48" onmouseover="showSkuProfile(<%=index %>);" onmouseout="hideSkuProfile();" title="<s:property value='stockDescription'/>">
	 		</s:if>
	 		<s:else>
	 			<img src="sample.png" alt='<s:property value="stockDescription"/>' height="49" width="48" border="0" 
	 			onmouseover="showSkuProfile(<%=index %>);" onmouseout="hideSkuProfile();" title="<s:property value='stockDescription'/>"/>
	 		</s:else>
	 	</a> 
		</span>
		<div id="skuProfile<%=index %>" style="display: none;">
			<table style="font:12px Arial, Helvetica, sans-serif" >
						<tr>
							<td><p><strong><font size='+1'>Product Profile</font></strong></p></td>
						</tr>
						<tr ><td>				
								<s:if test="skuConfigurationVO.ppcProfile!=NULL">				
									<s:text name="skuConfigurationVO.ppcProfile"/>
								</s:if>
						</td></tr>
			</table>
		</div>
	</s:if>
	 <s:if test="'SER'.equalsIgnoreCase(itemType)">
	 	<span style="padding:10px;">

					<a href="javascript:getServiceDetails('<s:property value="id"/>');">
						<img src="<%=request.getContextPath()%>/images/SMServices.png" alt='<s:property value="stockDescription" />' height="49" width="48" border="0" 
 							 title="<s:property value='stockDescription' />"/>					
					</a>

		</span>
	 </s:if>
	<%index++; %>
</s:iterator>
<%if(index==0){ %>
<div align="center"><h2><span style="color: red;">No products found </span></h2></div>
<%}%>