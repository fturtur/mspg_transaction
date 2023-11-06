<%@ taglib prefix="s" uri="/struts-tags" %>	
<table width="100%" border="0" cellspacing="0" cellpadding="1">
     <tr>
       <td width="150">
       	<label>
          <input id="searchText" type="text" name="textfield" style="width:110px"  /> <!-- onkeyup="disableFreeDetItem();autoComplete();" -->
          <img src="images/search.png" width="16" height="16" onclick="checkForFreeDetItem();autoComplete();"/>
          <input type="hidden" id="searchImg" value="N">
        </label>
    </td>
       <td rowspan="2" bgcolor="#CCCCCC">&nbsp;</td>
     </tr>
     <tr>
     	<td>
     		<div style="overflow-y: scroll;height: 300px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="1">
					<s:iterator value="categoriesVOs">
			     <tr>
			       <td align="left" valign="middle" width="160">
			       	<s:a href="javascript:getSkusByCategory('%{id}');" cssClass="categoryLink" ><img src="images/bullet.png"  class="categoryLink" width="16" height="16" border="0" /><s:property value="categoryName"/>  </s:a>
			       </td>
			       <!-- <td rowspan="1" bgcolor="#CCCCCC">&nbsp;</td> -->
			     </tr>
			    </s:iterator>
			
				<tr>
			
					<td align="left" valign="middle"><s:a href="javascript:getServiceTrx();" cssClass="categoryLink">
							<img src="images/bullet.png" width="16" height="16" border="0" class="categoryLink"/>Service Transaction </s:a>
					</td>
					<!-- <td rowspan="1" bgcolor="#CCCCCC">&nbsp;</td> -->
				</tr>
				</table>
			</div>
     	</td>
     </tr>
</table>
<script>
var timeoutId = 0;
$('#searchText').keyup(function () { 
    clearTimeout(timeoutId); // doesn't matter if it's 0
    timeoutId = setTimeout(functionsOnSearchText, 50);
});
</script>