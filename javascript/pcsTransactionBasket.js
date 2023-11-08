var submitCount=0;
var couponCounter=0;
var couponCode="";
var trxxAmt;
var totalFreeItemAmount=0.00;
pcsPostSubmitFlag=false;
pcsPreSubmitFlag=false;

function setBarcode(thiz){
	var gcItemChk=postTag;
	if(gcItemChk==1){
		var gcCode1 = thiz.value;
		var prgc1=gcCode1.substring(0,2);
		if(prgc1!='21'){
			alert("Invalid SKU Number for Gift Card, please select 2186");
			$('#barCode').val("");
			$('#searchText').val("");
			autoComplete();
		}else{
			$('#barCode').val(gcCode1);
			$('#searchText').val(gcCode1);
			autoComplete();
		}
	}else{
		$('#barCode').val(thiz.value);
		$('#searchText').val(thiz.value);
		autoComplete();
	}
}

function setdatalist(thiz){
	$('#dataEntryValTwo').val(thiz.value);
}


function addItem(){
	//var flag = true;
	var trxType=$('#trxType').val();
	var skuId = $('#skuId').val();
	var barCode=$('#barCode').val();
	//alert(barCode);
	if(barCode==null || barCode==""){
		barCode=$('#selectBarcode').val();
	}
	//alert(barCode);
	var scannedBarcode2=$('#scannedBarcode2').val();
	//alert(scannedBarcode2);
	var quantity = $('#quantity').val();
	var amount = $('#amount').val();
	var serviceFee=$('#serviceFee').val();
	var enDisPromo=$('#enDisPromo').val();
	var quantityInto=$('#quantityIntoId').val();
	var dataEntryVal=$('#dataEntryVal').val();
	var negativeAmountAllowed=$('#negativeAmountAllowed').val();
	var rcptType=$('#rcptType').val();
	var serviceFeeRcptType=$('#serviceFeeRcptType').val();
	// PCS Web Service -- START //
	var webService=$('#webService').val();
	var dataEntryValTwo=$('#dataEntryValTwo').val();
	var preWebService=$('#preWebService').val();
	
	// PCS Web Service -- END //
	
	
	//alert(serviceFeeRcptType);
	if(amount!=null && amount!=''){
		amount=amount.replace(/\,/g,'');
		//alert(amount);
	}
	if(serviceFee!=null && serviceFee!=''){
		serviceFee=serviceFee.replace(/\,/g,'');
	}
	var data="";
	if(trxType!=null && trxType=='Sale'){
		var message='';
		if(barCode==-1){
			message=message+"Please select a barcode.\n";
		}
		if(amount==null || amount==''){
			message=message+"Please enter the amount.\n";
		}else if(amount=='0.' || amount=='0' || amount=='0.0' || amount=='0.00'){
			message=message+"Please enter valid amount.\n";
		}else if(isNaN(amount)){
			message=message+"Please enter valid amount.\n";
		}
		if(quantity==null||quantity=="" || parseInt(quantity)==0){
			message=message+"Please enter the quantity";
			$('#quantity').val('');
		}else{
			if(isNaN(quantity)){
				alert("Invalid quantity");
				return false;
			}
		}
		if(message!=""){
			alert(message);
			return false;
		}
		//alert(couponCode);
		data="skuId="+skuId+"&amount="+amount+"&qty="+quantity+"&barcode="+barCode+"&trxType="+trxType+"&enDisPromo="+enDisPromo+
		"&rcptType="+rcptType+"&couponCode="+couponCode+"&scannedBarcode2="+scannedBarcode2;
	}else{
		var errorMessage="";
		if(amount==null || amount==''){
			errorMessage=errorMessage+"Please enter the amount.\n";
		}else if(isNaN(amount)){
			errorMessage=errorMessage+"Please enter valid amount.\n";
		}
		if(serviceFee==null||serviceFee==""){
			errorMessage=errorMessage+"Please enter the service fee.\n";
		}else if(isNaN(serviceFee)){
			errorMessage=errorMessage+"Please enter valid service fee.\n";
		}
		
		if((amount=='0.' || amount=='0' || amount=='0.0' || amount=='0.00') 
				&& (serviceFee=='0.' || serviceFee=='0' || serviceFee=='0.0' || serviceFee=='0.00')){
			errorMessage=errorMessage+"Please enter valid amount / service fee.\n";
		}
		
		if(quantity==null || quantity=="" || parseInt(quantity)==0){
			errorMessage=errorMessage+"Please enter the quantity.\n";
		}else if(isNaN(quantity)){
			errorMessage=errorMessage+"Invalid quantity.\n";
		}
		if(dataEntryVal!=undefined && (dataEntryVal==null || dataEntryVal=='')){
			var dataEntryLabel=$('#dataEntryLabel').val();
			errorMessage=errorMessage+"Please enter the "+dataEntryLabel+".\n";
		}
		// PCS Web Service -- START //
		if(dataEntryValTwo!=undefined && (dataEntryValTwo==null || dataEntryValTwo=='')){
			var dataEntryLabelTwo=$('#dataEntryLabelTwo').val();
			errorMessage=errorMessage+"Please enter the "+dataEntryLabelTwo+".\n";
		}
		if(dataEntryValTwo==-1){
			var dataEntryLabelTwo=$('#dataEntryLabelTwo').val();
			errorMessage=errorMessage+"Please select in "+dataEntryLabelTwo+".\n";
		}
		// PCS Web Service -- END //
		if(errorMessage!=""){
			alert(errorMessage);
			return false;
		}
		//quantity=1;
		data="skuId="+skuId+"&barcode="+barCode+"&amount="+amount+"&qty="+quantity+"&serviceFee="+serviceFee+"&trxType="+trxType+"&quantityInto="+quantityInto+
		"&dataEntryVal="+dataEntryVal+"&negativeAmountAllowed="+negativeAmountAllowed+"&rcptType="+rcptType+"&serviceFeeRcptType="+serviceFeeRcptType+"&webService="+webService+
		"&dataEntryValTwo="+dataEntryValTwo+"&preWebService="+preWebService;
		pcsPostValues=data;
	}
		//	return false;
		$.ajax({
			
			type:"POST",
		url:"addItem.action",
		data: data,
		dataType:"text",
		async:false,
		success:function(data){
			renderTransactionBasket(data);
			hidePaymentDiv();
			$('#totalAmtDiv').hide();
			hideManagerFunctions();
			$('#resumeId').hide();
			$('#logout').hide();
			$('#suspendId').show();
			//$('#cancelId').show();
			$('#searchText').val('');
			$('#msgId').html('');
			$('#searchText').focus();
			}
		});
		
	submitCount=0;
	couponCounter=0;
	couponCode="";
}

function showCouponScanDiv(){
	var totalCoupon=$('#couponCount').val();
	 var w = $(window);
	 $('#promoCouponDiv').css('top',Math.abs(((w.height() - $('#promoCouponDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#promoCouponDiv').css('left',Math.abs(((w.width() - $('#promoCouponDiv').outerWidth()) / 2) + w.scrollLeft()));
	 if(totalCoupon>0){
		 if(couponCounter<totalCoupon){
			 $('#bpsMask').show();
			 $('#couponCode').val('');
			 $('#promoCouponDiv').show();
			 $('#couponCode').focus();
			 couponCounter++;
		 }else{
			 $('#promoCouponDiv').hide();
			 $('#bpsMask').hide();
			 addItem();
		 }
	 }else{
		 addItem();
	 }
}

function saveCouponInfo(){
	if($('#couponCode').val()==null || $('#couponCode').val()==''){
		alert('Please scan the coupon');
		return false;
	}else{
		if(couponCode==""){
			couponCode=couponCode+$('#couponCode').val();
		}else{
			couponCode=couponCode+","+$('#couponCode').val();
		}
		$('#promoCouponDiv').hide();
		showCouponScanDiv();
	}
}

function closeCouponDiv(){
	var totalCoupon=$('#couponCount').val();
	$('#couponCode').val('');
	$('#promoCouponDiv').hide();
	$('#bpsMask').hide();
	couponCounter++;
	if(totalCoupon>0){
		 if(couponCounter>totalCoupon){
			 addItem();
		 }
	}else{
		 addItem();
	}	 
}

function clearCouponCode(){
	$('#couponCode').val('');
	return false;
}

function deleteItem(index){
	
	var flag = confirm("Are you sure want to delete the transaction line data?");
	if(flag){
		// PCS Web Service -- START //
		pcsPostSubmitFlag=false;
		pcsPreSubmitFlag=false;
		// PCS Web Service -- END //
		$.ajax({
			type: "POST",  
			url: "deleteItem.action",
			data: "index="+index,
			dataType: "text",
			async:true,
			success: function(data) {
				renderTransactionBasket(data);
				hidePaymentDiv();
				$('#totalAmtDiv').hide();
				$('#commonArea').hide();
				hideManagerFunctions();
				if($("#trxLineItems").find("tr").size()==0){
					$('#resumeId').show();
					$('#logout').show();
					$('#suspendId').hide();
					$('#cancelId').hide();
				}else{
					$('#resumeId').hide();
					$('#logout').hide();
					$('#suspendId').show();
					//$('#cancelId').show();
				}
				$('#msgId').html('');
				$('#searchText').focus();
			},
			error: function(xhr, msg, e) {
				alert(e);
			}
		});
		submitCount=0;
	}
}

function deleteAllItems(){
	if($("#trxLineItems").find("tr").size() > 0){
		var flag = confirm("Are you sure want to delete all the transaction lines?");
		if(flag){
			// PCS Web Service -- START //
			pcsPostSubmitFlag=false;
			pcsPreSubmitFlag=false;
			// PCS Web Service -- END //
			location.reload(true);
			/*$.ajax({
				type: "POST",  
				url: "deleteAllItems.action",
				dataType: "text",
				async:true,
				success: function(data) {
					renderTransactionBasket(data);
					hidePaymentDiv();
					$('#totalAmtDiv').hide();
					hideManagerFunctions();
					$('#resumeId').show();
					$('#logout').show();
					$('#discountId').show();
					$('#suspendId').hide();
					$('#cancelId').hide();
					$('#msgId').html('');
					$('.deleteImgClass').removeAttr('disabled');
					$('.categoryLink').removeAttr('disabled');
					$('#searchText').val('');
					$('#searchText').removeAttr('disabled');
					$('#searchText').focus();
				},
				error: function(xhr, msg, e) {
					alert(e);
				}
			});
			submitCount=0;*/
		}
	}
}


function renderTransactionBasket(data){
	$('#cardsContainer').hide();
	$('#tabledata').html(data);
}
var showPromotionCustDiv;
var discountMessage;
function addPromotionsToBasket(){
	showPromotionCustDiv=null;
	if(submitCount==0){
		var noOfLines=$("#trxLineItems").find("tr").size();
		if(noOfLines<1){
			alert("There are no items in the transaction basket");
			return false;
		}
		
		$.ajax({
				type:"POST",
				url:"addPromotionsToBasket.action",
				dataType:"text",
				async:false,
				success:function(data){
					renderTransactionBasket(data);
					if(showPromotionCustDiv!=null && showPromotionCustDiv>0){
						showPromotionsCustInfo();
					}else{
						showPaymentMethods();
						getTotalAmount();
					}
					$('#totalAmtDiv').hide();
				}
			});
		$('#msgId').html('');
		submitCount=1;
		}
	}
function showPromotionsCustInfo(){
	//$('#promotionsCustInfoDiv').html(data);
	 $('#bpsMask').show();
	 $('#promotionsCustInfoDiv').show();
	 var w = $(window);
	 $('#promotionsCustInfoDiv').css('top',Math.abs(((w.height() - $('#promotionsCustInfoDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#promotionsCustInfoDiv').css('left',Math.abs(((w.width() - $('#promotionsCustInfoDiv').outerWidth()) / 2) + w.scrollLeft()));
}

function closePromotionsCustInfo(){
	$('#promotionsCustInfoDiv').hide();
	$('#bpsMask').hide();
	submitCount=0;
}

function setPromotionCustInfo(){
	var pFlag=true;
	var pcustInfo=$('.pcustClass');
	for ( var i = 0; i < pcustInfo.length; i++) {
		if($(pcustInfo[i]).val()==null || $(pcustInfo[i]).val()==''){
			pFlag=false;
			break;
		}
	}
	
	if(!pFlag){
		alert('Please enter customer information.');
		return false;
	}
	
	var w = $(window);
	 $('#trxMsgDiv_error').hide();
	 $('#saveTrxDiv').css('top',Math.abs(((w.height() - $('#saveTrxDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#saveTrxDiv').css('left',Math.abs(((w.width() - $('#saveTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
	var formData = $($('#promotionCustInfo')).serializeArray();
	$.ajax({
		type:"POST",
		url:"setPromotionCustInfo.action",
		data: formData,
		dataType:"json",
		async:false,
		success:function(data){
			if(data.task=='success'){
				$('#promotionsCustInfoDiv').hide();
				$('#bpsMask').hide();
				showPaymentMethods();
				if(trxxAmt!=null && trxxAmt!=''){
					$("#txtCash").val(parseFloat(trxxAmt).toFixed(2));
					$("#totalAmount").val(parseFloat(trxxAmt).toFixed(2));
				}else{
					getTotalAmount();
				}
			}else{
				$('#saveTrxDiv').show();
				$('#trxMsgDiv').html('Error occured while saving customer details');
				$('#closeItemDiv').show();
			}
		}
	});
}

var selectedRowNo=0;
function changeRowColor(rowId, rowNo){
	var lineLength=$("#trxLineItems").find("tr").size();
	var lineTable = document.getElementById("trxLineItems");
	var row;
	for ( var i = 1; i <= lineLength; i++) {
		row=lineTable.rows[i-1];
		if(i==rowNo){
			var strRow = document.getElementById(rowId);
			//strCurrentRowColor = strRow.style.background;
			strRow.style.background = "#CCCCCC";
			selectedRowNo=rowNo;
		}else{
			if(i%2==0){
				row.style.background="#CFEFB6";
			}else{
				row.style.background="#A5E074";
			}
		}
	}
	/*$(rowId).removeAttr("style");
		 $(rowId).attr("style","background-color: #CCCCCC;");*/
	
	}
	
function backToRowColor(rowId, rowColor){
	document.getElementById(rowId).style.background = rowColor;
	selectedRowNo=0;
}



function showDiscountValue(){

	if($('#discountType1').attr('checked')){
		$('#amt').show();
		$('#percnt').hide();
	}
	
	else if($('#discountType2').attr('checked')){
		$('#amt').hide();
		$('#percnt').show();
	}
	
}

function setDiscountType(thiz){
	$('#discountType').val(thiz.value);
}

function applyManualDiscount(){
	var errorMsg="";
	var formData="";
	var discountType=$('#discountType').val();
	var discountValue=$('#discountValue').val();
	var discountRefNumber=$('#discountRefNumber').val();
	
	if(discountType==null || discountType==''){
		errorMsg=errorMsg+"Please select discount type.\n";
	}
	if(discountValue==null || discountValue==''){
		errorMsg=errorMsg+"Please enter discount value.\n";
	}else if(parseFloat(discountValue)==0){
		errorMsg=errorMsg+"Discount value cannot be zero.\n";
	}
	/*if(discountRefNumber==null || discountRefNumber==''){
		errorMsg=errorMsg+"Please enter discount reference number.\n";
	}else if(parseFloat(discountRefNumber)==0){
		errorMsg=errorMsg+"Discount reference number cannot be zero.\n";
	}*/
	
	if(discountRefNumber!=null && discountRefNumber!='' && parseFloat(discountRefNumber)==0){
		errorMsg=errorMsg+"Discount reference number cannot be zero.\n";
	}
	
	if(errorMsg!=""){
		alert(errorMsg);
		return false;
	}else{
		formData=formData+"discountType="+discountType+"&discountValue="+discountValue+"&dicountRefNum="+discountRefNumber+"&selectedRowNo="+selectedRowNo;
	}
	
	$.ajax({
		type:"POST",
		url:"applyManualDiscount.action",
		data: formData,
		dataType:"text",
		async:false,
		success:function(data){
			renderTransactionBasket(data);
			hidePaymentDiv();
			$('#totalAmtDiv').hide();
			hideManagerFunctions();
			$('#msgId').html(discountMessage);
			$('#resumeId').hide();
			$('#logout').hide();
			$('#commonArea').hide();
			$('#suspendId').show();
			//$('#cancelId').show();
			$('#searchText').val('');
			$('#searchText').focus();
			changeRowColor('trxLineItem'+selectedRowNo, selectedRowNo);
		}
	});
}