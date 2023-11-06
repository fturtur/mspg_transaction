<%@ taglib prefix="s" uri="/struts-tags" %>
<table width="680" height="50" border="0" cellpadding="0" cellspacing="0">
     <tr id="managerButtons">
       <td align="center" valign="middle" width="12.5%">
       		<input onclick="logout();" class="functionbutton" name="btnF5" type="button" id="logout" value="[F5]&#10;Sign Out" />
       		<input class="functionbutton" name="btnF7" type="button" id="cancelId" value="Cancel" onclick="closeTrx();" style="display: none;"/>
       </td>
       <td align="center" valign="middle" width="12.5%"><input onclick="showManagerFunctions();" class="functionbutton" name="btnF6" type="button" id="functions" value="[F6]&#10;Functions" /></td>
       <td align="center" valign="middle" width="12.5%">
	       	<input class="functionbutton" name="btnF7" type="button" id="suspendId" value="[F7]&#10;Suspend" onclick="showSuspendDiv();" style="display: none;"/>
	       	<input class="functionbutton" name="btnF7" type="button" id="resumeId" value="[F7]&#10;Resume" onclick="resumeTrx();" />
       </td>
       <td align="center" valign="middle" width="12.5%"><input onclick="cashierVoidTrx();" class="functionbutton" name="btnF8" type="button" id="btnF8" value="[F8]&#10;Void" /></td>
       <s:if test="'store cashier'.equalsIgnoreCase(#session.userVO.bpsUser.bpsRoles.roleName)">
       		<td align="center" valign="middle"><input onclick="pickup();" class="functionbutton" name="btnF9" type="button" id="btnF9" value="[F9]&#10;Pick-Up" /></td>
       </s:if>
       <td align="center" valign="middle" width="12.5%"><input onclick="precommit();" class="functionbutton" name="btnF10" type="button" id="btnF10" value="[F10]&#10;Pre-Comm" /></td>
       <td align="center" valign="middle" width="12.5%"><input onclick="smacInfo();" class="functionbutton" name="btnF11" type="button" id="btnF11" value="[F11]&#10;SMAC" /></td>
       <td align="center" valign="middle" width="12.5%"><input onclick="addPromotionsToBasket();showEnterCash();" class="functionbutton" name="btnF12" type="button" id="btnF12" value="[F12]&#10;Submit" /></td>
     </tr>
      <tr id="managerButtons1" style="display:none;">
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK223" type="button" id="btnOK223" value="[F6]&#10;Back" onclick="hideManagerFunctions();"/></td>
	    <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK224" type="button" id="btnOK224" value="Rebate" onclick=""/></td>
   	  	<td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK225" type="button" id="discountId" value="Discount" onclick="showManualDiscount();" /></td>
   	    <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK226" type="button" id="btnOK226" value="Item-Decl" onclick="showItemDeclaration();" /></td>
   	     <s:if test="'store cashier'.equalsIgnoreCase(#session.userVO.bpsUser.bpsRoles.roleName)">
       		<td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK22" type="button" id="btnOK22" value="Reprint" onclick="cashierReprintTrx();"/></td>
         </s:if>
         <s:else>
         	  <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK22" type="button" id="btnOK22" value="Reprint" onclick="reprintTrx();"/></td>  
         </s:else> 
        
        <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK3" type="button" id="btnOK3" value="Zero Rated" onclick="zeroRated();"/></td>
         <s:if test="'store cashier'.equalsIgnoreCase(#session.userVO.bpsUser.bpsRoles.roleName)">
       			   <td align="center" valign="middle" width="12.5%"><input class="functionbutton" name="btnOK3" type="button" id="btnOK3" value="Reconcile" onclick="saveTerminalReconciliation();"/></td>
         </s:if>
         <s:else>
         	 <td align="center" valign="middle" width="12.5%"><input class="functionbutton" type="button"  style="visibility: hidden" /></td>  
         </s:else> 
      </tr>
</table>