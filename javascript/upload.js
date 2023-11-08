function upload(){
	document.location.href="showUploadBillerTemplate";
}

function templateUpload() {
	var billerFile = $('#billerFile').val();
	var offlineVal = $('#offlineTemp').val();
	var cutOffTemp = $('#cutOffTemp').val();
	var errorTemp = $('#errorTemp').val();
	
	if(offlineVal == "true"){
		alert("Upload Biller can not be processed in offline mode.");
	}else if(cutOffTemp == "true"){
		alert("Biller processing time exceeded.");
	}else if (billerFile == "" || billerFile == "-1") {
		alert("Biller Template is required.");
	} else {
		var fileValue = $('input[type=file]').val();
	    var fileParts = fileValue.split('.');
	    var fileType = fileParts[fileParts.length - 1];
		
//		var myFSO = new ActiveXObject("Scripting.FileSystemObject");
//		var thefile = myFSO.getFile(billerFile);
//		var size = thefile.size;
		
		if (fileType == "xls") {
			/*if(size > 10485760){
				alert("File size is too large.");
				document.location.href="showUploadBillerTemplate";
				return false;
			} else {
				document.uploadBiller.submit();
			}*/
			document.uploadBiller.submit();
		} else {
		   alert("Invalid file! Please select excel(.xls) file only.");
		   document.location.href="showUploadBillerTemplate";
		   return false;
		}
	}
}

function back() {
	document.location.href="/Terminal/initTransactionPage.action";
	//window.location.href = '/initTransactionPage.action';
}

function onUpload(){
	var offlineVal = $('#offlineTemp').val();
	var cutOffTemp = $('#cutOffTemp').val();
	var errorTemp = $('#errorTemp').val();
	
	if(offlineVal == "true"){
		alert("Upload Biller can not be processed in offline mode.");
	}else if(cutOffTemp == "true"){
		alert("Biller processing time exceeded.");
	}else if(errorTemp == "error"){
		alert("Error occurred in processing the biller template.\n Please check biller template contents.");
	}
}

function backToUpload(){
	document.location.href="showUploadBillerTemplate";
}

function autoRefresh() {
//	setInterval( function() {
	setTimeout( function() {
		var bulkUploadId = $('#bulkUploadId').val();
		$.ajax({
			type: "POST",  
			url: "displayBulkUploadList.action",
			data: "bulkUploadId="+bulkUploadId,
			dataType: "text",
			async:true,
			success: function(data) {
				$('#autoRefresh').html(data);
				$('#autoRefresh').show();
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
//	  autoRefresh();
	  
	  var hasOpen = $("#hasOpen").val()
	  if(hasOpen == 1 || hasOpen == '1'){
		  $('#bulkUploadingDiv').show();
		  autoRefresh();
	  } else {
		  $('#bulkUploadingDiv').hide();
	  }
//	}, 5000);
	}, 10000);
}

function retry() {
	var bulkUploadId = $('#bulkUploadId').val();
	var confirmFlag = confirm("Do you want to proceed in retrying the validations?");
	if(confirmFlag) {
		$.ajax({
			type: "POST",  
			url: "validateBulkUploadFields.action",
			data: "bulkUploadId="+bulkUploadId,
			dataType: "text",
			async:true,
			success: function(data) {
//				$('#autoRefresh').html(data);
//				$('#autoRefresh').show();
				autoRefresh();
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
	}
}

function saveBulkUpload() {
	var hasOpen = $("#hasOpen").val();
	var hasFailed = $("#hasFailed").val();
	var hasSuccessful = $("#hasSuccessful").val();
	var allTrxFailed = $("#allTrxFailed").val();
	var paymentType = $("#paymentType").val();
	var bulkUploadFileId = $("#bufId").val();
	var failedLineCount = $("#failedLineCount").val();
	
	var totalValidAmt = $('#totalAmt').val();
	var cashAmt = $('#enterCash').val();
	if(paymentType == 'Cash' && totalValidAmt != "" && cashAmt != "") {
		totalValidAmt = totalValidAmt.replace(/,/gi, "");
		cashAmt = cashAmt.replace(/,/gi, "");
	}
	if(cashAmt == undefined || cashAmt == '') {
		cashAmt = 0.00;
	}
	
	if(allTrxFailed == 1 || allTrxFailed == '1') {
		alert("All lines are in Failed status. Cannot proceed in saving the transaction.");
	} else if(paymentType == 'Check' && 
	   (hasFailed == 1 || hasFailed == '1')) {
		alert("Failed status exist. Cannot proceed in saving the transaction if payment type is check.");
	} else if(hasOpen == 1 || hasOpen == '1'){
		alert("Open status exist.");
	} else if(paymentType == 'Cash' && parseFloat(cashAmt) < parseFloat(totalValidAmt)) {
		alert("Enter cash amount which is greater than or equal to valid total cash amount!");
	} else if(hasSuccessful == 1 || hasSuccessful == '1') {
		var printerStatusMsg = checkPrinterStatus();
		if(printerStatusMsg == 'OK'){
			var msg = "Do you want to proceed in saving the transactions?";
			if(hasFailed == 1 || hasFailed == '1') {
				var failedMsg = "\n There are " + failedLineCount + " failed line/s.";
				msg += failedMsg;
			}
			
			var confirmFlag = confirm(msg);
			if(confirmFlag) {
				$.ajax({
					type: "POST",  
					url: "saveBulkUploadTransaction.action",
					data: "bulkUploadFileId="+bulkUploadFileId+"&totalCashAmt="+cashAmt,
					dataType: "json",
					async: true,
					success: function(data) {
						if(data.task == 'success') {
							if(printBulkUploadTransaction(data)) {
								//alert("Transaction saved successfully.");
								alert(data.message);
							} else{
								 alert("Printing failed!");
							}
							/*document.location.href="showUploadBillerTemplate";
							alert("Transaction saved successfully.");
							for (i = 0; i < data.validations.length; i++) {
								alert("Insert " + data.validations[i]);
							}*/
							$('#uploadBillerList').attr('action', 'showUploadBillerTemplate.action');
							$('#uploadBillerList').submit();
						} else if(data.task == 'failed') {
							//alert("Failed to save the transaction.");
							alert(data.message);
						}
					},
					error: function(xhr, msg, e) {
						//alert(e);
					}
				});
			}
		} else {
			alert(printerStatusMsg);
		}
	}
}

/*function printBulkUploadTransaction(){
	var printCompleted = true;
	$.ajax({
		type: "POST",  
		url: 'printBulkUploadTransaction.action',		
//		data: 'billerSeqId='+printDetailsSP[0]+'&task=tender',
		dataType: "json",
		async:false,
		success: function(data) {
			if(data.task == 'success'){
				printCompleted = true;
			}
		},
		error: function(xhr, msg, e) {
//			alert(e);
		}
	});
	return printCompleted;
}*/

function cancelBillerUpload() {
	var bulkUploadFileId = $("#bufId").val();
	
	var confirmFlag = confirm("Do you want to proceed in cancelling the transactions?");
	if(confirmFlag) {
		$.ajax({
			type: "POST",  
			url: "cancelBulkUploadTransaction.action",
			data: "bulkUploadFileId="+bulkUploadFileId,
			dataType: "text",
			async:true,
			success: function(data) {
				document.location.href="showUploadBillerTemplate";
			},
			error: function(xhr, msg, e) {
				//alert(e);
			}
		});
	}
}

function checkPrinterStatus(){
	//printerStat = false;
	var printerStatusMsg = "";
	$.ajax({
		type: "POST",  
		url: 'getPrinterStatus.action',		
		dataType: "json",
		async:false,
		success: function(data) {
			if(data.printerStatusMsg == 'OK'){
				//printerStat = true;
				printerStatusMsg = data.printerStatusMsg;
			}else{
				//alert('Printer: ' + data.printerStatusMsg);
				//printerStat=false;
				printerStatusMsg = 'Printer: ' + data.printerStatusMsg;
			}
		},
		error: function(xhr, msg, e) {
			//alert(e);
		}
	});	
	//return printerStat;
	return printerStatusMsg;
}

function calculateBulkChangeAmt(obj) {
	var totalAmt = "";
	var enterCashAmt = "";
	var cashAmt = "";
	var changeAmt = "";
	
	if($('#totalAmt'))	
		totalAmt = $('#totalAmt').val();
	
	if($('#enterCash'))
		cashAmt = $('#enterCash').val();
	
	if($('#changeAmt'))
		changeAmt = $('#changeAmt').val();
	
	if(totalAmt != "" && cashAmt != "") {
		totalAmt = totalAmt.replace(/,/gi, "");
		cashAmt = cashAmt.replace(/,/gi, "");
		
		if(parseFloat(cashAmt) < parseFloat(totalAmt)) {
			$('#changeAmt').val("0.00")
			alert("Enter the amount which is greater than or equal to valid total cash amount!");
		} else {
			changeAmt = parseFloat(cashAmt) - parseFloat(totalAmt);
			$('#changeId').html(changeAmt.toFixed(2))
		}
	}
}

function printBulkUploadTransaction(data){
	var printCompleted = false;
	if(!printBulkUploadTender(data)){
		return false;
	}else{
		printCompleted = true;
	}
	for(var i=0; i < data.soa.length; i++){
		var lineCount = data.soa[i];
		if(!printBulkUploadSOA(i, lineCount)){
			return false;
		}else{
			printCompleted = true;
		}
	}
	if(!printBulkUploadAck()){
		return false;
	}else{
		printCompleted = true;
	}
	if(!printBlkUploadServiceFee(data.hasServiceFee)){
		return false;
	}
	return printCompleted;
}

function printBulkUploadTender(data) {
	var printTender = false;
	if(data.check != undefined) {
		alert('Insert Check number ' + data.check + '.');
		$.ajax({
			type: "POST",  
			url: 'printBulkUploadTransaction.action',		
			data: 'billerSeqId='+data.check+'&task=tender',
			dataType: "json",
			async: false,
			success: function(data) {
				if(data.task == 'success'){
					//alert('Check number ' + data.check + ' printed successfully');
					printTender = true;
				}else{
					alert("Error while printing check number " + data.check + ".");
				}
				
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
		});
	} else {
		printTender = true;
	}
	
	return printTender;
}

function printBulkUploadSOA(index, lineCount) {
	alert('Insert SOA for ' + lineCount + ' lines.');
	var printSOA = false;
	$.ajax({
		type: "POST",  
		url: 'printBulkUploadTransaction.action',		
		data: 'billerSeqId='+index+'&task=soa',
		dataType: "json",
		async: false,
		success: function(data) {
			if(data.task == 'success'){
				//alert('SOA for ' + lineCount + ' lines printed successfully');
				printSOA = true;
			}else{
				alert("Error while printing SOA for " + lineCount + " lines.");
			}
			
		},
		error: function(xhr, msg, e) {
			alert(e);
		}
	});
	
	return printSOA;
}

function printBulkUploadAck() {
	//alert('Printing acknowledgement receipt.');
	var printAck = false;
	$.ajax({
		type: "POST",  
		url: 'printBulkUploadTransaction.action',		
		data: 'task=ack',
		dataType: "json",
		async:false,
		success: function(data) {
			if(data.task == 'success'){
				//alert('Printing acknowledgement receipt completed successfully');
				printAck = true;
			}else{
				alert("Printing acknowledgement receipt failed.");
			}
		},
		error: function(xhr, msg, e) {
			alert(e);
		}
	});
	
	return printAck;
}

function printBlkUploadServiceFee(hasServiceFee) {
	var printServiceFee = false;
	if(hasServiceFee){
		//alert('Printing service fee receipt.');
		$.ajax({
			type: "POST",  
			url: 'printBulkUploadTransaction.action',		
			data: 'task=serviceFee',
			dataType: "json",
			async:false,
			success: function(data) {
				if(data.task == 'success'){
					//alert('Printing service fee receipt completed successfully');
					printServiceFee = true;
				}else{
					alert("Printing service fee receipt failed.");
				}
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
		});	
	} else {
		printServiceFee = true;
	}
	
	return printServiceFee;
}
