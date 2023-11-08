var readMode = "";
var elementID = "";
var readComplete = "true";
var nextFunction = "";
var readStream = "";

var readingfunctions ="";
var isWaitForClose = "false";

document.onkeypress = function(evt) {
    evt = evt || window.event;
	if (readMode == "READINGMSR") {
		evaluateMSR(evt);
	}
	else if (readMode == "READINGBARCODE") {
		evaluateBarcode(evt);
	}
	else {
		readingfunctions = readingfunctions + "NO READMODE ";
	}
	if(evt.keyCode==27){
		if(!$('#billerBarcode').is(':disabled')){
			$('#billerBarcode').hide();
			$('#bpsMask').hide();
			
			if($('#processOnLoad') && $('#processOnLoad').val() == 'Y'){
				fun_onload();
			}
		}
	}
};

var timerInterval;
function WaitForClose() {
	//alert('WaitForClose 1');
	if (isWaitForClose == "true") {
		//Check to see if the popup has been closed
		if(readComplete == "false")
		{//alert('WaitForClose 2');
			//If not, recall this function - the recursion
			if (timerInterval == 'null') {
				timerInterval = setInterval(WaitForClose, 500);
				readingfunctions = readingfunctions + "TIMEINTERVAL" + " ";
			}
		}
		else
		{//alert('WaitForClose 3');
			if (nextFunction != 'null') {
				readingfunctions = readingfunctions + "CLEARINTERVAL" + " ";
				isWaitForClose = "false";
				clearInterval(timerInterval);
				nextFunction();
			}
			else {//alert('WaitForClose 4');
				readingfunctions = readingfunctions + "nextFUNCTIONNULL" + " ";
			}
		}
	}
	else {//alert('WaitForClose 5');
		if (timerInterval != 'null') {
			clearInterval(timerInterval);
		}
	}
}

function ReadBarcode(requestNext, id) {
	readMode = "READINGBARCODE";
	commonInitialization(requestNext, id);
	WaitForClose();
}

function evaluateBarcode(evt) {
	if(evt.keyCode==13){
		readMode = 'null';
		document.getElementById(elementID).value = readStream;
		readComplete = "true";
		//readingfunctions = readingfunctions + "keyCode==13" + " ";
    }
 	else if(evt.keyCode==27){
		readMode = 'null';
		readStream = 'null';
		document.getElementById(elementID).value = 'null';
		readComplete = "true";
    }
	else {
		readStream = readStream + String.fromCharCode(evt.keyCode);
	}
}

function getUserNumberFromBarcode(id) {
	var tempCode =  document.getElementById(id).value;
	//alert(tempCode);
	tempCode=tempCode.substring(0,tempCode.length-2);
	var code = parseInt(tempCode, 10);
	//var code = tempCode.substring(2,tempCode.length-2);
	//alert(code);
	document.getElementById(id).value = code;
}

function getVoidBarcodeData(id, storeCodeID, terminalNoID, transactionNoID) {
	var code = document.getElementById(id).value.substring(1,8);
	document.getElementById(storeCodeID).value = code;
	code = document.getElementById(id).value.substring(8,11);
	document.getElementById(terminalNoID).value = code;
	code = document.getElementById(id).value.substring(11,20);
	document.getElementById(transactionNoID).value = code;
}

function getSuspendAndResumeBarcodeData(id, terminalNoID, transactionNoID) {
	var code = document.getElementById(id).value.substring(8,11);
	document.getElementById(terminalNoID).value = code;
	code = document.getElementById(id).value.substring(11,20);
	document.getElementById(transactionNoID).value = code;
}

var readMSRisInitialized="false";
function ReadMSR(requestNext, id) {
	//alert('ReadMSR');
//	readMode = "READINGMSR";
//	readingfunctions = ""; 
//	commonInitialization(requestNext, id);
//	WaitForClose();
	readMode = "READINGMSR";
	if(readMSRisInitialized=="false"){ 
		commonInitialization(requestNext, id);
	}
	WaitForClose();
}

function commonInitialization(requestNext, id) {
	elementID = id;
	readComplete = "false";
	readStream = "";
	nextFunction = requestNext;
	timerInterval = 'null';
	isWaitForClose = "true";
}

var readTrackStage = "READTRACK1";
var readTrackCount = 0;
var readChar = "";
var readCharCount = 0;
function evaluateMSR(evt) {
	

	if(readTrackStage == "TRACKEND") {
		//do nothing
		readMode = 'null';
		readComplete = "true";
		readStream = 'null';
	}
	else if(evt.keyCode==27){
		readMode = 'null';
		document.getElementById(elementID).value = "";
		readComplete = "true";
    }
	else {
		readChar = String.fromCharCode(evt.keyCode);
		if (readTrackStage == "TRACKCOMPLETE") {
			readMode = " ";
			readTrackStage = "TRACKEND";
			readComplete = "true";
			//document.getElementById(elementID).value = readStream;
		}
		else if ((readTrackStage == "READTRACK1") && (readChar == "%")) {
			readTrackStage = "SS";
			//document.getElementById(elementID).value += "SS ";
		}
		else if ((readTrackStage == "SS") && (readChar == "B")) {
			readTrackStage = "PAN1";
			//document.getElementById(elementID).value += "PAN1 ";
		}
		else if ((readTrackStage == "SS") && (readChar != "B")) {
			readTrackStage = "READTRACK2";
			//document.getElementById(elementID).value += "READTRACK2 ";
		}
		else if ((readTrackStage == "READTRACK2") && (readChar == ";")) {
			readStream="";
			readTrackStage = "PAN2";
			//document.getElementById(elementID).value += "PAN2 ";
		}
		else if (readTrackStage == "PAN1") {
			if ((readChar.charCodeAt(0) < 48) || (readChar.charCodeAt(0) > 57)) {
				readTrackStage = "TRACKCOMPLETE";
				//document.getElementById(elementID).value += "TRACK1COMPLETE ";
			}
			else {
				readStream = readStream + readChar;
				document.getElementById(elementID).value += readChar;
				readCharCount += 1;
			}
		}
		else if (readTrackStage == "PAN2"){
			if ((readCharCount == 0) && (readChar == ";")) {
				readTrackStage = "TRACKERROR";
				//document.getElementById(elementID).value += "TRACK2ERROR ";
			}
			else if ((readChar.charCodeAt(0) < 48) || (readChar.charCodeAt(0) > 57)) {
				readTrackStage = "TRACKCOMPLETE";
				//document.getElementById(elementID).value += "TRACK2COMPLETE ";
			}
			else {
				//readStream = readStream + readChar;
				document.getElementById(elementID).value += readChar;
				readCharCount += 1;
			}
		}
		else if ((readChar == "?") && (readTrackStage != "TRACKEND")){
			if (readTrackCount >= 1) {
				readTrackStage = "TRACKEND";
				readComplete = "true";
				//document.getElementById(elementID).value += "TRACK2END ";
			}
			else {
				readTrackCount += 1;
				readTrackStage = "READTRACK2";
				//document.getElementById(elementID).value += "READTRACK2 ";
			}
		}
		else if (readTrackStage == "TRACKERROR") {
			document.getElementById(elementID).value = "TRACKERROR";
			readComplete = "true";
		}
		else {
		}
 	}
}
