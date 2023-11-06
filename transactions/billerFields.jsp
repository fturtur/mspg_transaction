<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<html><head>

<link href="css/main.css" rel="stylesheet" type="text/css" />
</head>
	<s:head theme="simple"/>	
	<s:form id="billerScreenFieldsForm" >

		<table align="center" id="billerFieldTable">
			<tr>
				<td>
					
							<s:iterator value="lineItemVO.billerFields" var="screenField" status="fieldStatus">
							<s:hidden  id="fname" value='%{#screenField.bpsBillerMasterFieldNames.fieldName}' name='billerScreenFields[%{#fieldStatus.index}].bpsBillerMasterFieldNames.fieldName'></s:hidden>
								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'text'">
									<s:textfield name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
									id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" onblur="%{#screenField.billerScreenFields.fieldValidationJS};enableSubmit();"/>
								</s:if>
								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'checkbox'">
									<s:checkbox name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}" cssClass="fields"
									id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" onblur="%{#screenField.billerScreenFields.fieldValidationJS};enableSubmit();"/>
								</s:if>
								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'textarea'">
									<s:textarea name="uiValue" label="%{#screenField.billerScreenFields.fieldDisplayName}"  cssClass="fields"
									id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" rows="4" cols="16"  onblur="%{#screenField.billerScreenFields.fieldValidationJS};enableSubmit();"/>
								</s:if>
								
								<s:if test="#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsFieldTypes.fieldType == 'select'">
									
									<s:if test="lineItemVO.billerVO.billerDrivers.driverId >0">
										<s:select list="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsBillerScreenFieldValueses}" headerKey="0" headerValue="---please select---" name="uiValue" cssClass="fields"
										label="%{#screenField.billerScreenFields.fieldDisplayName}" listKey="fieldValueId" listValue="fieldValue"
										onblur="%{#screenField.billerScreenFields.fieldValidationJS};enableSubmit();" id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}" onchange="fetchDriverFields('%{lineItemVO.billerVO.billerDrivers.driverId}',this,'driverField');" ></s:select>
										
<%-- 									<s:select name="lineItemVO.billerVO.driverValue" id="driverField" list="lineItemVO.billerVO.driverFieldList" listKey="fieldValueId" listValue="fieldValue" headerKey="0" headerValue="---please select---"  label="%{lineItemVO.billerVO.billerDrivers.driverDisplayName}" cssClass="fields"/>
 --%>										
									</s:if>									
									
									 <s:else> 
										<s:select list="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.bpsBillerScreenFieldValueses}" headerKey="0" headerValue="---please select---" name="uiValue" cssClass="fields"
										label="%{#screenField.billerScreenFields.fieldDisplayName}" listKey="fieldValueId" listValue="fieldValue"
										onblur="%{#screenField.billerScreenFields.fieldValidationJS};enableSubmit();" id="%{#screenField.billerScreenFields.bpsBillerMasterFieldNames.fieldName}"  ></s:select>
									 </s:else> 
								
								</s:if>
								
								<div class="tempDiv" style="display: none;">
								
									<s:property value="%{#screenField.billerScreenFields.fieldValidationJS}" />
								</div>
								
							</s:iterator>		
					
				</td>
			</tr>
			
			<tr>
				<td>
				<s:if test="%{#billerScreenFields != 'null'}">
				<input type="button" id="submitId" onclick="addBiller();" value="Submit"/>
				<!--  <s:submit id="submitId"  value="Submit" onclick="addRow();"/>-->	
					<div id="scriptDiv">
						
					</div>
					</s:if>
					
				</td>
			</tr>	
		</table>
		
		<div align="center" id="billerPoliciesDiv" style="display:none;">
		<table id="billerPoliciesTable" >
			<tr ><td>				
					<p><strong><font size='+1'>Payment Policies:</font></strong></p>
					<ul>
						<li><strong>Valid Documents</strong><br />
							<s:iterator value="lineItemVO.billerVO.validDocuments" var="validDoc">
								- <s:property value="%{#validDoc.bpsValidDocuments.documentName}"/><br />							
							</s:iterator> 
						</li>
						<li><strong>Payments Accepted</strong><br />
							<s:iterator value="lineItemVO.billerVO.validPaymentOptions" var="validOptions">
								- <s:property value="%{#validOptions.bpsValidPmtPolicyOptions.optionName}"/><br />							
							</s:iterator>
						</li>
						
						<li><strong>Payment Options</strong><br /> 
							<s:iterator value="lineItemVO.billerVO.paymentOptions" var="paymentOptions">
								- <s:property value="%{#paymentOptions.bpsPaymentOptions.optionName}"/><br />							
							</s:iterator>
						</li>
						
						<li><strong>Due Date</strong><br />
							 - Current<br />
							 <s:if test="lineItemVO.billerVO.acceptPastDues=='Y'">
							 - Past Due
							</s:if>
						 </li>
					</ul>					
				
			</td></tr>
		</table>
		</div>
		</s:form>
		</html>