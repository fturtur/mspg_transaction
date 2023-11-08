// JavaScript Document

var strCurrentRowColor;

function changeRowColor(strRowName)
	{
	alert(strRowName);
	var strRow = document.getElementById(strRowName);
	strCurrentRowColor = strRow.style.background;
	strRow.style.background = "#CCCCCC";
//	alert(strRow.style.background);
	}
	
function backToRowColor(strRowName)
	{
	document.getElementById(strRowName).style.background = strCurrentRowColor;
	}