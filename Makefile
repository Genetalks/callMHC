all:
	make -C samtools -j
	make -C minimap2 -j
	make -C gfatools -j
	make -C hifiasm -j
	chmod a+x asm_calling_mhc build_event_and_call Bandage

.PHONY: clean

clean:
	make -C samtools clean
	make -C minimap2 clean
	make -C gfatools clean
	make -C hifiasm  clean
