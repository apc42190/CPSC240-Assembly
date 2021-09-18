echo "Assemble triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm -g -gdwarf
echo "Compile pythagoras.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l triangle.lis -o pythagoras.o pythagoras.c -std=c11 -g
echo "Link object files"
gcc -m64 -std=c11 -o pythagoras.out triangle.o pythagoras.o -fno-pie -no-pie -g
echo "------Program Start------"
gdb ./pythagoras.out
echo "------Program End------"
rm *.o
rm *.lis
rm *.out