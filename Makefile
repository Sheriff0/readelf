objs = readElf.o
 
readElf: $(objs)
	clang $(objs)

asms = readElf.s

$(objs): $(asms)
	as -o readElf.o readElf.s

