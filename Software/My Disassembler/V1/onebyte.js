function onebyte(){

	//One Byte Operations
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