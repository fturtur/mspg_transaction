var allowedOperations='';
var itemDeclarationCompleted='';
var inPcsTerminal='';
var applicationType='';
var isBpsBusinessTime='';
var bpsBusinessStartTime='';
var bpsBusinessCutoffTime='';
var flag=false;
var itemDecl=false;
$(document).ready(function() {
	isTerminalOnline();
	var ccInterval = $('#connectivityCheckInterval').val();
	if (ccInterval == '')
		ccInterval = 1;
	
	ccInterval = (ccInterval * 60 * 1000);
	setInterval(isTerminalOnline, ccInterval);
	getUpdateNum();
	setInterval(isCheckPickupTime, 60000);
	resetPassword();
	setInterval(validateCashTreshold, 2000);
	setInterval(getUpdateNum, 300000);
	checkDetails();
	GetCurrentDateAndTime();
	setInterval(GetCurrentDateAndTime, 20000);
	$(document).bind("contextmenu",function(e){
		alert("Right click not allowed");
        return false;
	});
	$('#searchText').focus();
});

/*function GetCurrentDateAndTime() // good
{
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	var hour = currentTime.getHours();
	var minute = currentTime.getMinutes();
	var AMPM = String;
	if (hour < 13) {
		AMPM = "AM";
	} else {
		hour = hour - 12;
		AMPM = "PM";
	}
	document.write(IntToStr(month) + "/" + IntToStr(day) + "/" + year + " "
			+ IntToStr(hour) + ":" + IntToStr(minute) + " " + AMPM);
}*/

// Compare 1st and 2nd Barcode //
function checkSecondBarcode(obj){
	var bar2 = obj.value;
	var gcItem=postTag;
	if(isNaN(bar2)){
		alert('Please enter Second barcode');
		return false;	
	}
	var bar1 = $('#barCode').val();
	if(bar1==bar2){
		$('#secondBarcodeError').show();
		$('#secondBarcodeError').html("Invalid second barcode! <br> Same with the item barcode!");
		//$('#secondBarcode').val('');
		$('#secondBarcode').focus();
		return false;
	}else{
		if(gcItem==1){
			if(bar2.length >= 13){
				var prf1=bar1.substring(0,2);
				var prf2=bar2.substring(0,2);
				if(prf1==prf2){
					$('#secondBarcodeError').show();
					$('#secondBarcodeError').html("Invalid GC Card Number! <br> Please enter valid barcode!");
					$('#secondBarcode').focus();
					return false;
				}else {
					//if(['22'].indexOf(prf2) <= 0){
					if(prf1!='21'){
						$('#secondBarcodeError').show();
						$('#secondBarcodeError').html("Invalid Item Barcode! <br> Item Barcode should be 2186!");
						$('#secondBarcode').focus();
						return false;
					}
					
					if(prf2!='22'){
						$('#secondBarcodeError').show();
						$('#secondBarcodeError').html("Invalid GC Card Number! <br> Please enter valid barcode!");
						$('#secondBarcode').focus();
						return false;
					}
					
				}
			}
		}
		
	}
	setSecondBarcode(obj);
}


function GetCurrentDateAndTime() //good
{
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	var hour = currentTime.getHours();
	var minute = currentTime.getMinutes();
	var AMPM = "AM";
	var h = hour;

	if (h >= 12) {
		h = hour-12;
		AMPM = "PM";
	}
	if (h == 0) {
		h = 12;
	}

	$('#terminalTime').html(IntToStr(month) + "/" + IntToStr(day) + "/" + year + " " + 	IntToStr(h) + ":" + IntToStr(minute) + " " + AMPM);
}

function GetCurrentTime24() //good
{
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	var hour = currentTime.getHours();
	var minute = currentTime.getMinutes();
	var second = currentTime.getMinutes();
	
	var currTime = IntToStr(month) + "/" + IntToStr(day) + "/" + year + " " + IntToStr(hour) + ":" + IntToStr(minute) + ":" + IntToStr(second);
	
	return currTime;
}


function IntToStr(intInteger) // good
{
	var strString = String;
	strString = intInteger.toString();
	if (strString.length > 1) {
		strString = intInteger;
	} else {
		strString = "0" + intInteger;
	}
	return (strString);
}

function isTerminalOnline() {
	$.ajax({
		type : "POST",
		url : "terminalConnected.action",
		data : "",
		dataType : "json",
		async : true,
		success : function(data) {
			// alert(data.task);
			if (data.task == 'success') {
				$('.onLineDiv').show();
				$('.offLineDiv').hide();
				$('#terminalStatus').val('online');

				$('#cashDeclarationCompleted').val(
						data.cashDeclarationCompleted);
				confirmCashAmount();

			} else if (data.task == 'failed') {
				$('.onLineDiv').hide();
				$('.offLineDiv').show();
				$('#terminalStatus').val('offline');
				if(inPcsTerminal!='' && inPcsTerminal=='Y'){
					if(allowedOperations!=null && (allowedOperations=='BOTH' || allowedOperations=='PCS' )){
						if(itemDeclarationCompleted=='false' && itemDecl==false){
							itemDecl=true;
							showItemDeclaration();
						}
					}
				}
				if($('#cashDeclarationCompleted').val() == 'false'){
					
					$('#checkPickupAni').show();
					$('#checkPickup').hide();
				}
			}
		},
		error : function(xhr, msg, e) {
			// alert(e);
		}
	});
}

function getUpdateNum() {

	$.ajax({
		type : "POST",
		url : "updateNum.action",
		dataType : "text",
		async : true,
		success : function(data) {
			$('#updateNum').html("Update#" + data);
		},
		error : function(xhr, msg, e) {
			// alert(e);
		}
	});

}


$(document).ajaxComplete(
		function(event, xhr, options) {
			if (options.dataType == 'text') {
				var data = $.httpData(xhr, options.dataType);
				var loginPage = $(data).find('#loginPage');

				if (typeof $(loginPage).val() != 'undefined'
						&& $(loginPage).val() == 'true') {

					$('#billerTranForm').attr('action', 'logout.action');
					$('#billerTranForm').submit();
				}
			}
		});
function checkDetails() {
	var qty = $('#trxCheckQty').val();
	var amt = $('#trxCheckAmt').val();

	if (qty != '')
		$('#pCheckQty').html(qty);

	if (amt != '')
		$('#pCheckAmt').html(amt);
}

function confirmCashAmount() {

	var cashDeclarationCompleted = $('#cashDeclarationCompleted').val();
	var terminalOnlineStatus = $('#terminalOnlineStatus').val();
	if (terminalOnlineStatus != null && terminalOnlineStatus == 'Offline') {
		$('.onLineDiv').hide();
		$('.offLineDiv').show();
		$('#terminalStatus').val('offline');
		$('#checkPickupAni').show();
		$('#checkPickup').hide();
	}
	if (cashDeclarationCompleted == 'false') {

		var w = $(window);
		$('#bpsMask').show();
		$('#confirmCashDiv').show();
		$('#confirmCashDiv')
				.css(
						'top',
						Math.abs(((w.height() - $('#confirmCashDiv')
								.outerHeight()) / 2)
								+ w.scrollTop()));
		$('#confirmCashDiv').css(
				'left',
				Math.abs(((w.width() - $('#confirmCashDiv').outerWidth()) / 2)
						+ w.scrollLeft()));

	} else if (cashDeclarationCompleted != null && terminalOnlineStatus != null
			&& cashDeclarationCompleted == 'true'
			&& terminalOnlineStatus == 'Offline-Existing') {
		$('.onLineDiv').hide();
		$('.offLineDiv').show();
		$('#terminalStatus').val('offline');	
		$('#checkPickupAni').hide();
		$('#checkPickup').show();
		if(inPcsTerminal!='' && inPcsTerminal=='Y'){
			if(allowedOperations!=null && (allowedOperations=='BOTH' || allowedOperations=='PCS' )){
				if(itemDeclarationCompleted=='false' && itemDecl==false){
					itemDecl=true;
					showItemDeclaration();
				}
			}
		}
	} else if (cashDeclarationCompleted != null && terminalOnlineStatus != null
			&& cashDeclarationCompleted == 'true'
			&& terminalOnlineStatus == 'Online') {
		$('#checkPickupAni').hide();
		$('#checkPickup').show();
		if(inPcsTerminal!='' && inPcsTerminal=='Y'){
			if(allowedOperations!=null && (allowedOperations=='BOTH' || allowedOperations=='PCS' )){
				if(itemDeclarationCompleted=='false' && itemDecl==false){
					itemDecl=true;
					showItemDeclaration();
				}
			}
		}
	}

}
function saveConfirmCash() {

	$('#confirmCashDiv').hide();

	$.ajax({
		type : "POST",
		url : "confirmCashAmount.action",
		data : "",
		dataType : "text",
		async : true,
		success : function(data) {
			$('#bpsMask').hide();
			$('#confirmCashDiv').hide();
			$('#msgId').html('Cash confirmed successfully..');
			$('#cashDeclarationCompleted').val('true');
			$('#checkPickupAni').hide();
			$('#checkPickup').show();
			if(inPcsTerminal!='' && inPcsTerminal=='Y'){
				if(allowedOperations!=null && (allowedOperations=='BOTH' || allowedOperations=='PCS' )){
					if(itemDeclarationCompleted=='false' && itemDecl==false){
						itemDecl=true;
						showItemDeclaration();
					}
				}
			}
		},
		error : function(xhr, msg, e) {
			$('.onLineDiv').hide();
			$('.offLineDiv').show();
			$('#terminalStatus').val('offline');
		}
	});
}
function validateCashTreshold() {

	var cashInHand = parseInt($('#cashInhand').val());
	var collectionTreshold = parseInt($('#collectionTreshold').val());
	if (cashInHand > collectionTreshold) {
		$('#cashPickup').hide();
		$('#cashPickupAni').show();
	} else {
		$('#cashPickup').show();
		$('#cashPickupAni').hide();
	}
}
function resetPassword() {

	var resetPassword = $('#resetPassword').val();
	if (resetPassword == '1') {
		$('#bpsMask').show();
		var w = $(window);
		$('#resetPasswordDiv').show();
		$('#resetPasswordDiv').css(
				'top',
				Math
						.abs(((w.height() - $('#resetPasswordDiv')
								.outerHeight()) / 2)
								+ w.scrollTop()));
		$('#resetPasswordDiv')
				.css(
						'left',
						Math.abs(((w.width() - $('#resetPasswordDiv')
								.outerWidth()) / 2)
								+ w.scrollLeft()));
	}
}
function validateLogin() {

	var invalid = " "; // Invalid character is a space
	var minLength = 7; // Minimum length
	var maxLength = 12;
	var newPassword = "";
	var confirmPassword = "";

	newPassword = document.getElementById('newPwd').value;
	confirmPassword = document.getElementById('confirmPwd').value;

	var flag = false;
	if (newPassword == null || confirmPassword == null || newPassword == ""
			|| confirmPassword == "") {
		alert("newPassword/confirmPassword is empty");
		return flag;
	}
	if (newPassword.length < 7 || newPassword.length > 12) {
		alert("Password must be between " + minLength + " and " + maxLength);
		// newPassword.focus();
		$('#newPwd').focus();
		return flag;
	}
	if (newPassword != confirmPassword) {
		alert("newPassword and confirmPassword is not match");
		// newPassword.focus();
		$('#newPwd').focus();
		return flag;
	}
	if (newPassword.indexOf(invalid) > -1) {
		alert("Sorry, spaces are not allowed.");
		// newPassword.focus();
		$('#newPwd').focus();
		return flag;
	}

	var intRegex = /^\d+$/;
	var alphaNumeric = /^[0-9a-zA-Z]+$/;
	if (newPassword.match(/^[a-zA-Z]+$/)) {
		alert("Password contains only alphabets. Password must contain\n both numeric and alphabetic characters. \n");
		$('#newPwd').focus();
		return flag;
	}
	if (intRegex.test(newPassword)) {
		alert("Password contains only numbers. Password must contain\n both numeric and alphabetic characters. \n");
		$('#newPwd').focus();
		return flag;
	}
	if (!alphaNumeric.test(newPassword)) {
		alert("Password must contain both numeric and alphabetic characters. \n Special characters not allowed.\n");
		$('#newPwd').focus();
		return flag;
	}

	else {
		$.ajax({
			type : "POST",
			url : "resetPwd.action",
			data : 'newPassword=' + newPassword,
			dataType : "json",
			async : true,
			success : function(data) {
				if (data.task == 'success') {

					if ($('#cashDeclarationCompleted').val() == 'true') {
						$('#bpsMask').hide();
					}else if(allowedOperations!=null && (allowedOperations=='BOTH' || allowedOperations=='PCS' ) 
							&& applicationType!=null && applicationType=='PCS'){
						$('#bpsMask').hide();
					}
					$('#resetPasswordDiv').hide();
					$('#msgId').html('Password changed successfully..');
					$('#resetPassword').val('0');
				} else if (data.task == 'Failed') {

					$('#loginErrorMsg').show();
					$('#loginErrorMsg').html(data.message);
				}
			},
			error : function(xhr, msg, e) {
				// alert(e);
			}
		});
	}
	if (flag) {
		clear();
	}
}
function clear() {

	document.getElementById('newPwd').value = "";
	document.getElementById('confirmPwd').value = "";
	document.getElementById('oldPwd').focus();

}
function isCheckPickupTime() {

	var ccInterval = $('#checkPickupInterval_1').val();
	var currentDate;
	var spCCInterval = ccInterval.split(':');
	if (spCCInterval.length > 0) {

		currentDate = new Date();
		if (currentDate.getHours() >= spCCInterval[0]
				&& currentDate.getMinutes() >= spCCInterval[1]
				&& $('#checkPickupInterval_1_check').val() == '') {
			$('#cashPickup').hide();
			$('#cashPickupAni').show();
			// $('#checkPickupInterval_1_check').val('completed');
			return;
		}
	}
	ccInterval = $('#checkPickupInterval_2').val();
	spCCInterval = ccInterval.split(':');
	if (spCCInterval.length > 0) {
		currentDate = new Date();
		if (currentDate.getHours() >= spCCInterval[0]
				&& currentDate.getMinutes() >= spCCInterval[1]
				&& $('#checkPickupInterval_2_check').val() == '') {
			$('#cashPickup').hide();
			$('#cashPickupAni').show();
			// $('#checkPickupInterval_2_check').val('completed');
		}
	}
}

function numbersOnly(evt) {

	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode > 31 && (charCode < 48 || charCode > 57))
		return false;

	return true;
}
function numbersOnlyWithf12(evt) {

	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode == 123) {
		return true;
	}
	if (charCode > 31 && (charCode < 48 || charCode > 57))
		return false;

	return true;
}

function logout(){	
	 var flag = confirm("Are you sure want to sign out?");

	 if(flag){	
		 windowOnBeforeUnload();
		//$('#billerTranForm').attr('action','logout.action');
		//$('#billerTranForm').submit();
		 document.location.href="logout.action";		 
	 }
}

function navigateToHomePage(){	
	 var flag = confirm("Are you sure you want to leave this page?");
	 if(flag){		
		 document.location.href="csaBulletin.action";
		 return true;
	 }else{
		 return false;
	 }
	 
}

function navigateToBPS(){
	/*var isBusinessFlag=false;
	var currentTime = GetCurrentTime24();
	var bpsBusinessStartDateTime=currentTime.split(' ')[0]+" "+bpsBusinessStartTime;
	var bpsBusinessEndDateTime=currentTime.split(' ')[0]+" "+bpsBusinessCutoffTime;
	var currentDate=new Date(currentTime);
	var bpsBusinessStartDate=new Date(bpsBusinessStartDateTime);
	var bpsBusinessEndDate=new Date(bpsBusinessEndDateTime);
	if(Date.parse(bpsBusinessStartDate) <= Date.parse(currentDate) 
			&& Date.parse(currentDate)<Date.parse(bpsBusinessEndDate)){
		isBusinessFlag=true;
	}
	if(isBusinessFlag){*/
		 var flag = confirm("Are you sure you want to leave this page?");
		 if(flag){		
			 document.location.href="initTransactionPage.action";		 
			 return true;
		 }
	/*}else{
		alert('Business hours are between '+bpsBusinessStartTime+' hrs and '+bpsBusinessCutoffTime+' hrs');
		return false;
	}*/
		 return false;
}

function navigateToBPSItemDecl(){
	/*var isBusinessFlag=false;
	var currentTime = GetCurrentTime24();
	var bpsBusinessStartDateTime=currentTime.split(' ')[0]+" "+bpsBusinessStartTime;
	var bpsBusinessEndDateTime=currentTime.split(' ')[0]+" "+bpsBusinessCutoffTime;
	var currentDate=new Date(currentTime);
	var bpsBusinessStartDate=new Date(bpsBusinessStartDateTime);
	var bpsBusinessEndDate=new Date(bpsBusinessEndDateTime);
	if(Date.parse(bpsBusinessStartDate) <= Date.parse(currentDate) 
			&& Date.parse(currentDate)<Date.parse(bpsBusinessEndDate)){
		isBusinessFlag=true;
	}
	if(isBusinessFlag){	*/	
			 document.location.href="initTransactionPage.action";		 
	/*}else{
		alert('Business hours are between '+bpsBusinessStartTime+' hrs and '+bpsBusinessCutoffTime+' hrs');
		logout();
	}*/
}

function navigateBPS(){
	/*var isBusinessFlag=false;
	var currentTime = GetCurrentTime24();
	var bpsBusinessStartDateTime=currentTime.split(' ')[0]+" "+bpsBusinessStartTime;
	var bpsBusinessEndDateTime=currentTime.split(' ')[0]+" "+bpsBusinessCutoffTime;
	var currentDate=new Date(currentTime);
	var bpsBusinessStartDate=new Date(bpsBusinessStartDateTime);
	var bpsBusinessEndDate=new Date(bpsBusinessEndDateTime);
	if(Date.parse(bpsBusinessStartDate) <= Date.parse(currentDate) 
			&& Date.parse(currentDate)<Date.parse(bpsBusinessEndDate)){
		isBusinessFlag=true;
	}
	
	if(isBusinessFlag){*/
	windowOnLoad();
		document.location.href="initTransactionPage.action";
	/*}else{
		alert('Business hours are between '+bpsBusinessStartTime+' hrs and '+bpsBusinessCutoffTime+' hrs');
		return false;
	}*/
}

function navigateToPCS(){	
	 var flag = confirm("Are you sure you want to leave this page?");
	 if(flag){		
		 document.location.href="initPcsTransactionPage.action";		 
	 }
}

function AllowOnlyDigits( eEvent ){
	if ( eEvent.keyCode > 47 && eEvent.keyCode < 58 )
		return true;
	else 
		return false;
}

function currencyFormatSM(obj){
	var amt= obj.value;
	if(isNaN(amt.replace(/,/gi, ""))){
		alert('Please enter valid amount');
		return false;	
	}
	amt= amt.toString().replace(/,/gi, "");
	amt= amt.toString().replace(".", "");
	
	var tempAmt = amt.substr(amt.length-2);
	amt = amt.substr(0, amt.length-2);
	var num =Number(amt);
	
	
	sign = (num == (num = Math.abs(num)));
	num = Math.floor(num * 100 + 0.50000000001);
	cents = num % 100;
	num = Math.floor(num / 100).toString();
	for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
		num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
	result= (((sign) ? '' : '-') + num + '.' + tempAmt);
		
	obj.value = result;
	
}
 function FormatCurrency(num) {
	 num = num.toString().replace(/\$|\,/g, '');
	 if (isNaN(num)) num = "0";
	 sign = (num == (num = Math.abs(num)));
	 num = Math.floor(num * 100 + 0.50000000001);
	 cents = num % 100;
	 num = Math.floor(num / 100).toString();
	 if (cents < 10) cents = "0" + cents;
	 for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
	 num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
	 return (((sign) ? '' : '-') + 'P' + num + '.' + cents);
}
 
 function closeTrx(){
	 location.reload(true);
 }
 
 function calcPickUpAmt(amt, obj, tdId){
	 if(isNaN($(obj).val())){
		 alert('Please enter valid quantity');
		 $(obj).focus();
		 return false;
	 }
	 var calAmt = amt * $(obj).val();
	 calAmt = calAmt.toFixed(2);
	 $('#'+tdId).html('Php '+calAmt);
 }
 
 
 function pickup(){
	 if($("#trxLineItems").find("tr").size() == 0 && $("#billerTable").find("tr").size() == 0){
		 $('#msgId').html('');
		 if($('#userType').val() == 'STORE CASHIER'){
			 $('#loginDiv').find('#failureMsg').html('');
			 $('#loginDiv').find('#mgrNum').val('');
			 $('#mgrPassword').val('');
			 $('#bpsMask').show();
			 $('#loginDiv').show();
			 var w = $(window);
			 $('#loginDiv').css('top',Math.abs(((w.height() - $('#loginDiv').outerHeight()) / 2) + w.scrollTop()));
			 $('#loginDiv').css('left',Math.abs(((w.width() - $('#loginDiv').outerWidth()) / 2) + w.scrollLeft()));
			 $('#mgrLoginInvokedFrom').val('pickup');
			 return ;
			 
		 }else if($('#userType').val() == 'STORE MANAGER' || $('#userType').val() =='HO MANAGER'){
			 var cashInHand = parseInt($('#cashInhand').val());
			 var collectionTreshold = parseInt($('#collectionTreshold').val());
		   	 var count = newIsCheckPickUpActive();
		   	 if((cashInHand > collectionTreshold) || parseInt(count)>0)
			 {
		   		 $('#commonArea').find('#cashpickupDiv').show();
				 if (cashInHand < collectionTreshold)
				 {
					 $('#ccHeadersDiv').hide();
				 }
		     }
		   	 else
		   		alert('Threshold limit has not reached - pickup()');
			    hideDivForPickups();
		 }
		hideDivForPickups(); 
	}else{
		alert('Pickup is not allowed while transaction is in process.');
	}
	 
 }
 
//adding code for new pickup functionality - start
 function newIsCheckPickUpActive(){	 
	 var count = 0;
	 var chkInterval_1 = $('#checkPickupInterval_1').val(); 
	 var chkInterval_2 = $('#checkPickupInterval_2').val(); 
	 var currentDate;
	 
	 currentDate = new Date();
	 
	 var  checkInterval_1 = chkInterval_1.split(':');
	 var  checkInterval_2 = chkInterval_2.split(':');
	 if((currentDate.getHours() >= checkInterval_1[0] ) && (currentDate.getMinutes() >= checkInterval_1[1]) && 
			 ($('#pickupCount').val() != 1) && (currentDate.getHours() < checkInterval_2[0] )) {
		 count = 1;
		 
	 }else if((currentDate.getHours() >= checkInterval_2[0] ) && (currentDate.getMinutes() >= checkInterval_2[1]) && 
			  ($('#pickupCount').val() != 2)){
		 count = 2;
	 }
	 return count;
 }
 
 function newPickUpActivity(){ 
	 var cashInHand = parseInt($('#cashInhand').val());
	 var collectionTreshold = parseInt($('#collectionTreshold').val());
	 var count = newIsCheckPickUpActive();
	 
	 //alert(cashInHand);
	 //alert(collectionTreshold);
	 //alert(count);
	 
	 $('#commonArea').html($('#cashpickupDiv').html());

	 if( (cashInHand > collectionTreshold)  && (parseInt(count) > 0) ){	
		 openCloseDivs('pickup');
		 $('#cashDetailsDiv').show();
		 $('#checkDetailsDiv').show();
		
	 }else if( (cashInHand > collectionTreshold)  && (parseInt(count) == 0) ){
		 openCloseDivs('pickup');
		 $('#cashDetailsDiv').show();
		 $('#checkDetailsDiv').hide();
			
	 }else  if( (cashInHand < collectionTreshold)  && (parseInt(count) > 0) ){
		 openCloseDivs('pickup');
		 $('#checkDetailsDiv').show();

	 }else{
		 openCloseDivs('pickup');
	 }
	 return count;
 }
//adding code for new pickup functionality - end
 
 function managerLogin(){
	 	
	 	if($('#mgrNum').val() == '' || $('#mgrNum').val() == 'null'){
	 		alert('Please provide manager username');
	 		$('#mgrNum').focus();
	 		return ;
	 	}
	 	if($('#mgrPassword').val() == '' || $('#mgrPassword').val() == 'null'){
	 		alert('Please provide manager password');
	 		$('#mgrPassword').focus();
	 		return ;
	 	}
		 $.ajax({
				type: "POST",  
				url: "managerLogin.action",
				data: "managerNum="+$('#mgrNum').val()+"&managerPassword="+$('#mgrPassword').val(),					 
				dataType: "json",
				cache:false,
				async:true,
				success: function(data) {
					
					if('success' == data.task){
						$('#billers').hide();
				   	    $('#commonArea').show();
				   	    $('#mgrId').val(data.mgrId);
				   	    $('#mgrPassword').val('');
				   	    $('#mgrNum').val('');
				   	    if($('#mgrLoginInvokedFrom').val() == 'pickup'){
				   	    	
				   		 // adding code for new pickup functionality -start
				   	     var count = newPickUpActivity();
				   	     if(parseInt(count)>0){
							 if (parseInt(data.checkQty) != 0)
							 {
								$('#checkQty').html(data.checkQty);
								$('#checkAmt').html(data.checkAmt);
							 } else {
								$('#checkQty').html('');
								$('#checkAmt').html('');
								$('#checkDetailsDiv').hide();
							 }
				   	     }
				   		// adding code for new pickup functionality - end

				   	     
				   	    }else if($('#mgrLoginInvokedFrom').val() == 'precommit'){
				   	    	
				   	    	$('#pCheckQty').html(data.checkQty);
					   	    $('#pCheckAmt').html(data.checkAmt);
				   	    	$('#commonArea').html($('#precomitDiv').html());
				   	    	
				   	    }else if($('#mgrLoginInvokedFrom').val() == 'voidTrxDiv'){
				   	    	
				   	    	$('#commonArea').html($('#voidTrxDiv').html());
				   	    	
				   	    }else if($('#mgrLoginInvokedFrom').val() =='reprint'){
				   	    	reprintTrx();
				   	    	
				   	    }
				   	    
				   	    $('#mgrLoginInvokedFrom').val('');
						closeMgrLogin();
						$('#userType').val('STORE CASHIER');
						
						$('#cards').hide();
						$('#paymentMethodsDiv').hide();
						$('#cardProfileArea').hide();
						$('#commonArea').show();
						
					}else{
						$('#failureMsg').html('Invalid username or password.');
					}
				},
				error: function(xhr, msg, e) {
					//alert(e);
				}
			});
	 }
	 function closeMgrLogin(){
		 $('#bpsMask').hide();
		 $('#loginDiv').hide();
	 }
	 
	 function openCloseDivs(type){
		 if(type=='resume'){
			 $('#commonArea').show();
			 $('#loginDiv').hide();
			 
		 }else if(type=='void' || type=='pickup' || type=='precommit'){
			 $('#loginDiv').hide();
			 $('#smacDiv').hide();
			 $('#commonArea').show();
			 $('#billers').hide();
		 
		 }else if(type=='smac'){
			 $('#smacDiv').show();
			 $('#loginDiv').hide();
			 $('#commonArea').hide();
			 $('#billers').show();
			 
		 }else if(type=='submit'){
			 $('#smacDiv').hide();
			 $('#loginDiv').hide();
			 $('#commonArea').hide();
			 $('#billers').show();
		 }else if(type == 'suspend'){
			 $('#commonArea').show();
		 }		 
	 }
	 
	 

function precommit() {
	 if($("#trxLineItems").find("tr").size() == 0 && $("#billerTable").find("tr").size() == 0){
		$.ajax({
			type : "POST",
			url : 'loadPrecommit.action',
			dataType : "json",
			async : true,
			success : function(data) {
				$('#bpsMask').hide();
				$('#commonArea').hide();
				$('#billers').show();
				$('#userType').val('STORE CASHIER');
				// adding code for cash pickup image blinking.. Durga - start
				if (data.task == 'success') {
					if (parseInt(data.checkQty) != 0) {
						$('#pCheckQty').html(data.checkQty);
						$('#pCheckAmt').html(data.checkAmt);
					} else {
						$('#pCheckQty').html('0');
						$('#pCheckAmt').html('0.00');
					}
					$('#msgId').html('');
					$('#billers').hide();
					$('#cards').hide();
					$('#paymentMethodsDiv').hide();
					$('#cardProfileArea').hide();
					$('#commonArea').show();
					$('#commonArea').html($('#precomitDiv').html());
				} else if (data.task == 'failed') {
					$('#msgId').html(data.message);
				}
			},
			error : function(xhr, msg, e) {
				alert(e);
			}
		});
	 }else{
		 alert('Pre-Commit is not allowed while transaction is in process.');
	 }
}


 function saveCashorCheckPickup(){
	 	$("#pickupButton").attr('disabled',true);
	 	var numbers = /^[0-9]+$/;
		var regExpr = new RegExp(numbers);
		var qty1000 = $('#p1000').val();
		var qty500 = $('#p500').val();
		var qty200 = $('#p200').val();
		var qty100 = $('#p100').val();
		var qty50 = $('#p50').val();
		var qty20 = $('#p20').val();
		var qty10 = $('#p10').val();
		var qty1 = $('#p1').val();
		var qty5 = $('#p5').val();

		var qty0_25 = $('#p0_25').val();
		var qty0_1 = $('#p0_1').val();
		var qty0_05 = $('#p0_05').val();
		var qty0_01 = $('#p0_01').val();
		
		
	if( $('#cashDetailsDiv') && $('#cashDetailsDiv').is(':visible')){

		if((qty1000=="" || null == qty1000) && (qty500=="" || qty500 == null) && (qty200 == "" || qty200 == null)
				&& (qty100 == "" || qty100 == null) && (qty50 == "" || qty50 == null) && (qty20 == "" || qty20 == null)
				&&(qty10 == "" || qty10 == null)&&(qty1 == "" || qty1 == null)&&(qty5 == "" || qty5 == null)
				&& (qty0_25 == "" || qty0_25 == null) && (qty0_1 == "" || qty0_1 == null)&&(qty0_05 == "" || qty0_05 == null)
				&&(qty0_01 == "" || qty0_01 == null)){
			alert("Quantity should not be empty");
			$("#pickupButton").removeAttr('disabled');
			return false;
		}
	}
	
	var checkQty = $('#checkQty').html();
	var checkAmt = $('#checkAmt').html();
	
	
	var data = '&1000='+qty1000+'&500='+qty500+'&200='+qty200+'&100='+qty100+'&50='+qty50+'&20='+qty20+'&10='+qty10+'&1='+qty1
	+'&5='+qty5+'&0_25='+qty0_25+'&0_1='+qty0_1+'&0_05='+qty0_05+'&0_01='+qty0_01+'&checkQty='+checkQty+'&checkAmt='+checkAmt;

	var count = newIsCheckPickUpActive();
	
	data=data+'&type=Pickup';
	$('#bpsMask').show();
	$.ajax({
		type: "POST",  
		url: 'pickupOrPrecommit.action',
		data: data,	
		dataType: "json",
		cache:false,
		async:true,
		success: function(data) {				
				$('#bpsMask').hide();
				$('#commonArea').hide();
				$('#billers').show();
				$('#cards').show();
				$('#paymentMethodsDiv').hide();
				$('#cardProfileArea').hide();
				$('#userType').val('STORE CASHIER');			
				
				// adding code for cash & check pickup image blinking  .. Durga - start
				// adding code for cash pickup image blinking.. Durga - start
				 if(data.task == 'success'){
					 	$('#msgId').html('Denomination saved successfully.');
					 	$('#cashInhand').val(data.cashInhand);	
						var cashInHand = parseInt($('#cashInhand').val());
						var collectionTreshold = parseInt($('#collectionTreshold').val());
						//alert("cashInHand.... JS... Pickup==="+cashInHand);
						if(cashInHand > collectionTreshold){
							$('#cashPickup').hide();
							$('#cashPickupAni').show();
						}else if(cashInHand <= collectionTreshold){
							$('#cashPickup').show();
							$('#cashPickupAni').hide();
						
						}else if (parseInt(count) == 1){
							$('#checkPickupInterval_1_check').val('completed');
							//$('#numOfCheckPickupsDone').val(1);
							$('#cashPickup').show();
							$('#cashPickupAni').hide();
			        
						}else if(parseInt(count) == 2){
							$('#checkPickupInterval_2_check').val('completed');
							//$('#numOfCheckPickupsDone').val(2);
							$('#cashPickup').show();
							$('#cashPickupAni').hide();
						}
					
					
				 }else if(data.task == 'failed'){
					$('#msgId').html(data.message);
				// adding code for cash & check pickup image blinking.. Durga - end
				
				$('#precomitDiv').find('#pCheckQty').html('0');
				$('#precomitDiv').find('#pCheckAmt').html('0.00');
				$('#cashpickupDiv').find('#checkQty').html('0');
				$('#cashpickupDiv').find('#checkAmt').html('0.00');
		}},
		error: function(xhr, msg, e) {
			//alert(e);
		}
	});
	
}
 
 function savePrecommit(){
	 	$("#precommitButton").attr('disabled',true); 
		var numbers = /^[0-9]+$/;
		var regExpr = new RegExp(numbers);
		//p0_05,p20,p0_1,p50,p0_25,p0_5,,p1,,p10,
		var qty1000 = $('#p1000').val();
		var qty500 = $('#p500').val();
		var qty200 = $('#p200').val();
		var qty100 = $('#p100').val();
		var qty50 = $('#p50').val();
		var qty20 = $('#p20').val();
		var qty10 = $('#p10').val();
		var qty1 = $('#p1').val();
		var qty5 = $('#p5').val();
		var qty0_25 = $('#p0_25').val();
		var qty0_1 = $('#p0_1').val();
		var qty0_05 = $('#p0_05').val();
		var qty0_01 = $('#p0_01').val();
		
		if((qty1000=="" || null == qty1000) && (qty500=="" || qty500 == null) && (qty200 == "" || qty200 == null)
				&& (qty100 == "" || qty100 == null) && (qty50 == "" || qty50 == null) && (qty20 == "" || qty20 == null)
				&&(qty10 == "" || qty10 == null)&&(qty1 == "" || qty1 == null)&&(qty5 == "" || qty5 == null)
				&& (qty0_25 == "" || qty0_25 == null) && (qty0_1 == "" || qty0_1 == null)&&(qty0_05 == "" || qty0_05 == null)
				&&(qty0_01 == "" || qty0_01 == null)){
			alert("Quantity should not be empty");
			$("#precommitButton").removeAttr('disabled'); 
			return false;
		}
			
			var data = '&1000='+qty1000+'&500='+qty500+'&200='+qty200+'&100='+qty100+'&50='+qty50+'&20='+qty20+'&10='+qty10+'&1='+qty1
				+'&5='+qty5+'&0_25='+qty0_25+'&0_1='+qty0_1+'&0_05='+qty0_05+'&0_01='+qty0_01;
			
			data=data+'&type=Precommit';
			$('#bpsMask').show();	

			$.ajax({
		type: "POST",  
		url: 'pickupOrPrecommit.action',
		data: data,					 
		dataType: "json",
		async:true,
		success: function(data) {
			$('#bpsMask').hide();
			$('#commonArea').hide();
			$('#billers').show();
			$('#cards').show();
			$('#paymentMethodsDiv').hide();
			$('#cardProfileArea').hide();
			$('#userType').val('STORE CASHIER');
			// adding code for cash pickup image blinking.. Durga - start
			 if(data.task == 'success'){
				 	$('#cashInhand').val(data.cashInhand);	
				 	$('#msgId').html('Denomination saved successfully.');
					var cashInHand = parseInt($('#cashInhand').val());
					var collectionTreshold = parseInt($('#collectionTreshold').val());
				//	alert("cashInHand.... JS... Precommit==="+cashInHand);
					if(cashInHand > collectionTreshold){
						$('#cashPickup').hide();
						$('#cashPickupAni').show();
					}else {
						$('#cashPickup').show();
						$('#cashPickupAni').hide();
					}
			 	}else if(data.task == 'failed'){
				$('#msgId').html(data.message);
			}
			// adding code for cash pickup image blinking.. Durga - end
			$('#precomitDiv').find('#pCheckQty').html('0');
			$('#precomitDiv').find('#pCheckAmt').html('0.00');
			$('#cashpickupDiv').find('#checkQty').html('0');
			$('#cashpickupDiv').find('#checkAmt').html('0.00');
		},
		error: function(xhr, msg, e) {
			//alert(e);
		}
	});

	// adding code for cash pickup image blinking.. Durga - end
		 
}
 
 
 function showManagerFunctions(){
	 $('#managerButtons').hide();
	 $('#managerButtons1').show();
 }
 
 function hideManagerFunctions(){
	 $('#managerButtons1').hide();
	 $('#managerButtons').show();
 }
 
 function checkCard(){
	 if(document.getElementById("smacNum").value.length>=8){
		 var smacNumberTemp = document.getElementById("smacNum").value.substring(0,8);
		 var smacNumber = parseFloat(smacNumberTemp);
		 if(!((smacNumber>=88700000 && smacNumber<= 88799999)
				 || (smacNumber>=88800000 && smacNumber<= 88879999)
				 	||(smacNumber>=88803500 && smacNumber <= 88803599)
				 		|| (smacNumber>=88890000 && smacNumber<=88899999))){
		 document.getElementById("smacNum1").innerHTML = "Invalid Card";
		 document.getElementById("smacNum").value = "";
		 document.getElementById("errorSmac").style.display="block";
		 document.getElementById("Submit32").disabled = true; 
		}else{
			document.getElementById("errorSmac").style.display="none";
		}
	 }
 }
 

 function saveTerminalReconciliation() {
	 if($("#trxLineItems").find("tr").size() == 0 && $("#billerTable").find("tr").size() == 0){
		 var r = confirm("Do you want to close the Terminal");
		 if (r == true) {
			//DATE REMOVED : 20161128
			//BY TOA8281
			//TRANSFER INSIDER terminalReconciliationConfirmation() FUNCTION
			//loginFromTerminalReconciliation(); 
			//DATE REMOVED : 20161128
			terminalReconciliationConfirmation();
		 }
	 }else{
		 alert('Reconciliation is not allowed while transaction is in process.');
	 }
}

function terminalReconciliationConfirmation() {
	var msg = prompt("Terminal will not be used after this process.\nType CONFIRMED to proceed or close window to cancel.", "");
	if (msg.toUpperCase() == "CONFIRM" ) {
			alert("PROCEED");
			loginFromTerminalReconciliation(); 
			terminalReconciliationLogin();
	} else {
			alert("ERROR");
			}
}

function loginFromTerminalReconciliation() {
	$('#loginDivForTerminalReconcilation').find('#employeeNumber').val('');
	$('#employeePassword').val('');
	$('#bpsMask').show();
	$('#loginDivForTerminalReconcilation').show();
	var w = $(window);
	$('#loginDivForTerminalReconcilation').css(
			'top',
			Math.abs(((w.height() - $('#loginDivForTerminalReconcilation')
					.outerHeight()) / 2)
					+ w.scrollTop()));
	$('#loginDivForTerminalReconcilation').css(
			'left',
			Math.abs(((w.width() - $('#loginDivForTerminalReconcilation')
					.outerWidth()) / 2)
					+ w.scrollLeft()));
	//$('#mgrLoginInvokedFrom').val('pickup');

}
function closeTerminalReconciliationLogin() {
	$('#bpsMask').hide();
	$('#loginDivForTerminalReconcilation').hide();
}
function terminalReconciliationLogin() {
	// alert("hai");

	if ($('#employeeNumber').val() == ''
			|| $('#employeeNumber').val() == 'null') {
		alert('Please provide employee number');
		$('#employeeNumber').focus();
		return false;
	}
	if ($('#employeePassword').val() == ''
			|| $('#employeePassword').val() == 'null') {
		alert('Please provide employee password');
		$('#employeePassword').focus();
		return false;
	}
	closeTerminalReconciliationLogin();
	$('#bpsMask').show();
	//$('#terminalReconcilationDiv').show();

	var w = $(window);
	$('#reconcilation').show();
	$('#reconcilation').css(
			'top',
			Math.abs(((w.height() - $('#reconcilation').outerHeight()) / 2)
					+ w.scrollTop()));
	$('#reconcilation').css(
			'left',
			Math.abs(((w.width() - $('#reconcilation').outerWidth()) / 2)
					+ w.scrollLeft()));
	$('#trxRecMsg').html('Terminal reconciliation is processing');

	$.ajax({
		type : "POST",
		url : "saveTerminalReconciliation.action",
		data : "employeeNum=" + $('#employeeNumber').val()
				+ "&employeePassword=" + $('#employeePassword').val(),
		dataType : "json",
		async : true,
		success : function(data) {
			if ('success' == data.task) {
				/*var w = $(window);
				$('#trxRecMsg').html('Terminal reconciliation process successfully completed<br/>Transaction count : '+data.terminalTrxCount);
				$('#terminalReconcilationDiv').css('top',Math.abs(((w.height() - $('#terminalReconcilationDiv').outerHeight()) / 2) + w.scrollTop()));
				$('#terminalReconcilationDiv').css('left',Math.abs(((w.width() - $('#terminalReconcilationDiv').outerWidth()) / 2) + w.scrollLeft()));
				  // alert("Success");
				  //	alert(data.terminalTrxCount);
				 */
				terminalReconciliationUnscheduler(data.terminalTrxCount);

			} else {
				$('#reconcilation').hide();
				alert(data.message);
				$('#bpsMask').hide();
			}
		},
		error : function(xhr, msg, e) {
			alert(e);
		}
	});
}
function terminalReconciliationUnscheduler(terminalCount) {
	$.ajax({
		type : "POST",
		url : "terminalReconciliationUnscheduler.action",
		data : "terminalTrxCount=" + terminalCount,
		dataType : "json",
		async : true,
		success : function(data) {
			$('#reconcilation').hide();
			//force logout -- Start
			if('success' == data.task){
				alert(data.message);
				//logout();
				alert('You will be logged out of the terminal');
				document.location.href="logout.action";
			}else if('failed' == data.task){
				alert(data.message);
				alert('You will be logged out of the terminal');
				document.location.href="logout.action";
			}
				//force logout -- End
			$('#bpsMask').hide();
		},
		error : function(xhr, msg, e) {
			alert(e);
		}
	});
}
function closeTerminalReconcilationDiv() {
	$('#bpsMask').hide();
	$('#terminalReconcilationDiv').hide();
}

function openScanningVoidBarcodePopup(){
	 screenValue='VOID';
	 $("#voidBarcodeData").val('');
	 showBarcodeDiv();
	 ReadBarcode(closeScanningVoidBarcodePopup,'voidBarcodeData');
}

function closeScanningVoidBarcodePopup(){
	closeBarcodeDiv();
	if ($("#voidBarcodeData").val() != 'null' && $("#voidBarcodeData").val() != '') {
		getVoidBarcodeData('voidBarcodeData', 'trxStoreCode', 'trxTerminalId', 'trxTransactionId');
		$('#trxStoreCode').attr('readOnly',true);
		$('#trxTerminalId').attr('readOnly',true);
		$('#trxTransactionId').attr('readOnly',true);
	}else {
		$('#trxStoreCode').val('');
		$('#trxTerminalId').val('');
		$('#trxTransactionId').val('');
		$('#trxStoreCode').focus();
	}
}

function showBarcodeDiv(){
	 $('#bpsMask').show();
	 $('#barcodeDiv').show();
	 var w = $(window);
	 $('#barcodeDiv').css('top',Math.abs(((w.height() - $('#barcodeDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#barcodeDiv').css('left',Math.abs(((w.width() - $('#barcodeDiv').outerWidth()) / 2) + w.scrollLeft()));
	 $('#barcodeDiv').focus();
}

function closeBarcodeDiv(){
	 $('#bpsMask').hide();
	 $('#barcodeDiv').hide();
}

function openScanningSuspendAndResumeBarcodePopup(){
	 screenValue='SUSPEND';
	 showBarcodeDiv();
	 $("#suspendAndResumeBarcodeData").val('');
	 ReadBarcode(closeScanningSuspendAndResumeBarcodePopup,'suspendAndResumeBarcodeData');
}

function closeScanningSuspendAndResumeBarcodePopup(){
	 closeBarcodeDiv();
	 //alert($("#suspendAndResumeBarcodeData").val());
	 if ($("#suspendAndResumeBarcodeData").val() != 'null' && $("#suspendAndResumeBarcodeData").val() != '') {
		 getSuspendAndResumeBarcodeData('suspendAndResumeBarcodeData', 'terminalNum', 'trxNumRes');
		 $('#terminalNum').attr('readOnly',true);
		 $('#trxNumRes').attr('readOnly',true);
	 }else {
		 $('#terminalNum').val('');
		 $('#trxNumRes').val('');
		 $('#terminalNum').focus();
	 }
	 $("#suspendAndResumeBarcodeData").val('');
}

function showReports(){

	var trId=$('#terminalId').val();
	var usr="mspgsrvc";
	var psswrd="SMRI2017";
	var srv="MSPGWB01";


	$.ajax({			 
				type: "POST", 
				url: "copyGeneratedRcp.action",
				data: "userid="+usr+"&password="+psswrd+"&server="+ srv + "&terminalId="+trId,
				dataType: "text",
				async:false,
				timeout: 3000,
				success: function(data) {
					trStat=data.status;
				},
				error: function(xhr, msg, e) {
					trStat="exception";
				}
		 });
}

function cashierReprintTrx(){
	$('#msgId').html('');
	if($("#trxLineItems").find("tr").size() == 0 && $("#billerTable").find("tr").size() == 0){ 
		$('#loginDiv').find('#failureMsg').html('');
		$('#loginDiv').find('#mgrNum').val('');
		$('#mgrPassword').val('');
		 if($('#userType').val() == 'STORE CASHIER'){
			 
			 $('#bpsMask').show();
			 $('#loginDiv').show();
			 var w = $(window);
			 $('#loginDiv').css('top',Math.abs(((w.height() - $('#loginDiv').outerHeight()) / 2) + w.scrollTop()));
			 $('#loginDiv').css('left',Math.abs(((w.width() - $('#loginDiv').outerWidth()) / 2) + w.scrollLeft()));
			 $('#mgrLoginInvokedFrom').val('reprint');
			 return ;
		 }else if($('#userType').val() == 'STORE MANAGER' || $('#userType').val() =='HO MANAGER'){
			 $('#billers').hide();
		   	 $('#commonArea').show();
		   	 $('#commonArea').html($('#cashpickupDiv').html());
		 } 
	}else{
		alert('Reprint is not allowed while transaction is in process.');
	}
}


function closeReprintDiv(){
	$('#reprintLastTrx').hide(); 
	$('#bpsMask').hide();
	$('#commonArea').hide();
	$('#billers').show();
	$('#cards').show();
 }

window.onbeforeunload = function(e) {
	var e = e || window.event;
		// For IE and Firefox
		if (e) {
			$.ajax({
				type: "POST",  
				url: "clearSessionVariableForRelogin.action",
				data: "",
				dataType: "json",
				async:true,
				success: function(data) {
//					alert(data.task);
					if(data.task == 'success'){
						
					}else if(data.task == 'failed'){
						
					}
				}, 
				error: function(xhr, msg, e) {
					//alert(e);
				}
			});
		}
};


//Prevents backspace except in the case of textareas and text inputs to prevent user navigation.
$(document).keydown(function (e) {
    var preventKeyPress;
    if (e.keyCode == 8) {
        var d = e.srcElement || e.target;
        switch (d.tagName.toUpperCase()) {
            case 'TEXTAREA':
                preventKeyPress = d.readOnly || d.disabled;
                break;
            case 'INPUT':
                preventKeyPress = d.readOnly || d.disabled ||
                    (d.attributes["type"] && $.inArray(d.attributes["type"].value.toLowerCase(), ["radio", "checkbox", "submit", "button"]) >= 0);
                break;
            case 'DIV':
                preventKeyPress = d.readOnly || d.disabled || !(d.attributes["contentEditable"] && d.attributes["contentEditable"].value == "true");
                break;
            default:
                preventKeyPress = true;
                break;
        }
    }
    else
        preventKeyPress = false;

    if (preventKeyPress)
        e.preventDefault();
});


window.history.forward();
window.onload = function()
{
  window.history.forward();
};

