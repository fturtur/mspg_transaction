// JavaScript Document

var blnInitialized = true;
var intRowNumber = parseInt(window.parent.parent.document.getElementById('intRowNumber').title);

function numbersOnly(evt)
	{
	 var charCode = (evt.which) ? evt.which : event.keyCode
	 if (charCode > 31 && (charCode < 48 || charCode > 57))
		return false;
	 return true;
	}
	
function alphaNumericOnly(evt) 
	{
	var chCode = ('charCode' in evt) ? evt.charCode : event.keyCode;
	return (chCode < 32 || chCode > 47 && chCode < 58 || chCode > 64 && chCode < 91 ); 
	}

function changeIFrameSrc(frameName, htmlSrc) //changes src from parent
	{
	window.parent.document.getElementById(frameName).src = htmlSrc;
	}

function changeIFrameSrc2(frameName, htmlSrc) //changes src from parent's parent
	{
	window.parent.parent.document.getElementById(frameName).src = htmlSrc;
	}

function changeStatus(divID, strMessage)
	{
    window.parent.parent.document.getElementById(divID).innerHTML = strMessage;
	}

function deleteData() //deletes all data from table
	{
	if(blnInitialized == true)
		{
		var objTable = window.parent.parent.billsframe.document.getElementById("billspayment");
		var objTR = objTable.getElementsByTagName('tr');
		objTable.removeChild(objTR[0]);
		blnInitialized = false;
		}
	}

function populateData(strBillerName, strAccountNumber, strAmountDue, strServiceFee) //adds rows into table
	{
	var strBackground = String;
	var objTable = window.parent.parent.billsframe.document.getElementById("billspayment");
	var objTR = window.parent.parent.billsframe.document.createElement("tr");
	var objTD1 = window.parent.parent.billsframe.document.createElement("td");
	var objTD2 = window.parent.parent.billsframe.document.createElement("td");
	var objTD3 = window.parent.parent.billsframe.document.createElement("td");
	var objBillerName = window.parent.parent.billsframe.document.createElement("td");
	var objAccountNumber = window.parent.parent.billsframe.document.createElement("td");
	var objAmountDue = window.parent.parent.billsframe.document.createElement("td");
	var objServiceFee = window.parent.parent.billsframe.document.createElement("td");
	var objTotalDue = window.parent.parent.billsframe.document.createElement("td");
	var objTD7 = window.parent.parent.billsframe.document.createElement("td");
	var objPaymentType = window.parent.parent.billsframe.document.createElement("td");
//	var objBankOrType = window.parent.parent.billsframe.document.createElement("td");
//	var objReferenceNumber = window.parent.parent.billsframe.document.createElement("td");
	var objAmountPaid = window.parent.parent.billsframe.document.createElement("td");
//	var objBalance = window.parent.parent.billsframe.document.createElement("td");
	objTR.appendChild(objTD1);
	objTR.appendChild(objTD2);
	objTR.appendChild(objTD3);
	objTR.appendChild(objBillerName);
	objTR.appendChild(objAccountNumber);
	objTR.appendChild(objAmountDue);
	objTR.appendChild(objServiceFee);
	objTR.appendChild(objTotalDue);
	objTR.appendChild(objTD7);
	objTR.appendChild(objPaymentType);
//	objTR.appendChild(objBankOrType);
//	objTR.appendChild(objReferenceNumber);
	objTR.appendChild(objAmountPaid);
//	objTR.appendChild(objBalance);
	objTable.appendChild(objTR);
	objTR.setAttribute("valign", "middle");
	objTR.setAttribute("id", "row" + intRowNumber);
	objTR.setAttribute("linenumber", intRowNumber);
	objTR.setAttribute("onmouseover", "changeRowColor(\'row" + intRowNumber + "\');");
	objTR.setAttribute("onmouseout", "backToRowColor(\'row" + intRowNumber + "\');");
	if(intRowNumber % 2 == 1) //for alternating row background color
		{
		strBackground = "#FFFF99";
		}
	else
		{
		strBackground = "#FFFFCC";
		}	
	objTR.setAttribute("style", "background:" + strBackground + ";");
	objTD1.setAttribute("bordercolor", "#FFFFFF");
	objTD2.setAttribute("bordercolor", "#FFFFFF");
//	objTD3.setAttribute("bordercolor", "#FFFFFF");
	objTD7.setAttribute("bordercolor", "#FFFFFF");
	objPaymentType.setAttribute("id", "objPaymentType" + intRowNumber);
	objAmountPaid.setAttribute("id", "objAmountPaid" + intRowNumber);
	objTotalDue.setAttribute("id", "objTotalDue" + intRowNumber);
//	objBalance.setAttribute("id", "objBalance" + intRowNumber);
	setData(objTD1, 15, "<img id=\"editbiller" + intRowNumber + "\" src=\"../images/edit.png\" width=\"12px\" height=\"12px\" onclick=\"window.parent.parent.document.getElementById('billers').src=\'pages/billerpagemeralco.html\';\" onmouseover=\"setCursorByID('editbiller" + intRowNumber + "')\" />", "center");
	setData(objTD2, 15, "<img id=\"deletebiller" + intRowNumber + "\" src=\"../images/delete.png\" width=\"12px\" height=\"12px\" onclick=\'deleteRow(" + intRowNumber + ");\' onmouseover=\"setCursorByID('deletebiller" + intRowNumber + "')\" />", "center");
	setData(objTD3, 20, (intRowNumber + 1), "center");
	setData(objBillerName, 150, strBillerName, "center");
	setData(objAccountNumber, 200, strAccountNumber, "left");
	setData(objAmountDue, 115, changeAmountView(strAmountDue), "right");
	setData(objServiceFee, 80, changeAmountView(strServiceFee), "right");
	setData(objTotalDue, 115, changeAmountView((parseInt(strAmountDue) + parseInt(strServiceFee)).toString()), "right");
	setData(objTD7, 15, "<img id=\"edittender" + intRowNumber + "\" src=\"../images/edit.png\" width=\"12px\" height=\"12px\" onclick=\"processTender(\'row" + intRowNumber + "\')\" onmouseover=\"setCursorByID('edittender" + intRowNumber + "')\" />", "center");
	setData(objPaymentType, 115, "&nbsp;", "center");
//	setData(objBankOrType, 100, "<input name=\"text" + intRowNumber + "\" type=\"text\" id=\"text" + intRowNumber + "\" style=\"width:93px\" />", "right");
//	setData(objReferenceNumber, 150, "<input name=\"text" + intRowNumber + " type=\"text\" id=\"text" + intRowNumber + "\" style=\"width:143px\" />", "right");
//	setData(objAmountPaid, 80, "<input name=\"text" + intRowNumber + " type=\"text\" id=\"text" + intRowNumber + "\" style=\"width:73px\" />", "right");
//	setData(objBalance, 80, "<input name=\"text" + intRowNumber + " type=\"text\" id=\"text" + intRowNumber + "\" style=\"width:73px\" />", "right");
	setData(objAmountPaid, 115, "&nbsp;", "right");
//	setData(objBalance, 100, "&nbsp;", "right");
//	alert(document.getElementById("row" + intRowNumber).style.background);
//	alert(window.parent.parent.billsframe.document.all.billspayment.row0.id);
	window.parent.parent.document.all.showtender.currentrow = intRowNumber; //keep current line number
	window.parent.parent.document.all.showtender.endrow = intRowNumber; //keep last row
	intRowNumber++;
	window.parent.parent.document.getElementById('intRowNumber').title = intRowNumber;
	
	}

function setData(objObject, intPixels, strInnerHTML, strAlign)
	{
	objObject.setAttribute("width", intPixels + "px;");
//	objObject.setAttribute("id", "tabledata");
	objObject.setAttribute("align", strAlign);
	objObject.innerHTML = "<div style=\'font-family:Arial, Helvetica, sans-serif;font-size:12px;font-weight:normal;\'>" + strInnerHTML + "</div>";
	}

function processTender(strRowName)
	{
	var intLineNumber = document.getElementById(strRowName).linenumber;
	window.parent.parent.document.all.showtender.currentline = intLineNumber;
//	alert(window.parent.parent.document.all.showtender.currentline);
	window.parent.parent.document.all.billers.src = "pages/tenders.html";
	}

function initializeStatus()
	{
    window.parent.parent.document.getElementById('status').innerHTML = "";
	}
	
function checkBillerIfComplete(strAccountNumber, strAmountDue)
	{
	if(strAccountNumber == "")
		{
		window.document.getElementById('messages').innerHTML = "Please complete all details";
		}
	}
	
function display(strMessage)
	{
	window.parent.parent.document.getElementById('details').innerHTML = strMessage;
	}
	
function getBillerName(strID)
	{
	return window.parent.parent.document.getElementById(strID).billername;
	}
	
function getServiceFee(strID)
	{
	return window.parent.parent.document.getElementById(strID).servicefee;
	}

function getGrandTotal(strID)
	{
	return window.parent.parent.document.getElementById(strID).totalvalue;
	}

function checkFieldLength(objName, intLength)
	{
	if (window.document.all.objName.value.length < intLength)
		{
		alert("Please enter correct detail.");
		return false;
		}
	}
	
function changeAmountView(strAmount)
	{
	if(strAmount.length == 3)
		strAmount = "P" + strAmount.substr(0,1) + "." + strAmount.substr(1,2);
	else if(strAmount.length == 2)
		strAmount = "P0." + strAmount;
	else if(strAmount.length == 1)
		strAmount = "P0.0" + strAmount;
	else
		strAmount = "P" + strAmount.substr(0,(strAmount.length - 2)) + "." + strAmount.substr((strAmount.length - 2), strAmount.length);
	return strAmount;
	}
	
function fromStringToNumber(strString)
	{
	var strTemp = "";
	var blnTemp = false;
	for(var i = 0; i < strString.length; i++)
		{
		if(strString.substr(i,1) == ">")
			blnTemp = true;
		if(blnTemp == true)
			{
			if(isNaN(strString.substr(i,1)) == false)
				{
				strTemp = strTemp + strString.substr(i,1);
				}
			}
		}
	return strTemp;
	}

function showTotal(strCard, strCheck, strOther, strCash) //show total at right panel
	{
	var strShowCard = "";
	var strShowCheck = "";
	var strShowOther = "";
	var strShowCash = "";
	var blnShowHeader = false;
	var strShowHeader = "";
	if(window.parent.parent.document.all.showtender.card == 1)
		{
		blnShowHeader = true;
		strShowCard = "<tr><td>CARD:</td><td align=\'center\'>0</td><td align=\'right\'>" + changeAmountView(strCard) + "</td></tr>";
		}
	if(window.parent.parent.document.all.showtender.check == 1)
		{
		blnShowHeader = true;
		strShowCheck = "<tr><td>CHECK:</td><td align=\'center\'>0</td><td align=\'right\'>" + changeAmountView(strCheck) + "</td></tr>";
		}
	if(window.parent.parent.document.all.showtender.other == 1)
		{
		blnShowHeader = true;
		strShowOther = "<tr><td>OTHER:</td><td align=\'center\'>0</td><td align=\'right\'>" + changeAmountView(strOther) + "</td></tr>";
		}
	if(window.parent.parent.document.all.showtender.cash == 1)
		strShowCash = "<tr><td colspan=\'2\'>CASH:</td><td align=\'right\'>" + changeAmountView(strCash) + "</td></tr>";
	if(blnShowHeader == true)
		strShowHeader = "<tr><td>&nbsp;</td><td align=\'center\'>Qty</td><td align=\'center\'>Amount</td></tr><tr><td colspan=\'3\'><hr /></td></tr>";
//	var intCombined = parseInt(strCash) + parseInt(strCheck) + parseInt(strCard) + parseInt(strOther);
	var intTotal = 0;
	for(var i = 0; i <= window.parent.document.all.showtender.endrow; i++)
		{
		intTotal += parseInt(fromStringToNumber(window.parent.billsframe.document.getElementById('objTotalDue' + i).innerHTML));
		}
	var intBalance = 0;
	for(var i = 0; i <= window.parent.document.all.showtender.endrow; i++)
		{
		intBalance += parseInt(fromStringToNumber(window.parent.billsframe.document.getElementById('objAmountPaid' + i).innerHTML));
		}
	intBalance = intTotal - intBalance;
//	alert(intBalance.toString());
//	var intTotal = parseInt(window.parent.parent.document.all.total.totalvalue) + intCombined;
//	var intBalance = intTotal - intCombined;
	display("<strong><table width=\'100%\' height=\'100%\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\'>" + strShowHeader + strShowCard + strShowCheck + strShowOther + strShowCash + "<tr><td colspan=\'2\'><font color=\'red\'>BALANCE:</font></td><td align=\'right\'><font color=\'red\'>" + changeAmountView(intBalance.toString()) + "</font></td></tr><tr><td colspan=\'3\'><hr /></td></tr></table><table width=\'100%\' height=\'100%\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\'><tr><font size=\'+1\'><td>TOTAL AMOUNT:</td><td align=\'right\'>" + changeAmountView(intTotal.toString()) + "</td></font></tr></table></strong>");
	window.parent.parent.document.all.total.totalvalue = intTotal.toString();
	window.parent.parent.document.all.total.card = (parseInt(window.parent.parent.document.all.total.card) + parseInt(strCard)).toString();
	window.parent.parent.document.all.total.check = (parseInt(window.parent.parent.document.all.total.check) + parseInt(strCheck)).toString();
	window.parent.parent.document.all.total.cash = (parseInt(window.parent.parent.document.all.total.cash) + parseInt(strCash)).toString();
	window.parent.parent.document.all.total.other = (parseInt(window.parent.parent.document.all.total.other) + parseInt(strOther)).toString();
	}
	
function deleteRow(intLineNumber)
	{
	if(confirm("Are you sure you want to delete this line?"))
		{
		var objTable = window.parent.billsframe.document.getElementById("billspayment");
		var objTR = objTable.getElementsByTagName('tr');
		objTable.removeChild(objTR[parseInt(intLineNumber)]);
		showTotal(0, 0, 0, 0);
		}
	}

// EFFECTS	

function setCursorByID(strID) //change mouse cursor on mouse over
	{
	window.document.getElementById(strID).style.cursor = "pointer";
	}