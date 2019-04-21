objs = readElf.o
 
readElf: $(objs)
	clang $(objs)
	rm $(objs)

asms = readElf.s

$(objs): $(asms)
	as -o readElf.o readElf.s

