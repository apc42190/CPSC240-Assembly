rm *.out
echo "Assemble hertz.asm"
nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm -g -gdwarf
echo "Compile maxwell.cpp"
g++ -c -Wall -m64 -no-pie -o maxwell.o maxwell.c -std=c++17 -g
echo "Link object files"
g++ -m64 -no-pie -o maxwell.out -std=c++17 hertz.o maxwell.o is_float.cpp -g
echo "------Program Start------"
gdb ./maxwell.out
echo "------Program End------"
rm *.o
rm *.lis