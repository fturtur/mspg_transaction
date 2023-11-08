/**
 * Revised this module to handle PCS Web Service
 */

/* PCS Web Service -- START*/
/* status is set to true/false based on the result of getPaymentStatus. */
var status;
/*serviceData holds the result string that webservice returns in*/
var serviceData;
/* PCS Web Service -- END*/

function addChequeRow(thiz,index){
	var $curRow = $(thiz).closest('tr');
	
	var checkAmt=$curRow.find('#txtCheck').val();
	var checkNum=$curRow.find('#txtCheckNumber').val();
	var checkBanks=$curRow.find('#checkBanks').val();
	if(checkAmt=='' || checkNum=='' || checkBanks==0){
		alert("Please enter complete details for the current row before adding a new row");
		return false;
	}
	
	var indexId=thiz.id;
	var imgIndex=parseInt(indexId)+1;
	var i = index.toString()+imgIndex.toString();
	var $curRow = $(thiz).closest('tr');
	$newRow = $curRow.clone();
	$newRow.find('#'+indexId).attr('id',imgIndex);
	$newRow.find('input:checkbox').attr('id','tenderCheck'+i);
	$newRow.find('input:checkbox').attr('checked',true);
	$newRow.find('#tenderID').attr('name','paymentVOs['+i+'].tenderId');
	$newRow.find('#paymentTpe').attr('name','paymentVOs['+i+'].paymentType');
	$newRow.find('#txtCheck').attr('name','paymentVOs['+i+'].paymentAmount');
	$newRow.find('#txtCheckNumber').attr('name','paymentVOs['+i+'].tenderRefNum');
	$newRow.find('#checkBanks').attr('name','paymentVOs['+i+'].bankId');
	//$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value','');
	//$newRow.find('select').attr('disabled','disabled');
	$newRow.find('select').attr('value','0');
	$curRow.find('#img').html('');
	//$newRow.find('#img').click(function(){addChequeRow(this,index);});
	$newRow.find('#checkSlNo').html('');
	$curRow.after($newRow);
	$curRow.after(" <tr align='center'><td height='10' colspan='6'><hr align='center' /></td></tr>");
}

function addCardRow(thiz,index){
	
	var $curRow = $(thiz).closest('tr');
	var cardAmt=$curRow.find('#txtCard').val();
	if(cardAmt==''){
		alert("Please enter complete details for the current row before adding a new row");
		return false;
	}
	
	var indexId=thiz.id;
	var imgIndex=parseInt(indexId)+1;
	var i = index.toString()+imgIndex.toString();
	var $curRow = $(thiz).closest('tr');
	$newRow = $curRow.clone();
	$newRow.find('#'+indexId).attr('id',imgIndex);
	$newRow.find('input:checkbox').attr('id','tenderCard'+i);
	$newRow.find('input:checkbox').attr('checked',true);
	$newRow.find('#tenderID'+index).attr('name','paymentVOs['+i+'].tenderId');
	$newRow.find('#paymentTpe'+index).attr('name','paymentVOs['+i+'].paymentType');
	$newRow.find('#cardProcessMode'+index).attr('name','paymentVOs['+i+'].cardProcessMode');
	$newRow.find('#cardProcessMode'+index).attr('id','cardProcessMode'+i);
	$newRow.find('#txtCard').attr('name','paymentVOs['+i+'].paymentAmount');
	//$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value','');
	$curRow.find('#cardImg').html('');
	$newRow.find('#onlineRadio').attr('name','rdoOnlineOffline'+i);
	$newRow.find('#offlineRadio').attr('name','rdoOnlineOffline'+i);
	$newRow.find('#onlineRadio').removeAttr('onclick');
	$newRow.find('#onlineRadio').click(function(){setCardProcessMode(this,i);});
	$newRow.find('#offlineRadio').removeAttr('onclick');
	$newRow.find('#offlineRadio').click(function(){setCardProcessMode(this,i);});
	$newRow.find('#cardSlNo').html('');
	$curRow.after($newRow);
	$curRow.after(" <tr align='center'><td height='10' colspan='6'><hr align='center' /></td></tr>");
}

function addGiftRow(thiz,index){
	var $curRow = $(thiz).closest('tr');
	var giftAmt=$curRow.find('#txtGift').val();
	var giftReferenceNumber=$curRow.find('#txtGiftReferenceNumber').val();
	if(giftAmt=='' || giftReferenceNumber==''){
		alert("Please enter complete details for the current row before adding a new row");
		return false;
	}
	
	var indexId=thiz.id;
	var imgIndex=parseInt(indexId)+1;
	var i = index.toString()+imgIndex.toString();
	var $curRow = $(thiz).closest('tr');
	$newRow = $curRow.clone();
	$newRow.find('#'+indexId).attr('id',imgIndex);
	$newRow.find('input:checkbox').attr('id','tenderGift'+i);
	$newRow.find('input:checkbox').attr('checked',true);
	$newRow.find('#tenderID'+index).attr('name','paymentVOs['+i+'].tenderId');
	$newRow.find('#paymentTpe'+index).attr('name','paymentVOs['+i+'].paymentType');
	$newRow.find('#txtGift').attr('name','paymentVOs['+i+'].paymentAmount');
	$newRow.find('#txtGiftReferenceNumber').attr('name','paymentVOs['+i+'].tenderRefNum');
	//$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value','');
	$curRow.find('#giftImg').html('');
	//$newRow.find('#giftImg').click(function(){addGiftRow(this,index);});
	$newRow.find('#giftSlNo').html('');
	$curRow.after($newRow);
	$curRow.after(" <tr align='center'><td height='10' colspan='6'><hr align='center' /></td></tr>");
}

function addOtherRow(thiz, index){
	var $curRow = $(thiz).closest('tr');
	var otherAmt=$curRow.find('#txtOther').val();
	var otherAccNum=$curRow.find('#txtAcountNumber').val();
	var otherRefNum=$curRow.find('#txtReferenceNumber').val();
	if(otherAmt=='' || otherAccNum=='' || otherRefNum==0){
		alert("Please enter complete details for the current row before adding a new row");
		return false;
	}
	
	
	var indexId=thiz.id;
	var imgIndex=parseInt(indexId)+1;
	var i = index.toString()+imgIndex.toString();
	var $curRow = $(thiz).closest('tr');
	$newRow = $curRow.clone();
	$newRow.find('#'+indexId).attr('id',imgIndex);
	$newRow.find('input:checkbox').attr('id','tenderOther'+i);
	$newRow.find('input:checkbox').attr('checked',true);
	$newRow.find('#tenderID'+index).attr('name','paymentVOs['+i+'].tenderId');
	$newRow.find('#paymentTpe'+index).attr('name','paymentVOs['+i+'].paymentType');
	$newRow.find('#txtOther').attr('name','paymentVOs['+i+'].paymentAmount');
	$newRow.find('#txtAcountNumber').attr('name','paymentVOs['+i+'].tenderAccNum');
	$newRow.find('#txtReferenceNumber').attr('name','paymentVOs['+i+'].tenderRefNum');
	//$newRow.find('input:text').attr('disabled','disabled');
	$newRow.find('input:text').attr('value','');
	$curRow.find('#otherImg').html('');
	//$newRow.find('#otherImg').click(function(){addOtherRow(this,index);});
	$newRow.find('#otherSlNo').html('');
	$curRow.after($newRow);
	$curRow.after(" <tr align='center'><td height='10' colspan='6'><hr align='center' /></td></tr>");
}

function setCardProcessMode(thiz,index){
	$('#cardProcessMode'+index).val(thiz.value);
}

function setPaymentInfo(){
	$('#msgId').html('');
	//if(validatePaymentDetails()){
	
		var formData = $($('#paymentProcess')).serializeArray();
		
		$.ajax({
			type: "POST",
			url: "setPaymentInfo.action",
			data: formData,
			dataType: "text",
			async: false,
			success:function(data){
				$('#paymentSummary').html(data); 
				$('#totalAmtDiv').show();
				//$('#changeDiv').show();
				hidePaymentDiv();
				$('#suspendId').hide();
				//$('#cancelId').show();
				$('#discountId').hide();
				$('.deleteImgClass').attr('disabled','disabled');
				$('#searchText').val('');
				$('#searchText').attr('disabled','disabled');
				$('.categoryLink').attr('disabled','disabled');
			}
		});
//	}
}

function cancelPaymentInfo(){
	hidePaymentDiv();
	submitCount=0;
	$('#searchText').focus();
	return false;
}
var negativeAmountAllowed=null;
function validatePaymentDetails(){
	
	
	var msg="";
	//alert(negativeAmountAllowed);
	var trxAmount=getTrxAmount();
	var amtLimit=0.00;
	var amtLimitFlag=false;
	var paymentFlag=false;
	var flag=false;
	var giftPassFlag=false;
	var checkBoxList=$('.tender');
	for ( var i = 0; i < checkBoxList.length; i++) {
		if($(checkBoxList[i]).is(':checked')){
			paymentFlag=true;
			var $curRow = $(checkBoxList[i]).closest('tr');
			if($(checkBoxList[i]).val()=='Cash'){
				if($('#txtCash').val()==null || $('#txtCash').val()==''){
					flag=true;
					msg=msg+"Please enter the cash amount\n";
				}else if(isNaN($('#txtCash').val().replace(/\,/g,''))){
					flag=true;
					msg=msg+"Please enter valid cash amount.\n";
				}else{
					if(amtLimit<trxAmount){
						amtLimit=amtLimit+parseFloat($('#txtCash').val().replace(/\,/g,''));
					}else{
						amtLimitFlag=true;
					}
				}
				if(negativeAmountAllowed!=null && negativeAmountAllowed=='N'){
					if($('#txtCash').val()=='0.00' || $('#txtCash').val()=='0.' || $('#txtCash').val()=='0' || $('#txtCash').val()=='0.0'){
						flag=true;
						msg=msg+"Cash amount should be greater than zero\n";
					}
				}
			}
			if($(checkBoxList[i]).val()=='Check'){
				var checkAmt=$curRow.find('#txtCheck').val();
				var checkNum=$curRow.find('#txtCheckNumber').val();
				var checkBanks=$curRow.find('#checkBanks').val();
				if(checkAmt=='' || checkNum=='' || checkBanks==0){
					flag=true;
					if(msg.indexOf("Please enter complete check details", 0)==-1){
						msg=msg+"Please enter complete check details\n";
					}
				}else if(isNaN(checkAmt.replace(/\,/g,''))){
					flag=true;
					if(msg.indexOf("Please enter valid check amount.", 0)==-1){
						msg=msg+"Please enter valid check amount.\n";
					}
				}else{
					if(checkAmt=='0.00' || checkAmt=='0.' || checkAmt=='0' || checkAmt=='0.0'){
						flag=true;
						if(msg.indexOf("Check amount should be greater than zero", 0)==-1){
							msg=msg+"Check amount should be greater than zero\n";
						}

					}else{
						if(amtLimit<trxAmount){
							amtLimit=amtLimit+parseFloat(checkAmt.replace(/\,/g,''));
						}else{
							amtLimitFlag=true;
						}
					}
					
					if(checkNum.length<6 || checkNum.length>13){
						flag=true;
						if(msg.indexOf("Check # should be between 6 to 13 digits / characters", 0)==-1){
							msg=msg+"Check # should be between 6 to 13 digits / characters\n";
						}
					}else if(!isNaN(checkNum) && parseInt(checkNum,13)==0){
						flag=true;
						if(msg.indexOf("Please enter valid Check #", 0)==-1){
							msg=msg+"Please enter valid Check #\n";
						}
					}
				}
			}
			if($(checkBoxList[i]).val()=='Card'){
				var txtCard=$curRow.find('#txtCard').val();
				if(txtCard==null || txtCard==''){
					flag=true;
					msg=msg+"Please enter card amount\n";
				}else if(isNaN(txtCard.replace(/\,/g,''))){
					flag=true;
					msg=msg+"Please enter valid card amount.\n";
				}
				
					if(txtCard=='0.00' || txtCard=='0.' || txtCard=='0' || txtCard=='0.0'){
						flag=true;
						msg=msg+"Card amount should be greater than zero\n";
					}else{
						if(amtLimit<trxAmount){
							amtLimit=amtLimit+parseFloat(txtCard.replace(/\,/g,''));
						}else{
							amtLimitFlag=true;
						}
					}
				
			}
			if($(checkBoxList[i]).val()=='Gift'){
				giftPassFlag=true;
				$('#creditBalanceType').val('Gift');
				var txtGift=$curRow.find('#txtGift').val();
				var txtGiftReferenceNumber=$curRow.find('#txtGiftReferenceNumber').val();
				if(txtGift=='' || txtGiftReferenceNumber==''){
					flag=true;
					if(msg.indexOf("Please enter complete Gift Card / Sodexo details", 0)==-1){
						msg=msg+"Please enter complete Gift Card / Sodexo details\n";
					}
				}else if(isNaN(txtGift.replace(/\,/g,''))){
					flag=true;
					if(msg.indexOf("Please enter valid gift card / sodexo amount.", 0)==-1){
						msg=msg+"Please enter valid gift card / sodexo amount.\n";
					}
				} else{
				
					if(txtGift=='0.00' || txtGift=='0.' || txtGift=='0' || txtGift=='0.0'){
						flag=true;
						if(msg.indexOf("Gift Card / Sodexo amount should be greater than zero", 0)==-1){
							msg=msg+"Gift Card / Sodexo amount should be greater than zero\n";
						}
						
					}else{
						if(amtLimit<trxAmount){
							amtLimit=amtLimit+parseFloat(txtGift.replace(/\,/g,''));
						}else{
							amtLimitFlag=true;
						}
					}
					if(txtGiftReferenceNumber.length<6 || txtGiftReferenceNumber.length>13){
						flag=true;
						if(msg.indexOf("Gift Card / Sodexo Reference # should be between 6 to 13 digits / characters", 0)==-1){
							msg=msg+"Gift Card / Sodexo Reference # should be between 6 to 13 digits / characters\n";
						}
					}else if(!isNaN(txtGiftReferenceNumber) && parseInt(txtGiftReferenceNumber,13)==0){
						flag=true;
						if(msg.indexOf("Please enter valid gift card / sodexo reference #", 0)==-1){
							msg=msg+"Please enter valid gift card / sodexo reference #\n";
						}
					}
				}
			}
			if($(checkBoxList[i]).val()=='Other'){
				giftPassFlag=true;
				$('#creditBalanceType').val('Other');
				var txtOther=$curRow.find('#txtOther').val();
				var txtAcountNumber=$curRow.find('#txtAcountNumber').val();
				var txtReferenceNumber=$curRow.find('#txtReferenceNumber').val();
				if(txtOther=='' || txtAcountNumber=='' || txtReferenceNumber==''){
					flag=true;
					if(msg.indexOf("Please enter complete other tender details", 0)==-1){
						msg=msg+"Please enter complete other tender details\n";
					}
				} else if(isNaN(txtOther.replace(/\,/g,''))){
					flag=true;
					if(msg.indexOf("Please enter valid other tender amount.", 0)==-1){
						msg=msg+"Please enter valid other tender amount.\n";
					}
				} else{
				
					if(txtOther=='0.00' || txtOther=='0.' || txtOther=='0' || txtOther=='0.0'){
						flag=true;
						if(msg.indexOf("Other tender amount should be greater than zero", 0)==-1){
							msg=msg+"Other tender amount should be greater than zero\n";
						}
					}else{
						if(amtLimit<trxAmount){
							amtLimit=amtLimit+parseFloat(txtOther.replace(/\,/g,''));
						}else{
							amtLimitFlag=true;
						}
					}
					
					/*if(txtAcountNumber.length<6 || txtAcountNumber.length>13){
						flag=true;
						if(msg.indexOf("Other tender Account # should be between 6 to 13 digits / characters", 0)==-1){
							msg=msg+"Other tender Account # should be between 6 to 13 digits / characters\n";
						}
					}else*/ if(!isNaN(txtAcountNumber) && parseInt(txtAcountNumber,20)==0){
						flag=true;
						if(msg.indexOf("Please enter valid other tender Account #", 0)==-1){
							msg=msg+"Please enter valid other tender Account #\n";
						}
					}
					
					/*if(txtReferenceNumber.length<6 || txtReferenceNumber.length>13){
						flag=true;
						if(msg.indexOf("Other tender Reference # should be between 6 to 13 digits / characters", 0)==-1){
							msg=msg+"Other tender Reference # should be between 6 to 13 digits / characters\n";
						}
					}else*/ if(!isNaN(txtReferenceNumber) && parseInt(txtReferenceNumber,3)==0){
						flag=true;
						if(msg.indexOf("Please enter valid other tender Reference #", 0)==-1){
							msg=msg+"Please enter valid other tender Reference #\n";
						}
					}
				}
			}
		}
	}
	
	if(!paymentFlag){
		alert("Please select atleast one payment method.");
		return false;
	}
	
	if(flag){
		alert(msg);
		return false;
	}
	
	/*if(amtLimit>trxAmount){
		amtLimitFlag=true;
	}*/
	var amount=$('.amt');
	var totalAmount=0.00;
	for ( var j = 0; j < amount.length; j++) {
		if(amount[j].value!=undefined && amount[j].value!=null && amount[j].value!=''){
			totalAmount=totalAmount+parseFloat((amount[j].value).replace(/\,/g,''));
		}
	}
	$('#creditBalance').val('0.00');
	//alert(amtLimit);
	//alert(amtLimitFlag);
	//alert(trxAmount);
	//alert(totalAmount);
	if(trxAmount!=totalAmount){
		if(!giftPassFlag || totalAmount<trxAmount || amtLimitFlag){
			alert("Total tender amount should be equal to transaction amount");
			return false;
		}else{
			var creditBalance=totalAmount-trxAmount;
			$('#creditBalance').val(creditBalance);
		}
	}
	
	var offlineFlag=false;
	for ( var i = 0; i < checkBoxList.length; i++) {
		if($(checkBoxList[i]).is(':checked')){
			if($(checkBoxList[i]).val()=='Card'){
				var cardProcessMode=$('#cardProcessMode2').val();
				//alert(cardProcessMode);
				if(cardProcessMode!=undefined && cardProcessMode!=null && cardProcessMode=='offline'){
					offlineFlag=true;
					$('#bpsMask').show();
					var w = $(window);
					 $('#cardOfflineDiv').css('top',Math.abs(((w.height() - $('#cardOfflineDiv').outerHeight()) / 2) + w.scrollTop()));
					 $('#cardOfflineDiv').css('left',Math.abs(((w.width() - $('#cardOfflineDiv').outerWidth()) / 2) + w.scrollLeft()));
					 $('#cardOfflineDiv').show();
				}
			}
		}
	}
	if(!offlineFlag){
		setPaymentInfo();
	}
	return true;
}


function getTrxAmount(){
	var noOfLines=$("#trxLineItems").find("tr").size();
	var totalAmount=0;
	for(var i=1;i<=noOfLines;i++){
		var arr=$("#trxLineItems #sellingPrice"+i).text().split(" ");
		totalAmount=totalAmount+parseFloat($.trim(arr[1].replace(/\,/g,'')));
	}
	return totalAmount.toFixed(2)-totalFreeItemAmount;
}

function checkDigit(thiz, tenderName){
	//alert((thiz.value).length);
	if((thiz.value).length<6 || (thiz.value).length>13){
		alert(tenderName+" # should be between 6 to 13 digits");
		thiz.focus();
		return false;
	}
}

function enableDisable(thiz){
	var $curRow = $(thiz).closest('tr');
	if($(thiz).is(':checked')){
		$curRow.find('input:text').removeAttr('disabled');
		$curRow.find('img').removeAttr('disabled');
		$curRow.find('select').removeAttr('disabled');
	}else{
		$curRow.find('input:text').attr('value','');
		$curRow.find('input:text').attr('disabled','true');
		$curRow.find('img').attr('disabled','true');
		$curRow.find('select').attr('value','0');
		$curRow.find('select').attr('disabled','true');
	}
}

function showEnterCash(){
	if($('#changeDiv')){
		$('#changeDiv').show();
		
	}
	
}

function showPaymentMethods(){
	 $('#msgId').html('');
	 $('#cards').hide();
	 $('#paymentMethodsDiv').html($('#paymentDiv').html()); 
	 $('#paymentDiv').remove();
	 $('#paymentMethodsDiv').show();
}

function getTotalAmount(){
	var noOfLines=$("#trxLineItems").find("tr").size();
	var totalAmount=0;
	for(var i=1;i<=noOfLines;i++){
		var arr=$("#trxLineItems #sellingPrice"+i).text().split(" ");
		totalAmount=totalAmount+parseFloat($.trim(arr[1].replace(/\,/g,'')));
	}
	//alert(totalAmount.toFixed(2).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
	$("#txtCash").val(totalAmount.toFixed(2).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
	$("#totalAmount").val(totalAmount.toFixed(2));
}


function calculateChangeAmt(obj){
	
	var changeAmt="";
	var enterCashAmt="";
	var cashAmt = "";
	
	if($('#cashAmount')){
		cashAmt = $('#cashAmount').text();
		cashAmt=cashAmt.replace(/P/gi, "");
	}
	if($('#cashAmount') && typeof cashAmt != 'undefined'){
		 if($('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash')){
			 enterCashAmt = $('#enterCash').val();		
		 }
		 if(enterCashAmt!="" && cashAmt != ""){
			 enterCashAmt = enterCashAmt.replace(/,/gi, "");
			 cashAmt = cashAmt.replace(/,/gi, "");
			 if(parseFloat(enterCashAmt)<parseFloat(cashAmt)){
				 //$('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').val('');
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html('0.00');
				 $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#enterCash').focus();
				  $('#totalAmount').find('#totAmtTable').find('#changeDiv').find('#changeId').html('0.00');
				 alert("Enter the amount which is greater than or equal to cash amount");
				 lowAmount=true;
				 $('#enterCash').focus();
				 return false;
			 }else{
				 changeAmt = parseFloat(enterCashAmt) - parseFloat(cashAmt);		
				 $('#changeId').html(changeAmt.toFixed(2));
				 lowAmount=false;
				 return true;
			 }
		 }else{
			 if(cashAmt != ""){
				 alert('Please enter cash amount');
			 }else{
				 lowAmount=false;
				 return true;
			 }
		 }
	}else{
		lowAmount=false;	
		 return true;
	}
}

function closeCardOfflineDiv(){
	/*$('.offlineClass').hide();
	$('.onlineClass').hide();
	$('.errorClass').show();*/
	$('#bpsMask').hide();
	$('#cardOfflineDiv').hide();
}

function closeCardOnlineDiv(){
	$('#bpsMask').hide();
	$('#cardOfflineDiv').hide();
	$.ajax({
		type: "POST",
		url: "renderTenderPage.action",
		dataType: "text",
		async: false,
		success:function(data){
			renderTransactionBasket(data);
			showPaymentMethods();
			$('#totalAmtDiv').hide();
		}
	});
}

function processPcsEft(){
	var eftFlag=false;
	var data="";
	var cardProcessMode=$('#cardProcessMode').val(); 
    var paymentId=$('#paymentId').val();
    var cardAmount=$('#cardAmount').val();
    if(cardProcessMode!=null && cardProcessMode=='offline'){
    	var tenderRefNum=$('#tenderRefNum').val();
    	var approvalCode=$('#apprCode').val();
    	data="cardProcessMode="+cardProcessMode+"&paymentId="+paymentId+"&cardAmount="+cardAmount+"&tenderRefNum="+tenderRefNum+"&approvalCode="+approvalCode;
    }else{
    	data="cardProcessMode="+cardProcessMode+"&paymentId="+paymentId+"&cardAmount="+cardAmount;
    }

	$.ajax({
		type: "POST",
		url: "processPcsEFT.action",
		data: data,
		dataType: "json",
		async: false,
		success:function(data){
			 if(data.task=='success'){
				 $('#cardOfflineDiv').hide();
				 eftFlag=true;
			 }else if (data.task=='failed'){
				 eftFlag=false;
			 }
		}
	});
	return eftFlag;
}

var cardCounter=0;
function setCardOfflineDetails(){
	
	if($('#cardNo').val()=='' && $('#approvalCode').val()==''){
		alert("Card No and Approval Code cannot be empty.");
		return false;
	}else if($('#cardNo').val()==''){
		alert("Card No cannot be empty.");
		return false;
	}else if($('#approvalCode').val()==''){
		alert("Approval Code cannot be empty.");
		return false;
	}
	$('#cardTenderAccNum').val($('#cardNo').val());
	$('#carsHostAuthCode').val($('#approvalCode').val());
	$('#cardNo').val('');
	$('#approvalCode').val('');
	$('#cardOfflineDiv').hide();
	$('#bpsMask').hide();
	/*if(processPcsEft()){
		cardCounter++;
		processOnlineCards();
	}else{
		$('.offlineClass').hide();
		$('.errorClass').show();
	}*/
	setPaymentInfo();
}

function processOfflineCards(){
	
	var w = $(window);
	 $('#cardOfflineDiv').css('top',Math.abs(((w.height() - $('#cardOfflineDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#cardOfflineDiv').css('left',Math.abs(((w.width() - $('#cardOfflineDiv').outerWidth()) / 2) + w.scrollLeft()));
	 
	 var checkBoxList=$('.tender');
		for ( var i = 0; i < checkBoxList.length; i++) {
			
		}
    if(cardProcessMode!=null && cardProcessMode=='offline'){
    	$('#cardOfflineDiv').show();
    }
	
}

//function called on submit
function processOnlineCards(){
	if(!calculateChangeAmt()){
		return false;
	}
	var cardsLength=$("#cardPaymentDetails").find("tr").size();
	var cardsTable = document.getElementById("cardPaymentDetails");
	var w = $(window);
	 $('#cardOfflineDiv').css('top',Math.abs(((w.height() - $('#cardOfflineDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#cardOfflineDiv').css('left',Math.abs(((w.width() - $('#cardOfflineDiv').outerWidth()) / 2) + w.scrollLeft()));
	 if(cardsLength>0){
		if(cardCounter<cardsLength){
			    var cardProcessMode=cardsTable.rows[cardCounter].cells[1].innerHTML; 
			    var paymentId=cardsTable.rows[cardCounter].cells[2].innerHTML;
			    var cardAmount=cardsTable.rows[cardCounter].cells[3].innerHTML;
			    $('#cardProcessMode').val(cardProcessMode);
			    $('#paymentId').val(paymentId);
			    $('#cardAmount').val(cardAmount);
			    if(cardProcessMode!=null && cardProcessMode=='offline'){
			    	$('#cardOfflineDiv').show();
			    }else{
			    	$('#bpsMask').show();
				   	 $('#onlineMsg').html('Please swipe Credit Card');
					 $('.offlineClass').hide();
				     $('.onlineClass').show();
			    	 $('#cardOfflineDiv').show();
			    	if(!processPcsEft()){
			    		$('.offlineClass').hide();
				    	$('.onlineClass').hide();
				    	$('.errorClass').show();
			    	}else{
			    		cardCounter++;
			    		processOnlineCards();
			    	}
			    }  
		} else{
			saveTransaction();
		}
	 }else{
		 saveTransaction();
	 }
}


function saveTransaction(){
	var trxAmt=$('#totalAmt').text();
	var changeAmt=$('#changeId').text();
	var totalAmt=$('#enterCash').val();
	var addMsg = "";
	trxAmt=trxAmt.replace(/P/gi, "");
	changeAmt=changeAmt.replace(/P/gi, "");
	
	$('#bpsMask').show();	
	 var w = $(window);
	 $('#trxMsgDiv_error').hide();
	 $('#closeTrxDiv1').hide();
	 $('#closeItemDiv').hide();	
	 $('#trxMsgDiv').hide();	
	 $('#saveTrxDiv').show();
	 $('#saveTrxDiv').css('top',Math.abs(((w.height() - $('#saveTrxDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#saveTrxDiv').css('left',Math.abs(((w.width() - $('#saveTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
	
	// PCS Web Service -- START //
	 if(pcsPreSubmitFlag){
		//$('#trxMsgDiv_success').html('');
		$('#trxMsgDiv_success').hide();
		$("#trxMsgDiv").hide();
		if(!fun_pcsPreSubmit()){
			 $('#closeTrxDiv1').show();
			 $('#closeTrxDiv1').focus();
			return false;
		}else{
			$('#trxMsgDiv').html("Calling third party web service"); 
			$('#trxMsgDiv').show();
			$('#trxMsgDiv').hide();
		}		
	 }else{
		 
		 $('#trxMsgDiv_success').html('Saving Transaction in process.');	
		 $('#trxMsgDiv_success').show(); 
	 }
	// PCS Web Service -- END //
	 
	
	 
	 
	var data="trxAmt="+trxAmt+"&changeAmt="+changeAmt+"&totalAmt="+totalAmt;
	$.ajax({
		type: "POST",
		url: "savePcsTransaction.action",
		data: data,
		dataType: "json",
		async: true,
		success:function(data){
			if(data.task=='success'){
				
				if(savePcsTransToServer()){
					if(printTransaction()){
						// PCS Web Service -- START //
						 
						 if(!pcsPostSubmitFlag){
							 if(!pcsPreSubmitFlag){
								 $('#trxMsgDiv_success').html('Transaction saved successfully.');
							 }
						 }else{
							
							 $('#trxMsgDiv_success').hide();
							 $('#trxMsgDiv').show();
							 $('#trxMsgDiv').html('Transaction saved successfully. <br/>Calling third party service...');
						 }
						// PCS Web Service -- END //
					}else{
						alert("Printing failed");
						//$('#trxMsgDiv_success').html('Transaction saved successfully.');
						// PCS Web Service -- START //
						$('#trxMsgDiv_success').hide();
						
						if(pcsPostSubmitFlag){
							$('#trxMsgDiv_success').hide();
							$('#trxMsgDiv').show();
							$('#trxMsgDiv').html('Calling third party web service...');
						 }
						// PCS Web Service -- END //
						
					}
					// PCS Web Service -- START //
				
					if(pcsPostSubmitFlag){
						fun_pcsPostSubmit();
					 }
					// PCS Web Service -- END //
				}
			}else if(data.task=='skip'){
				//do nothing
			}else{
				//$('#trxMsgDiv').css('color','green');
				$('#trxMsgDiv').html(data.message);
			}
			$('#trxMsgDiv_success').show();
			$('#closeTrxDiv').show();
			$('#closeTrxDiv').focus();
		}
	});
}

function savePcsTransToServer(){
	var saveSuccess = false;
	var reTry = 'F';
	for(var o=0;o<2;o++){
		if(o==1){
			reTry = 'T';
		}
		$.ajax({
			type: "POST",
			url: "savePcsTransToServer.action",
			data: 'task=save&retry='+reTry,
			dataType: "json",
			async: false,
			success:function(data){
				if(data.task == 'success'){
					
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').show();
					$('#trxMsgDiv_error').hide();
					
					saveSuccess = true;
				}else if(data.task == 'skip'){
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').show();
					$('#trxMsgDiv_error').hide();
					saveSuccess = true;
				}else{
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').hide();
					$('#trxMsgDiv_error').show();
					$('#trxMsgDiv_error').html(data.message);
					$('#closeTrxDiv').show();
				}
			}
		});
		if(saveSuccess){
			break;
		}
	}
	return saveSuccess;
}

function printTransaction(){
	
	var printCompleted = false;
	
	if(!printSMACValidation()){
		return false;
	}else{
		printCompleted = true;
	}
	
	if(!printCheckValidation()){
		return false;
	}else{
		printCompleted = true;
	}
	
	if(!printOtherValidation()){
		return false;
	}else{
		printCompleted = true;
	}
	
	$.ajax({
		type: "POST",
		url: "printPcsTransaction.action",
		data: 'task=receipt',
		dataType: "json",
		async: false,
		success:function(data){
			if(data.task == 'success'){
				
				$('#trxMsgDiv').hide();
				$('#trxMsgDiv_success').show();
				$('#trxMsgDiv_error').hide();
				
				printCompleted = true;
			}else{
				$('#trxMsgDiv').hide();
				$('#trxMsgDiv_success').hide();
				$('#trxMsgDiv_error').show();
				$('#trxMsgDiv_error').html('Print Error.');
				$('#closeTrxDiv').show();
			}
		}
	});
	return printCompleted;
}

function printCheckValidation(){
	
	var printCompleted = true;
		

	 $("tr .checkValidation").each(function() {
		 printCompleted=false;
	   $this = $(this);
	   var paymentId = $this.find("#pId").html();
	   var tenderRefNum = $this.find("#tenderRefNum").html();
	   alert('Insert Check number '+tenderRefNum+'.');
	   $.ajax({
			type: "POST",
			url: "printPcsTransaction.action",
			data: 'task=tenderValidation&tenderType=check&paymentId='+paymentId+'&tenderRefNum='+tenderRefNum,
			dataType: "json",
			async: false,
			success:function(data){
				if(data.task == 'success'){
					
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').show();
					$('#trxMsgDiv_error').hide();
					
					printCompleted = true;
				}else{
					$('#trxMsgDiv').hide();
					$('#trxMsgDiv_success').hide();
					$('#trxMsgDiv_error').show();
					$('#trxMsgDiv_error').html('Error while printing check number '+tenderRefNum);
					$('#closeTrxDiv').show();
				}
			}
		});
	 });


	
	return printCompleted;
}

function printOtherValidation(){
	
	var printCompleted = true;
	$("tr .otherValidation").each(function() {
		printCompleted=false;
		   $this = $(this);
		   var paymentId = $this.find("#pId").html();
		   var tenderRefNum = $this.find("#tenderRefNum").html();
		   var tenderAccNum = $this.find("#tenderAccNum").html();
		   alert('Insert validation for other tender ref # '+tenderRefNum+'.');
		   $.ajax({
				type: "POST",
				url: "printPcsTransaction.action",
				data: 'task=tenderValidation&tenderType=other&paymentId='+paymentId+'&tenderRefNum='+tenderRefNum+'&tenderAccNum='+tenderAccNum,
				dataType: "json",
				async: false,
				success:function(data){
					if(data.task == 'success'){
						$('#trxMsgDiv').hide();
						$('#trxMsgDiv_success').show();
						$('#trxMsgDiv_error').hide();
						
						printCompleted = true;
					}else{
						$('#trxMsgDiv').hide();
						$('#trxMsgDiv_success').hide();
						$('#trxMsgDiv_error').show();
						$('#trxMsgDiv_error').html('Error while printing other tender ref # '+tenderRefNum+'.');
						$('#closeTrxDiv').show();
					}
				}
			});
		 });
	return printCompleted;
}

function printSMACValidation(){
	
	var printCompleted = true;
		

	 $("tr .smacValidation").each(function() {
		 printCompleted=false;
	   $this = $(this);
	   var smacLabel = $this.find("#smacLabel").html();
	   var trxLineNum = $this.find("#trxLineNum").html();
	   var smacQuantity = $this.find("#smacQuantity").html();
	   for(var i=0;i<smacQuantity;i++){
		   alert('Insert Validation For '+smacLabel+'.');
		   $.ajax({
				type: "POST",
				url: "printPcsTransaction.action",
				data: 'task=tenderValidation&tenderType=smac&tenderRefNum='+trxLineNum,
				dataType: "json",
				async: false,
				success:function(data){
					if(data.task == 'success'){
						
						$('#trxMsgDiv').hide();
						$('#trxMsgDiv_success').show();
						$('#trxMsgDiv_error').hide();
						
						printCompleted = true;
					}else{
						$('#trxMsgDiv').hide();
						$('#trxMsgDiv_success').hide();
						$('#trxMsgDiv_error').show();
						$('#trxMsgDiv_error').html('Error while printing SMAC validation');
						$('#closeTrxDiv').show();
					}
				}
			});
	   	}
	 });
	 
	return printCompleted;
}

function reprintTrx(){
	$('#msgId').html('');
	if($("#trxLineItems").find("tr").size() == 0){
		 $('#bpsMask').show();
		 var w = $(window);
		 $('#reprintLastTrx').show();
		 $('#reprintLastTrx').css('top',Math.abs(((w.height() - $('#reprintLastTrx').outerHeight()) / 2) + w.scrollTop()));
		 $('#reprintLastTrx').css('left',Math.abs(((w.width() - $('#reprintLastTrx').outerWidth()) / 2) + w.scrollLeft()));
		 
		 $.ajax({
				type: "POST",  
				url: 'reprintPcsLastTransaction.action',
				data: '',					 
				dataType: "json",
				async:false,
				success: function(data) {
					
					if(data.task == 'success'){
						$('#reprintMsgDiv').html('Reprint of last valid transaction completed successfully.');
						hideManagerFunctions();
						$('#cards').show();
						$('#closeReptintButton').show();
					}else{
						$('#cards').show();
						$('#reprintMsgDiv').html('Reprint of last valid transaction failed.');
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


function showSuspendDiv(){
	 $('#msgId').html('');
	 //alert("showSuspendDiv");
	 $('#msgId').html('');
	 $('#cards').hide();
	 $('#paymentMethodsDiv').hide();
	 $('#cardProfileArea').hide();
	 $('#totalAmtDiv').hide();
	 $('#commonArea').show();
	 $('#commonArea').html($('#suspendTrxDiv').html());
}
function closeSuspendDiv(){
	 $('#cards').show();
	 $('#commonArea').hide();
	 if($('#suspendMsgDiv').text() == 'Transaction suspended successfully.'){
		 window.location.reload();
	 }else{
		 $('#suspendDiv').hide();
		 $('#bpsMask').hide();
	 }
}

function resumeTrx(){
	 $('#msgId').html('');
	 $('#cards').hide();
	 $('#commonArea').show();
	 $('#commonArea').html($('#resumeTrx').html());
	 openScanningSuspendAndResumeBarcodePopup();
}

function closeResumeDiv(){
	 $('#cards').show();
	 $('#commonArea').hide();
}

function suspend(){
	$("#suspendButton").attr('disabled',true);
	var reason = $('#suspendResId').val();
	var trxAmt=getTrxAmount();
	var data="trxAmt="+trxAmt+"&reasonCode="+reason;
	var w = $(window);
	 $('#bpsMask').show();
	 $('#suspendDiv').show();
	 $('#suspendDiv').css('top',Math.abs(((w.height() - $('#suspendDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#suspendDiv').css('left',Math.abs(((w.width() - $('#suspendDiv').outerWidth()) / 2) + w.scrollLeft()));
	$.ajax({
		type: "POST",
		url: "suspendPcsTransaction.action",
		data: data,
		dataType: "json",
		async: false,
		success:function(data){
			$('#suspendMsgDiv').html(data.message);
			$('#closeSuspendButton').show();
		}
	});
	
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
	
	var data="terminalNum="+terminalNum+"&trxNumRes="+trxNumRes;
	 $('#bpsMask').show();
	 var w = $(window);
	 $('#resumeTrxDiv').show();
	 $('#resumeTrxDiv').css('top',Math.abs(((w.height() - $('#resumeTrxDiv').outerHeight()) / 2) + w.scrollTop()));
	 $('#resumeTrxDiv').css('left',Math.abs(((w.width() - $('#resumeTrxDiv').outerWidth()) / 2) + w.scrollLeft()));
	$.ajax({
		type: "POST",
		url: "resumePcsTransaction.action",
		data: data,
		dataType: "text",
		async: false,
		success:function(data){
			if(data.match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)){
				renderTransactionBasket(data);
				hidePaymentDiv();
				hideDiv();
				$('#totalAmtDiv').hide();
				$('#resumeId').hide();
				$('#logout').hide();
				$('#suspendId').show();
				//$('#cancelId').show();
				$('#searchText').focus();
				$('#bpsMask').hide();
				$('#resumeTrxDiv').hide();
			}else{
				$('#bpsMask').hide();
				$('#resumeTrxDiv').hide();
				alert(data);
			}
		}
	});
	
}

function smacInfo(){
	 $('#msgId').html('');
	if($("#trxLineItems").find("tr").size()>0){
		 ReadMSR(checkCard,"smacNum");
		 $('#bpsMask').show();
		 $('#smacDiv').show();
		 var w = $(window);
		 $('#smacDiv').css('top',Math.abs(((w.height() - $('#smacDiv').outerHeight()) / 2) + w.scrollTop()));
		 $('#smacDiv').css('left',Math.abs(((w.width() - $('#smacDiv').outerWidth()) / 2) + w.scrollLeft()));
	}else{
		alert("There are no items in the transaction basket.");
		return false;
	}
}

function saveSmacInfo(){
	 
	 var smacNum = $('#smacNum').val();
	
	 if(smacNum == ''){
		 alert('Please enter Card Number');
		 return ;
	 }else if(isNaN(smacNum)){
		 alert('Please enter valid Card Number');
		 return ;
	 }

	 $.ajax({
			type: "POST",  
			url: "savePcsSmacInfo.action",
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
	 //$('#cards').show();
	 $('#bpsMask').hide();
	 $('#smacDiv').hide();
	 $('#commonArea').hide();
	 //hidePaymentDiv();
}


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
		url: "pcsCashierVoidTransaction.action",
		data: data,			
		dataType: "json",
		cache:false,
		async:false,
		success: function(data) {
			
				if(data.task == 'Manager void approved'){
					alert('Void approved by manager, please continue.');
					$('#trxButton1').hide();
					$('#trxButton2').hide();
					$('#trxButton3').show();
					
				}else if(data.task == 'Cashier Void'){
					alert(data.message);
					$('#trxButton1').hide();
					$('#trxButton2').show();
					$('#trxButton3').hide();
				}else if(data.task=='time'){
					alert(data.message);
					
				}else if(data.task=='failed'){
					alert(data.message);
				}
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
		 url: "pcsVoidTransaction.action",
		 data: data,					 
		 dataType: "json",
		 async:true,
		 success: function(data) {
			 
			 if(data.task == 'success'){
				 alert(data.message);
				 $('#bpsMask').hide();
				 $('#commonArea').hide();
				 $('#cardsContainer').html('');
				 $('#searchText').val('');
				 $('#cards').show();
				 $('#saveTrxDiv').hide();
			 }else if(data.task =='failed'){
			// Modified to resolve issue 5686
				 alert(data.message);
				 $('#bpsMask').hide();
				 //$('#commonArea').hide();
				 //$('#cards').show();
				 $('#saveTrxDiv').hide();
			 }
		 },
		 error: function(xhr, msg, e) {
			// alert(e);
		 }
	 });
}



function zeroRated(){
	 $('#msgId').html('');
	if($("#trxLineItems").find("tr").size() == 0){
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

// PCS Web Service -- START //
function closeTrxxDiv(){
	$("#saveTrxDiv").hide();
	$("#bpsMask").hide();
}
// PCS Web Service -- END //	

