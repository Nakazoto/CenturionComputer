//Find WriteString subroutine 
var findWriteString = function() {
	var strcnt = 0;
	var testcnt = 0;

	//Easy mode with null terminator
	for (strcnt = 0; strcnt < splitData.length; strcnt++) {
		//Add all the JSR routines here
		if (splitData[strcnt] == "7B") {
			console.log("7B");
			for (testcnt = 0; testcnt < 16; testcnt++) {
				var rawhex = parseInt(splitData[strcnt+2+testcnt], 16);

				if (rawhex < 160 && rawhex > 0) {return;}  //160 DEC = A0
				if (rawhex == 0) {
					//Add if else for JSR ahead or behind
					wtsl = parseInt(splitData[strcnt+1], 16) + strcnt;
					return;
				}
			}
		}
	}
}




//Check for String/ASCII
var checkForString = function() {
	
	//Check if JSR to PC+/-
	if (splitData[i] == "7B") {

		console.log((parseInt(splitData[i+1], 16) + i));			
		if ((parseInt(splitData[i+1], 16) + i) != wtsl) {return;}
		
		result.value += " " + splitData[i+1] + "            JSR ";
		i = i + 1; branch1(); result.value += "; Jump to writestring at direct PC offset by N address "; branch2a(); 
		i = i + 1;				
		result.value += "0x";
		entryPoint = document.getElementById("entry").value;
		disAddr = parseInt(entryPoint, 16) + (i);
		result.value += disAddr.toString(16).padStart(4, '0');
		result.value += ":     ";
		
		printString();
		
		
	}
}

//Print the string out
var printString = function() {
	var strcnt = 0;
	
	// Start converting string
	result.value += "'";
	for (strcnt = 0; strcnt < 16; strcnt++) {
		var rawhex = parseInt(splitData[i+strcnt], 16);
		if (rawhex == 0) {break;}
		var newhex = rawhex - 128;
		if (newhex == 13) {
			result.value += "/CR ";
		} else if (newhex == 10) {
			result.value += "/LF ";
		} else {
			result.value += String.fromCharCode(newhex);
		}
		
	}
	result.value += "'" + "\r\n";
	i = i+strcnt;
	return(cont=1);
	
}