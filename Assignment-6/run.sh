rm *.out
echo "Assemble looper.asm"
nasm -f elf64 -l looper.lis -o looper.o looper.asm
echo "Assemble clockspeed.asm"
nasm -f elf64 -l clockspeed.lis -o clockspeed.o clockspeed.asm
echo "Compile driver.cpp"
gcc -c -Wall -m64 -no-pie -o driver.o driver.c -std=c11
echo "Compile get_precision_number.c"
gcc -c -Wall -m64 -no-pie -o get_precision_number.o get_precision_number.c -std=c11
echo "Link object files"
gcc -m64 -no-pie -o clock.out looper.o driver.o clockspeed.o get_precision_number.o is_float.cpp -lm
echo "------Program Start------"
./clock.out
echo "------Program End------"
rm *.o
rm *.lis
rm *.out