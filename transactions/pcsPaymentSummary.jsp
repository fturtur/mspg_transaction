<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- Payment Summary Div Start -->
<div id="totalAmtDiv" align="left" style="display: none;">
	<table width='100%' height='100%' border='0' cellpadding='0'
		cellspacing='0' id="totAmtTable">
		<tr>
			<td>&nbsp;</td>
			<td align="left">Qty</td>
			<td align="right">Amount</td>
		</tr>
		<tr>
			<td height="10" colspan="10"><hr align="center" /></td>
		</tr>
		<%String paymentTpe=""; %>
		<s:iterator value="#session.trxPaymentVOList" var="paymentVO">
			<s:if test="'Card'.equalsIgnoreCase(paymentType)">
			
			<tr>
				<td><strong>CARD:</strong></td>
				<td><strong><s:property value="tenderQuantity"/></strong></td>
				<td align='right'><strong>P<s:text name="format.money"><s:param value="tenderAmount"/></s:text></strong></td>
			</tr>
			</s:if>
			<s:if test="'Check'.equalsIgnoreCase(paymentType)">
			<tr>
				<td><strong>CHECK:</strong></td>
				<td><strong><s:property value="tenderQuantity"/></strong></td>
				<td align='right'><strong>P<s:text name="format.money"><s:param value="tenderAmount"/></s:text></strong></td>
			</tr>
			</s:if>
			<s:if test="'Gift'.equalsIgnoreCase(paymentType)">
			<tr>
				<td><strong>GIFT CARD / SODEXO:</strong></td>
				<td><strong><s:property value="tenderQuantity"/></strong></td>
				<td align='right'><strong>P<s:text name="format.money"><s:param value="tenderAmount"/></s:text></strong></td>
			</tr>
			</s:if>
			<s:if test="'Other'.equalsIgnoreCase(paymentType)">
			<tr>
				<td><strong>OTHER:</strong></td>
				<td><strong><s:property value="tenderQuantity"/></strong></td>
				<td align='right'><strong>P<s:text name="format.money"><s:param value="tenderAmount"/></s:text></strong></td>
			</tr>
			</s:if>
			<s:if test="'Cash'.equalsIgnoreCase(paymentType)">
			<%paymentTpe="Cash"; %>
			<tr>
				<td><strong>CASH:</strong></td>
				<td>&nbsp;</td>
				<td align='right' id="cashAmount"><strong>P<s:text name="format.money"><s:param value="tenderAmount"/></s:text></strong></td>
			</tr>
			</s:if>
		</s:iterator>
		<tr>
			<td><font color='red'><strong>BALANCE:</strong></font></td>
			<td>&nbsp;</td>
			<td align='right'><font color='red'><strong>P<s:text name="format.money"><s:param value="#session.creditBalance"/></s:text></strong></font></td>
		</tr>
		<tr>
			<td colspan='4'><hr /></td>
		</tr>
		<tr>
			<td colspan='2'><strong>TOTAL AMOUNT:</strong></td>
			<td align='right' id="totalAmt"><strong>P<s:text name="format.money"><s:param value="#session.totalAmount"/></s:text></strong></td>
		</tr>
		<tr>
			<td>
				<div id="changeDiv" style="display: none;">
					<table>
					<%if("Cash".equalsIgnoreCase(paymentTpe)) {%>
						<tr>
							<td colspan='2'><strong>Change:</strong></td>
							<td align='right'><strong>P<span id="changeId">0.00</span></strong></td>
						</tr>
						<tr>
							<td colspan='3'><hr /></td>
						</tr>
						<tr>
							<td colspan='2'><strong>Enter Cash:</strong></td>
							<td align='right'><input type='text' id="enterCash"
								onkeypress='return numbersOnlyWithf12(event);'
								onchange="currencyFormatSM(this);calculateChangeAmt(this);"
								style='align: right;' maxlength="19"/></td>
						</tr>
						<%} %>
						<tr>
							<td colspan='3'><hr /></td>
						</tr>
						<tr>
							<td colspan='2' align='right'><input id='submitButton'
								name='Submit' type='button' onclick="processOnlineCards();"
								class='smallpagebutton' value='OK' /></td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<table id="cardPaymentDetails" style="display: none;">
		<s:iterator value="#session.trxExactPaymentVOList" var="paymentVO">
			<s:if test="'Card'.equalsIgnoreCase(paymentType) && 'online'.equalsIgnoreCase(cardProcessMode)">
			<tr>
				<td id='cardLabel'>CARD:</td>
				<td id='processMode'><s:property value="cardProcessMode"/></td>
				<td id='pId'><s:property value="paymentId"/></td>
				<td id='tAmt'><s:property value="tenderAmount"/></td>
			</tr>
			</s:if>
		</s:iterator>
	</table>
	
	<table id="checkPaymentDetails" style="display: none;">
		<s:iterator value="#session.trxExactPaymentVOList" var="paymentVO">
			<s:if test="'Check'.equalsIgnoreCase(paymentType)">
				<tr class="checkValidation">
					<td id='checkLabel'>CHECK:</td>
					<td id='pId'><s:property value="paymentId"/></td>
					<td id='tenderRefNum'><s:property value="tenderRefNum"/></td>
					<td id='tAmt'><s:property value="tenderAmount"/></td>
				</tr>
			</s:if>
		</s:iterator>
	</table>
	
	<table id="otherPaymentDetails" style="display: none;">
		<s:iterator value="#session.trxExactPaymentVOList" var="paymentVO">
			<s:if test="'Other'.equalsIgnoreCase(paymentType)">
				<tr class="otherValidation">
					<td id='otherLabel'>Other:</td>
					<td id='pId'><s:property value="paymentId"/></td>
					<td id='tenderAccNum'><s:property value="tenderAccNum"/></td>
					<td id='tenderRefNum'><s:property value="tenderRefNum"/></td>
					<td id='tAmt'><s:property value="tenderAmount"/></td>
				</tr>
			</s:if>
		</s:iterator>
	</table>
	
	<table id="smacDetails" style="display: none;">
		<s:iterator value="#session.trxLineItemVOList" var="trxLineItemVO">
			<s:if test="%{#trxLineItemVO.isValidationReqd.equalsIgnoreCase('Y')}">
				<tr class="smacValidation">
					<td id='smacLabel'><s:property value="stockDesc"/></td>
					<td id='trxLineNum'><s:property value="trxLineNum"/></td>
					<td id='smacQuantity'><s:property value="quantity"/></td>
				</tr>
			</s:if>
		</s:iterator>
	</table>
</div>
<!-- Payment Summary Div End -->