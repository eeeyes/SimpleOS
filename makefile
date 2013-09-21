ASM_SRCS = $(wildcard *.asm) 

a.img : boot.bin system.bin createBootImg.sh
	./createBootImg.sh
%.d:%.asm
	nasm -M -MT "$*.o" $*.asm > $*.d

%.o: %.asm
	nasm $*.asm -o $*.o -f elf

%.o : %.c
	gcc -c $*.c -o $*.o


include $(ASM_SRCS:.asm=.d)



boot.bin : boot.asm sys.inc auto.inc
	nasm boot.asm -o boot.bin
system.bin : head.o  main.o
	ld head.o main.o -o system.bin -s --oformat=binary -Ttext=0

main.o	:  main.c

auto.inc : constants.sh  createAutoInc.sh
	./createAutoInc.sh


clean:
	rm *.o
	rm *.bin
	rm *.d

.PHONY : clean
