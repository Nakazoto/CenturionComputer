


all: out/* out/DIAG/*

out/DIAG/f1.asm: disassemble.py disassemble_f1.py diag_common.py
	python3 disassemble_f1.py > out/DIAG/f1.asm

out/DIAG/f2.asm: disassemble.py disassemble_f2.py diag_common.py
	python3 disassemble_f2.py > out/DIAG/f2.asm

out/DIAG/f3.asm: disassemble.py disassemble_f3.py diag_common.py
	python3 disassemble_f3.py > out/DIAG/f3.asm

out/DIAG/f4.asm: disassemble.py disassemble_f4.py diag_common.py
	python3 disassemble_f4.py > out/DIAG/f4.asm

out/bootstrap.asm: disassemble.py disassemble_bootstrap.py
	python3 disassemble_bootstrap.py > out/bootstrap.asm

out/autoload.asm: disassemble.py disassemble_autoload.py
	python3 disassemble_autoload.py > out/autoload.asm