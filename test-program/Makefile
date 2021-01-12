# #version 1:
# #引用其他makefile
# #include xxx.mk
# objs = main.o kdb.o command.o display.o \
# 		insert.o utils.o

# #变量定义
# PROGRAM=test

# #显示规则
# $(PROGRAM): $(objs)
# 	cc -o $(PROGRAM) $(objs)


# #隐士规则: main.o : main.c
# main.o :
# 	echo "$*.c"
# 	cc -c $*.c

# kbd.o:
# 	cc -c $*.c

# command.o:
# 	cc -c $*.c


# display.o:
# 	cc -c $*.c

# insert.o:
# 	cc -c $*.c

# utils.o:
# 	cc -c $*.c


.PHONY: clean
# clean:
# 	-rm $(PROGRAM) $(objs)


#version 2: 更多通配符

# PROGRAM=test

# src := $(wildcard *.c)



# #gcc -MM main.c  自动生成头文件的依赖关系.

# #make -n or --just-print:   这个参数让make过程只显示命令，不执行它.
# #make -s or --slient:       这个参数让make全面禁止命令显示.

# #如何标记命令为不在意失败:  给命令前加-， 如-rm *.o


# #make 如何追踪当前正在编译的目录: make -w or --print-directory.

# #几种赋值符号：
# #	“=”是最普通的等号，在make时，会把整个makefile展开，最后才决定变量的最后值
# #	”:=”就表示直接赋值，赋予当前位置的值。”:=”才是真正意义上的直接赋值
# #	“？=”表示如果该变量没有被赋值，则赋予等号后的值


# #几种特殊推导扩展符号，或者叫自动化变量：
# #	$@ 代表目标
# #	$^ 代表所有的依赖对象
# #	$< 代表第一个依赖对象


# #定义命令包（类似自定义函数）
# #它的每个语句必须都是命令，而不能是一些变量定义。
# define my-test
# pwd
# ls -al
# endef

# #变量测试
# define my-val
# 	@echo "make level: "${MAKELEVEL}
#    ls -al $(shell pwd)
#    #${MAKE} host-type=$(shell arch) whoami=$(shell whoami)
# endef

# #替换变量集合里面的结尾字符，如下把src集合里面的结尾为.c的字符串替换成.o字符串。
# objs := $(src:.c=.o)
# #静态模式替换变量的结尾字符：
# objs2 := $(src:%.c=%.o)

# #高级变量应用：
# first_second = hello
# a = first
# b = sencond
# all = $($(a)_$(b))  #$(all) 就是 hello.


# al := 1
# a_objs := a.o b.o c.o
# 1_objs := 1.o 2.o 3.o

# source := $($(al)_objs:.o=.c)   #这里会使用1_objs.

# #环境变量：如CFLAGS,这个时寡欲编译的参数的环境变量
# #如果makefile中没有定义，那就使用整个环境变量里面的整个CFLAGS; 如果makefile中定义了，那就使用makefile中的。

# clean:
# 	echo $(src)
# 	$(my-test)
# 	@echo ${src}
# 	${my-val}
# 	@echo ${objs}
# 	@echo ${objs2}
# 	@echo $(source)


#version 3: 使用条件编译

src := $(wildcard *.c) $(wildcard ./sub/*.c)
objs := $(src:%.c=%.o)
deps := $(src:%.c=%.d)


PROGRAM := test-bin

libs_for_gcc := -lgnu
normal_libs :=

#CC=gcc
#条件判断编译: 
#	ifeq(a,b) ...endif
#	ifneq(q,b) ...endif
#	ifdef a  ...endif
#	ifndef a ...endif
ifeq ($(CC),gcc)
CFLAGS= -Wall -O -g $(libs_for_gcc) -I ./sub/
else
CFLAGS= -Wall -O -g $(normal_libs) -I ./sub/
endif

all: $(PROGRAM)

$(PROGRAM): $(objs) $(deps)
	@echo $(objs)
	$(CC) $(CFLAGS) -o $@ $(objs)

%.d:%.c
	$(CC) -MM $(CFLAGS) $<  >$@
	#$(CC) -MM $(CFLAGS) $< | sed 's/\\.o/.d/'g >>$@
%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $<

.PHONY: clean
clean:
	rm -f $(objs) $(deps) $(PROGRAM)