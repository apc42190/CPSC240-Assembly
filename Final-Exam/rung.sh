rm *.out
echo "Assemble force.asm"
nasm -f elf64 -l force.lis -o force.o force.asm -g -gdwarf
echo "Compile driver.cpp"
g++ -c -Wall -m64 -no-pie -o driver.o driver.cpp -std=c++17 -g
echo "Link object files"
g++ -m64 -no-pie -o force.out -std=c++17 force.o driver.o
echo "------Program Start------"
gdb ./force.out
echo "------Program End------"
rm *.o
rm *.lis
rm *.out