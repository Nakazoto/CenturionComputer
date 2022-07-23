
	.export __cpu_to_le32
	.export __le32_to_cpu
	.export __be32_to_cpu
	.export __cpu_to_be32

	.setcpu 4
	.code

__cpu_to_le32:
__le32_to_cpu:
	ldb	2(s)		; High word swapped as new low
	xfrb	bh,al
	xfrb	bl,ah
	ldb	4(s)		; Low word swapped as new high
	xfrb	bl,yl
	xfrb	bh,bl
	xfrb	yl,bh
__cpu_to_be32:
__be32_to_cpu:
	rsr
