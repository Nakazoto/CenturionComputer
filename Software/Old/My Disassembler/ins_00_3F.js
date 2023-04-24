function ins_00_3F(){

	//00 through 0F
	if (splitData[i] == "00") {
		result.value += "               HLT                ";
		result.value += "; Halts the CPU" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "01") {
		result.value += "               NOP                ";
		result.value += "; No Operation" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "02") {
		result.value += "               SF                 ";
		result.value += "; Set Fault" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "03") {
		result.value += "               RF                 ";
		result.value += "; Reset Fault" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "04") {
		result.value += "               EI                 ";
		result.value += "; Enable Interrupt system" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "05") {
		result.value += "               DI                 ";
		result.value += "; Disable Interrupt system" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "06") {
		result.value += "               SL                 ";
		result.value += "; Set Link" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "07") {
		result.value += "               RL                 ";
		result.value += "; Reset Link" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "08") {
		result.value += "               CL                 ";
		result.value += "; Complement Link" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "09") {
		result.value += "               RSR                ";
		result.value += "; Return from Subroutine" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "0A") {
		result.value += "               RI                 ";
		result.value += "; Return from Interrupt" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "0B") {
		result.value += "               RIM                ";
		result.value += "; Return from Interrupt Modified (illegal on CPU6?)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "0C") {
		result.value += "               ELO                ";
		result.value += "; Enable Link Out (CPU6 will flash ABT light)" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "0D") {
		result.value += "               PCX                ";
		result.value += "; Transfer PC to X" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "0E") {
		result.value += "               DLY                ";
		result.value += "; Delay 4.5ms" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "0F") {
		result.value += "               RSYS               ";
		result.value += "; Return from JSYS using stack" + "\r\n";
		return(cont=1);
	}
	
	
	//10 through 1F
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
	
	
	//20 through 2F
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
	if (splitData[i] == "28") {
		result.value += "               INAL               ";
		result.value += "; Increment byte of implicit AL register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "29") {
		result.value += "               DCAL               ";
		result.value += "; Decrement byte of implicit AL register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "2A") {
		result.value += "               CLAL               ";
		result.value += "; Clear byte of implicit AL register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "2B") {
		result.value += "               IVAL               ";
		result.value += "; Invert byte of implicit AL register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "2C") {
		result.value += "               SRAL               ";
		result.value += "; Shift byte of implicit AL register left" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "2D") {
		result.value += "               SLAL               ";
		result.value += "; Shift byte of implicit AL register right" + "\r\n";
		return(cont=1);
	}
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
	
	
	//30 through 3F
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
	if (splitData[i] == "38") {
		result.value += "               INAW               ";
		result.value += "; Increment word of implicit AW register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "39") {
		result.value += "               DCAW               ";
		result.value += "; Decrement word of implicit AW register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "3A") {
		result.value += "               CLAW               ";
		result.value += "; Clear word of implicit AW register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "3B") {
		result.value += "               IVAW               ";
		result.value += "; Invert word of implicit AW register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "3C") {
		result.value += "               SRAW               ";
		result.value += "; Shift word of implicit AW register left" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "3D") {
		result.value += "               SLAW               ";
		result.value += "; Shift word of implicit AW register right" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "3E") {
		result.value += "               INX                ";
		result.value += "; Increment word of implicit X register" + "\r\n";
		return(cont=1);
	}
	if (splitData[i] == "3F") {
		result.value += "               DCX                ";
		result.value += "; Decrement word of implicit X register" + "\r\n";
		return(cont=1);
	}
	
}