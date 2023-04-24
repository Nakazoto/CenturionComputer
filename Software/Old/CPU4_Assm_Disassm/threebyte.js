function threebyte() {
	
	// Three byte operations (and Indexed Mode operations)
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
	
	if (splitData[i] == "78") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         JSR ";
		i = i + 1; address1(); result.value += "; Jump to subroutine at literal address (not possible?)" + "\r\n";
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
	
	// Is 0x80 really a 2-byte?
/* 	if (splitData[i] == "80") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAL";
		i = i + 1; address1a(); result.value += "; Load literal address into byte of AL" + "\r\n";
		return(cont=1);
	} */
	
	if (splitData[i] == "81") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAL";
		i = i + 1; address2(); result.value += "; Load direct address into byte of AL" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "82") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDAL";
		i = i + 1; address3(); result.value += "; Load indirect address into byte of AL" + "\r\n";
		return(cont=1);
	}
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
	
/* 	if (splitData[i] == "C0") {
		result.value += " " + splitData[i+1] + " " + splitData[i+2] + "         LDBL";
		i = i + 1; address1a(); result.value += "; Load literal address into byte of BL" + "\r\n";
		return(cont=1);
	} */
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
}