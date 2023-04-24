function ins_80_BF() {
	
	// 80 through 8F
	//////////////////////////////////////////
	// Is 0x80 through 0x84 really a 2-byte?
	if (splitData[i] == "80") {
		result.value += " " + splitData[i+1] + "            LDAL";
		i = i + 1; address1a(); result.value += "; Load literal address into byte of AL" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "81") {
		result.value += " " + splitData[i+1] + "            LDAL";
		i = i + 1; address2(); result.value += "; Load indirect address into byte of AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "82") {
		result.value += " " + splitData[i+1] + "            LDAL";
		i = i + 1; address3(); result.value += "; Load indirect address into byte of AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "83") {
		result.value += " " + splitData[i+1] + "            LDAL";
		i = i + 1; branch1(); result.value += "; Load direct PC offset by N address into byte of AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "84") {
		result.value += " " + splitData[i+1] + "            LDAL";
		i = i + 1; branch1a(); result.value += "; Load indirect PC offset by N address into byte of AL" + "\r\n";
		return(cont=1);
	}
	// Is 0x80 through 0x84 really a 2-byte?
	//////////////////////////////////////////
	if (splitData[i] == "85") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAL";
			i = i + 1; address5(); result.value += "; Load index mode register address into AL (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            LDAL";
			i = i + 1; address4(); result.value += "; Load index mode register address into AL (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "86") {
		result.value += "               ???                ";
		result.value += "               ; Disable Parity Checking" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "87") {
		result.value += "               ???                ";
		result.value += "               ; Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "88") {
		result.value += "               LALA               ";
		result.value += "; Load byte from address in AW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "89") {
		result.value += "               LALB               ";
		result.value += "; Load byte from address in BW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "8A") {
		result.value += "               LALX               ";
		result.value += "; Load byte from address in XW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "8B") {
		result.value += "               LALY               ";
		result.value += "; Load byte from address in YW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "8C") {
		result.value += "               LALZ               ";
		result.value += "; Load byte from address in ZW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "8D") {
		result.value += "               LALS               ";
		result.value += "; Load byte from address in S into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "8E") {
		result.value += "               LALC               ";
		result.value += "; Load byte from address in C into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "8F") {
		result.value += "               LALP               ";
		result.value += "; Load byte from address in P into implicit AL" + "\r\n";
		return(cont=1);
	}
	
	
	// 90 through 9F
	if (splitData[i] == "90") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAW";
		i = i + 1; address1(); result.value += "; Load literal address into byte of AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "91") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAW";
		i = i + 1; address2(); result.value += "; Load direct address into byte of AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "92") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAW";
		i = i + 1; address3(); result.value += "; Load indirect address into byte of AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "93") {
		result.value += " " + splitData[i+1] + "            LDAW";
		i = i + 1; branch1(); result.value += "; Load direct PC offset by N address into word of AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "94") {
		result.value += " " + splitData[i+1] + "            LDAW";
		i = i + 1; branch1a(); result.value += "; Load indirect PC offset by N address into word of AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "95") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAW";
			i = i + 1; address5(); result.value += "; Load index mode register address into AW (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            LDAW";
			i = i + 1; address4(); result.value += "; Load index mode register address into AW (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	
	
	if (splitData[i] == "96") {
		result.value += "               ???                ";
		result.value += "               ; Turn off CPU line 4" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "97") {
		result.value += "               ???                ";
		result.value += "               ; Illegal?" + "\r\n";
		return(cont=1);
	}
	
	
	if (splitData[i] == "98") {
		result.value += "               LAWA               ";
		result.value += "; Load word from address in AW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "99") {
		result.value += "               LAWB               ";
		result.value += "; Load word from address in BW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "9A") {
		result.value += "               LAWX               ";
		result.value += "; Load word from address in XW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "9B") {
		result.value += "               LAWY               ";
		result.value += "; Load word from address in YW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "9C") {
		result.value += "               LAWZ               ";
		result.value += "; Load word from address in ZW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "9D") {
		result.value += "               LAWS               ";
		result.value += "; Load word from address in S into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "9E") {
		result.value += "               LAWC               ";
		result.value += "; Load word from address in C into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "9F") {
		result.value += "               LAWP               ";
		result.value += "; Load word from address in P into implicit AW" + "\r\n";
		return(cont=1);
	}
	
	
	// A0 through AF	
	if (splitData[i] == "A0") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAL";
		i = i + 1; address2(); result.value += "; Store AL into PC address (PC)- <- X (Opposite 60)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A1") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAL";
		i = i + 1; address2(); result.value += "; Store AL into direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A2") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAL";
		i = i + 1; address3(); result.value += "; Store AL into indirect address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A3") {
		result.value += " " + splitData[i+1] + "            STAL";
		i = i + 1; branch1(); result.value += "; Store byte of AL into direct PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A4") {
		result.value += " " + splitData[i+1] + "            STAL";
		i = i + 1; branch1a(); result.value += "; Store byte of AL into indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}	
	if (splitData[i] == "A5") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAL";
			i = i + 1; address5(); result.value += "; Store AL into index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            STAL";
			i = i + 1; address4(); result.value += "; Store AL into index mode register (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "A6") {
		result.value += "               ???                ";
		result.value += "               ; Turn on CPU line 4" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A7") {
		result.value += "               ???                ";
		result.value += "               ; Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A8") {
		result.value += "               SALA               ";
		result.value += "; Store byte from address in AW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "A9") {
		result.value += "               SALB               ";
		result.value += "; Store byte from address in BW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "AA") {
		result.value += "               SALX               ";
		result.value += "; Store byte from address in XW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "AB") {
		result.value += "               SALY               ";
		result.value += "; Store byte from address in YW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "AC") {
		result.value += "               SALZ               ";
		result.value += "; Store byte from address in ZW into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "AD") {
		result.value += "               SALS               ";
		result.value += "; Store byte from address in S into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "AE") {
		result.value += "               SALC               ";
		result.value += "; Store byte from address in C into implicit AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "AF") {
		result.value += "               SALP               ";
		result.value += "; Store byte from address in P into implicit AL" + "\r\n";
		return(cont=1);
	}
	
	
	// B0 through Bf	
	if (splitData[i] == "B0") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAW";
		i = i + 1; address2(); result.value += "; Store AW into PC address (PC)- <- X (Opposite 60)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B1") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAW";
		i = i + 1; address2(); result.value += "; Store AW into direct address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B2") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAW";
		i = i + 1; address3(); result.value += "; Store AW into indirect address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B3") {
		result.value += " " + splitData[i+1] + "            STAW";
		i = i + 1; branch1(); result.value += "; Store word of AW into direct PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B4") {
		result.value += " " + splitData[i+1] + "            STAW";
		i = i + 1; branch1a(); result.value += "; Store word of AW into indirect PC offset by N address" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B5") {
		var judge = splitData[i+1].charAt(1);
		if (parseInt(judge, 16) > 7) {
			result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         STAW";
			i = i + 1; address5(); result.value += "; Store AW into index mode register (view supplemental material)" + "\r\n";
		} else {
			result.value += " " + splitData[i+1] + "            STAW";
			i = i + 1; address4(); result.value += "; Store AW into index mode register (view supplemental material)" + "\r\n";
		}
		return(cont=1);
	}
	if (splitData[i] == "B6") {
		result.value += "               ???                ";
		result.value += "               ; Writes -1 to AH at interrupt level 1. See instructions C6 and 1F" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B7") {
		result.value += "               ???                ";
		result.value += "               ; Illegal?" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B8") {
		result.value += "               SAWA               ";
		result.value += "; Store word from address in AW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "B9") {
		result.value += "               SAWB               ";
		result.value += "; Store word from address in BW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "BA") {
		result.value += "               SAWX               ";
		result.value += "; Store word from address in XW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "BB") {
		result.value += "               SAWY               ";
		result.value += "; Store word from address in YW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "BC") {
		result.value += "               SAWZ               ";
		result.value += "; Store word from address in ZW into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "BD") {
		result.value += "               SAWS               ";
		result.value += "; Store word from address in S into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "BE") {
		result.value += "               SAWC               ";
		result.value += "; Store word from address in C into implicit AW" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "BF") {
		result.value += "               SAWP               ";
		result.value += "; Store word from address in P into implicit AW" + "\r\n";
		return(cont=1);
	}

}