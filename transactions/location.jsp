<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags" %>
<%@page import="java.util.List" %>
<script type="text/javascript" src="javascript/effect.js"></script>
<script src="javascript/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="javascript/jquery.hotkeys.js"></script>

<link href="css/main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
</script>
<s:head theme="simple"/>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
						align="center">
			<s:select id="location" theme="simple" headerKey="0" headerValue="--please select--"  list="paymentVO.bpsLocation" listKey="locationId" listValue="locationName" ></s:select>
								
</table>						