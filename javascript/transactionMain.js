	function getBillers(billerCatId){
		$('#msgId').html('');
		$.ajax({
			type: "POST",  
			url: "getBillers.action",
			data: "billerCatId="+billerCatId,
			dataType: "text",
			async:false,
			success: function(data) {
			        $('#billersContainer').html(data);
			        $('#billersContainer').show();	
			        $('#billersPolicies').hide();
			        $('#totalAmount').hide();
			        
			        $('#billerIndex').val("");					
					$('#tenderIndex').val("");
			}, 
			error: function(xhr, msg, e) {
			}
		});
	}
	function showBillerPolicies(billerId){
		$('#msgId').html('');
		$.ajax({
			type: "POST",
			url: "showPoliciesScreen.action",
			data: "billerId="+billerId,
			dataType: "text",
			async:true,
			success: function(data) {
				$('#billersPolicies').html(data);
			},
			error: function(xhr, msg, e) {
			}
		});
	}
	 /*Cebu Pacific Webservice Integration - START*/	
	function checkMixedTrx(mixTrxAllowed, billerId){
		$('#msgId').html('');
		var mixTrx = $('#centertablePanel').find('#tableItems').find('#billerTable').find('#mixedTrxAllowed').val();
		
		if(mixTrx!="" && ((mixTrx=='Y' && mixTrxAllowed=='N') || (mixTrx=='N' && mixTrxAllowed=='N') || (mixTrx=='N' && mixTrxAllowed=='Y'))){
			var billers = $('.resumeBiller');
			for(var i=0;i<billers.length;i++){
				if(($(billers[i]).val() == billerId && !postSubmitFlag) || ($(billers[i]).val() == billerId && !preSubmitFlag)){
					return true;
				}
			}
			alert("Multiple transactions are not allowed for this biller");
			return false;
		}else if((mixTrx!=undefined && mixTrx!="" && postSubmitFlag) || (mixTrx!=undefined && mixTrx!="" && preSubmitFlag)){
			alert("There is a third party integration. Multiple transactions are not allowed for this biller");
			return false;
		}else  
			return true;
	}
	 /*Cebu Pacific Webservice Integration - END*/	
	function fetchBillerFields(billerId, billProcessingType, processingTime,mixTrxAllowed){
		$('#msgId').html('');
		createCookie("testcookie","1234",10);
		//checking for the mixed trx allowed or not
		if(!checkMixedTrx(mixTrxAllowed, billerId))
			return;
		
		if(null != processingTime && '' != processingTime){
			
			var prccTimeSP = processingTime.split(':');
			var processingTime = new Date();
			processingTime.setHours(prccTimeSP[0], prccTimeSP[1], prccTimeSP[2], 00);
			
			var currentTime = new Date();
			if(currentTime > processingTime){
				
				alert('Biller processing time of biller exceded');
				return ;
			}
		}
		$('#billerId').val(billerId);
		if(billProcessingType == 'Y'){
			//// -- CORRECTION FOR OFFLINE TRANSACTION - START -- ////
			$('#billerProcessingMode').val('online');
			//// -- CORRECTION FOR OFFLINE TRANSACTION - END -- ////
			var isOnline = false;
			$.ajax({
				type: "POST",  
				url: "terminalConnected.action",
				data: "",
				dataType: "json",
				async:false,
				success: function(data) {
					
					if(data.task == 'success'){
						
						isOnline = true;
						$('#billerCardProcessMode').val('online');
					}else if(data.task == 'failed'){
						
						$('.onLineDiv').hide();
						$('.offLineDiv').show();
						$('#terminalStatus').val('offline');
						alert('Selected biller can not be processed in offline mode.');
						isOnline = false;
					}
				}, 
				error: function(xhr, msg, e) {
					$('.onLineDiv').hide();
					$('.offLineDiv').show();
					$('#terminalStatus').val('offline');
					alert('Selected biller can not be processed in offline mode.');
					isOnline = false;
				}
			});
			if(!isOnline){
				return ;
			}
		}else{
			//// -- CORRECTION FOR OFFLINE TRANSACTION - START -- ////
			$('#billerProcessingMode').val('offline');
			//// -- CORRECTION FOR OFFLINE TRANSACTION - END -- ////
			$('#terminalStatus').val('offline');
		}
		
		$.ajax({
			type: "POST",  
			url: "fetchBillerFields.action",
			data: "billerId="+billerId,
			dataType: "text",
			async:true,
			success: function(data) {
				$('#totalAmount').find('#totAmtTable').remove();
				$('#billersPolicies').find('#billerPoliciesTable').remove();
				
				$('#billersContainer').html(data);
				$('#billersContainer').show();
							
				$('#billerPoliciesTable').clone().appendTo($('#billersPolicies'));			
				$('#billersPolicies').show();
				setErrorSpan();
				setJavaScript();
				
				billerBarCodeCheck();
				/*PreSubmit Before Save - START*/	
				setPreSubmitJavaScript();
				/*PreSubmit Before Save - END*/	
 				/*Cebu Pacific Webservice Integration - START*/	
				setPostSubmitJavaScript();
 				/*Cebu Pacific Webservice Integration - END*/	
				if($('#processOnLoad') && $('#processOnLoad').val() == 'Y' && $('#billerBarcodeExists').val() == 'N'){
					$('#editDiv').click();
					fun_onload();
				}
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
	}
	function setErrorSpan(){
		
		var elements = $('.fields');
		if(elements.length > 0){
			
			for(var i=0;i<elements.length;i++){
				//alert($(elements[i]).attr('id'));
				var span = document.createElement('span');
				$(span).attr('style', 'color:red;');
				$(span).attr('id', $(elements[i]).attr('id')+'Error');
				$(span).insertAfter($(elements[i]));
			}
		}
	}
	function setJavaScript(){
		
		$('#scriptDiv').html('');
		var jsDivs = $('.tempDiv');
		
		var content = '';
		for(var i =0;i<jsDivs.length;i++){

			content = content + $(jsDivs[i]).text();			
		}	
		
		content = '<script>'+content+'</script>';
	//alert(content);
		$('#scriptDiv').html(content);
	}
	 /*Cebu Pacific Webservice Integration - START*/	
	function setPostSubmitJavaScript(){
		
		$('#postScriptDiv').html('');
		var jsDivs = $('.postSubmitDiv');
		var content = '';
		if(jsDivs!=undefined && jsDivs!=null){
			for(var i =0;i<jsDivs.length;i++){
				content = content + $(jsDivs[i]).text();			
			}	
		}
		if(content!=''){
			content = '<script>'+content+'</script>';
		//alert(content);
			$('#postScriptDiv').html(content);
		}
	}
	 /*Cebu Pacific Webservice Integration - END*/	
	
	/*PreSubmit Before Save - START*/	
	function setPreSubmitJavaScript(){
		
		$('#preScriptDiv').html('');
		var jsDivs = $('.preSubmitDiv');
		var content = '';
		if(jsDivs!=undefined && jsDivs!=null){
			for(var i =0;i<jsDivs.length;i++){
				content = content + $(jsDivs[i]).text();			
			}	
		}
		if(content!=''){
			content = '<script>'+content+'</script>';
		//alert(content);
			$('#preScriptDiv').html(content);
		}
	}
	 /*PreSubmit Before Save - END*/	
	function billerBarCodeCheck(){
		if($('#billerBarcodeExists') && $('#billerBarcodeExists').val() == 'Y'){
			if($('#billerNumOfBarcodes') && $('#billerNumOfBarcodes').val() > 0){
				
				var w = $(window);
				$('#bpsMask').show();
				$('#billerBarcode').show();
				$('#barcodeCount').html('');
				$('#billerBarcode').css('top',Math.abs(((w.height() - $('#billerBarcode').outerHeight()) / 2) + w.scrollTop()));
				$('#billerBarcode').css('left',Math.abs(((w.width() - $('#billerBarcode').outerWidth()) / 2) + w.scrollLeft()));
				
				$('#barcodeCount').html(1);
				$('#barCodeStr').focus();
				/*var inputs = $('#billerBarcode input');
				for(var i=0;i<inputs.length;i++){
					if('barCodeStr' == $(inputs[i]).attr('id')){

						document.getElementById(inputs[i].attr('id')).focus();
					}
				}*/
				
				$('#totalNumOfBarcodes').val($('#billerNumOfBarcodes').val());
				$('#billerBarcodeVal').val('');
			}
		}
	}	
	function fetchDriverFields(billerId,driverId,obj){
		$('#msgId').html('');
		var index = "";
		if($('#billerIndex').val()!="")
			index = $('#billerIndex').val();
		
		 $.ajax({
			type: "POST",  
			url: "fetchBillerDriverFields.action",
			data: "billerId="+billerId+"&driverId="+driverId+"&driverFieldId="+obj.value+"&index="+index,
			dataType: "text",
			async:true,
			success: function(data) {				
				$("#billersContainer").html(data);
				$("#billersContainer").show();
				
				setJavaScript();
				/*PreSubmit Before Save - START*/	
				setPreSubmitJavaScript();
				/*PreSubmit Before Save - END*/	
 				/*Cebu Pacific Webservice Integration - START*/	
				setPostSubmitJavaScript();
				/*Cebu Pacific Webservice Integration - END*/	
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		}); 
	}
	function autoComplete(){		
		$('#msgId').html('');
		var searchText = $('#searchText').val(); 		
	
		if(searchText!=""){		
			$.ajax({
				type: "POST",  
				url: "billerAutoComplete.action",
				data: "searchText="+searchText,
				dataType: "text",
				async:true,
				success: function(data) {					
					$('#billersContainer').html(data);
					$('#billersContainer').show();
				},
				error: function(xhr, msg, e) {
					alert("error " + e);
				}
			});
		}else{
			$('#billersContainer').hide();
		}		
	}
	
	function checkPastDues(){
		
		var acceptPastDue=$('#acceptPastDue').val();

		if(acceptPastDue=='Y'){
			var gracePeriod=$('#gracePeriod').val();
			var endDate=$('#endDate').val();
			var dattmp = endDate.split('/').reverse().join('/'),
			nwdate =  new Date(dattmp);
			nwdate.setDate(nwdate.getDate()+ parseInt(gracePeriod));
			var currentDate = new Date();
			currentDate.setHours(0,0,0,0);
			if(currentDate>nwdate){
				alert("Sorry due date is expired");
				return false;
			}		
			else if((currentDate<nwdate)||(currentDate==nwdate))
				return true;	
		}else
			return true;
	}
	 
function validatePaymentsAgainstPolicies(){
		 
		
		 var payment = parseInt($('#payment').val().replace(/P|\,|\./g, ''));
		 var dueAmt = parseInt($('#amountDue').val().replace(/P|\,|\./g, ''));
		 var exactPmt = false;
		 var underPmt = false;
		 var overPmt = false;
		 var msgStr = '';
		 var policies = $('.billerPaymentOptions');
		 for(var i =0; i<policies.length;i++){
			 
			 if($(policies[i]).val() == 'Exact Payment'){
				 exactPmt = true;
			 }
			if($(policies[i]).val() == 'Under Payment'){
				underPmt = true;
			}
			if($(policies[i]).val() == 'Over Payment'){
				overPmt = true;
			}
		 }
		 
		 if(payment < dueAmt){
			 if(underPmt){
				 return true;
			 }else{
				 msgStr = msgStr + 'Under payment not allowed.';
			 }
		 }
		 if(payment == dueAmt){
			 if(exactPmt){
				 return true;
			 }else{
				 msgStr = 'Payment have to be exact.';
			 }
		 }
		 
		 if(payment > dueAmt){
			 if(overPmt){
				 return true;
			 }else{
			 msgStr = msgStr + 'Over payment not allowed.';
			 }
		 }
		 
		 //alert( msgStr );
		 $('#paymentError').html(msgStr);
		 return false;
	 }

	function addBiller(thiz){
		$('#msgId').html('');
		//alert(check_for_duplicate_txn('2323232323232'));
		$(thiz).attr('disabled', 'true');
//		alert($('#callEditDiv').val());
		if($('#callEditDiv').val() == 'Y'){
			$('.editDiv').click();
		}
		
		if($('#callSubmit').val() == 'Y'){
			if(!fun_submit()){
				$(thiz).removeAttr('disabled');
				return false;
			}
		}
		if(!validatePaymentsAgainstPolicies()){
			$(thiz).removeAttr('disabled');
			return false;
		}
		var dueAmt="";
		var serviceFee="";
		var billerId = $('#billerId').val();
		var index = $('#billerIndex').val();
		
		//check biller id for resume transaction
		if(billerId=="" && index!=""){			
			billerId=$('#resumeBiller'+index).val();			
			$('#billerId').val(billerId);
		}
		
		if(!checkPastDues())
			return;
		
		var textList = $("#billerFieldTable").find('.fields');
		
		var fieldsList = "";
		var fieldListDisabled= "";
		 for(var i=0;i<textList.length;i++){
			 if(textList[i].type!='radio' && textList[i].type!='checkbox'){
				 fieldListDisabled=fieldListDisabled + textList[i].id + ":" + textList[i].disabled +";";
				 if(textList[i].value!=""){
					 
					//due amout should be changed to payment
					 if(textList[i].id=='payment'){	
						 dueAmt = GetPriceAsString(textList[i].value);
						 dueAmt =  dueAmt.replace("P","");

						 fieldsList = fieldsList + textList[i].id + ":" + dueAmt +";";
					 }else
						 fieldsList = fieldsList + textList[i].id + ":" + textList[i].value +";";
				 }
				 
			 }else if(textList[i].type=='radio'){
				 
				 if($('#'+textList[i].id).attr('checked') && $('#'+textList[i].id).val()!='')
					 fieldsList = fieldsList + textList[i].id + ":" + textList[i].value +";";
				 
			 }else if(textList[i].type=='checkbox'){
				 
				 if($('#'+textList[i].id).attr('checked') && $('#'+textList[i].id).val()!='')
					 fieldsList = fieldsList + textList[i].id + ":" + textList[i].value +";";
			 }
		 }

		 if(dueAmt!=""){
			 var serviceList = $('#servcieFeeTable').find(".service");
			 for(var i=0;i<serviceList.length;i++){		
				 
				serviceList[i].value = calculateServiceFee(dueAmt);	
			 	serviceFee = serviceFee+"serviceFee:"+serviceList[i].id+","+serviceList[i].name+","+serviceList[i].value+";";			 
		 	}
		 }
		 if(serviceFee!="")
			 	fieldsList = fieldsList+serviceFee;
		 
		//hidding the signout button.
			$('#signOut').hide();
			
		var url = "";
		
		if(index==""){
			url = "addBillerDetails.action";
		}else{
			url = "updateBillerDetails.action?index="+index;
		}
		/*Cebu Pacific Webservice Integration - END*/	
		billerFieldList=fieldsList;
 		/*Cebu Pacific Webservice Integration - END*/	
		
		/* -- Mixed Online and Offline Biller fix - START -- */
		var transProcessMode = "";
		transProcessMode = $('#billerProcessingMode').val();
		if(transProcessMode == "online"){
			$('#billerTransProcessingMode').val(transProcessMode);
		}
		/* -- Mixed Online and Offline Biller fix - END -- */
		
		$.ajax({
				type: "POST",  
				url: url,
				data: "fieldsList="+fieldsList+"&billerId="+billerId+"&fieldListDisabled="+fieldListDisabled,					 
				dataType: "text",
				async:true,
				success: function(data) {
				
					$('#centertablePanel').find('#tableItems').remove();
					$('#billersPolicies').find('#billerPoliciesTable').remove();
					$('#totalAmount').find('#totAmtTable').remove();
					$('#centertablePanel').html(data);				
					$("#billersContainer").hide();
						
					if(index!=""){
						$('#billerIndex').val("");
						$('#tenderIndex').val(index);
					}
					getTendersDetails();
					$('#resumeId').hide();
					$('#voidButton').hide();
					$('#signOut').hide();
						
					$('.imgClass').hide();
				},
				error: function(xhr, msg, e) {
					//alert(e);
				}
		});
	}

	function addTableRow(table){
		var $tr = $(table).find("tbody tr:last").clone();
		$tr.append(function(){
			
		});
	}
	function enableSubmit(){
		var flag = true;
		var textList = $('.fields');
			 for(var i=0;i<textList.length;i++){
				 if(textList[i].value==null || textList[i].value== ""){
						 flag = false;
						$('#submitId').attr('disabled', 'disabled');
					}else if(textList[i].value != null || textList[i].value != ""){ 
						$('#submitId').attr('disabled', false);
					}
			 }
			 if(!flag){
				 $('#submitId').attr('disabled', 'disabled');
				 }
			 else {$('#submitId').attr('disabled', false);}
	}
	function saveBillerBarcode(thiz){
		var billerBarcodeVal = $('#billerBarcodeVal').val();
		billerBarcodeVal = billerBarcodeVal + $(thiz).val();
		$('#billerBarcodeVal').val(billerBarcodeVal);
		var count = $('#barcodeCount').html();
		var countInt = parseInt(count);
		countInt = countInt+1;
		$('#barcodeCount').html(countInt+"");
		$(thiz).val('');
		$('#barCodeStr').focus();
		if(countInt > $('#totalNumOfBarcodes').val()){
			
			$('#bpsMask').hide();
			$('#billerBarcode').hide();
			smbps_barcodeValidation();
		}
	}
 function suspend(){
	 $("#suspendButton").attr('disabled',true);
	 var reason = $('#suspendResId').val();
	 //alert($('#suspendResId').find("option:selected").text());
	 if('' == reason){
		 alert('Please select reason code to suspend.');
		 return false;
	 }
	var w = $(window);
	 $('#bpsMask').show();
	 $('#suspendDiv').show();
	 $('#suspendDiv').css('top',Math.abs(((w.height() - $('#suspendDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#suspendDiv').css('left',Math.abs(((w.width() - $('#suspendDiv').outerWidth()) / 2) + w.scrollLeft()));
	 
	 $.ajax({
			type: "POST",  
			url: 'suspendTransactionPage.action',
			data: 'reasonCode='+reason+'&reasonCodeText='+$('#suspendResId').find("option:selected").text(),					 
			dataType: "json",
			async:true,
			success: function(data) {
					if(data.task == 'success'){
						$('#suspendMsgDiv').html(data.message);
					}else{
						$('#suspendMsgDiv').html(data.message);
					}
					$('#closeSuspendButton').show();
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
	
 }
 function showSuspendDiv(){
	 $('#msgId').html('');
	 //alert("showSuspendDiv");
	 $('#billers').hide();
	 $('#commonArea').show();
	 $('#commonArea').html($('#suspendTrxDiv').html());
 }
 function closeSuspendDiv(){
	 
	 $('#billers').show();
	 $('#commonArea').hide();
	 if($('#suspendMsgDiv').text() == 'Transaction suspended successfully.'){
		 window.location.reload();
	 }
 }
 
 function hideDiv(){
	 $('#billers').show();
	 $('#commonArea').hide();
 }

  function hideDivForPickups(){
	 $('#userType').val('STORE CASHIER');
	 $('#billers').show();
	 $('#commonArea').hide();
 }

 function cashierVoidTrx(){
	 $('#msgId').html('');
	 if($("#billerTable").find("tr").size() == 0){
		 var voidProcessDiv = $('#voidProcessDiv').html();
		 if(voidProcessDiv.length > 0){
			 $('#billers').hide();
			 $('#commonArea').show();
			 $('#commonArea').html($('#voidProcessDiv').html());
		 }else{
			 $('#billers').hide();
			 $('#commonArea').show();
			 $('#commonArea').html($('#voidTrxDiv').html());
			 openScanningVoidBarcodePopup();
		 } 
	 }else{
		 alert('Void is not allowed while transaction is in process.');
	 }
 }
var screenValue='';
 
 function voidTrx(){
	 
	 var message = '';
		if ($('#trxStoreCode').val() == '' || $('#trxStoreCode').val() == null
				|| $('#trxStoreCode').val() == 'null') {
			message = message + 'Store code is mandatory.\n';
		}
		if ($('#trxTerminalId').val() == '' || $('#trxTerminalId').val() == null
				|| $('#trxTerminalId').val() == 'null') {
			message = message + 'Terminal Number is mandatory.\n';
		}
		if ($('#trxTransactionId').val() == ''
				|| $('#trxTransactionId').val() == null
				|| $('#trxTransactionId').val() == 'null') {
			message = message + 'Transaction Number is mandatory.\n';
		}
		if ($('#trxReasonId').val() == '' || $('#trxReasonId').val() == null) {
			message = message + 'Reason is mandatory.\n';
		}

		if (message != null && message != '') {
			alert(message);
			return false;
		}
	
	var data = 'storeCode='+$('#trxStoreCode').val()+'&terminalId='+$('#trxTerminalId').val()+'&transactionId='+$('#trxTransactionId').val()
		+'&reason='+$('#trxReasonId').val();

	$.ajax({
		type: "get",  
		url: "cashierVoidTransaction.action",
		data: data,			
		dataType: "json",
		cache:false,
		async:false,
		success: function(data) {
			//if(data.task == 'success'){
				
			//	$('#trxStatusTr').show();
			//	$('#trxStatusMsg').html(data.message);
			
				if(data.task == 'Manager void approved'){
					//alert(data.message);
					 /*$.ajax({
							type: "POST",  
							url: "resumeTransaction.action",
							data: 'terminalNum='+$('#trxTerminalId').val()+'&trxNumRes='+$('#trxTransactionId').val(),					 
							dataType: "text",
							async:true,
							success: function(data) {
								
								$('#centertablePanel').find('#tableItems').remove();
								$('#billersPolicies').find('#billerPoliciesTable').remove();
								$('#totalAmount').find('#totAmtTable').remove();
								
								$('#centertablePanel').html(data);				
								$("#billersContainer").hide();
								*/
								/*$('#trxButton1').hide();
								$('#trxButton2').hide();
								$('#trxButton3').show();*/
								 /*
								$('#voidProcessDiv').html($('#commonArea').html());
							},
							error: function(xhr, msg, e) {
								alert(e);
							}
						});*/
					//alert("Transaction could not be located.");
					alert('Void approved by manager, please continue.');
					$('#trxButton1').hide();
					$('#trxButton2').hide();
					$('#trxButton3').show();
					
				}else if(data.task == 'Cashier Void'){
					//$('#trxButton1').hide();
					//$('#trxButton2').show();
					
					//alert("Transaction void successfully.Waiting for the manager approval.");
					alert(data.message);
					$('#trxButton1').hide();
					$('#trxButton2').show();
					$('#trxButton3').hide();
				}else if(data.task=='time'){
					alert(data.message);
					
				}else if(data.task=='failed'){
					alert(data.message);
				}
				//$('#commonArea').hide();
				//$('#billers').show();
		},
		error: function(xhr, msg, e) {
			//alert(e);
		}
	});
 }
 function saveVoidTrx(){
	 
	 var data = 'storeCode='+$('#trxStoreCode').val()+'&terminalId='+$('#trxTerminalId').val()+'&transactionId='+$('#trxTransactionId').val()
		+'&reason='+$('#trxReasonId').val()+'&cashierId='+$('#cashierId').val();
	 
	 $('#bpsMask').show();
	 var w = $(window);
	 $('#saveTrxDiv').show();
	 $('#saveTrxDiv').css('top',Math.abs(((w.height() - $('#saveTrxDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#saveTrxDiv').css('left',Math.abs(((w.width() - $('#saveTrxDiv').outerWidth()) / 2) + w.scrollLeft()));

	 $.ajax({
		 type: "POST",  
		 url: "voidTransaction.action",
		 data: data,					 
		 dataType: "json",
		 async:true,
		 success: function(data) {
			 
			 if(data.task == 'success'){
									
				 //$('#trxStatusTr').show();
				 //$('#trxMsgDiv').html('Transaction void successfully.');
				 alert(data.message);
				 $('#bpsMask').hide();
				 $('#commonArea').hide();
				 $('#billers').show();
				 $('#saveTrxDiv').hide();
			 }else if(data.task =='failed'){
			// Modified to resolve issue 5686
				 alert(data.message);
				 $('#bpsMask').hide();
				 $('#commonArea').hide();
				 $('#billers').show();
				 $('#saveTrxDiv').hide();
			 }
		 },
		 error: function(xhr, msg, e) {
			// alert(e);
		 }
	 });
 }
 
 function paymentHistory(){
		$.ajax({
			type: "POST",  
			url: "paymentHistory.action",
			dataType: "text",
			async:true,
			success: function(data) {
				$('#billers').hide();
				 $('#commonArea').show();
			   $('#commonArea').html(data);
			 	
			
		},
		error: function(xhr, msg, e) {
			//alert(e);
		}
		}); 
		
}
 
function fetchPaymentHistory(){
		var actnum=$('#actNum').val();
		var biller=$('#biller').val();
		var fdate=$('#fdate').val();
		var tdate=$('#tdate').val();
		var branch=$('#branch').val();
		var location=$('#location').val();

		if((actnum==null||actnum=="")||(biller==null||biller=="")||(fdate==null||fdate=="")||
			(tdate==null||tdate=="")||(branch==null||branch=="")||(location==null||location==""))
			{
			alert("field should not be empty");
			}
		else{
		var data='actnum='+$('#actNum').val()+'&biller='+$('#biller').val()+'&fdate='+$('#fdate').val()+
		'&tdate='+$('#tdate').val()+'&branch='+$('#branch').val()+'&location='+$('#location').val();
		
		$.ajax({
			type: "POST",  
			url: "fetchPaymentHistory.action",
			data: data,					 
			dataType: "text",
			async:true,
			success: function(data) {
					 $('#centertablePanel').show();
					 $('#centertablePanel').html(data);
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
	 }
	}
 
 function hoVoidTrx(data){
	 
	 var hoTrxUrl = $('#hoTrxUrl').val();
	 var data = 'terminalId='+$('#terminalId').val()+'&transactionId='+$('#transactionId').val()
			+'&reason='+$('#reasonId').val()+'&cashierId='+$('#cashierId').val()+'&mgrId='+$('#mgrId').val()+
			'&terminalId='+$('#terminalId').val()+'&oldUniTrxId='+data.oldUniTrxId+'&newUniTrxId='+data.newUniTrxId;
	 
	 $.ajax({
			type: "POST",  
			url: hoTrxUrl,
			data: data,					 
			dataType: "text",
			async:true,
			success: function(data) {
				
				if(data.task == 'success'){
					
					$('#billers').hide();
					$('#commonArea').show();
					$('#commonArea').html($('#precomitDiv').html());
				}
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
		
 }

 function smacInfo(){
	 $('#msgId').html('');
	 ReadMSR(checkCard,"smacNum");
	 $('#bpsMask').show();
	 $('#smacDiv').show();
	 var w = $(window);
	 $('#smacDiv').css('top',Math.abs(((w.height() - $('#smacDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#smacDiv').css('left',Math.abs(((w.width() - $('#smacDiv').outerWidth()) / 2) + w.scrollLeft()));

 }

 function saveSmacInfo(){
	 
	 var smacNum = $('#smacNum').val();
	
	 if(smacNum == ''){
		 alert('Please enter Card Number');
		 return ;
	 }

	 $.ajax({
			type: "POST",  
			url: "saveSmacInfo.action",
			data: 'smacNum='+smacNum,					 
			dataType: "json",
			async:true,
			success: function(data) {
				$('#smacNum').val('');
				$('#msgId').html(data.task);	
				closeSmacDiv();
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
 }
 function closeSmacDiv(){
	 readTrackStage = "READTRACK1"; 
	 readTrackCount = 0; 
	 readMSRisInitialized = "false"; 
	 $('#smacNum').val(''); 
	 document.getElementById("smacNum1").innerHTML = '';
	 document.getElementById("Submit32").disabled = false; 
	 $('#billers').show();
	 $('#bpsMask').hide();
	 $('#smacDiv').hide();
	  $('#commonArea').hide();
 }
 function resumeTrx(){
	 $('#msgId').html('');
	 //alert('resumeTrx');
	 $('#billers').hide();
	 $('#commonArea').show();
	 $('#commonArea').html($('#resumeTrx').html());
	 openScanningSuspendAndResumeBarcodePopup();
 }
	
 function getTrxData(){
	 
	var message='';
	var terminalNum=$('#terminalNum').val();
	var trxNumRes=$('#trxNumRes').val();
	
	if((terminalNum==null || terminalNum=="") && (trxNumRes==null || trxNumRes=="")){
		message='Please provide Terminal Number or Transaction Number';
	}else if(terminalNum==null || terminalNum==""){
		message='Please provide Terminal Number';
	}else if(trxNumRes==null || trxNumRes==""){
		message='Please provide Transaction Number';
	}
	
	if(message!=''){
		alert(message);
		return false;
	}
		
	 $('#bpsMask').show();
	 var w = $(window);
	 $('#resumeTrxDiv').show();
	 $('#resumeTrxDiv').css('top',Math.abs(((w.height() - $('#resumeTrxDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#resumeTrxDiv').css('left',Math.abs(((w.width() - $('#resumeTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
	 $.ajax({
			type: "POST",  
			url: "resumeTransaction.action",
			data: 'terminalNum='+terminalNum+'&trxNumRes='+trxNumRes,					 
			dataType: "text",
			async:true,
			success: function(data) {				
				
				//check if data contain html tags.
				if(data.match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)){
				
					$('#centertablePanel').find('#tableItems').remove();
					$('#billersPolicies').find('#billerPoliciesTable').remove();
					$('#totalAmount').find('#totAmtTable').remove();
							
					$('#centertablePanel').html(data);				
					$("#billersContainer").hide();
							
					$('#suspendId').show();
					$('#resumeId').hide();
							
					$('#terminalNum').val('');
					$('#trxNumRes').val('');
					closeResumeDiv();
					$('#bpsMask').hide();
					$('#resumeTrxDiv').hide();
					
					//6152 - MERGING FIX START
					if($('#tableItems') && $('#tableItems').find('#billerTable tr').length>0){
						editTenderDetails($('#tableItems') && $('#tableItems').find('#billerTable tr').length);
						removeTableTriggered=true;
					}
					//6152 - MERGIN FIX END
					
				}else{
					//check if data contain plain text.
					
					$('#bpsMask').hide();
					$('#resumeTrxDiv').hide();
					
					alert(data);					
				}
			
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
 }
 function closeResumeDiv(){
	 $('#billers').show();
	 $('#bpsMask').hide();
	 $('#commonArea').hide();
 }

 
 function processEft(){
	 
	 var cardList = $('.cardClass');
	 var cardFlag = false;
	 var cardTextList="";
	 var totalAmt=0;
	 for(var i=0;i<cardList.length;i++){
			var cardVal='';
			if($('#cardcheck'+i).attr('checked')){
				cardFlag = true;
				cardVal = $('#card'+i).is(':checked') ? 'online':'offline';
				cardTextList = cardTextList + "CARD:" +cardTenderId+":"+cardCombId+":"+ $('#cardAmount'+i).val()+":"+cardVal+"::";
				totalAmt = parseFloat(totalAmt)+parseFloat($('#cardAmount'+i).val());
			}
		}
 }
 function zeroRated(){
	 $('#msgId').html('');
	 if($("#billerTable").find("tr").size() == 0){
			alert("There are no line items in the transaction basket.");
			return false;
		}
	 $.ajax({
			type: "POST",  
			url: "saveZeroRatedFlag.action",
			data: '',					 
			dataType: "text",
			async:true,
			success: function(data) {
				$('#msgId').html('ZeroRated saved successfully.');
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
 }
 
 /* All the Common Functions we see for SM */
 function GetPriceAsString(num) {
                  num = num.toString().replace(/\$|\,/g, '');
                  if (isNaN(num)) num = "0";
                  sign = (num == (num = Math.abs(num)));
                  //num = Math.floor(num * 100 + 0.50000000001);
                  cents = num % 100;
                  num = Math.floor(num / 100).toString();
                  if (cents < 10) cents = "0" + cents;
                  for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
 					num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
                  return (((sign) ? '' : '-') + 'P' + num + '.' + cents);
         }


 function GetPriceAsString1(num) {
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



 function TrimLeadZeros(s) {
     return s.replace(/^0+/, "");
     }
 
 function reprintTrx(){
	 $('#msgId').html('');
	if($("#billerTable").find("tr").size() == 0){
		 $('#bpsMask').show();
		 var w = $(window);
		 $('#reprintLastTrx').show();
		 $('#reprintLastTrx').css('top',Math.abs(((w.height() - $('#reprintLastTrx').outerHeight()) / 2) + w.scrollTop()));
		 $('#reprintLastTrx').css('left',Math.abs(((w.width() - $('#reprintLastTrx').outerWidth()) / 2) + w.scrollLeft()));
	 
		 $.ajax({
				type: "POST",  
				url: 'reprintLastTransaction.action',
				data: '',					 
				dataType: "json",
				async:true,
				success: function(data) {
					
					if(data.task == 'success'){
						$('#reprintMsgDiv').html('Reprinted last valid transaction completed successfully.');
						hideManagerFunctions();
						$('#closeReptintButton').show();
					}else{
						$('#reprintMsgDiv').html('Reprinting last valid transaction failed.');
						$('#closeReptintButton').show();
					}
				},
				error: function(xhr, msg, e) {
					//alert(e);
				}
			});
	 }else{
		 alert('Reprint is not allowed while transaction is in process.');
	 }
 }
 
 
 function isNumberKey(evt){
	 var charCode = (evt.which) ? evt.which : evt.keyCode;
	 if ( ! ( charCode > 47 && charCode < 58 )  && charCode != 8)
	 {
		 return false;
	 }
	 return true;
 }
 
 
 // method to check if SOA is already processed.
 // Modified method to return string value. 
 function check_for_duplicate_txn(soa_num, whereCondition){
	 
	 var data = 'billerId='+$('#billerId').val()+'&soaNum='+soa_num+'&whereCondition='+whereCondition;
	// alert(data);
	 var status = 'false';
	 $.ajax({
			type: "POST",  
			url: 'checkSOARefNum.action',
			data: data,					 
			dataType: "json",
			async:false,
			success: function(data) {
				//alert(data.status);
				if(data.task == 'success'){
					if(data.status == '0'){
						status = 'true';
					}
				}
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
	 return status;
 }