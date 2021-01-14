#defne the global values

#define the toolchain's values:
TOOLCHAIN_ROOT :=/usr
#SYSROOTS :=/
CROSS_PATH :=$(TOOLCHAIN_ROOT)/bin/
CROSS_PERFIX :=

##define project values:
#define my-create_folder
$(shell mkdir -p $(ROOT)/bin/)
$(shell mkdir -p $(ROOT)/lib/)
$(shell mkdir -p $(ROOT)/maps/)
#endef

#$(my-create_folder)

export PROGRAM_PATH :=$(ROOT)/bin/
export LIB_SHARE_PATH :=$(ROOT)/lib/
export MAP_FILE_PATH :=$(ROOT)/maps/







#define how to create the .d and map files. -----------------------------------------
CFLAGS=-MMD -MP -MF"$(@:%.o=%.d)"
#LDFLAGS=-Wl,-Map=$(notdir $(basename $@)).map
LDFLAGS=-Wl,-Map=$(notdir $(basename $@)).map


#base on the makefile's input enviroment: -DDEBUG_ENABLE, we can control the complain debug level...----------------
OUTPUT_FILE:=@
ifdef $(DEBUG_ENABLE)
  SHOW_DEBUG :=y
  LDFLAGS +=-rdynamic
  OPTIMIZATION_LEVEL := -O0 -g -rdynamic
else
  SHOW_DEBUG :=
  LDFLAGS +=-rdynamic
  OPTIMIZATION_LEVEL := -O2
endif


#buidl the bin-utils name: --------------------------------------------------------
#@ 字符可以禁止命令行的显示。
ifeq ($(SHOW_DEBUG),y)
	SHOW_DEBUG :=
else
	SHOW_DEBUG :=@
endif

AR :=$(SHOW_DEBUG)$(CROSS_PATH)$(CROSS_PERFIX)ar
AS :=$(SHOW_DEBUG)$(CROSS_PATH)$(CROSS_PERFIX)as
CC :=$(SHOW_DEBUG)$(CROSS_PATH)$(CROSS_PERFIX)gcc
CPP :=$(SHOW_DEBUG)$(CROSS_PATH)$(CROSS_PERFIX)g++
LD :=$(SHOW_DEBUG)$(CROSS_PATH)$(CROSS_PERFIX)ld
STRIP :=$(SHOW_DEBUG)$(CROSS_PATH)$(CROSS_PERFIX)strip




#include file flages:  ------------------------
IFLAGS :=-I$(SYSROOTS)/usr/include

# --sysroot=dir 的作用
#   如果在编译时指定了-sysroot=dir 就是为编译时指定了逻辑目录。编译过程中需要引用的库，头文件，
#	如果要到/usr/include目录下去找的情况下，则会在前面加上逻辑目录。

#编译选项累加
CFLAGS += --sysroot=$(SYSROOTS) $(OPTIMIZATION_LEVEL) -Wall  -fmessage-length=0

#链接选项累加
LDFLAGS += --sysroot=$(SYSROOTS) -Wl,-rpath-link $(SYSROOTS)/lib -Wl,-rpath-link $(SYSROOTS)/usr/lib  -L$(SYSROOTS)/lib



