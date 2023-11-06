<%@ taglib prefix="s" uri="/struts-tags" %>


<%int index=0; %>
			<s:iterator value='#request.serviceVOList'>
			<span style="padding:10px;">

					<a href="javascript:getServiceDetails('<s:property value="id"/>');">
						<img src="<%=request.getContextPath()%>/images/SMServices.png" alt='<s:property value="serviceName" />' height="49" width="48" border="0" 
 							 title='<s:property value="serviceName" />'/>					
					</a>

				<%index++; %>
			</span>
			</s:iterator>
			
		
			
	
<%if(index==0){ %>
<div align="center"><h2><span style="color: red;">No products found </span></h2></div>
<%}%>