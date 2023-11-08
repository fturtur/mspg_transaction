//hot key for logout
$(document).bind('keydown', 'f5',function (evt){
	 var flag = false;
	 if(evt.which == 116 && !flag){
		 evt.preventDefault();
		 if(!$('#signOut').is(':hidden')){
			 logout();
	 	 }
		 flag = true;
	 	return false;
	 }
});

// hot key for resume transaction
$(document).bind('keydown', 'f6',function (evt){
	
	 if(evt.keyCode==117){			 
		 evt.preventDefault();
		 if($('#managerButtons1').is(":visible")){
			 $('#managerButtons').show();
			 $('#managerButtons1').hide();
		 }else{
			 $('#managerButtons1').show();
			 $('#managerButtons').hide();
		 }
		 return false;
	 }
});

// hot key for resume transaction
$(document).bind('keydown', 'f7',function (evt){
	 if(evt.keyCode==118){	
		 evt.preventDefault();
		 if(!$('#resumeId').is(':hidden')){
			 resumeTrx();
			 openCloseDivs('resume');
		 }
		 if(!$('#suspendId').is(':hidden')){
			 showSuspendDiv();
			 openCloseDivs('suspend');
		 }
		 return false;
	 }
});

//hot key for void transaction
$(document).bind('keydown', 'f8',function (evt){
	 if(evt.keyCode==119){
		 evt.preventDefault();
		 if(!$('#voidButton').is(':hidden')){
			 cashierVoidTrx();
			 openCloseDivs('void');
		 }
		 return false;
	 }
});

//hot key for pickup
$(document).bind('keydown', 'f9',function (evt){
	 if(evt.keyCode==120){
		 evt.preventDefault();
		 if(!$('#pickUpButton').is(':hidden')){
			 pickup();
		 }
		 return false;
	 }
});

//hot key for precommit
$(document).bind('keydown', 'f10',function (evt){
	 if(evt.keyCode==121){
		 evt.preventDefault();
		 precommit();
		 return false;
	 }
});

//hot key for smac
$(document).bind('keydown', 'f11',function (evt){
	 if(evt.keyCode==122){
		 evt.preventDefault();
		 smacInfo();
		 return false;
	 }
});

//hot key for submit
$(document).bind('keydown', 'f12',function (evt){
	 if(evt.keyCode==123){
		 evt.preventDefault();
		 addPromotionsToBasket();
		 showEnterCash();
	 }
});

$(document).bind('keydown', 'esc', function (evt){
	if(evt.keyCode==27){
		evt.preventDefault();
		if(hasSecondBarcode=="Y"){
			hasSecondBarcode='N';
			$('#bpsMask').hide();
			$('#secondBarcodeDiv').hide();
			$('#cardsContainer').hide();
			hidePaymentDiv();
			$('#totalAmtDiv').hide();
			hideManagerFunctions();
			//$('#resumeId').hide();
			//$('#logout').hide();
			//$('#suspendId').show();
			$('#searchText').val('');
			$('#msgId').html('');
			$('#searchText').focus();
		}
		var voidBarcodeDiv=$('#barcodeDiv').css('display');
		if(voidBarcodeDiv!=undefined && voidBarcodeDiv!='none'){
			closeBarcodeDiv();
			if(screenValue!=undefined && screenValue!='' && screenValue=='VOID'){
				$('#trxStoreCode').focus();
			}else if(screenValue!=undefined && screenValue!='' && screenValue=='SUSPEND'){
				$('#terminalNum').focus();
			}
		}
	}
});