#Aaron Cope
#CPSC240-01 //1 is the section number
#apc42190@csu.fullerton.edu
#Triangle Areas

rm *.out
echo "Assemble huron.asm"
nasm -f elf64 -l huron.lis -o huron.o huron.asm -g -gdwarf
echo "Compile triangle.cpp"
g++ -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c++17 -g
echo "Link object files"
g++ -m64 -no-pie -o triangle.out -std=c++17 huron.o triangle.o is_float.cpp output_area.cpp output_error_message.cpp -g
echo "------Program Start------"
gdb ./triangle.out
echo "------Program End------"
rm *.o
rm *.lis
rm *.out