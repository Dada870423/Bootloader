#OSDI LAB 1

CC = aarch64-linux-gnu
CFLAGS = -fPIC -Include -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles -mgeneral-regs-only
ASMOPS = -fPIC -Iinclude
all: kernel8.img



SRC_DIR = src
BUILD_DIR = obj


${BUILD_DIR}/%.o: ${SRC_DIR}/%.c
	${CC}-gcc ${CFLAGS} -c $< -o $@

C_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)


kernel8.img: ${SRC_DIR}/link.ld ${OBJ_FILES} 
	${CC}-ld -Iinclude -T ${SRC_DIR}/link.ld -o ${BUILD_DIR}/kernel8.elf ${OBJ_FILES}
	${CC}-objcopy -O binary ${BUILD_DIR}/kernel8.elf kernel8.img

clean:
	rm -f kernel8.elf
	rm -f obj/*

run:
	qemu-system-aarch64 -M raspi3 -kernel kernel8.img -serial stdio
