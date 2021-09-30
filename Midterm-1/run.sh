rm *.out
echo "Assemble triangle.asm"
nasm -f elf64 -l ohm.lis -o ohm.o ohm.asm
echo "Compile pythagoras.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l ohm.lis -o faraday.o faraday.c -std=c11
echo "Link object files"
gcc -m64 -std=c11 -o faraday.out ohm.o faraday.o -fno-pie -no-pie 
echo "------Program Start------"
./faraday.out
echo "------Program End------"
rm *.o
rm *.lis