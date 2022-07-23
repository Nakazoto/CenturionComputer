
	.export __cpu_to_le16
	.export __le16_to_cpu
	.export __be16_to_cpu
	.export __cpu_to_be16

	.setcpu 4
	.code

__cpu_to_le16:
__le16_to_cpu:
	ldb	2(s)
	xfrb	bh,al
	xfrb	bl,ah
__cpu_to_be16:
__be16_to_cpu:
	rsr
