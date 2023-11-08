function getTendersDetails(){

	$("#tenderRow").hide();
	var billerId = $('#billerId').val();
	var index= "";
	
	if($('#tenderIndex').val()!="")
		index = $('#tenderIndex').val();	
	
	$.ajax({
		type:"post",
		url: "fetchTenderInfo.action",
		data:"billerId="+billerId+"&index="+index,
		dataType: "text",
		async: true,
		success: function(data){		
			$('#dynamicTenderTable').html(data);
			$('#dynamicTenderTable').show();
			//$('#tenderIndex').val("");
			
			$('#billersPolicies').find('#billerPoliciesTable').remove();
			$('#billerPoliciesTable').clone().appendTo($('#billersPolicies'));			
			$('#billersPolicies').show();
			if($('#chequeAmount0')){
				$('#chequeAmount0').val('');
			}
		},
		error: function(xhr, msg, e) {
			alert(e);
		}
	});
}

function editTenderDetails(index){
	
//	if($('#trxAdditionInprogress').val() == 'false' || ($('#billerTable tr').length == parseInt(index)+1)){
		if(index!="" && $('#tenderTable') && $('#tenderTable').length>0){
			
			$.ajax({
				type: "POST",  
				url: "editTenderDetails.action",
				data: "index="+index,
				dataType: "text",
				async:true,
				success: function(data) {			
					$('#commonArea').hide();
					$('#billers').show();
					$('#dynamicTenderTable').html(data);
					$('#dynamicTenderTable').show();
					$("#tenderRow").hide();	
					$('#tenderIndex').val(index);
					
					$('#totalAmount').find('#totAmtTable').remove();			
	//				$('#totAmtTable').clone().appendTo($('#totalAmount'));			
	//				$('#totalAmount').show();
					
					$('#billersPolicies').find('#billerPoliciesTable').remove();
					$('#billerPoliciesTable').clone().appendTo($('#billersPolicies'));			
					$('#billersPolicies').show();
					
	//				$('#billersPolicies').find('#billerPoliciesTable').remove();
	//				$('#billersContainer').hide();
					$('.imgClass').hide();
					$(".delImgClass").hide();
				},
				error: function(xhr, msg, e) {
					alert(e);
				}
			});
		}
//	}
}


function enableDisable(index,mode){
	
	var cashLength=$('.cashCss:checkbox:checked');
	var chequeLength=$('.chequeCss:checkbox:checked');
	/*var cashLength=$('.cashCss').find("input[type=checkbox]:checked");
	var cashLength=$('.cashCss').find("input[type=checkbox]:checked");
	var cashLength=$('.cashCss').find("input[type=checkbox]:checked");*/
	//var ccLength = $('#tenderfieldsDiv').find("input[type=checkbox]:checked");
	/*alert(cashLength.length);
	alert(chequeLength.length);
	alert($('#mixedTenderAllowed').val());*/
	if(cashLength.length == 1 && chequeLength.length>=1 && $('#mixedTenderAllowed').val() == 'N' && ($('#allCombinations').val() == 'N' || $('#allCombinations').val() == '')){
		
		
		if(mode=='cash'){
			if($('#cashcheck').attr('checked')){
				$('#cashcheck').attr('checked', false);
				alert('Biller do not accept mulitple tenders.');
				return;
			}
		}else if(mode == 'cheque'){
			var $cbox = $('#chequeRow'+index).find('input:checkbox');
			if($cbox.attr('checked')){
				$cbox.attr('checked', false);
				alert('Biller do not accept mulitple tenders.');
				return;
			}
		}else if(mode == 'card'){
			var $cbox = $('#cardRow'+index).find('input:checkbox');
			if($cbox.attr('checked')){
				$cbox.attr('checked', false);
				alert('Biller do not accept mulitple tenders.');
				return;
			}
		}else if(mode == 'other'){
			var $cbox = $('#otherRow'+index).find('input:checkbox');
			if($cbox.attr('checked')){
				$cbox.attr('checked', false);
				alert('Biller do not accept mulitple tenders.');
				return;
			}
		}
	}
	
	
//	var $cbox;
	if(mode=='cash'){
		if($('#cashcheck').attr('checked')){
			$('#cashtext').attr('disabled', false);
		}
		else{
			$('#cashtext').val('');
			$('#cashtext').attr('disabled', 'disabled');
		}
		//$('#cardAmount'+index).focus();
	}
	else if(mode == 'cheque'){
		var $cbox = $('#chequeRow'+index).find('input:checkbox');
		if($cbox.attr('checked')){
			$('#chequeRow'+index).find('input:text').attr('disabled',false);
		}
		else{
			var temp =$('#chequeRef'+index).val()+':'+$('#chequeRow'+index).find('.selectTemp').val(); 
			restCheckDetails(temp);
			$('#chequeRow'+index).find('input:text').attr('disabled','disabled');
			$('#chequeRow'+index).find('input:text').val('');
			$('#chequeRow'+index).find('input:select').val('0');
		}
	}
	else if(mode == 'card'){
		var $cbox = $('#cardRow'+index).find('input:checkbox');
		if($cbox.attr('checked')){
			$('#cardRow'+index).find('input:text').attr('disabled',false);
			$('#cardRow'+index).find('input:radio').attr('disabled',false);
		}
		else{
			$('#cardRow'+index).find('input:text').attr('disabled','disabled');
			$('#cardRow'+index).find('input:radio').attr('disabled','disabled');
			$('#cardRow'+index).find('input:text').val('');
		}
	}
	else if(mode == 'other'){
		var $cbox = $('#otherRow'+index).find('input:checkbox');
		if($cbox.attr('checked')){
			$('#otherRow'+index).find('input:text').attr('disabled',false);
		}
		else{
			$('#otherRow'+index).find('input:text').attr('disabled','disabled');
			$('#otherRow'+index).find('input:text').val('');
		}
	}
}
Array.prototype.remByVal = function(val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] === val) {
            this.splice(i, 1);
            i--;
        }
    }
    return this;
}	
function restCheckDetails(objVal){
	
	var checkDetails = $('#checkDetails').val();
	//alert(checkDetails);
	if(checkDetails != ''){
		
		var checkDetailsSP = checkDetails.split(',');
		//alert('objVal ='+objVal);
		//alert('checkDetailsSP 1'+checkDetailsSP);
		checkDetailsSP.remByVal(objVal);
		//alert('checkDetailsSP 2'+checkDetailsSP);
		$('#checkDetails').val(checkDetailsSP);
	}
	
	
}	
function restOtherDetails(objVal){
	var otherDetails = $('#otherDetails').val();
	//alert(checkDetails);
	if(otherDetails != ''){
		
		var otherDetailsSP = otherDetails.split(',');
		otherDetailsSP.remByVal(objVal);
		$('#otherDetails').val(otherDetailsSP);
	}
}	

//6152 - START
var totalAmountAndDueEqualFlag = false;
//6152 - END

function validateValues(){
	isTenderPageOpen = false;
	//6152 - START
	totalAmountAndDueEqualFlag = false;
	//6152 - END
	
	var billerId = $('#billerId').val();
		
	var cashTextList = "";
	var chequeTextList="";
	var cardTextList="";
	var otherTextList="";
	var totalList = "";
	var notcheckedList="";	
	
	var checkNum="";
	
	var cashTenderId="";
	var checkTenderId="";
	var cardTenderId="";
	var otherTenderId="";
	
	var cashCombId=0;
	var checkCombId=0;
	var cardCombId=0;
	var otherCombId=0;
	var totalAmt=0;
	
	var cashFlag = false;
	var checkFlag = false;
	var cardFlag = false;
	var otherFlag = false;
//	var mixTrxFlag = false;
	var allCombFlag = false;
	var combFlag = false;
		
	var chequeList = $('.chequeClass');
	var cardList = $('.cardClass');
	var otherList = $('.otherClass');
	
	/*if($('#mixedTrxAllowed')){
		if($('#mixedTrxAllowed').val()!="" && $('#mixedTrxAllowed').val()=='Y')			
			mixTrxFlag = true;		
	}*/
	
	if($('#allCombinations')){
		if($('#allCombinations').val()!="" && $('#allCombinations').val()=='Y')
			allCombFlag = true;
	}
	
	if($('#cashTenderId'))
		cashTenderId = $('#cashTenderId').val();
	
	if($('#checkTenderId'))
		checkTenderId = $('#checkTenderId').val();
	
	if($('#cardTenderId'))
		cardTenderId = $('#cardTenderId').val();
	
	if($('#otherTenderId'))
		otherTenderId = $('#otherTenderId').val();
	
	if($('#cashCombinationId') && $('#cashCombinationId').val()!="")
		cashCombId = $('#cashCombinationId').val();
	
	if($('#checkCombinationId') && $('#checkCombinationId').val()!="")
		checkCombId = $('#checkCombinationId').val();
	
	if($('#cardCombinationId') && $('#cardCombinationId').val()!="")
		cardCombId = $('#cardCombinationId').val();
	
	if($('#otherCombinationId') && $('#otherCombinationId').val()!="")
		otherCombId = $('#otherCombinationId').val();
	
	if(!checkTenderType()){
	/*6152 START*/
		alert("Please select atleast one checkbox");
	/*6152 END*/
		return;
	}
	if($('#cashcheck') && typeof cashTenderId != 'undefined' && typeof cashCombId != 'undefined'){
		if($('#cashcheck').attr('checked')){
			if($('#cashtext').val()!=''){
				cashFlag = true;
				if(parseFloat($('#cashtext').val().replace(/,/gi, ""))>0){
				cashTextList = cashTextList + "CASH:"+cashTenderId+":"+cashCombId+":"+ $('#cashtext').val()+"::";
				totalAmt = parseFloat(totalAmt)+parseFloat($('#cashtext').val().replace(/,/gi, ""));
				totalAmt = totalAmt.toFixed(2);
				}
				else{
					alert("Please enter amount greater than zero.");
					return;
				}
			}else{
				alert("Please enter values in cash related fields");
				return;
			}
		}else
			notcheckedList = notcheckedList+"CASH:"+cashTenderId+":"+cashCombId+",";
	}
	
	var checkDetails = '';
		//alert('before check 0');
	for(var i=0;i<chequeList.length;i++){
		if($('#chequecheck'+i).attr('checked')){
			if($('#chequeAmount'+i).val()!='' && $('#chequeRef'+i).val()!=''){
				//alert('before check 1');
				checkFlag = true;				
				if(parseInt(checkNum) == parseInt($('#chequeRef'+i).val())){
					alert("Check numbers are same. Enter the different check number");	
					return;
				}
				//alert('before check 2');
				if(parseInt($('#bankListId'+i).find('select option:selected').val())==0){
					alert("select the bank");
					return;
				}
			//	alert('before check 3');
				checkNum = $('#chequeRef'+i).val();
				if(parseFloat($('#chequeAmount'+i).val().replace(/,/gi, ""))>0){
					chequeTextList = chequeTextList + "CHECK:" +checkTenderId+":"+checkCombId+":"+ $('#chequeAmount'+i).val()+":"+$('#chequeRef'+i).val()+":"+$('#bankListId'+i).find('select option:selected').val()+"::";
					totalAmt = parseFloat(totalAmt)+parseFloat($('#chequeAmount'+i).val().replace(/,/gi, ""));
					totalAmt = totalAmt.toFixed(2);
					// Modified to resolve duplicate check print
					/*if(checkDetails == ''){
						
						checkDetails = $('#chequeRef'+i).val()+":"+$('#bankListId'+i).find('select option:selected').val()+',';
					}else{
						
						checkDetails = checkDetails+$('#chequeRef'+i).val()+":"+$('#bankListId'+i).find('select option:selected').val()+',';
					}*/
				}
				else{
					alert("Please enter amount greater than zero.");
					checkDetails='';
					return;
				}
				//alert('before check 4');
				if($('#chequeRef'+i).val().length<6 || $('#chequeRef'+i).val().length>12){
					alert("Minimum 6 and maximum 12 digits are allowed in check number.");
					checkDetails='';
					return;
				}
				
				//alert('before check 5');
			}else{
				alert("Please enter values in check related fields");
				return;
			}
		}
	}
		
	for(var i=0;i<cardList.length;i++){
		var cardVal='';
		if($('#cardcheck'+i).attr('checked')){
			cardFlag = true;
			cardVal = $('#card'+i).is(':checked') ? 'online':'offline';
			if(parseFloat($('#cardAmount'+i).val().replace(/,/gi, ""))>0){
				cardTextList = cardTextList + "CARD:" +cardTenderId+":"+cardCombId+":"+ $('#cardAmount'+i).val()+":"+cardVal+"::";
				totalAmt = parseFloat(totalAmt)+parseFloat($('#cardAmount'+i).val().replace(/,/gi, ""));
				totalAmt = totalAmt.toFixed(2);
				}
				else{
					alert("Please enter amount greater than zero.");
					return;
				}
		}
	}
	if(cardFlag){
		$('#cardProcessMode').val('Y');
	}	
	
	for(var i=0;i<otherList.length;i++){
		if($('#othercheck'+i).attr('checked')){
			if($('#otherAmount'+i).val()!='' && $('#otherRef'+i).val()!=''){
				otherFlag = true;
				if(parseFloat($('#otherAmount'+i).val().replace(/,/gi, ""))>0){
					otherTextList = otherTextList + "OTHER:" +otherTenderId+":"+otherCombId+":"+ $('#otherAmount'+i).val()+":"+$('#otherRef'+i).val()+"::";
					totalAmt = parseFloat(totalAmt)+parseFloat($('#otherAmount'+i).val().replace(/,/gi, ""));
					totalAmt = totalAmt.toFixed(2);
					}
					else{
						alert("Please enter amount greater than zero.");
						return;
					}
			}else{
				alert("Please enter values in other related fields");
				return;
			}
		}
	}
		
		
	if(chequeList.length>0 && !checkFlag){
		notcheckedList = notcheckedList+"CHECK:"+checkTenderId+":"+checkCombId+",";
	}
	if(cardList.length>0 && !cardFlag){
		notcheckedList = notcheckedList+"CARD:"+cardTenderId+":"+cardCombId+",";
	}
	if(otherList.length>0 && !otherFlag){
		notcheckedList = notcheckedList+"OTHER:"+otherTenderId+":"+otherCombId+",";
	}
		
	if(cashTextList!=""){
		totalList = totalList+cashTextList+";";
	}
		
	if(chequeTextList!=""){
		totalList = totalList+chequeTextList+";";
	}
	if(cardTextList!=""){
		totalList = totalList+cardTextList+";";
	}
	if(otherTextList!=""){
		totalList = totalList+otherTextList+";";
	}
	
	if($('#discount')){		
		
		if($('#discount').is(':checked'))
			totalList = totalList+"discount:"+$('#discount').val()+";";
		else
			totalList = totalList+"discount:"+'';
	}

		
	var url = "";
		
	var tenderIndex = $('#tenderIndex').val();
	if(tenderIndex==""){
		url = "addTendersDetails.action";
	}else{
		url = "updateTenderDetails.action?index="+tenderIndex;
	}	
	
	
/*	if(mixTrxFlag){
		if(allCombFlag)
			combFlag = true;
		else
			combFlag = getCombinations(cashFlag,checkFlag,cardFlag,otherFlag);
		
		if(combFlag)
			combFlag = checkTotalAmt(totalAmt);
		
	}else{				
		combFlag = checkCombinations(cashFlag,checkFlag,cardFlag,otherFlag);
		if(combFlag)
			combFlag = checkTotalAmt(totalAmt);
	}*/
	
	if(allCombFlag)
		combFlag = true;	
	else
		combFlag = getCombinations(cashFlag,checkFlag,cardFlag,otherFlag);		
		
	if(combFlag)
		combFlag = checkTotalAmt(totalAmt);
	
	/*6152 START*/
	if(!totalAmountAndDueEqualFlag){
		totalAmountAndDueEqualFlag=true;
		return;
	}
	/*6152 END*/
	
	
	if(combFlag){
		if(checkDetails != ''){
			if($('#checkDetails').val() == ''){
				$('#checkDetails').val(checkDetails);
			}else{
				$('#checkDetails').val($('#checkDetails').val()+checkDetails);
			}
		}
		//SAMPLE BILLER NAME FIX - START
		if(!isValidationOnly){
			$.ajax({
				type:"post",
				url: url,
				data:"tenderDetailsList="+totalList+"&notcheckedList="+notcheckedList+"&billerId="+billerId,
				dataType: "text",
				async: true,
				success: function(data){
						
					$('#centertablePanel').html(data);			
					$("#tenderRow").show();			
					$('#dynamicTenderTable').hide();
					$("#billersContainer").hide();
					$('#billersPolicies').hide();
					$('#tenderIndex').val("");
					
					$('#totalAmount').find('#totAmtTable').remove();			
					$('#totAmtTable').clone().appendTo($('#totalAmount'));			
					$('#totalAmount').show();
					
					$('#suspendId').show();
					$('#trxAdditionInprogress').val('false');
					$('.imgClass').show();
					$(".delImgClass").show();
				},
				error: function(xhr, msg, e) {
					alert(e);
				}
			});
			
			isValidationOnly=false;
		}
		//SAMPLE BILLER NAME FIX - END
	}
	/*6152 START*/
	tenderValidationDone=true;
	/*6152 END*/
}

function checkTenderType(){
	var flag = false;
/*6152 START*/	
	if($('#cashcheck')){
		flag = $('#cashcheck').is(":checked")?true:false;
	}
	
	if(!flag && $('#chequecheck0')){
		flag = $('#chequecheck0').is(":checked")?true:false;
	}
	
	if(!flag && $('#cardcheck0')){
		flag = $('#cardcheck0').is(":checked")?true:false;
	}
	
	if(!flag && $('#othercheck0')){
		flag = $('#othercheck0').is(":checked")?true:false;
	}
/*6152 END*/	
	return flag;
}

function checkTotalAmt(totalAmt){
	var totaldue = $('#totaldue').val();
	var exactPayment = $('#exactPayment').val();
	var overPayment = $('#overPayment').val();
	var underPayment = $('#underPayment').val();
	
	totaldue = totaldue.replace(/,/gi, "");
	
	if(parseFloat(totalAmt) != parseFloat(totaldue)){
		
		alert('Amount should be equal to total due');
	/*6152 START*/
		totalAmountAndDueEqualFlag=false;
	/*6152 END*/
		return false;
	}
	
	//6152 - START
	totalAmountAndDueEqualFlag=true;
	//6152 - END
	
	/*if(overPayment!="" && overPayment=='N'){ 
		if(parseFloat(totalAmt)>parseFloat(totaldue)){
			alert('Over payment is not allowed');
			return false;
		}
	}
	
	if(exactPayment!="" && exactPayment=='N'){ 
	
		if(parseFloat(totalAmt)==parseFloat(totaldue)){
			alert('Exact payment is not allowed');
			return false;
		}
	}
	
	if(underPayment!="" && underPayment=='N'){ 
		
		if(parseFloat(totalAmt)<parseFloat(totaldue)){
			alert('Under payment is not allowed');
			return false;
		}
	}*/
	return true;
	
/*	if(totalAmt!="" && hidTotAmt!=""){
		if(parseFloat(totalAmt)>parseFloat(hidTotAmt)){
			alert("Total amount cann't be greater than the total due amount.");
			return false;
		}else
			return true;
	}	*/
}

function checkCombinations(cashFlag,checkFlag,cardFlag,otherFlag){
	var flag = false;
	
	if((cashFlag && checkFlag) || (cashFlag && cardFlag) || (cashFlag && otherFlag)){		
		alert("combinations are not allowed.");
		return flag;
	}
	if((checkFlag && cashFlag) || (checkFlag && cardFlag) || (checkFlag && otherFlag)){		
		alert("combinations are not allowed.");
		return flag;
	}
	if((cardFlag && cashFlag) || (cardFlag && checkFlag) || (cardFlag && otherFlag)){		
		alert("combinations are not allowed.");
		return flag;
	}
	if((otherFlag && cashFlag) || (otherFlag && checkFlag) || (otherFlag && cardFlag)){		
		alert("combinations are not allowed.");
		return flag;
	}
	flag = true;
	return flag;
}

function getCombinations(cashFlag,checkFlag,cardFlag,otherFlag){
	var flag = false;
	
	var cashCombId=0;
	var checkCombId=0;
	var cardCombId=0;
	var otherCombId=0;
	
	if($('#cashCombinationId') && $('#cashCombinationId').val()!="")
		cashCombId = $('#cashCombinationId').val();
	
	if($('#checkCombinationId') && $('#checkCombinationId').val()!="")
		checkCombId = $('#checkCombinationId').val();
	
	if($('#cardCombinationId') && $('#cardCombinationId').val()!="")
		cardCombId = $('#cardCombinationId').val();
	
	if($('#otherCombinationId') && $('#otherCombinationId').val()!="")
		otherCombId = $('#otherCombinationId').val();
	
	if(cashCombId!="" && cashCombId!='0')		
		cashCombId = parseInt(cashCombId);
	
	if(checkCombId!="" && checkCombId!="0")
		checkCombId = parseInt(checkCombId);
	
	if(cardCombId!="" && cardCombId!="0")
		cardCombId = parseInt(cardCombId);
	
	if(otherCombId!="" && otherCombId!="0")
		otherCombId = parseInt(otherCombId);
	
	if((cashFlag && checkFlag) && (cashCombId>0 && checkCombId>0)){
		if(cashCombId!=checkCombId){
			alert("cash and check combinations are not allowed for this biller.");
			return flag;
		}
	}
	
	if((cashFlag && cardFlag) && (cashCombId>0 && cardCombId>0)){
		if(cashCombId!=cardCombId){
			alert("cash and card combinations are not allowed for this biller.");
			return flag;
		}
	}
	
	if((cashFlag && otherFlag) && (cashCombId>0 && otherCombId>0)){
		if(cashCombId!=otherCombId){
			alert("cash and other combinations are not allowed for this biller.");
			return flag;
		}
	}
	
	if((checkFlag && cardFlag) && (checkCombId>0 && cardCombId>0)){
		if(checkCombId!=cardCombId){
			alert("check and card combinations are not allowed for this biller.");
			return flag;
		}
	}
	
	if((checkFlag && otherFlag) && (checkCombId>0 && otherCombId>0)){
		if(checkCombId!=otherCombId){
			alert("check and other combinations are not allowed for this biller.");
			return flag;
		}		
	}
	
	if((cardFlag && otherFlag) && (cardCombId>0 && otherCombId>0)){
		if(cardCombId!=otherCombId){
			alert("card and other combinations are not allowed for this biller.");
			return flag;
		}
	}
	flag = true;
	return flag;	
}

function deductCashAmt(obj){
	
	var cashAmt = "";
	
	/*if($('#cashcheck') && $('#cashcheck').is(":checked"))
		cashAmt = $('#cashtext').val();	
	
	if(obj.value!="" && cashAmt!="" && parseFloat(cashAmt)>parseFloat(obj.value)){
		
		cashAmt = parseFloat(cashAmt)-parseFloat(obj.value);
		$('#cashtext').val(cashAmt);
		
	}else if(obj.value!="" && cashAmt!="" && parseFloat(cashAmt)<parseFloat(obj.value)){
		
		$('#cashtext').val("");
		$('#cashcheck').attr('checked',false);
	}*/

}

/*function validCheckNo(obj){
	
	var num= obj.value;
		if(num.length<6||num.length>10){
			alert("please enter valid check number");
			obj.focus();
			return false;
		}
		else
			{
			result = num; 
			obj.value = result;
			return obj.value;
			}
	
}*/