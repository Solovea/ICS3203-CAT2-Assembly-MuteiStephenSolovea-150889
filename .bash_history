nasm -v
nasm -f elf32 number_classification.asm -o classify_number.o
nasm -f elf64 number_classification.asm -o number_classification.o
ld number_classification.o -o number_classification
./number.classification
./number_classification
