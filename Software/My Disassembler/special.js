function special(){

	// Special 1-byte Instructions
	if (splitData[i] == "56") {
		result.value += "               ???";
		result.value += "                ; Set high bit in internal status register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "57") {
		result.value += "               ???";
		result.value += "                ; Clear high bit in internal status register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "67") {
		result.value += "               ???";
		result.value += "                ; Unknown" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "86") {
		result.value += "               ???";
		result.value += "                ; Turn off CPU line 6" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "87") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "86") {
		result.value += "               ???";
		result.value += "                ; Turn off CPU line 4" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "87") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A6") {
		result.value += "               ???";
		result.value += "                ; Turn on CPU line 4" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A7") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B6") {
		result.value += "               ???";
		result.value += "                ; Writes -1 to AH at interrupt level 1. See instructions C6 and 1F" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B7") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C6") {
		result.value += "               ???";
		result.value += "                ; Writes 0 to AH at interrupt level 1. See instructions B6 and 1F" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C7") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E7") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F6") {
		result.value += "               ???";
		result.value += "                ; Page table management?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F7") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	
	
	//Special 2-byte instructions
	if (splitData[i] == "2E") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "2F") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "46") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}
	
	if (splitData[i] == "66") {
		i = i + 1; result.value += " " + splitData[i] + "            JSYS";
		result.value += "               ; System call. See supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "77") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Multiply or Divide? Using an odd register for either operand will operate on memory." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "78") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Multiply or Divide? Using an odd register for either operand will operate on memory." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D6") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Swap high/low bytes in 16 bit value. Register in LOW nibble. (?)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D7") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Stores AW into any register in register file" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E6") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Load AW from any register in register file?" + "\r\n";
		return(cont=1);
	}
	
	
	//Special 3-byte instructions
	if (splitData[i] == "7E") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         PUSH";
		result.value += "               ; Push multiple 8-bit registers to stack" + "\r\n"
		//i = i + 1; address2(); result.value += "; Push multiple 8-bit registers to stack" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "7F") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         POP ";
		result.value += "               ; Pop multiple 8-bit registers from stack" + "\r\n"
		//i = i + 1; address2(); result.value += "; Push multiple 8-bit registers to stack" + "\r\n";
		return(cont=1);
	}
	
	
	//47 Instruction
	if (splitData[i] == "47") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}
	
}