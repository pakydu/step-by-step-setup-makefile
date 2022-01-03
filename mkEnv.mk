#defne the global values
#CURDIR:=`pwd`
SHELL:=/bin/bash
#BASE:=$(shell str="$(strip $(BASE))";if [ $${str:0:1} = "/" ]; then echo $(BASE);else echo $(CURDIR)/$(BASE); fi)
#Makefile中需要打印信息，可以通过如下方法：
#$(info info text)、$(warning warning text)或者$(error error text)
ifeq ($(ROOT_BASE), "")
$(error "Please export what is your ROOT_BASE for this sub_project")
else
$(info "the root_bas=${ROOT_BASE}")
endif



#BASE on the makefile's input enviroment: -DDEBUG_ENABLE, we can control the complain debug level...----------------
ifdef $(DEBUG_ENABLE)
  LDFLAGS +=-rdynamic
  OPTIMIZATION_LEVEL := -O0 -g -rdynamic
  OUTPUT_FILE:=""
else
  LDFLAGS +=-rdynamic
  OPTIMIZATION_LEVEL := -O2
  OUTPUT_FILE:=@
endif

#define the different platform EVN
###################################
#     aarch64-linux-gnu-gcc       #
###################################
ifeq ($(ARCH), arm64)

export ARCH_TYPE:=ARM64
export ROOTFS_PATH:=$(ROOT_BASE)/root_fs/rootfs_arm64


TOOLCHAIN_PATH=/opt/linaro-7.5.0/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu
CROSS_PATH:=$(TOOLCHAIN_PATH)/bin/
CROSS_PERFIX=aarch64-linux-gnu-
SYSROOTS=$(TOOLCHAIN_PATH)/sysroot/sysroot-glibc-linaro-2.25-2019.12-aarch64-linux-gnu

#You can add more head file path for your projects.
IFLAGS:=  \
	-I$(SYSROOTS)/usr/include \
	-I$(TOOLCHAIN_PATH)/aarch64-linux-gnu/libc/usr/include


CFLAGS+=-D$(ARCH_TYPE) 
LDFLAGS+= -Wl,-rpath-link $(ROOTFS_PATH)/usr/local/lib -L$(ROOTFS_PATH)/usr/local/lib
#LDFLAGS+= -Wl,-rpath-link $(SYSROOTS)/lib -Wl,-rpath-link $(SYSROOTS)/usr/lib -L$(SYSROOTS)/lib -L$(SYSROOTS)/usr/lib \
#		-L$(TOOLCHAIN_PATH)/aarch64-linux-gnu/libc/lib \
#		-Wl,-rpath-link $(ROOTFS_PATH)/usr/local/lib -L$(ROOTFS_PATH)/usr/local/lib
#
else
###############################
#     arm-linux-gnu-gcc       #
###############################
ifeq ($(ARCH), "arm)
echo "we will do the arm32 ........"
$(error "It will be supported by later.")
else

################################################################################################
#     gcc      It will use the system defautl  tool                                            #
#     If you want to tool the code in the product Os, you can use the "x86" for your projects. #
################################################################################################
ifeq ($(ARCH), "x86)
echo "we will do the x86........"
export ROOTFS_PATH:=$(ROOT_BASE)/root_fs/rootfs_x86

else
$(error "please check your project, what is your arch ${ARCH} type for build?")

endif  #for x86

endif  #for arm

endif #for arm64




#buidl the bin-utils name: --------------------------------------------------------
AR :=$(CROSS_PATH)$(CROSS_PERFIX)ar
AS :=$(CROSS_PATH)$(CROSS_PERFIX)as
CC :=$(CROSS_PATH)$(CROSS_PERFIX)gcc
CPP :=$(CROSS_PATH)$(CROSS_PERFIX)g++
LD :=$(CROSS_PATH)$(CROSS_PERFIX)ld
STRIP :=$(CROSS_PATH)$(CROSS_PERFIX)strip




#append the 3rd include path.
#IFLAGS+=-I$(ROOT_BASE)/source/xxx/3rd_part/cJSON \
#		-I$(ROOT_BASE)/source/xxx/3rd_part/sqlite
		

# --sysroot=dir 的作用
#   如果在编译时指定了-sysroot=dir 就是为编译时指定了逻辑目录。编译过程中需要引用的库，头文件，
#	如果要到/usr/include目录下去找的情况下，则会在前面加上逻辑目录。

#编译选项累加
CFLAGS += $(OPTIMIZATION_LEVEL) -Wall

#链接选项累加
#LDFLAGS += 



export ROOT_BASE ROOTFS_PATH OUTPUT_FILE
