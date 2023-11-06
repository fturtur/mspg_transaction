<%@page import="com.sm.bps.transactions.vo.BillerLineItemVO"%>
<%@ page import ="com.sm.bps.biller.pojo.BpsBillerServices" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<html><head>

<link href="css/main.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
var rawPayment='<%=request.getAttribute("rawPayment")%>';
$(document).ready(function() {
	if($("#billerFieldTable")){
		var textList = $("#billerFieldTable").find('.fields');
		for(var i=0;i<textList.length;i++){
			if(textList[i].id=='payment' && textList[i].value!=""){
				textList[i].value =  "P"+textList[i].value;
			}
		}
	}
	if(rawPayment!=null && rawPayment!=''){
		if(document.all.amountDue!=undefined && document.all.amountDue!=null){
			document.all.amountDue.setAttribute("RAW", TrimLeadZeros(rawPayment));
		}
	}
}); 
</script>
	<s:head theme="simple"/>	
	<s:form id="billerScreenFieldsForm" >
		<s:if test="#request.barcodeExists == 'Y'">
			<table align="right">
				<tr>
					<td>
						<a href="javascript:billerBarCodeCheck();"><img alt="" src="images/SMScannerIcon.png" /></a>
					</td>
				</tr>
			</table>
		</s:if>
		<table align="center" >
			<tr>
				<td align="center">
				<img  src="<%=request.getContextPath()%>/transactions/billerImages.jsp?id=<s:property value="lineItemVO.billerId"/>&logo=true"  />
				</td>
			</tr>
		</table>
		<table align="center" id="billerFieldTable">							
							
							<tr><td>
								<input type="hidden" id="billerBarcodeExists"  value="<s:property value="#request.barcodeExists"/>"/>
								<input type="hidden" id="billerNumOfBarcodes"  value="<s:property value="#request.numOfBarcodes"/>"/>
								<s:if test="lineItemVO.billerVO.billerDrivers.driverId >0">
									<s:select list="lineItemVO.billerVO.driverFieldList" headerKey="0" headerValue="---please select---" name="lineItemVO.billerVO.uiValue" cssClass="fields"
										label="%{lineItemVO.billerVO.billerDrivers.driverDisplayName}" listKey="driverFieldId" listValue="fieldValue"
										id="lineItemVO.billerVO.billerDrivers.driverId" onchange="fetchDriverFields('%{lineItemVO.billerId}','%{lineItemVO.billerVO.billerDrivers.driverId}',this);" >
									</s:select>										
								</s:if>
							</td></tr>							
					
							<s:iterator value="lineItemVO.billerFields" var="screenField" status="fieldStatus">
							<s:hidden  id="fname" value='%{#screenField.bpsBillerMasterFieldNames.fieldName}' name='billerScreenFields[%{#fieldStatus.index}].bpsBillerMasterFieldNames.fieldName'></s:hidden>
							<s:set var="onkeypressVal" value="%{#screenField.bpsBillerMasterFieldNames.onkeypress}" />	
							<tr><td>	
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'text'">
									<s:if test="#screenField.disabled!=null">
										<s:if test="#screenField.billerScreenFields.size!=null">
											<s:textfield name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
											id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" disabled="true" 
											onblur="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();" 
											maxlength="%{#screenField.billerScreenFields.size}" onkeypress="%{#screenField.onkeypress}">									
											</s:textfield>	
										</s:if>
										<s:else>
											<s:textfield name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
											id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" disabled="true" 
											onblur="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();" onkeypress="%{#screenField.onkeypress}">									
											</s:textfield>
										</s:else>
									</s:if>
									<s:else>
										<s:if test="#screenField.billerScreenFields.size!=null">
											<s:textfield name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
											id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" 
											onblur="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();" 
											maxlength="%{#screenField.billerScreenFields.size}" onkeypress="%{#screenField.onkeypress}">									
											</s:textfield>	
										</s:if>
										<s:else>
											<s:textfield name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
											id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"
											 onblur="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();" onkeypress="%{#screenField.onkeypress}">									
											</s:textfield>
										</s:else>
									</s:else>			
									<input type="button" style="display:none;" class="editDiv" onclick="fun_edit_<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" />();">					
								</s:if>								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'checkbox'">
									<%-- <s:checkbox name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
									id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" onblur="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();"/>
									 --%>
									<s:if test='uiValue!=null'>
										<input type="checkbox" name="<s:property value='uiValue'/>" id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" class="fields"
										value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" checked="checked"/>
										<label><s:property value='%{#screenField.billerScreenFields.fieldDisplayName}'/></label>
									</s:if>
									<s:else>
										<input type="checkbox" name="<s:property value='uiValue'/>" id="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>" class="fields"
										value="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>"/>
										<label><s:property value='%{#screenField.billerScreenFields.fieldDisplayName}'/></label>
									</s:else>								
								</s:if>
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'textarea'">
									<s:textarea name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}"  cssClass="fields"
									id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" rows="4" cols="16"  onblur="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();"/>
									<input type="button" style="display:none;" class="editDiv" onclick="fun_edit_<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" />();">
								</s:if>
								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'select'">
									<s:select list="%{#screenField.billerScreenFields.bpsBillerScreenFieldValues}"  name="uiValue" cssClass="fields"
									label="%{#screenField.billerScreenFields.fieldDisplayName}" listKey="fieldValue.split(\"@\")[0]" listValue="fieldValue.split(\"@\")[1]"
									onchange="fun_%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}();" id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"  ></s:select>
									<input type="button" style="display:none;" class="editDiv" onclick="fun_edit_<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" />();">
								</s:if>
								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'radio'">									
									<s:if test='uiValue!=null'>
										<input type="radio" name="<s:property value='uiValue'/>" id="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>" class="fields" 
										value="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>" checked="checked"/>									
										<label><s:property value='%{#screenField.billerScreenFields.fieldDisplayName}'/></label>
									</s:if>
									<s:else>
										<input type="radio" name="<s:property value='uiValue'/>" id="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>" class="fields" 
										value="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>"/>									
										<label><s:property value='%{#screenField.billerScreenFields.fieldDisplayName}'/></label>
									</s:else>
								</s:if>
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'submit'">									
									<input type="hidden" id="callSubmit" value="Y" />
								</s:if>
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'onload'">
									<input type="hidden" id="processOnLoad" value="Y" />
								</s:if>
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'barcode'">
									<input type="hidden" id="processOnLoadAfterBarcode" value="Y" />
								</s:if>
								<!--Cebu Pacific Webservice Integration - START-->
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'postsubmit'">									
									<input type="hidden" id="callPostSubmit" value="Y" />
									<div class="postSubmitDiv" style="display: none;">
									function fun_postSubmit(){
										<s:property value="%{#screenField.billerScreenFields.fieldValidationJs}" />
									}
									</div>
								</s:if>
								<!--Cebu Pacific Webservice Integration - END-->
								<!--PreSubmit Before Save - START-->
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'presubmit'">									
									<input type="hidden" id="callPreSubmit" value="Y" />
									<div class="preSubmitDiv" style="display: none;">
									function fun_preSubmit(){
										<s:property value="%{#screenField.billerScreenFields.fieldValidationJs}" />
									}
									</div>
								</s:if>
								<!--PreSubmit Before Save - END-->
								<%-- <span id="<s:property value='%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}'/>Error"  style="position:absolute;z-index:1;color:red;">&nbsp;</span> --%>
								<div class="tempDiv" style="display: none;">
								<pre>
								<!--Cebu Pacific Webservice Integration - START-->
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'presubmit'">
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'postsubmit'">
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'barcode'">
								  <s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'global'">
								  
										function fun_<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" />(){
											//alert('onload');
									//		var p = document.getElementById('<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>');
										 <s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'onload'">
										 <s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'submit'">
									//		$('#<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>').nextAll().remove();
									//		var span = document.createElement('span');
									//		$(span).attr('style', 'color:red;');
									//		$(span).attr('id', '<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>Error');
									//		$(span).insertAfter(p);
											</s:if>
											</s:if>
									
									</s:if>
										<s:property value="%{#screenField.billerScreenFields.fieldValidationJs}" />
									<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'global'">
									<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'barcode'">
										}
									</s:if>
									</s:if>
									</s:if>
									</s:if>
									</s:if>
									<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'presubmit'">
									<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'postsubmit'">
									<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'onload'">
										<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'submit'">	
										<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType != 'barcode'">
										function fun_edit_<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" />(){
											//if(!$('#<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>Error')){
												var p = document.getElementById('<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>');
												var disabled = false;
												if($(p).is(":disabled")){
													$(p).removeAttr('disabled');
													disabled = true;
												}
												$('#<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>').nextAll().remove();
												var span = document.createElement('span');
												$(span).attr('style', 'color:red;');
												$(span).attr('id', '<s:property value="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"/>Error');
												$(span).insertAfter(p);
												if(disabled){
													$(p).attr("disabled", "disabled");
												}
											//}
										}
										</s:if>
										</s:if>
										</s:if>
										</s:if>
										</s:if>
										<!--Cebu Pacific Webservice Integration - END-->
									<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'barcode'">
										function smbps_barcodeValidation(){
											//if($('#callEditDiv').val() == 'Y'){
												$('.editDiv').click();
											//}
											gstrBarcode   = $('#billerBarcodeVal').val();
											if(gstrBarcode != '')
												gbValsFromBC = true;
											<s:property value="%{#screenField.billerScreenFields.fieldValidationJs}" />
											
											if($('#processOnLoad') && $('#processOnLoad').val() == 'Y'){
												fun_onload();
											}
										}
									</s:if>		
								  </pre>
								  
								</div>
								
								</td>								
							</tr>	
							</s:iterator>

			<tr>
				<td>
				<s:if test="#request.editBillerFields == 'true'">
					<input type="hidden" id="callEditDiv" value="Y" />
				</s:if>
				<s:if test="%{#billerScreenFields != 'null'}">
				<input type="button" id="submit" onclick="addBiller(this);" value="OK"/>
				
				<!--  <s:submit id="submitId"  value="Submit" onclick="addRow();"/>-->	
					<div id="scriptDiv">
						
					</div>
					<div id="editScriptDiv">
						
					</div>
					</s:if>
					
				</td>
			</tr>	
		</table>
		<table id="servcieFeeTable">			
			 <%
			BillerLineItemVO itemVO = (BillerLineItemVO)session.getAttribute("billerLineItemVO");
			 if(null != itemVO){
			List<BpsBillerServices> serviceFeeList = itemVO.getBillerVO().getServiceFeeList();
			if(serviceFeeList!=null && !serviceFeeList.isEmpty()){
				for(BpsBillerServices service:serviceFeeList){
					if("Y".equalsIgnoreCase(service.getUseAlgorithm())){
			%>
			<tr><td>
				<input type="hidden" class="service" name="<%=service.getBpsServiceFeeTypes().getServiceFeeName() %>" id="<%=service.getBpsServiceFeeTypes().getServiceFeeId()%>">
				<script type="text/javascript">
					<%=service.getServiceFeeAlgorithm()%>				
				</script>
			</td>
			</tr>	
			<%				
					}
				}				
			 }
			 }
			%>
			
		</table>
		<div align="center" id="billerPoliciesDiv" style="display:none;">
		<table id="billerPoliciesTable" >
			<tr ><td>				
					<s:if test='lineItemVO.billerVO.policyImgFlag!=true'>				
					<p><strong><font size='+1'>Payment Policies:</font></strong></p>
					<ul>
						<li><strong>Valid Documents</strong><br />
							<s:iterator value="lineItemVO.billerVO.validDocuments" var="validDoc">
								- <s:property value="%{#validDoc.bpsValidDocuments.documentName}"/><br />							
							</s:iterator> 
						</li>
						
						<li><strong>Payments Accepted</strong><br />
							<s:iterator value="lineItemVO.billerVO.validPaymentOptions" var="validOptions">
								- <span style="text-transform: uppercase"><s:property value="%{#validOptions.bpsTenderTypes.tenderName}"/><br /></span>							
							</s:iterator>
							<s:if test='lineItemVO.billerVO.mixedTenderAllowed=="Y" && lineItemVO.billerVO.tenderSize > 1'>
								- COMBINATION
							</s:if>
						</li>
						
						<%-- <li><strong>Payments Accepted</strong><br />
							<s:iterator value="lineItemVO.billerVO.validPaymentOptions" var="validOptions">
								- <span style="text-transform: uppercase"><s:property value="%{#validOptions.bpsTenderTypes.tenderName}"/><br /></span>							
							</s:iterator>
						</li> --%>
						
						<li><strong>Payment Options</strong><br /> 
							<s:iterator value="lineItemVO.billerVO.paymentOptions" var="paymentOptions">
							<input type="hidden"  class="billerPaymentOptions" value='<s:property value="%{#paymentOptions.bpsPaymentOptions.optionName}"/>'/>
								- <s:property value="%{#paymentOptions.bpsPaymentOptions.optionName}"/><br />							
							</s:iterator>
						</li>
						
						<li><strong>Due Date</strong><br />
							 - Current<br />
							 <s:hidden  id="acceptPastDue" value="%{#lineItemVO.billerVO.acceptPastDues}"/>							 
							 <s:hidden id="gracePeriod" value="%{#lineItemVO.billerVO.gracePeriod}"/>
							 <s:hidden id="endDate" value="%{#lineItemVO.billerVO.endDate}"/>							 
							 <s:if test='lineItemVO.billerVO.acceptPastDues=="Y"'>		
							 	<s:if test='lineItemVO.billerVO.gracePeriod!=null'>					
									 - Past Due + <s:property value="%{lineItemVO.billerVO.gracePeriod}"/> Days Grace Period
							 	</s:if>
							 	<s:else>
							 		- Past Due
							 	</s:else>
							</s:if>
							
						 </li>
						
						<%-- <li><strong>Due Date</strong><br />
							 - Current<br />
							 <s:hidden  id="acceptPastDue" value="%{#lineItemVO.billerVO.acceptPastDues}"/>							 
							 <s:hidden id="gracePeriod" value="%{#lineItemVO.billerVO.gracePeriod}"/>
							 <s:hidden id="endDate" value="%{#lineItemVO.billerVO.endDate}"/>							 
							 <s:if test='lineItemVO.billerVO.acceptPastDues=="Y"'>							
							 - Past Due
							</s:if>
						 </li> --%>
						</ul>	
					</s:if>	
				<s:else>
					<s:iterator value="lineItemVO.billerVO.paymentOptions" var="paymentOptions">
						<input type="hidden"  class="billerPaymentOptions" value='<s:property value="%{#paymentOptions.bpsPaymentOptions.optionName}"/>'/>
					</s:iterator>
					<s:hidden  id="acceptPastDue" value="%{#lineItemVO.billerVO.acceptPastDues}"/>							 
					 <s:hidden id="gracePeriod" value="%{#lineItemVO.billerVO.gracePeriod}"/>
	     			 <s:hidden id="endDate" value="%{#lineItemVO.billerVO.endDate}"/>	
					<img  src="<%=request.getContextPath()%>/transactions/billerImages.jsp?id=<s:property value="lineItemVO.billerId"/>&policyImg=true" width="220" height="300"  /> 
				</s:else>						
				
			</td></tr>
		</table>
		</div>
		</s:form>
		</html>