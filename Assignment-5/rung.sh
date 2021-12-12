rm *.out
echo "Assemble clock.asm"
nasm -f elf64 -l clock.lis -o clock.o clock.asm -g -gdwarf
echo "Compile driver.cpp"
gcc -c -Wall -m64 -no-pie -o driver.o driver.c -std=c11 -g
echo "Link object files"
gcc -m64 -no-pie -o clock.out -std=c11 clock.o driver.o -g
echo "------Program Start------"
gdb ./clock.out
echo "------Program End------"
rm *.o
rm *.lis
rm *.out
