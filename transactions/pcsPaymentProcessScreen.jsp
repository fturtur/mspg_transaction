
<table align="center" width="650" border="0" cellpadding="1" cellspacing="1" id="pcsTenders" style="display: none;">
  <tr>
    <td colspan="2">&nbsp;</td>
    <td id="tenders"><div align="center"><strong>AMOUNT</strong></div></td>
    <td colspan="3" id="tenders"><div align="center"><strong>DETAILS</strong></div></td>
  </tr>
  <tr>
    <td height="10" colspan="6"><hr align="center" /></td>
  </tr>
  <tr>
    <td width="31" align="center">1</td>
    <td width="72"><label>
      <input id="tenderCash" name="tender" type="checkbox" onclick="enableDisable();" value="Cash" checked="checked" />
    CASH</label></td>
    <td width="120" align="center"><label>
      Php
      <input name="txtCash" type="text" id="txtCash" style="width:73px;" onkeypress="return numbersOnly(event);" />
    </label></td>
    <td width="23" align="center"><label></label></td>
    <td colspan="2" align="center">&nbsp;</td>
  </tr>
  <tr align="center">
    <td height="10" colspan="6"><hr align="center" /></td>
  </tr>
  <tr>
    <td align="center">2</td>
    <td><label id="tenders">
      <input id="tenderCheck" name="tender" type="checkbox" value="Check" onclick="enableDisable();" />
    CHECK</label></td>
    <td align="center"><label>
      Php
      <input name="txtCheck" type="text" id="txtCheck" style="width:73px;" onkeypress="return numbersOnly(event);" />
    </label></td>
    <td align="right"><img id="addcheck" onmouseover="setCursorByID('addcheck');" src="../images/add.png" width="16" height="16" />&nbsp;&nbsp;&nbsp;</td>
    <td width="176" align="left">Check #
    <input name="txtCheckNumber" type="text" id="txtCheckNumber" onkeypress="return alphaNumericOnly(event);" /></td>
    <td width="159" align="left">Bank:
    <select>
      <option>&lt;Select Bank&gt;</option>
    </select></td>
  </tr>
  <tr align="center">
    <td height="10" colspan="6"><hr align="center" /></td>
  </tr>
 <!--  <tr>
    <td align="center">3</td>
    <td><label id="tenders">
      <input name="tender" type="checkbox" value="Card" onclick="enableDisable();" />
    CARD</label></td>
    <td align="center"><label>
      Php
      <input name="txtCard" type="text" id="txtCard" style="width:73px;" onkeypress="return numbersOnly(event);" />
    </label></td>
    <td align="right"><img id="addcard" onmouseover="setCursorByID('addcard');" src="../images/add.png" width="16" height="16" />&nbsp;&nbsp;&nbsp;<label></label></td>
    <td colspan="2" align="left"><label>
    <input name="rdoOnlineOffline" type="radio" value="radiobutton" checked="checked" />
Online</label>
      &nbsp;&nbsp;&nbsp;
      <label>
      <input name="rdoOnlineOffline" type="radio" value="radiobutton" />
Offline</label></td>
  </tr>
  <tr align="center">
    <td height="10" colspan="6"><hr align="center" /></td>
  </tr>
  <tr>
    <td align="center">4</td>
    <td><input name="tender2" type="checkbox" value="Other" onclick="enableDisable();" />
    GIFT PASS / SODEXO </td>
    <td align="center">Php
    <input name="txtCard2" type="text" id="txtCard2" style="width:73px;" onkeypress="return numbersOnly(event);" /></td>
    <td align="right"><img id="addcard" onmouseover="setCursorByID('addcard');" src="../images/add.png" width="16" height="16" /></td>
    <td colspan="2" align="left">Reference  #
    <input name="txtReferenceNumber2" type="text" id="txtReferenceNumber2" onkeypress="return alphaNumericOnly(event);" /></td>
  </tr>
  <tr>
    <td colspan="6" align="center"><hr align="center" /></td>
  </tr>
  <tr>
    <td align="center">5</td>
    <td><label id="tenders">
      <input name="tender" type="checkbox" value="Other" onclick="enableDisable();" />
    OTHER</label></td>
    <td align="center"><label>
       Php
       <input name="txtOther" type="text" id="txtOther" style="width:73px;" onkeypress="return numbersOnly(event);" />
    </label></td>
    <td align="right"><img id="addother" onmouseover="setCursorByID('addother');" src="../images/add.png" width="16" height="16" />&nbsp;&nbsp;&nbsp;</td>
    <td align="left">Account  #
      <input name="txtReferenceNumber" type="text" id="txtReferenceNumber" onkeypress="return alphaNumericOnly(event);" />
    <br /><br /></td>
    <td align="left">Reference  #
    <input name="txtReferenceNumber3" type="text" id="txtReferenceNumber3" onkeypress="return alphaNumericOnly(event);" /></td>
  </tr>
  <tr>
    <td colspan="6" align="center"><hr align="center" /></td>
  </tr> -->
  
  <tr>
    <td colspan="6"><div align="right">
      <label>
      <input name="okButton" type="button" class="smallpagebutton" id="okButton" onclick="setPaymentInfo();" value="     OK     " />
      </label>
    </div></td>
  </tr>
</table>

