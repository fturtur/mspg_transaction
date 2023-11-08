/*Cebu Pacific Webservice Integration - START*/
/*status is set to true/false based on the result of getPaymentStatus. 
If it is set true, the tender page will be displayed*/
var status;
/*serviceData holds the result string that webservice returns in*/
var serviceData;
/*Cebu Pacific Webservice Integration - END*/	
	function editBillerDetails(index){
			
			if(index!= "" && $('#billerTable') && $('#billerTable tr').length>0){
				//$('.imgClass').hide();
				$.ajax({
					type: "POST",  
					url: "editBillerDetails.action",
					data:  "index="+index,
					dataType: "text",
					async:true,
					success: function(data) {
						$('#commonArea').hide();
						$('#billers').show();
						$('#billersContainer').html(data);
						$('#billersContainer').show();					
						$('#billerIndex').val(index);					
						$('#tenderIndex').val("");
						//$('#tenderTable').show();
						$("#tenderRow").show();			
						//$('#dynamicTenderTable').hide();
						//removeTable();
						$('#billersPolicies').find('#billerPoliciesTable').remove();
						$('#billerPoliciesTable').clone().appendTo($('#billersPolicies'));			
						$('#billersPolicies').show();
						
						$('#dynamicTenderTable').find('#tenderfieldsDiv').remove();
						$('#totalAmount').find('#totAmtTable').remove();
						
						setJavaScript();
						setErrorSpan();
						var payment = $('#payment').val();
						if('' != payment && typeof payment != 'undefined'){
							payment =  payment.replace(/P|\,|\./g, '');
							/*payment = payment.replace(/[^0-9\.]+/g, '');
							payment = payment.replace(/[^0-9\P]+/g, '');*/
//							payment = payment.trim();
							$('#payment').val(payment);
						}
//						if($('#processOnLoad') && $('#processOnLoad').val() == 'Y' && $('#billerBarcodeExists').val() == 'N'){
						if($('#processOnLoad') && $('#processOnLoad').val() == 'Y'){
							fun_onload();
						}
						$('.imgClass').hide();
						$(".delImgClass").hide();
					},
					error: function(xhr, msg, e) {
						alert(e);
					}
				});		
			}
		return false;
	}
	function setEditJavaScript(){
		
		$('#editScriptDiv').html('');
		var jsDivs = $('.editTempDiv');
		
		var content = '';
		for(var i =0;i<jsDivs.length;i++){

			content = content + $(jsDivs[i]).text();			
		}	
		
		content = '<script>'+content+'</script>';
		
		$('#editScriptDiv').html(content);
	}
	function deleteBillerDetails(index){
		
		var billerId = $('#billerId').val();
		var trClass=$('.trClass');
		var flag = confirm("Are you sure want to delete the transaction line data?");
		
		if(flag){
			if(trClass!=null && trClass!=undefined && trClass.length>1){
				//alert('deleteBillerDetails ='+$('#checkDetails').val());
				if($('#checkDetails') && $('#checkDetails').val() != ''){
					var deletedVals = $('#checkDetails_'+index).val().split(',');
					//alert('deleteBillerDetails ='+deletedVals);
					if(deletedVals.length > 0){
						for(var i=0;i<deletedVals.length;i++){
							restCheckDetails(deletedVals[i]);
						}
					}else{
						restCheckDetails($('#checkDetails_'+index).val());
					}
					
				}
				if($('#otherDetails') && $('#otherDetails').val() != ''){
					var deletedVals = $('#otherDetails_'+index).val().split(',');
					//alert('deleteBillerDetails ='+deletedVals);
					if(deletedVals.length > 0){
						for(var i=0;i<deletedVals.length;i++){
							restOtherDetails(deletedVals[i]);
						}
					}else{
						restotherDetails($('#otherDetails_'+index).val());
					}
					
				}
			
				$.ajax({
					type: "POST",  
					url: "deleteBillerDetails.action",
					data: "index="+index+"&billerId="+billerId,
					dataType: "text",
					async:true,
					success: function(data) {			
						$('#centertablePanel').html(data);				
						$("#billersContainer").hide();				
						$('#billerIndex').val("");
						$('#tenderIndex').val("");
						//$('#tenderTable').show();
						$("#tenderRow").show();			
						//$('#dynamicTenderTable').hide();
						removeTable();
											
						if($('#billerTable') && $('#billerTable tr').length==0){
							$('#suspendId').hide();
							$('#resumeId').show();
							$('#voidButton').show();
							$('#signOut').show();
						}
					},
					error: function(xhr, msg, e) {
						alert(e);
					}
				});
			}else{
				location.reload(true);
			}
		}

	}
	
	function findLastEditLine(){
		var editFlag = "";
		var lineNum = "";
		
		editFlag = $('#editLineFlag').val();
		lineNum = $('#editLineNum').val();
		
		if(editFlag!="" && editFlag=='Y'){
			if(lineNum!=""){
				if($('#tableItems tr').length>0){					
					$('#biller_field_'+lineNum).attr("style","background:#F4F4F8");
					$('#tender_field_'+lineNum).attr("style","background:#F4F4F8");
				}
			}
		}
	}

	// Hotkey for Ctrl+del to delete all transaction lines data.
	$(document).bind('keydown', 'Ctrl+del', function (evt){        	
		if(evt.ctrlKey && ( evt.keyCode == 46 )){
			
			if($('#billerTable') && $('#billerTable tr').length>0 && $('#deleteTrxLinesInProcess').val() == 'false'){
				deleteTrxDetails();
				$("#tenderRow").show();
				 event.preventDefault();
				return false;
			}	
			
			if($('#billerTable') && $('#billerTable tr').length==0)
				$('#signOut').show();
			
		}        	
	});
	
	// hidding the barcode popup when using on escape
	$(document).bind('keydown', 'esc', function (evt){
		if(evt.keyCode==27){
			evt.preventDefault();
			var billerBarcodeCss=$('#billerBarcode').css('display');
			var voidBarcodeDiv=$('#barcodeDiv').css('display');
			//alert(billerBarcodeCss);
			//alert(voidBarcodeDiv);
			if(billerBarcodeCss!=undefined && billerBarcodeCss!='none'){
				$('#billerBarcode').hide();
				$('#bpsMask').hide();
				//alert($('#billerScreenFieldsForm').find("input[type='text']:first"));
				$('#billerScreenFieldsForm').find("input[type='text']:first").focus();
			}
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
	
	//hot key for last edit transaction line details.
	$(document).bind('keydown', 'f2',function (evt){
		if(evt.keyCode==113){			
			findLastEditLine();
		 	return false;
		 }
	 });
	
	
	//hot key for logout
	 $(document).bind('keydown', 'f5',function (evt){
		 var flag = false;
		 if(evt.which == 116 && !flag){
			 
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
			 //openCloseDivs('pickup');
			 //$('#loginDiv').show();
			 //newPickUpActivity();
			 if(!$('#pickUpButton').is(':hidden')){
				 pickup();
			 }
			 return false;
		 }
	 });
	 
	 //hot key for precommit
	 $(document).bind('keydown', 'f10',function (evt){
		 if(evt.keyCode==121){
			 precommit();
			 return false;
		 }
	 });
	 
	 //hot key for smac
	 $(document).bind('keydown', 'f11',function (evt){
		 if(evt.keyCode==122){
			 smacInfo();
			 openCloseDivs('smac');
			 return false;
		 }
	 });

	 var lowAmount=false;
	 var paymentAreaRendered=false;

	/*6152 START*/
	 var tenderValidationDone=false;
	/*6152 END*/
	 //hot key for sumbit the transaction lines data
	 $(document).bind('keydown', 'f12',function (evt){
		 if(evt.keyCode==123){
			 evt.preventDefault();
			/*6152 START*/
			 callRenderPaymentArea();
			/*6152 END*/
		 }
	 });
	/*6152 START*/
	 function callRenderPaymentArea(){
		if(!isTenderPageOpen){
			 if(!paymentAreaRendered){
				renderPaymentArea();
			 }
	 	}else{
	 		alert("Please Complete All Tender Related Fields.");
	 	}
		 return false;
	 }
	//SAMPLE BILLER NAME FIX - START
	 var isValidationOnly = false;
	//SAMPLE BILLER NAME FIX - END
	 function renderPaymentArea(){
		if($('#tableItems') && $('#tableItems').find('#billerTable tr').length>0 && $('#tableItems').find('#tenderTable tr').length>0 && 
			($('#tableItems').find('#billerTable tr').length == $('#tableItems').find('#tenderTable tr').length)){
			 var enterCashEle = $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash');
			 if($(enterCashEle) && $(enterCashEle).val() == '' && $('#totalCashAmt') && /*6152*/parseFloat($('#totalCashAmt').val())/*6152*/ > 0 && $('#enterCash') && $('#enterCash').val() == ''){
				 $('#totalAmount').find('#totAmtTable').remove();
				 $('#totAmtTable').clone().appendTo($('#totalAmount'));			
				 $('#totalAmount').show(); 
				 showCash();
			 }else{
				//SAMPLE BILLER NAME FIX - START
				isValidationOnly = true;
				//SAMPLE BILLER NAME FIX - END
				validateValues();
				if(tenderValidationDone){
					 if(!paymentAreaRendered){
						showCash();
						if(printerStat){
							paymentAreaRendered=true;
						 }else{
							paymentAreaRendered=false;							
						 }
					 }
					 tenderValidationDone = false;
				 } 
			 }
		 }else{
			 if (($('#tableItems').find('#billerTable tr').length != $('#tableItems').find('#tenderTable tr').length))
			 {
				 alert("All tenders for the lines are not completed");
			 } else{
				 alert("No transactions are available");
			 }
		 }
		 if($('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash')!=undefined){
			 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
		 }
	 }
/*6152 END*/
	 
	//hot key for submit the Biller Fields data
	 $(document).bind('keydown', 'f3',function (evt){
		 if(evt.keyCode==114){
			 $('#commonArea').hide();
			 $('#billers').show();
			 return false;
		 }
	 });
	 
	
	 
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
//			 $('#loginDiv').hide();
		 }		 
	 }
	
	function deleteTrxDetails(){
		$('#deleteTrxLinesInProcess').val('true');
		if($('#billerTable tr').length>0){
			var flag = confirm("Are you sure want to deleting all the transaction lines data?");
			if(flag){
				location.reload(true);
				/*$.ajax({
					type: "POST",  
					url: "deleteTrxDetails.action",						 
					dataType: "text",
					async:true,
					success: function(data) {
						
						$('#centertablePanel').html(data);						
						$("#billersContainer").hide();
						$('#billerIndex').val("");
						$('#tenderIndex').val("");
						$('#deleteTrxLinesInProcess').val('false');
						$('#signOut').show();
						removeTable(); 						
						return false;
					},
					error: function(xhr, msg, e) {
						alert(e);
					}
				});	        	
				return false;    */ 	
			}			
		}			
	}
	
	/*6152 START*/
	var removeTableTriggered=false;
	function removeTable(){
		$('#billersPolicies').find('#billerPoliciesTable').remove();
		$('#totalAmount').find('#totAmtTable').remove();
		$('#dynamicTenderTable').find('#tenders').remove();

		if($('#tableItems') && $('#tableItems').find('#billerTable tr').length>0){
			editTenderDetails($('#tableItems') && $('#tableItems').find('#billerTable tr').length);
			removeTableTriggered=true;
		}
	}
	/*6152 END*/
	
	function showCash(){
		if($('#tableItems') && $('#tableItems').find('#billerTable tr').length>0 && $('#tableItems').find('#tenderTable tr').length>0 &&
			($('#tableItems').find('#billerTable tr').length == $('#tableItems').find('#tenderTable tr').length)){

			 $('#billersPolicies').hide();
			 $("#billersContainer").hide();

			 $('#totalAmount').find('#totAmtTable').remove();
			 $('#totAmtTable').clone().appendTo($('#totalAmount'));			
			 $('#totalAmount').show();
			/*6152 START*/
			 paymentAreaRendered = true;
			 if($('#totalCashAmt') && /*6152*/parseFloat($('#totalCashAmt').val())/*6152*/ > 0){
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').show();
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
			 }else{
			 
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').show();	
				 saveTransaction();				
			 }
			 /*6152 END*/
		 }else{
			 if (($('#tableItems').find('#billerTable tr').length != $('#tableItems').find('#tenderTable tr').length))
			 {
				 alert("All tenders for the lines are not completed");
			 } else{
				alert("No transactions are available");
			 }
		 }
	}
	
	function calculateChangeAmt(obj){
		
		var changeAmt="";
		var enterCashAmt="";
		var cashAmt = "";
		
		if($('#totalAmt'))	
			 totAmt = $('#totalAmt').val();
		
		if($('#totalCashAmt'))
			cashAmt = $('#totalCashAmt').val();
		
		if($('#totalCashAmt') && typeof cashAmt != 'undefined'){
			
			 if($('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash')){
				 //currencyFormat(obj);
				 enterCashAmt = $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').val();		
			 }
			
			/* if(enterCashAmt=="" && cashAmt != ""){
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
				 alert("Enter the amount");				 
				 return false;
			 }*/
			
			 var discountAmt = $('#discountAmt').val();
			 
			 if(enterCashAmt!="" && cashAmt != ""){
				 enterCashAmt = enterCashAmt.replace(/,/gi, "");
				 cashAmt = cashAmt.replace(/,/gi, "");
				 
				 if(discountAmt != '' && typeof discountAmt != 'undefined'){
					 var tempCash = cashAmt;
					 discountAmt = discountAmt.replace(/,/gi, "");
					 
					 cashAmt = cashAmt - discountAmt;
					 if(parseFloat(enterCashAmt)<parseFloat(cashAmt)){
						 //$('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').val('');
						 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html('0.00');
						 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
						 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html('0.00');
						 alert("Enter the amount which is greater than or equal to cash amount, cash ="+tempCash+", discount="+discountAmt);
						 lowAmount=true;
						 return false;
					 }
				 }else  if(parseFloat(enterCashAmt)<parseFloat(cashAmt)){
					 //$('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').val('');
					 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html('0.00');
					 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
					  $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html('0.00');
					 alert("Enter the amount which is greater than or equal to cash amount");
					 lowAmount=true;
					 return false;
				 }
			 }
			 
			 if(enterCashAmt!="" && cashAmt != ""){				 
				 changeAmt = parseFloat(enterCashAmt) - parseFloat(cashAmt);		
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html(changeAmt.toFixed(2));
				 lowAmount=false;
				 return true;
			 }
		}else{
			lowAmount=false;	
			 return true;
		}
	}
var duplicateSubmit=false;
	 function saveTransaction(){
	 	/*6152 START*/
		paymentAreaRendered = false;
		/*6152 END*/
		if(!duplicateSubmit){
			duplicateSubmit=true;
		var cashAmt="";
		var changeAmt="";
		var enterCashAmt="";
		var processMode = "";
		
		if(!calculateChangeAmt()){
			duplicateSubmit=false;
			return false;
		}
		
		 enterCashAmt = $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').val();		
		 changeAmt = $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html();
		 //// -- CORRECTION FOR OFFLINE TRANSACTION - START -- ////
		 //processMode = $('#billerCardProcessMode').val();
		 //processMode = $('#billerProcessingMode').val();
		 //// -- CORRECTION FOR OFFLINE TRANSACTION - END -- ////
		 
		 /* -- Mixed Online and Offline Biller fix - START -- */
		 processMode = $('#billerTransProcessingMode').val();
		 /* -- Mixed Online and Offline Biller fix - END -- */
		 $('#bpsMask').show();
		 var w = $(window);
		 $('#trxMsgDiv_error').hide();
		 $('#closeTrxDiv1').hide();
		 $('#closeItemDiv').hide();
		 /*PreSubmit Before Save - START*/	
		 $('#trxMsgDiv').show();
		 /*PreSubmit Before Save - END*/	
		 $('#saveTrxDiv').show();
		 $('#saveTrxDiv').css('top',Math.abs(((w.height() - $('#saveTrxDiv').outerHeight()) / 2) + w.scrollTop()));
		 $('#saveTrxDiv').css('left',Math.abs(((w.width() - $('#saveTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
		 /*PreSubmit Before Save - START*/	
		 if(preSubmitFlag){
//			$('#trxMsgDiv').html('Saving transaction with third party service...');
			if(!fun_preSubmit()){
				duplicateSubmit=false;
				return false;
			}else{

			}
		 }
		 /*PreSubmit Before Save - END*/	
		 
		 $('#trxMsgDiv').html('Saving Transaction in process.');
		 if(isPrinterStatusOk()){
		 
			 if(enterCashAmt == '' || typeof enterCashAmt == 'undefined')
				  cashAmt = 0;
			 else
					 cashAmt = enterCashAmt;
			 
			 var pSub="N";
			 if(preSubmitFlag){
				 pSub="Y";
			 }
			 
			 $.ajax({			 
				 type: "POST",  
				 url: 'saveTransaction.action?changeAmt='+parseFloat(changeAmt).toFixed(2)+"&cashAmt="+cashAmt+"&processMode="+processMode+"&preSubmitMark="+pSub,							 
				 dataType: "json",
				 async:true,
				 success: function(data) {		
					 if(data.task == 'success'){
						 $('#cashInhand').val(data.cashInhand);	
						 validateCashTreshold();
						 /*Cebu Pacific Webservice Integration - START*/		
						 if(printTransaction()){						
							
							 $('#trxMsgDiv').html('Transaction saved successfully.');
							 $('#trxMsgDiv_success').hide();
							 $('#trxMsgDiv').show();
							 if(!postSubmitFlag){
							 $('#closeTrxDiv').show();
							 $('#closeTrxDiv').focus();
						 }else{
								 $('#trxMsgDiv').html('Transaction saved successfully. <br/>Calling third party service...');
							 }
						 }else{
							 alert("Printing failed");
							 if(postSubmitFlag){
								 $('#trxMsgDiv').html('Calling third party service...');
							 }else{
								 $('#closeTrxDiv').show();
							 }
						 }
						 
						 if(postSubmitFlag){
							 fun_postSubmit();
						 }
								 
					 }else if(data.task == 'failed'){
						 $('#trxMsgDiv').html(data.message);
						 $('#closeSaveTrxErrorButton').show();
						 
					 }
					 //$('#closeTrxDiv').show();
					/*Cebu Pacific Webservice Integration - END*/	
				 },
				 error: function(xhr, msg, e) {
					 alert(e);
				 }
			 });
			}
		}
	 }
	 
	function closeOnlineErrorDiv(){
		$('#closeSaveTrxErrorButton').hide();
		$('#bpsMask').hide();
		$('#saveTrxDiv').hide();
		callRenderPaymentArea();
	}


	function onlineTransaction(){
		 $.ajax({			 
				type: "POST",  
				url: 'onlineTransaction.action',							 
				dataType: "json",
				async:false,
				success: function(data) {		
					if(data.task == 'success'){
						$('#trxMsgDiv').html('Transaction saved successfully.');
						$('#trxMsgDiv_success').hide();
						$('#trxMsgDiv').show();
					}else if(data.task == 'failed'){
						 $('#trxMsgDiv').html(data.message);
						 $('#closeSaveTrxErrorButton').show();
					}
					//$('#closeTrxDiv').show();
				},
				error: function(xhr, msg, e) {
					alert(e);
				}
			});	
	 }
	function printTransaction(){
		var printCompeted = false;
		var trs = $('#billerTable tr');
		if(!printTender()){
			
			return false;
		}else{
			printCompeted = true;
		}
		if(!printOther()){
			return false;
		}else{
			printCompeted = true;
		}
		for(var i=1; i <= trs.length; i++){
			
			var billerName = $('#billerName_'+i).html();
			if(!printSOA(i, billerName)){
				return false;
			}else{
				printCompeted = true;
			}
		}
		if(!printAck()){
			return false;
		}else{
			printCompeted = true;
		}
		if(!printServiceFee()){
			return false;
		}
		return printCompeted;
	}
	function printSOA(index, billerName){
		
		alert('Insert SOA '+billerName+'.');
		var printCompleted = false;
		$.ajax({
			type: "POST",  
			url: 'printTransaction.action',		
			data: 'billerSeqId='+index+'&task=soa',
			dataType: "json",
			async:false,
			success: function(data) {
				
				if(data.task == 'success'){
					
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').show();
					$('#trxMsgDiv_error').hide();
					//alert('Print SOA of '+billerName+' completed successfully');
					printCompleted = true;
				}else{
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').hide();
					$('#trxMsgDiv_error').show();
					$('#trxMsgDiv_error').html('Error while printing SOA  of '+billerName);
					$('#closeTrxDiv').show();
				}
				
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
		});	
		return printCompleted;
	}
	function printTender(){
	// Modified to resolve duplicate check print
		var checkDetails = $('#checkDetails').val();
//		if(checkDetails == ''){
			var checkDetailsRes = $('.printCheckDetails');
			for(var i=0;i<checkDetailsRes.length;i++){
				if(checkDetails == ''){
					checkDetails = $(checkDetailsRes[i]).val();
				}else{
					checkDetails = checkDetails+','+$(checkDetailsRes[i]).val();
				}
			}
//		}
		var printCheckDetails = checkDetails.split(',');
		var printTenders = false;
		var oldValues = '';
		for(var i=0;i<printCheckDetails.length;i++){
				
			var printDetails = printCheckDetails[i];
			printDetails = printDetails.replace(',', '');
			var printDetailsSP = printDetails.split(':');
			if(printDetailsSP[0] != ''){
				
				if(checkProcessedTenders(oldValues, printDetailsSP[0], i)){
					
					if(oldValues == ''){
						oldValues = printDetailsSP[0];
					}else{
						oldValues = oldValues+','+printDetailsSP[0];
					}
					alert('Insert Check number '+printDetailsSP[0]+'.');
					$.ajax({
						type: "POST",  
						url: 'printTransaction.action',		
						data: 'billerSeqId='+printDetailsSP[0]+'&task=tender',
						dataType: "json",
						async:false,
						success: function(data) {
							
							if(data.task == 'success'){
								
								$('#trxMsgDiv').hide();
								$('#trxMsgDiv_success').show();
								$('#trxMsgDiv_error').hide();
								//alert('Insert Check number '+printDetailsSP[0]+' completed successfully');
								printTenders = true;
							}else{
								$('#trxMsgDiv').hide();
								$('#trxMsgDiv_success').hide();
								$('#trxMsgDiv_error').show();
								$('#trxMsgDiv_error').html('Error while printing check number '+printDetailsSP[0]);
								$('#closeTrxDiv').show();
							}
							
						},
						error: function(xhr, msg, e) {
							alert(e);
						}
					});
				}
				
			}else{
				printTenders = true;
			}
		}
	//	alert(printTenders);
		return printTenders;
	}
	
	function printOther(){
		
			var otherDetails = $('#otherDetails').val();
			var otherDetailsRes = $('.printOtherDetails');
			
				for(var i=0;i<otherDetailsRes.length;i++){
					if(otherDetails == ''){
						otherDetails = $(otherDetailsRes[i]).val();
					}else{
						otherDetails = otherDetails+','+$(otherDetailsRes[i]).val();
					}
					
				}
			var printOtherDetails = otherDetails.split(',');
			var printOthers = false;
			var oldValues = '';
			for(var i=0;i<printOtherDetails.length;i++){
					
				var printDetails = printOtherDetails[i];
				
				if(printDetails != ''){
					if(checkProcessedTenders(oldValues, printDetails, i)){
						
						if(oldValues == ''){
							oldValues = printDetails;
						}else{
							oldValues = oldValues+','+printDetails;
						}
						alert('Insert validation for other tender '+printDetails+'.');
						$.ajax({
							type: "POST",  
							url: 'printTransaction.action',		
							data: 'billerSeqId='+printDetails+'&task=other',
							dataType: "json",
							async:false,
							success: function(data) {
								
								if(data.task == 'success'){
									
									$('#trxMsgDiv').hide();
									$('#trxMsgDiv_success').show();
									$('#trxMsgDiv_error').hide();
									//alert('Insert Check number '+printDetailsSP[0]+' completed successfully');
									printOthers = true;
								}else{
									$('#trxMsgDiv').hide();
									$('#trxMsgDiv_success').hide();
									$('#trxMsgDiv_error').show();
									$('#trxMsgDiv_error').html('Error while printing check number '+printDetailsSP[0]);
									$('#closeTrxDiv').show();
								}
								
							},
							error: function(xhr, msg, e) {
								alert(e);
							}
						});
					}
					
				}else{
					printOthers = true;
				}
			}
			return printOthers;
		}
	
	function checkProcessedTenders(processedTenders, newTender, i){
		if(i > 0){
			var proccessedTenderSP = processedTenders.split(',');
			for(var j=0;j<proccessedTenderSP.length;j++){
				//alert('proccessedTenderSP[j] ='+proccessedTenderSP[j]);
				//alert('newTender ='+newTender);
				if(proccessedTenderSP[j] == newTender){
					//alert('checkProcessedTenders =false');
					return false;
				}
			}
		}
		//alert('checkProcessedTenders =true');
		return true;
	}
	function printAck(index, billerName){
		//alert('Printing acknowledgement reciept.');
		var printCompleted = false;
		$.ajax({
			type: "POST",  
			url: 'printTransaction.action',		
			data: '&task=ack',
			dataType: "json",
			async:false,
			success: function(data) {
				
				if(data.task == 'success'){
					
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').show();
					$('#trxMsgDiv_error').hide();
					//alert('Print acknowledgement reciept completed successfully');
					
					printCompleted = true;
				}else{
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').hide();
					$('#trxMsgDiv_error').show();
					$('#trxMsgDiv_error').html('Print acknowledgement reciept failed.');
					$('#closeTrxDiv').show();
				}
				
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
		});	
		return printCompleted;
	}
	function printServiceFee(){
		var printCompleted = false;
		var isServiceFeeExist = false;
		var tableRows=$('.trClass');
		var serviceFee = 0;
		//alert(tableRows.length);
		for(var i=0;i<tableRows.length;i++){
			serviceFee = $('#serviceFee_'+(i+1)).html();
			serviceFee = serviceFee.replace('P', '').replace(',' , '');
			//alert('serviceFee 1 ='+serviceFee);
			serviceFee = parseInt(serviceFee);
			//alert('serviceFee 1 ='+serviceFee);
			if(serviceFee > 0){
				isServiceFeeExist = true;
				break;
			}
		}
		if(isServiceFeeExist){
			
			//alert('Printing service fee.');
			$.ajax({
				type: "POST",  
				url: 'printTransaction.action',		
				data: 'task=serviceFee',
				dataType: "json",
				async:false,
				success: function(data) {
					
					if(data.task == 'success'){
						
						$('#trxMsgDiv').hide();
						$('#trxMsgDiv_success').show();
						$('#trxMsgDiv_error').hide();
						//alert('Transaction completed successfully');
						printCompleted = true;
					}else{
						$('#trxMsgDiv').hide();
						$('#trxMsgDiv_success').hide();
						$('#trxMsgDiv_error').show();
						$('#trxMsgDiv_error').html('Transaction printing failed.');
						$('#closeTrxDiv').show();
					}
					
				},
				error: function(xhr, msg, e) {
					alert(e);
				}
			});	
		}else{
			printCompleted = true;
		}
		
		return printCompleted;
	}
	
	function checkBlank(thiz){
		if(thiz.value==null  || thiz.value==''){
			 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
			 alert("Enter the amount");				 
			 return false;
		}
	}
	 /*Cebu Pacific Webservice Integration - START*/	
	function closeTrxxDiv(){
		$("#saveTrxDiv").hide();
		$("#bpsMask").hide();
	}
	 /*Cebu Pacific Webservice Integration - END*/	  





	function isPrinterStatusOk(){
	printerStat = false;
	$.ajax({
		type: "POST",  
		url: 'getPrinterStatus.action',		
//		data: 'billerSeqId='+index+'&task=soa',
		dataType: "json",
		async:false,
		success: function(data) {
			if(data.printerStatusMsg == 'OK'){
				printerStat = true;
//				$('#trxMsgDiv').hide();
//				$('#trxMsgDiv_success').show();
//				$('#trxMsgDiv_error').hide();
				//alert('Print SOA of '+billerName+' completed successfully');
		
			}else{
//				alert('Printer: ' + data.printerStatusMsg);
				$('#trxMsgDiv').hide();
				$('#trxMsgDiv_success').hide();
				$('#trxMsgDiv_error').show();
				$('#trxMsgDiv_error').html('Printer: ' + data.printerStatusMsg);
				$('#closeTrxDiv').show();
				printerStat=false;
			}
			
		},
		error: function(xhr, msg, e) {
			alert(e);
		}
	});	
	return printerStat;
}	