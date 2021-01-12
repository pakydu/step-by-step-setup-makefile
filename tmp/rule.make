# This is the global place to define the variables

SHOW_DEBUG-y:=
SAVE_LOG-y:=y

#Convert the relative path to the absolute path
CURDIR:=`pwd`
SHELL:=/bin/bash
BASE:=$(shell str="$(strip $(BASE))";if [ $${str:0:1} = "/" ]; then echo $(BASE);else echo $(CURDIR)/$(BASE); fi)
MAP_FILE_PATH=$(BASE)/G4_Builder/maps/

CFLAGS=-MMD -MP -MF"$(@:%.o=%.d)"
LDFLAGS=-Wl,-Map=$(notdir $(basename $@)).map

ifeq ($(BASE)/debug, $(wildcard $(BASE)/debug))
	OPTIMIZATION_LEVEL:=-O0 -g3
	LDFLAGS+=-rdynamic 
	SHOW_DEBUG-y:=y
else
	OPTIMIZATION_LEVEL:=-O2
	CFLAGS+=-DPRODUCTION
endif

HWCFGSUB=
HWPLATFORM=
export NEWTOOLS:=NO

ifeq ($(BASE)/newarm, $(wildcard $(BASE)/newarm))
export NEWTOOLS:=YES
export ROOTFS:=$(BASE)/rootfs_newarm
export HWPLATFORM:=ARM32
#TOOLCHAIN_INSTALLATION_PATH=/home/flobro/emerson-build/buildroots/buildroot-arm32/buildroot-arm32/output/host/
#TOOLCHAIN_PATH:=$(TOOLCHAIN_INSTALLATION_PATH)
#CROSS_PATH:=/home/flobro/emerson-build/buildroots/buildroot-arm32/buildroot-arm32/output/host/bin/
#CROSS_PREFIX:=arm-buildroot-linux-gnueabihf
#SYSROOTS=$(TOOLCHAIN_INSTALLATION_PATH)/arm-buildroot-linux-gnueabihf/sysroot

TOOLCHAIN_INSTALLATION_PATH=/opt/arm-buildroot-linux-gnueabihf_sdk-buildroot
#TOOLCHAIN_INSTALLATION_PATH=/opt/arm-buildroot-linux-gnueabihf_sdk-buildroot.old
TOOLCHAIN_PATH:=$(TOOLCHAIN_INSTALLATION_PATH)
CROSS_PATH:=$(TOOLCHAIN_INSTALLATION_PATH)/bin/
CROSS_PREFIX:=arm-buildroot-linux-gnueabihf
SYSROOTS=$(TOOLCHAIN_INSTALLATION_PATH)/arm-buildroot-linux-gnueabihf/sysroot

IFLAGS:=-includestdbool.h \
	-I$(SYSROOTS)/usr/include/glib-2.0 \
	-I$(SYSROOTS)/usr/include/glib-2.0/glib \
	-I$(SYSROOTS)/usr/include/json-glib-1.0 \
	-I$(SYSROOTS)/usr/include/dbus-1.0 \
	-I$(SYSROOTS)/usr/include/xlslib \
	-I$(SYSROOTS)/usr/include/uuid \
	-I$(SYSROOTS)/usr/include/luajit-2.0 \
	-I$(SYSROOTS)/usr/lib/glib-2.0/glib \
	-I$(SYSROOTS)/usr/lib/glib-2.0/include \
	-I$(SYSROOTS)/usr/lib/dbus-1.0/include

#OLDBUILD=1 - normal build - old SS* names for E3
#OLDBUILD=0 - new build - new E3* names for E3
export OLDBUILD=1
ifeq ($(BASE)/arm64_base_full, $(wildcard $(BASE)/arm64_base_full))
    export HWCFGSUB:=E3
    export E3BUILD:=FULL
    export HWCFG:=IMX8MM
    export LIBPLATEXT:=libARME3
    export ROOTFS:=$(BASE)/rootfs_arm64-full

else 
    ifeq  ($(BASE)/arm64_base_short, $(wildcard $(BASE)/arm64_base_short))
    export HWCFGSUB:=E3
    export E3BUILD:=UPDATE
    export HWCFG:=IMX8MM
    export LIBPLATEXT:=libARME3
    export ROOTFS:=$(BASE)/rootfs_arm64-short
    
    else
	export HWCFG:=AM335x
	export HWCFGSUB:=" "
	export LIBPLATEXT:=libARMSS
	export OLDBUILD=1
    endif
    
endif
export LIBPLATDIR:=libARM
CFLAGS+=-D$(HWCFG) -DTDB_DISALLOW_NESTING=0 -D__GLIBC__=2 -D__GLIBC_MINOR=30
LDFLAGS+=--sysroot=$(SYSROOTS) -Wl,-rpath-link $(SYSROOTS)/lib -Wl,-rpath-link $(SYSROOTS)/usr/lib -L$(SYSROOTS)/lib -L$(SYSROOTS)/usr/lib

else
#############################################
#       (newx86 - buildroot)   #
#############################################
ifeq ($(BASE)/newx86, $(wildcard $(BASE)/newx86))
export NEWTOOLS:=YES
export ROOTFS:=$(BASE)/rootfs_newx86
TOOLCHAIN_INSTALLATION_PATH=/opt/i686-buildroot-linux-gnu_sdk-buildroot/
TOOLCHAIN_PATH:=$(TOOLCHAIN_INSTALLATION_PATH)/bin/
CROSS_PATH:=$(TOOLCHAIN_PATH)
CROSS_PREFIX:=i686-buildroot-linux-gnu
SYSROOTS=$(TOOLCHAIN_INSTALLATION_PATH)/i686-buildroot-linux-gnu/sysroot/
export HWPLATFORM:=x86
export LIBPLATEXT:=libX86
export LIBPLATDIR:=libX86

IFLAGS:=-includestdbool.h \
	-I$(SYSROOTS)/usr/include/glib-2.0 \
	-I$(SYSROOTS)/usr/include/glib-2.0/glib \
	-I$(SYSROOTS)/usr/include/json-glib-1.0 \
	-I$(SYSROOTS)/usr/include/dbus-1.0 \
	-I$(SYSROOTS)/usr/include/xlslib \
	-I$(SYSROOTS)/usr/include/uuid \
	-I$(SYSROOTS)/usr/include/luajit-2.0 \
	-I$(SYSROOTS)/usr/lib/glib-2.0/glib \
	-I$(SYSROOTS)/usr/lib/glib-2.0/include \
	-I$(SYSROOTS)/usr/lib/dbus-1.0/include

export HWCFG:=x86
CFLAGS+=-Dx86 -DTDB_DISALLOW_NESTING=0
LDFLAGS+=--sysroot=$(SYSROOTS) -Wl,-rpath-link $(SYSROOTS)/lib -Wl,-rpath-link $(SYSROOTS)/usr/lib -L$(SYSROOTS)/lib -L$(SYSROOTS)/usr/lib
else

#############################################
#       arm-poky-linux-gnueabi (cortexa8)   #
#############################################
ifeq ($(BASE)/cortexa8, $(wildcard $(BASE)/cortexa8))
export HWCFG:=AM335x
export HWPLATFORM:=ARM32
#ifeq ($(BASE)/cortexa8-e2r, $(wildcard $(BASE)/cortexa8-e2r))
#export HWCFGSUB:=E2R
#endif

export ROOTFS:=$(BASE)/rootfs_cortexa8_AM335x
HARDFLOATFLAGS=-mfloat-abi=hard -mfpu=neon -mtune=cortex-a8

TOOLCHAIN_INSTALLATION_PATH=/opt/poky/cortexa8t2hf

SYSROOTS=$(TOOLCHAIN_INSTALLATION_PATH)/sysroots
CONFIG_SITE=$(TOOLCHAIN_INSTALLATION_PATH)/site-config-cortexa8t2hf-vfp-neon-poky-linux-gnueabi
OECORE_ACLOCAL_OPTS_PATH=$(SYSROOTS)/i686-pokysdk-linux/usr/share/aclocal
PYTHONHOME=$(SYSROOTS)/i686-pokysdk-linux/usr
OECORE_NATIVE_SYSROOT=$(SYSROOTS)/i686-pokysdk-linux
SDKTARGETSYSROOT=$(SYSROOTS)/cortexa8t2hf-vfp-neon-poky-linux-gnueabi
TOOLCHAIN_PATH:=$(SYSROOTS)/cortexa8t2hf-vfp-neon-poky-linux-gnueabi
CROSS_PATH:=$(SYSROOTS)/i686-pokysdk-linux/usr/bin/arm-poky-linux-gnueabi
CROSS_PREFIX:=/arm-poky-linux-gnueabi

IFLAGS:=-I$(TOOLCHAIN_PATH)/usr/include \
	-includestdbool.h \
	-I$(TOOLCHAIN_PATH)/usr/include/glib-2.0 \
	-I$(TOOLCHAIN_PATH)/usr/include/glib-2.0/glib \
	-I$(TOOLCHAIN_PATH)/usr/include/json-glib-1.0 \
	-I$(TOOLCHAIN_PATH)/usr/include/dbus-1.0 \
	-I$(TOOLCHAIN_PATH)/usr/include/xlslib \
	-I$(TOOLCHAIN_PATH)/usr/include/uuid \
	-I$(TOOLCHAIN_PATH)/usr/lib/glib-2.0/glib \
	-I$(TOOLCHAIN_PATH)/usr/lib/glib-2.0/include \
	-I$(TOOLCHAIN_PATH)/usr/lib/dbus-1.0/include \

CFLAGS+=--sysroot=$(SDKTARGETSYSROOT) -DAM335x -D__GLIBC__=2 -D__GLIBC_MINOR=19
LDFLAGS+=--sysroot=$(SDKTARGETSYSROOT) -Wl,-rpath-link $(TOOLCHAIN_PATH)/lib -Wl,-rpath-link $(TOOLCHAIN_PATH)/usr/lib -L$(TOOLCHAIN_PATH)/lib -L$(TOOLCHAIN_PATH)/usr/lib

else
#############################################
#       i586-poky-linux (x86)   #
#############################################
ifeq ($(BASE)/x86, $(wildcard $(BASE)/x86))
export HWCFG:=x86
export ROOTFS:=$(BASE)/rootfs_x86

TOOLCHAIN_INSTALLATION_PATH=/opt/poky/x86

SYSROOTS=$(TOOLCHAIN_INSTALLATION_PATH)/sysroots
CONFIG_SITE=$(TOOLCHAIN_INSTALLATION_PATH)/site-config-core2-32-poky-linux
OECORE_ACLOCAL_OPTS_PATH=$(SYSROOTS)/i686-pokysdk-linux/usr/share/aclocal
PYTHONHOME=$(SYSROOTS)/i686-pokysdk-linux/usr
OECORE_NATIVE_SYSROOT=$(SYSROOTS)/i686-pokysdk-linux
SDKTARGETSYSROOT=$(SYSROOTS)/core2-32-poky-linux
TOOLCHAIN_PATH:=$(SYSROOTS)/core2-32-poky-linux
CROSS_PATH:=$(SYSROOTS)/i686-pokysdk-linux/usr/bin/i586-poky-linux
CROSS_PREFIX:=/i586-poky-linux

IFLAGS:=-I$(TOOLCHAIN_PATH)/usr/include \
	-includestdbool.h \
	-I$(TOOLCHAIN_PATH)/usr/include/glib-2.0 \
	-I$(TOOLCHAIN_PATH)/usr/include/glib-2.0/glib \
	-I$(TOOLCHAIN_PATH)/usr/include/json-glib-1.0 \
	-I$(TOOLCHAIN_PATH)/usr/include/dbus-1.0 \
	-I$(TOOLCHAIN_PATH)/usr/include/xlslib \
	-I$(TOOLCHAIN_PATH)/usr/include/uuid \
	-I$(TOOLCHAIN_PATH)/usr/lib/glib-2.0/glib \
	-I$(TOOLCHAIN_PATH)/usr/lib/glib-2.0/include \
	-I$(TOOLCHAIN_PATH)/usr/lib/dbus-1.0/include \

CFLAGS+=--sysroot=$(SDKTARGETSYSROOT) -Dx86
LDFLAGS+=--sysroot=$(SDKTARGETSYSROOT) -Wl,-rpath-link $(TOOLCHAIN_PATH)/lib -Wl,-rpath-link $(TOOLCHAIN_PATH)/usr/lib -L$(TOOLCHAIN_PATH)/lib -L$(TOOLCHAIN_PATH)/usr/lib

endif
endif
endif
endif
##########################################################################################
#         DO NOT modify these settings below, unless you know what you are doing!        #
##########################################################################################
ifneq (yes,$(ECLIPSE))
	COLOR_BLACK=\e[0;30m
	COLOR_BLUE=\e[0;34m
	COLOR_GREEN=\e[0;32m
	COLOR_CYAN=\e[0;36m
	COLOR_RED=\e[0;31m
	COLOR_PURPLE=\e[0;35m
	COLOR_BROWN=\e[0;33m
	COLOR_GRAY=\e[0;37m
	COLOR_DARK_GRAY=\e[1;30m
	COLOR_LIGHT_BLUE=\e[1;34m
	COLOR_LIGHT_GREEN=\e[1;32m
	COLOR_LIGHT_CYAN=\e[1;36m
	COLOR_LIGHT_RED=\e[1;31m
	COLOR_LIGHT_PURPLE=\e[1;35m
	COLOR_YELLOW=\e[1;33m
	COLOR_WHITE=\e[1;37m
	COLOR_END=\e[0m
endif

#make sure only touch one of cortexa8/x86
temp=$(shell set i = 0; for cmp in $(wildcard $(BASE)/x86 $(BASE)/newx86 $(BASE)/cortexa8 $(BASE)/newarm);do i=`expr $$i + 1`;done;if [ -z $$i ];then echo "NONE";exit 1;elif [ $$i -gt 1 ];then echo "MULTI";exit 1;fi;)
ifeq ("$(temp)", "MULTI")
$(error $(shell echo -e "$(COLOR_RED)only choice one of newx86/x86/cortexa8/newarm$(COLOR_END)"))
exit 1
endif
ifeq ("$(temp)", "NONE")
$(error $(shell echo -e "you must $(COLOR_RED)touch newx86/x86/cortexa8/newarm$(COLOR_END) first"))
exit 1
endif

CFLAGS+=$(OPTIMIZATION_LEVEL)

ifeq ($(SHOW_DEBUG-y),y)
	SHOW_DEBUG:=
else
	SHOW_DEBUG:=@
endif

BUILD_TMP_FOLDER:=$(BASE)/.tmp
ifeq ($(strip $(SAVE_LOG-y)),y)
	LOG_FILE:=$(BASE)/build.log
	FIFO_FILE:=$(BUILD_TMP_FOLDER)/.test.fifo
	OUTPUT_FILE = @logfile="$(strip $(LOG_FILE))";fifofile="$(FIFO_FILE)";rm -f $$fifofile;mkfifo $$fifofile;cat $$fifofile | tee -a $$logfile & exec 2>$$fifofile;
else
	LOG_FILE:=/dev/null
	OUTPUT_FILE:=@
endif

CROSS:=$(CROSS_PATH)$(CROSS_PREFIX)-
AR:=$(SHOW_DEBUG)$(CROSS)ar
AS:=$(SHOW_DEBUG)$(CROSS)as
CC:=$(SHOW_DEBUG)$(CROSS)gcc
CPP:=$(SHOW_DEBUG)$(CROSS)g++ -std=c++11
#CPP:=$(SHOW_DEBUG)$(CROSS)g++
LD:=$(SHOW_DEBUG)$(CROSS)ld
#"strip" command maybe used in shell script, DO NOT add @
STRIP:=$(CROSS)strip

ROOT_PART:=$(ROOTFS)/rootfs_partition
DATA_PART:=$(ROOTFS)/data_partition
ROOT_PART_UNSTRIPPED:=$(ROOTFS)/rootfs_partition_unstripped


CFLAGS+=-D_GNU_SOURCE -Wall -pthread -fmessage-length=0 $(HARDFLOATFLAGS)
ifeq ($(NEWTOOLS),YES)
CFLAGS+= -DNEWTOOLS
endif

#support the HT function to record reset information. If we can remove the old funcion, we will not need this flag.
CFLAGS+= -DUSE_HT_FUNCTION
IFLAGS+=-I$(BASE)/3rd_party_sw/libJsonObjects
LDFLAGS+=-L${ROOT_PART}/usr/lib -Wl,-rpath-link ${ROOT_PART}/usr/lib -Wl,-rpath-link ${ROOT_PART}/lib

export BASE ROOTFS ROOT_PART ROOT_PART_UNSTRIPPED DATA_PART STRIP LOG_FILE FIFO_FILE
