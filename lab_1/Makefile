all: lab_1

FILE_NAME = boot
OBJ = $(FILE_NAME).o
SRC = $(FILE_NAME).S

TARGET =$(FILE_NAME).bin 

lab_1: $(TARGET)

$(TARGET): $(OBJ)
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary -o $@ $^

$(OBJ): $(SRC)
	as --32 -o $@ $^
	

run: $(TARGET)
	qemu-system-i386 -fda $(TARGET)

clean:
	rm -rf $(TARGET) $(OBJ)

