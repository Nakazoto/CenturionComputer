function ins_40_7F() {
	
	//40 through 4F
	if (splitData[i] == "40") {
		result.value += " " + splitData[i+1] + "            ADD ";
		i = i + 1; arg3(); result.value += "; Add bytes of two explicit registers (L + R stored in L)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "41") {
		result.value += " " + splitData[i+1] + "            SUB ";
		i = i + 1; arg3(); result.value += "; Subtract bytes of two explicit registers (L - R stored in L)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "42") {
		result.value += " " + splitData[i+1] + "            AND ";
		i = i + 1; arg3(); result.value += "; AND bytes of two explicit registers (L AND R stored in L)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "43") {
		result.value += " " + splitData[i+1] + "            ORI ";
		i = i + 1; arg3(); result.value += "; OR bytes of two explicit registers (L OR R stored in L)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "44") {
		result.value += " " + splitData[i+1] + "            ORE ";
		i = i + 1; arg3(); result.value += "; XOR bytes of two explicit registers (L XOR R stored in L)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "45") {
		result.value += " " + splitData[i+1] + "            XFR ";
		i = i + 1; arg3(); result.value += "; Copy byte of one explicit register into other (R into L)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "46") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "47") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "48") {
		result.value += "               AABL               ";
		result.value += "; Add implicit AL and BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "49") {
		result.value += "               SABL               ";
		result.value += "; Subtract implicit AL and BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "4A") {
		result.value += "               NABL               ";
		result.value += "; AND implicit AL and BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "4B") {
		result.value += "               XAXL               ";
		result.value += "; Transfer implicit AL into XL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "4C") {
		result.value += "               XAYL               ";
		result.value += "; Transfer implicit AL into YL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "4D") {
		result.value += "               XABL               ";
		result.value += "; Transfer implicit AL into BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "4E") {
		result.value += "               XAZL               ";
		result.value += "; Transfer implicit AL into ZL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "4F") {
		result.value += "               XASL               ";
		result.value += "; Transfer implicit AL into SL" + "\r\n";
		return(cont=1);
	}
	
	
	//50 through 5F
	if (splitData[i] == "50") {
		result.value += " " + splitData[i+1];
		var test1 = parseInt((splitData[i+1].charAt(0)), 16)
		var test2 = parseInt((splitData[i+1].charAt(1)), 16)
		if ((test1 % 2 != 0) || (test2 % 2 != 0)) {
			result.value += "            MEM?";
			i = i + 1; arg4(); result.value += "; Odd register means operation on memory" + "\r\n";
		} else {
			result.value += "            ADD ";
			i = i + 1; arg4(); result.value += "; Add word of two explicit registers (L + R stored in L)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "51") {
		result.value += " " + splitData[i+1];
		var test1 = parseInt((splitData[i+1].charAt(0)), 16)
		var test2 = parseInt((splitData[i+1].charAt(1)), 16)
		if ((test1 % 2 != 0) || (test2 % 2 != 0)) {
			result.value += "            MEM?";
			i = i + 1; arg4(); result.value += "; Odd register means operation on memory" + "\r\n";
		} else {
			result.value += "            SUB ";
			i = i + 1; arg4(); result.value += "; Subtract word of two explicit registers (L - R stored in L)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "52") {
		result.value += " " + splitData[i+1];
		var test1 = parseInt((splitData[i+1].charAt(0)), 16)
		var test2 = parseInt((splitData[i+1].charAt(1)), 16)
		if ((test1 % 2 != 0) || (test2 % 2 != 0)) {
			result.value += "            MEM?";
			i = i + 1; arg4(); result.value += "; Odd register means operation on memory" + "\r\n";
		} else {
			result.value += "            AND ";
			i = i + 1; arg4(); result.value += "; AND word of two explicit registers (L AND R stored in L)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "53") {
		result.value += " " + splitData[i+1];
		var test1 = parseInt((splitData[i+1].charAt(0)), 16)
		var test2 = parseInt((splitData[i+1].charAt(1)), 16)
		if ((test1 % 2 != 0) || (test2 % 2 != 0)) {
			result.value += "            MEM?";
			i = i + 1; arg4(); result.value += "; Odd register means operation on memory" + "\r\n";
		} else {
			result.value += "            ORI ";
			i = i + 1; arg4(); result.value += "; OR word of two explicit registers (L OR R stored in L)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "54") {
		result.value += " " + splitData[i+1];
		var test1 = parseInt((splitData[i+1].charAt(0)), 16)
		var test2 = parseInt((splitData[i+1].charAt(1)), 16)
		if ((test1 % 2 != 0) || (test2 % 2 != 0)) {
			result.value += "            MEM?";
			i = i + 1; arg4(); result.value += "; Odd register means operation on memory" + "\r\n";
		} else {
			result.value += "            ORE ";
			i = i + 1; arg4(); result.value += "; XOR word of two explicit registers (L XOR R stored in L)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "55") {
		result.value += " " + splitData[i+1];
		var test1 = parseInt((splitData[i+1].charAt(0)), 16)
		var test2 = parseInt((splitData[i+1].charAt(1)), 16)
		if ((test1 % 2 != 0) || (test2 % 2 != 0)) {
			result.value += "            MEM?";
			i = i + 1; arg4(); result.value += "; Odd register means operation on memory" + "\r\n";
		} else {
			result.value += "            XFR ";
			i = i + 1; arg4(); result.value += "; Copy word of one explicit register into other (R into L)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "56") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Set high bit in internal status register." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "57") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Clear high bit in internal status register." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "58") {
		result.value += "               AABW               ";
		result.value += "; Add implicit AW and BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "59") {
		result.value += "               SABW               ";
		result.value += "; Subtract implicit AW and BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "5A") {
		result.value += "               NABW               ";
		result.value += "; AND implicit AW and BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "5B") {
		result.value += "               XAXW               ";
		result.value += "; Transfer implicit AW into XW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "5C") {
		result.value += "               XAYW               ";
		result.value += "; Transfer implicit AW into YW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "5D") {
		result.value += "               XABW               ";
		result.value += "; Transfer implicit AW into BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "5E") {
		result.value += "               XAZW               ";
		result.value += "; Transfer implicit AW into ZW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "5F") {
		result.value += "               XASW               ";
		result.value += "; Transfer implicit AW into SW" + "\r\n";
		return(cont=1);
	}
	
	
	//60 through 6F
	if (splitData[i] == "60") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDXW";
		i = i + 1; address1(); result.value += "; Load literal word into word XW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "61") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDXW";
		i = i + 1; address2(); result.value += "; Load direct word into word XW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "62") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDXW";
		i = i + 1; address3(); result.value += "; Load indirect word into word XW" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "63") {
		result.value += " " + splitData[i+1] + "            LDXW";
		i = i + 1; branch1(); result.value += "; Load direct PC offset by N address into word XW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "64") {
		result.value += " " + splitData[i+1] + "            LDXW";
		i = i + 1; branch1a(); result.value += "; Load indirect PC offset by N address into word XW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "65") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDXW";
			i = i + 1; address5(); result.value += "; Load index mode into word XW (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            LDXW";
			i = i + 1; address4(); result.value += "; Load index mode into word XW (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "66") {
		i = i + 1; result.value += " " + splitData[i] + "            JSYS";
		i = i + 1; address1a(); result.value += "            ; System call. See supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "67") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2 byte instruction. See supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "68") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STXW";
		i = i + 1; address2(); result.value += "; Store XW into PC address (PC)- <- X (Opposite 60)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "69") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STXW";
		i = i + 1; address2(); result.value += "; Store XW into direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "6A") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STXW";
		i = i + 1; address3(); result.value += "; Store XW into indirect address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "6B") {
		result.value += " " + splitData[i+1] + "            STXW";
		i = i + 1; branch1(); result.value += "; Store word of XW into direct PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "6C") {
		result.value += " " + splitData[i+1] + "            STXW";
		i = i + 1; branch1a(); result.value += "; Store word of XW into indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "6D") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STXW";
			i = i + 1; address5(); result.value += "; Store XW into index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            STXW";
			i = i + 1; address4(); result.value += "; Store XW into index mode register (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "6E") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JMP ";
		i = i + 1; address2(); result.value += "; Load CCR with byte at address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "6F") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JMP ";
		i = i + 1; address2(); result.value += "; Store CCR to address" + "\r\n";
		return(cont=1);
	}
	
	
	//70 through 7F
	if (splitData[i] == "70") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JMP ";
		i = i + 1; address1(); result.value += "; Jump to literal address (not possible?)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "71") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JMP ";
		i = i + 1; address2(); result.value += "; Jump to direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "72") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JMP ";
		i = i + 1; address3(); result.value += "; Jump to indirect address" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "73") {
		result.value += " " + splitData[i+1] + "            JMP ";
		i = i + 1; branch1(); result.value += "; Jump to direct PC offset by N address "; branch2a(); 
		return(cont=1);
	}
	if (splitData[i] == "74") {
		result.value += " " + splitData[i+1] + "            JMP ";
		i = i + 1; branch1a(); result.value += "; Jump to indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "75") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JMP ";
			i = i + 1; address5(); result.value += "; Jump to index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            JMP ";
			i = i + 1; address4(); result.value += "; Jump to index mode register (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "76") {
		result.value += "               ???                ";
		result.value += "; Enable Parity Checking" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "77") {
		i = i + 1; result.value += " " + splitData[i] + "            MUL ";
		result.value += "               ; Multiply. Using an odd register for either operand will operate on memory." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "78") {
		i = i + 1; result.value += " " + splitData[i] + "            DIV ";
		result.value += "               ; Divide. Using an odd register for either operand will operate on memory." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "79") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JSR ";
		i = i + 1; address2(); result.value += "; Jump to subroutine at direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "7A") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JSR ";
		i = i + 1; address3(); result.value += "; Jump to subroutine at indirect address" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "7B") {
		result.value += " " + splitData[i+1] + "            JSR ";
		i = i + 1; branch1(); result.value += "; Jump to subroutine at direct PC offset by N address "; branch2a(); 
		return(cont=1);
	}
	if (splitData[i] == "7C") {
		result.value += " " + splitData[i+1] + "            JSR ";
		i = i + 1; branch1a(); result.value += "; Jump to to subroutine at indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "7D") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JSR ";
			i = i + 1; address5(); result.value += "; Jump to subroutine at index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            JMP ";
			i = i + 1; address4(); result.value += "; Jump to subroutine at index mode register (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "7E") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         PUSH";
		result.value += "               ; Push multiple 8-bit registers to stack" + "\r\n"
		return(cont=1);
	}
	if (splitData[i] == "7F") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         POP ";
		result.value += "               ; Pop multiple 8-bit registers from stack" + "\r\n"
		return(cont=1);
	}
	
}