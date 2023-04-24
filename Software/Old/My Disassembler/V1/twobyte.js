function twobyte() {

	// Two-byte operations
	if (splitData[i] == "10") {
		result.value += " " + splitData[i+1] + "            BL  ";
		i = i + 1; branch1(); result.value += "; Branch if link set to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "11") {
		result.value += " " + splitData[i+1] + "            BNL ";
		i = i + 1; branch1(); result.value += "; Branch if link not set to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "12") {
		result.value += " " + splitData[i+1] + "            BF  ";
		i = i + 1; branch1(); result.value += "; Branch if fault set to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "13") {
		result.value += " " + splitData[i+1] + "            BNF ";
		i = i + 1; branch1(); result.value += "; Branch if fault not set to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "14") {
		result.value += " " + splitData[i+1] + "            BZ  ";
		i = i + 1; branch1(); result.value += "; Branch if equal to zero to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "15") {
		result.value += " " + splitData[i+1] + "            BNZ ";
		i = i + 1; branch1(); result.value += "; Branch if not equal to zero to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "16") {
		result.value += " " + splitData[i+1] + "            BM  ";
		i = i + 1; branch1(); result.value += "; Branch if minus set to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "17") {
		result.value += " " + splitData[i+1] + "            BP  ";
		i = i + 1; branch1(); result.value += "; Branch on positive to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "18") {
		result.value += " " + splitData[i+1] + "            BGZ ";
		i = i + 1; branch1(); result.value += "; Branch if greater than zero to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "19") {
		result.value += " " + splitData[i+1] + "            BLE ";
		i = i + 1; branch1(); result.value += "; Branch if less than or equal to zero to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "1A") {
		result.value += " " + splitData[i+1] + "            BS1 ";
		i = i + 1; branch1(); result.value += "; Branch if sense switch 1 set to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "1B") {
		result.value += " " + splitData[i+1] + "            BS2 ";
		i = i + 1; branch1(); result.value += "; Branch if sense switch 2 set to zero to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "1C") {
		result.value += " " + splitData[i+1] + "            BS3 ";
		i = i + 1; branch1(); result.value += "; Branch if sense switch 3 set to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "1D") {
		result.value += " " + splitData[i+1] + "            BS4 ";
		i = i + 1; branch1(); result.value += "; Branch if sense switch 4 set to zero to 0x"; branch2();
		return(cont=1);
	}
	if (splitData[i] == "1E") {
		result.value += " " + splitData[i+1] + "            BIE";
		i = i + 1; branch1(); result.value += "; Branch on interrupts enabled to 0x"; branch2();
		return(cont=1);
	}				
	if (splitData[i] == "1F") {
		result.value += " " + splitData[i+1] + "            BEP?";
		i = i + 1; branch1(); result.value += "; Branch on Even Parity (CPU6 is different. See instructions B6 and C6)";
		return(cont=1);
	}
	
	if (splitData[i] == "20") {
		result.value += " " + splitData[i+1] + "            INR ";
		i = i + 1; arg1(); result.value += "; Increment byte of explicit register by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "21") {
		result.value += " " + splitData[i+1] + "            DCR ";
		i = i + 1; arg1(); result.value += "; Decrement byte of explicit register by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "22") {
		result.value += " " + splitData[i+1] + "            CLR ";
		i = i + 1; arg1(); result.value += "; Clear byte of explicit register by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "23") {
		result.value += " " + splitData[i+1] + "            IVR ";
		i = i + 1; arg1(); result.value += "; Invert byte of explicit register by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "24") {
		result.value += " " + splitData[i+1] + "            SRR ";
		i = i + 1; arg1(); result.value += "; Shift byte of explicit register right by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "25") {
		result.value += " " + splitData[i+1] + "            SLR ";
		i = i + 1; arg1(); result.value += "; Shift byte of explicit register left by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "26") {
		result.value += " " + splitData[i+1] + "            RRR ";
		i = i + 1; arg1(); result.value += "; Rotate byte of explicit register right by 1 + const." + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "27") {
		result.value += " " + splitData[i+1] + "            RLR ";
		i = i + 1; arg1(); result.value += "; Rotate byte of explicit register left by 1 + const." + "\r\n";
		return(cont=1);
	}
	
	if (splitData[i] == "30") {
		result.value += " " + splitData[i+1] + "            INR ";
		i = i + 1; arg2(); result.value += "; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "31") {
		result.value += " " + splitData[i+1] + "            DCR ";
		i = i + 1; arg2(); result.value += "; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "32") {
		result.value += " " + splitData[i+1] + "            CLR ";
		i = i + 1; arg2(); result.value += "; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "33") {
		result.value += " " + splitData[i+1] + "            IVR ";
		i = i + 1; arg2(); result.value += "; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "34") {
		result.value += " " + splitData[i+1] + "            SRR ";
		i = i + 1; arg2(); result.value += "; Shift byte of explicit register right by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "35") {
		result.value += " " + splitData[i+1] + "            SLR ";
		i = i + 1; arg2(); result.value += "; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "36") {
		result.value += " " + splitData[i+1] + "            RRR ";
		i = i + 1; arg2(); result.value += "; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "37") {
		result.value += " " + splitData[i+1] + "            RLR ";
		i = i + 1; arg2(); result.value += "; Rotate byte of explicit register left by 1 + const. (Odd reg. on MEM)" + "\r\n";
		return(cont=1);
	}
	
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
	
	
	if (splitData[i] == "C0") {
		result.value += " " + splitData[i+1] + "            LDBL";
		i = i + 1; address1a(); result.value += "; Load literal address into byte of BL" + "\r\n";
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
}