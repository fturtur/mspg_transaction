var hasSecondBarcode='N';
var barcode2='';
var screenValue='';
function functionsOnSearchText(){
	disableFreeDetItem();
	autoComplete();
}

function autoComplete(){		
	$('#msgId').html('');
	var searchText = $('#searchText').val(); 
	var searchImg = $('#searchImg').val(); 
	$('#cardProfileArea').hide();
	if(searchText!=undefined && searchText!="" && searchText.length>=3){
			$.ajax({
				type: "POST",  
				url: "skuAutoComplete.action",
				data: "searchText="+searchText+"&searchImg="+searchImg,
				dataType: "text",
				async:true,
				success: function(data) {
					//alert(data);
					if(data.match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)){
						$('#barcode').hide();
						$('#totalAmtDiv').hide();
						$('#cardsContainer').html(data);
						$('#cardsContainer').show();
						var barCode=$('#barCode').val();
						if(barCode!=null && barCode!=""){
							if(hasSecondBarcode=='Y'){
								$('#bpsMask').show();
								$('#secondBarcodeDiv').show();
								$('#secondBarcodeDiv').css('top',Math.abs(((w.height() - $('#secondBarcodeDiv').outerHeight()) / 2) + w.scrollTop()));
								$('#secondBarcodeDiv').css('left',Math.abs(((w.width() - $('#secondBarcodeDiv').outerWidth()) / 2) + w.scrollLeft()));
								$('#secondBarcode').focus();
							}
						}
					}else{
						if(!isNaN(searchText) && searchText.length==13 && data.indexOf('free dept item')!=-1){
							 var w = $(window);
							 $('#bpsMask').show();
							 $('#freeDeptItemDiv').show();
							 $('#freeDeptItemDiv').css('top',Math.abs(((w.height() - $('#freeDeptItemDiv').outerHeight()) / 2) + w.scrollTop()));
							 $('#freeDeptItemDiv').css('left',Math.abs(((w.width() - $('#freeDeptItemDiv').outerWidth()) / 2) + w.scrollLeft()));
							 //$('#freeDeptItemMsgDiv').html(data);
						}else{
							if(data.indexOf('free dept item')==-1 && searchText.length!=13){
								alert(data);
							}
							if(data.indexOf('Mixed transactions are not allowed')==-1 || data.indexOf('Items with different receipt types are not allowed')==-1 || data.indexOf('Mixed with online services transactions are not allowed')==-1 ){
								alert(data);
							}
							
						}
						
					}
					
				},
				error: function(xhr, msg, e) {
					//alert(e);
				}
			});
			
	}else{
		$('#cardsContainer').hide();
		//$('#cardProfileArea').hide();
	}	
}

function checkForFreeDetItem(){
	$('#searchImg').val('Y');
}

function disableFreeDetItem(){
	$('#searchImg').val('N');
}

function renderFreeDeptItem(){
	var searchText = $('#searchText').val(); 
	$.ajax({
		type: "POST",  
		url: "renderFreeDeptItem.action",
		data: "searchText="+searchText,
		dataType: "text",
		async:true,
		success: function(data) {
			if(data.match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)){
				$('#barcode').hide();
				$('#totalAmtDiv').hide();
				$('#cardsContainer').html(data);
				$('#cardsContainer').show();
				$('#freeDeptItemDiv').hide();
				$('#bpsMask').hide();
			}else{
				alert(data);
			}
			
		},
		error: function(xhr, msg, e) {
			//alert(e);
		}
	});
}

function showSkuProfile(index){
	$('#cardProfileArea').html($('#skuProfile'+index).html());
	$('#cardProfileArea').show();
}

function hideSkuProfile(){
	$('#cardProfileArea').html('');
	$('#cardProfileArea').hide();
}

function hideDiv(){
	 $('#cards').show();
	 $('#commonArea').hide();
}

function hidePaymentDiv(){
	 $('#cards').show();
	 $('#paymentMethodsDiv').hide();
	 $('#cardProfileArea').hide();
}


function cashierVoidTrx(){
	$('#msgId').html('');
	if($("#trxLineItems").find("tr").size() == 0){
		 $('#cards').hide();
		 $('#commonArea').show();
		 $('#commonArea').html($('#voidTrxDiv').html());
		 openScanningVoidBarcodePopup(); 
	}else{
		alert('Void is not allowed while transaction is in process.');
	}
}



function showItemDeclaration(){
	//$('#msgId').html('');
	if($("#trxLineItems").find("tr").size() == 0){
		$('#bpsMask').show();
		$.ajax({
			type: "POST",  
			url: 'getSkusForItemDeclaration.action',
			dataType: "text",
			async:true,
			success: function(data) {
				if(data.indexOf("stockId")!=-1){
					 $('#itemDeclarationDiv').html(data);
					 $('#bpsMask').show();
					 $('#itemDeclarationDiv').show();
					 var w = $(window);
					 $('#itemDeclarationDiv').css('top',Math.abs(((w.height() - $('#itemDeclarationDiv').outerHeight()) / 2) + w.scrollTop()));
					 $('#itemDeclarationDiv').css('left',Math.abs(((w.width() - $('#itemDeclarationDiv').outerWidth()) / 2) + w.scrollLeft()));
				}else{
					$('#bpsMask').hide();
				}
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
		});
	}else{
		alert('Item declaration is not allowed while transaction is in process.');
	}
}

function saveItemDeclaration(){
	$('#itemDeclarationButton').attr('disabled',true);
	if(itemDeclarationCompleted=='true'){
		if($('input[name=declarationType]:checked').length<=0){
			alert("Please select declaration type - Replenishment/End-of-Day");
			$('#itemDeclarationButton').removeAttr('disabled');
			return false;
		}
	}
	var formData = $($('#itemDeclaration')).serializeArray();
	$.ajax({
		type: "POST",  
		url: 'saveItemDeclaration.action',
		data: formData,
		dataType: "json",
		async:true,
		success: function(data) {
			 $('#bpsMask').show();
			 if(data.task="success"){
				 itemDeclarationCompleted='true';
				 flag=true;
				 $('#itemDeclarationDiv').hide();
				 var w = $(window);
				 $('#trxMsgDiv_error').hide();
				 $('#trxMsgDiv').hide();
				 $('#saveTrxDiv').show();
				 $('#saveTrxDiv').css('top',Math.abs(((w.height() - $('#saveTrxDiv').outerHeight()) / 2) + w.scrollTop()));
				 $('#saveTrxDiv').css('left',Math.abs(((w.width() - $('#saveTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
				 $('#trxMsgDiv_success').html('Item declaration completed successfully.');
				 $('#trxMsgDiv_success').show();
				 $('#closeItemDiv').show();
			 }else{
				 $('#itemDeclarationDiv').show();
				 var w = $(window);
				 $('#trxMsgDiv_error').hide();
				 $('#trxMsgDiv').hide();
				 $('#saveTrxDiv').show();
				 $('#saveTrxDiv').css('top',Math.abs(((w.height() - $('#saveTrxDiv').outerHeight()) / 2) + w.scrollTop()));
				 $('#saveTrxDiv').css('left',Math.abs(((w.width() - $('#saveTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
				 $('#trxMsgDiv_success').html('Item declaration failed.');
				 $('#trxMsgDiv_success').show();
				 $('#closeItemDiv').show();
			 }
			 $('#itemDeclarationDiv').html('');
		},
		error: function(xhr, msg, e) {
			alert(e);
		}
	});
}

function closeItemDeclaration(){
	 $('#itemDeclarationDiv').hide();
	 $('#bpsMask').hide();
}

function closeItemDiv(){
	$('#saveTrxDiv').hide();
	if(flag){
		$('#bpsMask').hide();
		document.location.href="initPcsTransactionPage.action";
	}
}

function closeFreeDeptItemDiv(){
	$('#freeDeptItemDiv').hide();
    $('#bpsMask').hide();
}

function calculateAmount(thiz,price,index){
	if(thiz.value==null || thiz.value==''){
		thiz.value=0;
	}else if(isNaN(thiz.value)){
		alert('Please enter valid quantity');
		thiz.focus();
		return false;
	}
	var amount=(thiz.value*price).toFixed(2);
	$('#amounttd'+index).html('Php '+amount);
	$('#amount'+index).val(amount);
}

function fetchTransactionScreen(id){
	$('#msgId').html('');
	createCookie("testcookie","1234",10);
	$.ajax({
		type: "POST",  
		url: 'getCardDetails.action',
		data: 'skuID='+id,
		dataType: "text",
		async:true,
		success: function(data) {
			//$('#dummyDiv').html(data);
			if(data.match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)){
				$('#cardsContainer').html(data);
				$('#totalAmtDiv').hide();
				$('#cardProfileArea').html($('#skuProfile').html());
				$('#cardProfileArea').show();
				$('#searchText').val('');
				hideManagerFunctions();
				//alert(hasSecondBarcode);
				var barCode=$('#barCode').val();
				if(barCode!=null && barCode!=""){
					if(hasSecondBarcode=='Y'){
						$('#bpsMask').show();
						$('#secondBarcodeDiv').show();
						$('#secondBarcodeDiv').css('top',Math.abs(((w.height() - $('#secondBarcodeDiv').outerHeight()) / 2) + w.scrollTop()));
						$('#secondBarcodeDiv').css('left',Math.abs(((w.width() - $('#secondBarcodeDiv').outerWidth()) / 2) + w.scrollLeft()));
						$('#secondBarcode').focus();
					}
				}
			}else{
				alert(data);
			}
		},
		error: function(xhr, msg, e) {
			alert(e);
		}
	});
}

function setSecondBarcode(thiz){
	if(thiz.value!=null && thiz.value!='' && (thiz.value).length==13){
		$('#scannedBarcode2').val(thiz.value);
		$('#bpsMask').hide();
		$('#secondBarcodeDiv').hide();
	}
}

function clearSecondBarcode(){
	$('#secondBarcode').val('');
	$('#secondBarcode').focus();
}

function getSkusByCategory(skuCategoryId){
	$('#msgId').html('');
	createCookie("testcookie","1234",10);
	$.ajax({
		type: "POST",  
		url: "getSkusByCategory.action",
		data: "skuCategoryId="+skuCategoryId,
		dataType: "text",
		async:false,
		success: function(data) {
			$('#barcode').hide();
			$('#totalAmtDiv').hide();
			$('#cardsContainer').html(data);
			$('#cardsContainer').show();
		}, 
		error: function(xhr, msg, e) {
		}
	});
}

function getServiceTrx(){
	$('#msgId').html('');
	$.ajax({
		type:"POST",
		url:"getServiceTrx.action",
		dataType: "text",
		async:false,
		success:function(data){
			$('#barcode').hide();
			$('#totalAmtDiv').hide();
			$('#cardsContainer').html(data);
			$('#cardsContainer').show();
			hideManagerFunctions();
		}
	});
}


function getServiceDetails(serviceId){
	$('#msgId').html('');
	$.ajax({
		type:"POST",
		url:"getServiceDetails.action",
		data: "serviceId="+serviceId,
		dataType: "text",
		async:false,
		success:function(data){
			if(data.match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)){
				$('#cardsContainer').html(data);
				$('#totalAmtDiv').hide();
				//$('#cardProfileArea').html($('#skuProfile').html());
				$('#cardProfileArea').hide();
				$('#searchText').val('');

				//PCS Web Service -- START //
				//setErrorSpan();
				setJavaScript();
				setPostSubmitJavaScript();
				setPreSubmitJavaScript();
				//PCS Web Service -- END //

			}else{
				alert(data);
			}
		}
	});
}

function AllowOnlyDigits( eEvent ){
	if ( eEvent.keyCode > 47 && eEvent.keyCode < 58 ){
		return true;
	}
	else 
		return false;
}

function alphaNumericOnly(evt){
	var chCode = ('charCode' in evt) ? evt.charCode : event.keyCode;
	return ((chCode != 32) || (chCode > 47 && chCode<58) || (chCode > 64 && chCode<91) || (chCode > 96 && chCode<123));
	
}

function hideDivForPickups(){
	 $('#userType').val('STORE CASHIER');
	 $('#cards').show();
	 $('#commonArea').hide();
}

function showManualDiscount(){
	$('#msgId').html('');
	if(submitCount==0){
		if($("#trxLineItems").find("tr").size()>0){
			if(selectedRowNo!=0){
				 $('#msgId').html('');
				 $('#cards').hide();
				 $('#paymentMethodsDiv').hide();
				 $('#cardProfileArea').hide();
				 $('#totalAmtDiv').hide();
				 $('#commonArea').show();
				 $('#commonArea').html($('#manualDiscountDiv').html());
			}else{
				alert("Please select a transaction line before applying manual discount");
				return false;
			}
		}else{
			alert("There are no items in the transaction basket.");
			return false;
		}
	}
}

function enableDisablePromotion() {
	objEnDisPromoLabel = document.getElementById("en_dis_promo_label");
	if(document.getElementById("en_dis_promo").checked == true) {
		objEnDisPromoLabel.style.color = "rgb(0, 150, 0)";
		objEnDisPromoLabel.innerHTML = "Enabled";
		$('#enDisPromo').val('enabled');
		couponCounter=0;
	}else {
		objEnDisPromoLabel.style.color = "rgb(255, 0, 0)";
		objEnDisPromoLabel.innerHTML = "Disabled";
		$('#enDisPromo').val('disabled');
		var totalCoupon=$('#couponCount').val();
		if(totalCoupon>0){
			couponCounter=totalCoupon+1;
		}
	}
}


//PCS Web Service -- START //
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
	$('#scriptDiv').html(content);
}

function setPostSubmitJavaScript(){
	var jsDivs = $('.pcsPostSubmitDiv');
	var chk = false;
	var content = '';
	if(jsDivs!=undefined && jsDivs!=null){
		for(var i =0;i<jsDivs.length;i++){
			content = content + $(jsDivs[i]).text();
			chk = true;
		}	
	}
	if(content!='' && chk){
		$('#pcsPostScriptDiv').html('');
		content = '<script>'+content+'</script>';
		$('#pcsPostScriptDiv').html(content);
	}
}

function setPreSubmitJavaScript(){
	var jsDivs = $('.pcsPreSubmitDiv');
	var chk = false;
	var content = '';
	if(jsDivs!=undefined && jsDivs!=null){
		for(var i =0;i<jsDivs.length;i++){
			content = content + $(jsDivs[i]).text();
			chk = true;
		}	
	}
	if(content!='' && chk){
		$('#pcsPreScriptDiv').html('');
		content = '<script>'+content+'</script>';
		$('#pcsPreScriptDiv').html(content);
	}
}
//PCS Web Service -- END //




