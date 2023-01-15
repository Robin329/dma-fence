# SPDX-License-Identifier: GPL-2.0
# Please keep these build lists sorted!

# If we are running by kernel building system
ifneq ($(KERNELRELEASE),)
# If we running without kernel build system
# core driver code

dmabuf_selftests-y := \
	selftest.o \
	st-dma-fence.o \
	st-dma-fence-chain.o

obj-m += dma-fence-kernel.o
obj-m += dmabuf_selftests.o

ccflags-y += -I$(src) -DDEBUG

else

# BUILDSYSTEM_DIR:=/lib/modules/$(shell uname -r)/build
BUILDSYSTEM_DIR=/home/ubuntu/workspace/rspi-4b/raspberrypi-linux/build
PWD:=$(shell pwd)

all:
# run kernel build system to make module
	$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) modules
	gcc -Wall -o dma-fence-test dma-fence-test.c -lpthread

clean:
# run kernel build system to cleanup in current directory
	$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) clean
	rm -rf dma-fence-test
endif