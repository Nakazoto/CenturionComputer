function ins_C0_FF(){
	
	//C0 through CF
	//////////////////////////////////////////
	// Is 0xC0 through 0xC4 really a 2-byte?
	if (splitData[i] == "C0") {
		result.value += " " + splitData[i+1] + "            LDBL";
		i = i + 1; address1a(); result.value += "; Load literal address into byte of BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C1") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBL";
		i = i + 1; address2(); result.value += "; Load direct address into byte of BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C2") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBL";
		i = i + 1; address3(); result.value += "; Load indirect address into byte of BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C3") {
		result.value += " " + splitData[i+1] + "            LDBL";
		i = i + 1; branch1(); result.value += "; Load direct PC offset by N address into byte of BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C4") {
		result.value += " " + splitData[i+1] + "            LDBL";
		i = i + 1; branch1a(); result.value += "; Load indirect PC offset by N address into byte of BL" + "\r\n";
		return(cont=1);
	}
	// Is 0xC0 through 0xC4 really a 2-byte?
	//////////////////////////////////////////
	if (splitData[i] == "C5") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBL";
			i = i + 1; address5(); result.value += "; Load index mode register address into BL (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            LDAL";
			i = i + 1; address4(); result.value += "; Load index mode register address into BL (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "C6") {
		result.value += "               ???";
		result.value += "                ; Writes 0 to AH at interrupt level 1. See instructions B6 and 1F" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C7") {
		result.value += "               ???";
		result.value += "                ; Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C8") {
		result.value += "               LBLA               ";
		result.value += "; Load byte from address in AW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "C9") {
		result.value += "               LBLB               ";
		result.value += "; Load byte from address in BW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "CA") {
		result.value += "               LBLX               ";
		result.value += "; Load byte from address in XW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "CB") {
		result.value += "               LBLY               ";
		result.value += "; Load byte from address in YW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "CC") {
		result.value += "               LBLZ               ";
		result.value += "; Load byte from address in ZW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "CD") {
		result.value += "               LBLS               ";
		result.value += "; Load byte from address in S into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "CE") {
		result.value += "               LBLC               ";
		result.value += "; Load byte from address in C into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "CF") {
		result.value += "               LBLP               ";
		result.value += "; Load byte from address in P into implicit BL" + "\r\n";
		return(cont=1);
	}
	
	
	// D0 through DF	
	if (splitData[i] == "D0") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBW";
		i = i + 1; address1(); result.value += "; Load literal address into byte of BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D1") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBW";
		i = i + 1; address2(); result.value += "; Load direct address into byte of BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D2") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBW";
		i = i + 1; address3(); result.value += "; Load indirect address into byte of BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D3") {
		result.value += " " + splitData[i+1] + "            LDBW";
		i = i + 1; branch1(); result.value += "; Load direct PC offset by N address into word of BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D4") {
		result.value += " " + splitData[i+1] + "            LDBW";
		i = i + 1; branch1a(); result.value += "; Load indirect PC offset by N address into word of BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D5") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBW";
			i = i + 1; address5(); result.value += "; Load index mode register address into BW (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            LDAW";
			i = i + 1; address4(); result.value += "; Load index mode register address into BW (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "D6") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Special 2-byte instruction, see supplemental material." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D7") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Stores AW into any register in register file" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D8") {
		result.value += "               LBWA               ";
		result.value += "; Load byte from address in AW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "D9") {
		result.value += "               LBWB               ";
		result.value += "; Load byte from address in BW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "DA") {
		result.value += "               LBWX               ";
		result.value += "; Load byte from address in XW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "DB") {
		result.value += "               LBWY               ";
		result.value += "; Load byte from address in YW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "DC") {
		result.value += "               LBWZ               ";
		result.value += "; Load byte from address in ZW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "DD") {
		result.value += "               LBWS               ";
		result.value += "; Load byte from address in S into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "DE") {
		result.value += "               LBWC               ";
		result.value += "; Load byte from address in C into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "DF") {
		result.value += "               LBWP               ";
		result.value += "; Load byte from address in P into implicit BW" + "\r\n";
		return(cont=1);
	}
	
	
	//E0 through EF
	if (splitData[i] == "E0") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBL";
		i = i + 1; address2(); result.value += "; Store BL into PC address (PC)- <- X (Opposite 60)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E1") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBL";
		i = i + 1; address2(); result.value += "; Store BL into direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E2") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBL";
		i = i + 1; address3(); result.value += "; Store BL into indirect address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E3") {
		result.value += " " + splitData[i+1] + "            STBL";
		i = i + 1; branch1(); result.value += "; Store byte of BL into direct PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E4") {
		result.value += " " + splitData[i+1] + "            STBL";
		i = i + 1; branch1a(); result.value += "; Store byte of BL into indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E5") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBL";
			i = i + 1; address5(); result.value += "; Store BL into index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            STAL";
			i = i + 1; address4(); result.value += "; Store BL into index mode register (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}	
	if (splitData[i] == "E6") {
		i = i + 1; result.value += " " + splitData[i] + "            ??? ";
		result.value += "               ; Load AW from any register in register file?" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "E7") {
		result.value += "               ???";
		result.value += "                ; Unknown. Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E8") {
		result.value += "               SBLA               ";
		result.value += "; Store byte from address in AW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "E9") {
		result.value += "               SBLB               ";
		result.value += "; Store byte from address in BW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "EA") {
		result.value += "               SBLX               ";
		result.value += "; Store byte from address in XW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "EB") {
		result.value += "               SBLY               ";
		result.value += "; Store byte from address in YW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "EC") {
		result.value += "               SBLZ               ";
		result.value += "; Store byte from address in ZW into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "ED") {
		result.value += "               SBLS               ";
		result.value += "; Store byte from address in S into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "EE") {
		result.value += "               SBLC               ";
		result.value += "; Store byte from address in C into implicit BL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "EF") {
		result.value += "               SBLP               ";
		result.value += "; Store byte from address in P into implicit BL" + "\r\n";
		return(cont=1);
	}
	
	
	// F0 through FF	
	if (splitData[i] == "F0") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBW";
		i = i + 1; address2(); result.value += "; Store BW into PC address (PC)- <- X (Opposite 60)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F1") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBW";
		i = i + 1; address2(); result.value += "; Store BW into direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F2") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBW";
		i = i + 1; address3(); result.value += "; Store BW into indirect address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F3") {
		result.value += " " + splitData[i+1] + "            STBW";
		i = i + 1; branch1(); result.value += "; Store word of BW into direct PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F4") {
		result.value += " " + splitData[i+1] + "            STBW";
		i = i + 1; branch1a(); result.value += "; Store word of BW into indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F5") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STBW";
			i = i + 1; address5(); result.value += "; Store BW into index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            STBW";
			i = i + 1; address4(); result.value += "; Store BW into index mode register (view supplemental material)" + "\r\n";
		}
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
	if (splitData[i] == "F8") {
		result.value += "               SBWA               ";
		result.value += "; Store word from address in AW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "F9") {
		result.value += "               SBWB               ";
		result.value += "; Store word from address in BW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "FA") {
		result.value += "               SBWX               ";
		result.value += "; Store word from address in XW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "FB") {
		result.value += "               SBWY               ";
		result.value += "; Store word from address in YW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "FC") {
		result.value += "               SBWZ               ";
		result.value += "; Store word from address in ZW into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "FD") {
		result.value += "               SBWS               ";
		result.value += "; Store word from address in S into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "FE") {
		result.value += "               SBWC               ";
		result.value += "; Store word from address in C into implicit BW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "FF") {
		result.value += "               SBWP               ";
		result.value += "; Store word from address in P into implicit BW" + "\r\n";
		return(cont=1);
	}	
	
}