<%@ taglib prefix="s" uri="/struts-tags" %>
<s:form theme="simple" id="itemDeclaration">
<table width="700"  border="0" align="center" cellpadding="0" cellspacing="0" style="background-color: white;">
		<tr>
          <td class="bordertopleft"></td>
          <td class="bordertop"></td>
          <td class="bordertopright"></td>
        </tr>
        <tr>
          <td class="borderleft"></td>
          <td >
          <div  style="overflow-y: scroll; height: 500px">
          	<table width="660"  border="0" align="center" cellpadding="0" cellspacing="0" style="background-color: white;">
<tr>
<td><span class="style5" style="font-weight: bold;">PRODUCT DECLARATION </span></td>
<td width="20" rowspan="3">&nbsp;</td>
</tr>
<tr>
  <td><hr /></td>
  </tr>
<tr>
  <td>
  <table width="650" border="0" align="center" cellpadding="1" cellspacing="1" id="tenders">
  	<s:if test="#session.userVO.itemDeclarationCompleted==true">
    <tr>
      <td colspan="6" align="left">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="declarationType" type="radio" value="REP" checked="checked"/>Replenishment<br />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="declarationType" type="radio" value="EOD" />End-of-Day
        </td>
    </tr>
    <tr>
      <td colspan="6" align="left"><hr /></td>
    </tr>
    </s:if>
    <tr>
      <td align="center"><strong>Item</strong></td>
      <td align="center"><strong>Code</strong></td>
      <td align="center">&nbsp;</td>
      <td align="center"><strong>Quantity</strong></td>
      <td align="center">&nbsp;</td>
      <td align="center"><strong>Amount</strong></td>
      </tr>
    <tr>
      <td colspan="6" align="center"><hr align="center" /></td>
      </tr>
      <%int index=0; %>
    <s:iterator value="itemDeclarationVOs" var="itemDeclarationVO" status="fields">
	    <tr id="stockId">
	      <td align="left"><strong><s:property value="stockDesc"/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].id" value='%{#itemDeclarationVO.id}'/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].companyId" value='%{#itemDeclarationVO.companyId}'/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].branchId" value='%{#itemDeclarationVO.branchId}'/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].locationId" value='%{#itemDeclarationVO.locationId}'/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].terminalId" value='%{#itemDeclarationVO.terminalId}'/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].stockDesc" value='%{#itemDeclarationVO.stockDesc}'/>
	      </strong></td>
	      <td align="center"><s:property value="stockCode"/>
	      	<s:hidden name="itemDeclarationVOs[%{#fields.index}].stockCode" value='%{#itemDeclarationVO.stockCode}'/>
	      </td>
	      <td align="center"> x </td>
	      <td align="center"><label>
	      	<s:textfield name="itemDeclarationVOs[%{#fields.index}].quantity" size="5" maxlength="5" onkeypress="return  AllowOnlyDigits(event);" 
	      		onblur='calculateAmount(this,"%{#itemDeclarationVO.price}","%{#fields.index}");' cssStyle="text-align: right;"/>
	      	<s:hidden id="amount%{#fields.index}" name="itemDeclarationVOs[%{#fields.index}].amount" />
	        <!-- <input name="quantity" type="text" size="5" onblur="calculateAmount(this);"/> -->
	      </label></td>
	      <td align="center">=</td>
	      <td align="right" id="amounttd<%=index%>">Php 
	      <s:if test="#itemDeclarationVO.amount!=0">
	      	<s:property value="amount"/> 
	      </s:if>
	      <s:else>
	      	0.00
	      </s:else>
	      	
	      
	      </td>
	    </tr>
	    <%index++; %>
    </s:iterator>
    <tr>
      <td colspan="6" align="right"><hr align="center" /></td>
    </tr>
    <tr>
      <td colspan="6"><div align="right">
          <input name="okButton" type="button" class="smallpagebutton" id="itemDeclarationButton" onclick="saveItemDeclaration();" value="OK" />&nbsp;&nbsp;&nbsp;
		  <s:if test="#session.userVO.itemDeclarationCompleted==true">
		  <input name="cancelButton" type="button" class="smallpagebutton" id="cancelButton" value="Cancel" onclick="closeItemDeclaration();"/>
		  </s:if>
      	  <s:else>
      	  		<s:if test="%{#session.userVO.bpsTerminal.terminalDefaultPage.equalsIgnoreCase('P')}">
      	  			<input name="cancelButton" type="button" class="smallpagebutton" id="cancelButton" value="Cancel" onclick="logout();"/>
      	  		</s:if>
      	  		<s:else>
      	  			<input name="cancelButton" type="button" class="smallpagebutton" id="cancelButton" value="Cancel" onclick="navigateToBPSItemDecl();"/>
      	  		</s:else>
      	  </s:else>
      </div></td>
    </tr>
</table></td>
  </tr>
</table>
  </div>        
          </td>
          <td class="borderright"></td>
        </tr>
        <tr>
          <td class="borderbottomleft"></td>
          <td class="borderbottom"></td>
          <td class="borderbottomright"></td>
        </tr>
</table>
</s:form>
