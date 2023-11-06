<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="jq" uri="/struts-jquery-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

 <s:iterator value="bpsBillers" var="biller">
	<span style="padding:10px;">	
	<a href="javascript:fetchBillerFields('<s:property value="billerId"/>','<s:property value="isOnline"/>', '<s:property value="trxCutOffTime"/>','<s:property value="mixedTrxAllowed"/>');"> 
 		<img src="<%=request.getContextPath()%>/transactions/billerImages.jsp?id=<s:property value="billerId"/>"  alt="biller logo" border="1" height="49" width="48">
 	</a> 
	</span>
</s:iterator> 

	





	    	