rm *.out
echo "Assemble hello.asm"
nasm -f elf64 -l hello.lis -o hello.o hello.asm
echo "Compile welcome.cpp"
g++ -c -Wall -m64 -no-pie -o welcome.o welcome.cpp -std=c++17
echo "Link object files"
g++ -m64 -no-pie -o welcome.out -std=c++17 hello.o welcome.o
echo "------Program Start------"
./welcome.out
echo "------Program End------"
rm *.o
rm *.lis