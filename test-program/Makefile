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


# .PHONY: clean
# clean:
# 	-rm $(PROGRAM) $(objs)


#version 2: 更多通配符

PROGRAM=test

src := $(wildcard *.c)

%.o: 

clean:
	echo $(src)
	echo "$vpath"

#gcc -MM main.c  自动生成头文件的依赖关系.

#make -n or --just-print:   这个参数让make过程只显示命令，不执行它.
#make -s or --slient:       这个参数让make全面禁止命令显示.

#如何标记命令为不在意失败:  给命令前加-， 如-rm *.o


#make 如何追踪当前正在编译的目录: make -w or --print-directory.

#几种赋值符号：
#	“=”是最普通的等号，在make时，会把整个makefile展开，最后才决定变量的最后值
#	”:=”就表示直接赋值，赋予当前位置的值。”:=”才是真正意义上的直接赋值
#	“？=”表示如果该变量没有被赋值，则赋予等号后的值


#几种特殊推导扩展符号：
#	$@ 代表目标
#	$^ 代表所有的依赖对象
#	$< 代表第一个依赖对象
