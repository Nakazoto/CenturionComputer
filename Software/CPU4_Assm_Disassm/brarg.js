var branch1 = function() {
	var relJmpArg0 = parseInt(splitData[i], 16);
	if (parseInt(splitData[i], 16) < 128) {
		result.value += " (PC+0x" + splitData[i].padStart(2, '0') + ")";
		result.value += "     ";
	} else {
		var relJmpArg0 = parseInt(splitData[i], 16);
		relJmpArg0 = 128 - (relJmpArg0 - 128);
		result.value += " (PC-0x" + relJmpArg0.toString(16).padStart(2, '0') + ")";
		result.value += "     ";
	};
};

var branch1a = function() {
	var relJmpArg0 = parseInt(splitData[i], 16);
	if (parseInt(splitData[i], 16) < 128) {
		result.value += " [PC+0x" + splitData[i].padStart(2, '0') + "]";
		result.value += "     ";
	} else {
		var relJmpArg0 = parseInt(splitData[i], 16);
		relJmpArg0 = 128 - (relJmpArg0 - 128);
		result.value += " [PC-0x" + relJmpArg0.toString(16).padStart(2, '0') + "]";
		result.value += "     ";
	};
};

var branch2 = function() {
	var br1 = parseInt(splitData[i], 16);
	var relJmpArg1 = parseInt(splitData[i], 16);
	var relJmpArg2 = 128 - (relJmpArg1 - 128);
	if (br1 < 128) {
		result.value += splitData[i] + " ahead PC" + " (0x" + (br1 + (i+1)).toString(16).padStart(4, '0') + ")" + "\r\n";
	} else {
		result.value += relJmpArg2.toString(16) + " behind PC" + " (0x" + ((i+1) - relJmpArg2).toString(16).padStart(4, '0') + ")" + "\r\n";
	}
}

var branch2a = function() {
	var br1 = parseInt(splitData[i], 16);
	var relJmpArg1 = parseInt(splitData[i], 16);
	var relJmpArg2 = 128 - (relJmpArg1 - 128);
	if (br1 < 128) {
		result.value += " (0x" + (br1 + (i+1)).toString(16).padStart(4, '0') + ")" + "\r\n";
	} else {
		result.value += " (0x" + ((i+1) - relJmpArg2).toString(16).padStart(4, '0') + ")" + "\r\n";
	}
}


var arg1 = function() {
	var arg = splitData[i].charAt(0);
	if (arg == "0") {
		result.value += " AH, ";
	} else if (arg == "1") {
		result.value += " AL, ";
	} else if (arg == "2") {
		result.value += " BH, ";
	} else if (arg == "3") {
		result.value += " BL, ";
	} else if (arg == "4") {
		result.value += " X, ";
	} else if (arg == "6") {
		result.value += " YH, ";
	} else if (arg == "7") {
		result.value += " YL, ";
	} else if (arg == "8") {
		result.value += " ZH, ";
	} else if (arg == "9") {
		result.value += " ZL, ";
	} else if (arg == "A") {
		result.value += " SH, ";
	} else if (arg == "B") {
		result.value += " SL, "
	} else if (arg == "C") {
		result.value += " C, ";
	} else if (arg == "E") {
		result.value += " P, ";
	};
	result.value += splitData[i].charAt(1);
	result.value += "         ";
};
var arg2 = function() {
	var arg = splitData[i].charAt(0);
	if (arg == "0") {
		result.value += " AW, ";
	} else if (arg == "1") {
		result.value += " MEM, ";
	} else if (arg == "2") {
		result.value += " BW, ";
	} else if (arg == "3") {
		result.value += " MEM, ";
	} else if (arg == "4") {
		result.value += " X,  ";
	} else if (arg == "5") {
		result.value += " MEM, ";
	} else if (arg == "6") {
		result.value += " YW, ";
	} else if (arg == "7") {
		result.value += " MEM, ";
	} else if (arg == "8") {
		result.value += " ZW, ";
	} else if (arg == "9") {
		result.value += " MEM, ";
	} else if (arg == "A") {
		result.value += " SW, ";
	} else if (arg == "B") {
		result.value += " MEM, "
	} else if (arg == "C") {
		result.value += " C, ";
	} else if (arg == "D") {
		result.value += " MEM, "
	} else if (arg == "E") {
		result.value += " P, ";
	} else if (arg == "F") {
		result.value += " MEM, "			
	};
	result.value += splitData[i].charAt(1);
	result.value += "         ";
};
var arg3 = function() {
	var j = 0;
	for (j = 0; j < 2; j++) {
		var arg = splitData[i].charAt(j);
		if (arg == "0") {
			result.value += " AH";
		} else if (arg == "1") {
			result.value += " AL";
		} else if (arg == "2") {
			result.value += " BH";
		} else if (arg == "3") {
			result.value += " BL";
		} else if (arg == "4") {
			result.value += " X ";
			
		//DOUBLE CHECK IF THIS IS ALRIGHT!
		} else if (arg == "5") {
			result.value += " X ";
		
		} else if (arg == "6") {
			result.value += " YH";
		} else if (arg == "7") {
			result.value += " YL";
		} else if (arg == "8") {
			result.value += " ZH";
		} else if (arg == "9") {
			result.value += " ZL";
		} else if (arg == "A") {
			result.value += " SH";
		} else if (arg == "B") {
			result.value += " SL"
		} else if (arg == "C") {
			result.value += " C ";
		} else if (arg == "E") {
			result.value += " P ";
		};
		if (j == 0) {result.value += ", ";}
	}
	result.value += "       ";
};
var arg4 = function() {
	var j = 0;
	for (j = 0; j < 2; j++) {
		var arg = splitData[i].charAt(j);
		if (arg == "0") {
			result.value += " AW";
		} else if (arg == "2") {
			result.value += " BW";
		} else if (arg == "4") {
			result.value += " X ";
		} else if (arg == "6") {
			result.value += " YW";
		} else if (arg == "8") {
			result.value += " ZW";
		} else if (arg == "A") {
			result.value += " SW";
		} else if (arg == "C") {
			result.value += " C ";
		} else if (arg == "E") {
			result.value += " P ";
		} else if (arg == "1") {
			result.value += " M1";
		} else if (arg == "3") {
			result.value += " M3";
		} else if (arg == "5") {
			result.value += " M5";
		} else if (arg == "7") {
			result.value += " M7";
		} else if (arg == "9") {
			result.value += " M9";
		} else if (arg == "B") {
			result.value += " MB";
		} else if (arg == "D") {
			result.value += " MD";
		} else if (arg == "F") {
			result.value += " MF";
		};
		if (j == 0) {result.value += ", ";}
	}
	result.value += "       ";
};

var address1 = function() {
	result.value += " #" + splitData[i] + splitData[i+1] + "         "; i = i + 1;
}
var address1a = function() {
	result.value += " #" + splitData[i] + splitData[i+1] + "         ";
}
var address2 = function() {
	result.value += " " + splitData[i] + splitData[i+1] + "          "; i = i + 1;
}
var address3 = function() {
	result.value += " [" + splitData[i] + splitData[i+1] + "]        "; i = i + 1;
}
//Indexed mode addressing
var address4 = function() {
	var arg = splitData[i].charAt(0);
	if (arg == "0") {
		result.value += " AW";
	} else if (arg == "2") {
		result.value += " BW";
	} else if (arg == "4") {
		result.value += " X ";
	} else if (arg == "6") {
		result.value += " YW";
	} else if (arg == "8") {
		result.value += " ZW";
	} else if (arg == "A") {
		result.value += " SW";
	} else if (arg == "C") {
		result.value += " C ";
	} else if (arg == "E") {
		result.value += " P ";
	};
	result.value += ", " + splitData[i].charAt(1) + "         ";
}
var address5 = function() {
	var arg = splitData[i].charAt(0);
	if (arg == "0") {
		result.value += " AW";
	} else if (arg == "2") {
		result.value += " BW";
	} else if (arg == "4") {
		result.value += " X ";
	} else if (arg == "6") {
		result.value += " YW";
	} else if (arg == "8") {
		result.value += " ZW";
	} else if (arg == "A") {
		result.value += " SW";
	} else if (arg == "C") {
		result.value += " C ";
	} else if (arg == "E") {
		result.value += " P ";
	};
	result.value += ", " + splitData[i].charAt(1) + ", " 
	i = i + 1; 
	result.value += "0x" + splitData[i] + "   ";
}