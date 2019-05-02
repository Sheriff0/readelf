objs = readElf.o
 
readElf: $(objs)
	ld -o readelf @arg.txt $(objs)

asms = readElf.s elf.utils.s elf.data.s

$(objs): $(asms)
	as --keep-locals -o readElf.o readElf.s

