Linux下面如何一步一个的通过makefile来管理工程
- makefile 基本语法联系:  ./test-program/Makefile, 这个文件包含两个基本的语法测试代码.最新的代码是把他们注释掉了.你可以根据需要打开先关部分进行测试.
- 目前根目录下的两个makefile主要就是控制整个工程的总体编译: 
    > mkEnv.mk: 整个文件主要是定义了整体项目的相关变量,它会被其他的各个小工程的makfile包含/调用.
    > Makefile: 整个是整个工程的makefile,你可以在里面按照一定的规则添加新的小工程进来.
    > 当前有两个小工程,一个是bin文件的编译,一个是sharelibrary的编译.
- 基本上我们可以整个makefile的架构去组织自己的大型项目了,这样也就方便我们集成我们的软件项目的自动测试和的脚本发布.
   ** make build ARCH=arm64  #buidl the all projects for arm64.
   ** make libitgw ARCH=arm64    #just build the libitgw project for arm64.
   ** you can export the ARCH env for all of the terminal shell window.
   ~~~
                    export ARCH=arm64/arm/x86    #you can define the ARCH for arm64,arm32 or x86.
                    export DEBUG_ENABLE=1     #you can enable the debug for gcc.
    ~~~
    ** when you go to a subproject folder, you should exporT the root_path of your code in the root_path:
    ~~~
                    export ROOT_BASE="/home/pakydu/works/V21-12/itgw_py" 
    ~~~


使用变量覆盖的方式切换编译工具链：
- makefile里面用CC ?= gcc
- 在命令行重新定义CC, 如make CC=aarch64-linux-gnu-gcc， 那么就会使用这个CC替换makefile里面的gcc， 如果CC没有定义，那就使用gcc。

## Makefile simple intruduce:
~~~
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
# #make -s or --slient:       这个参数让make全面禁止命令显示. -->这样我们就不需要给每个命令前面添加@字符了。


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
# # $? 所有比目标新的依赖目标的集合
# # $* 不包含扩展名的目标文件


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
#  CFLAGS: C代码编译器参数的环境变量
#  CPPFLAGS:C++代码编译器的环境变量
#  LDFLAGS: 连接器参数的环境变量
# #如果makefile中没有定义，那就使用整个环境变量里面的整个CFLAGS; 如果makefile中定义了，那就使用makefile中的。

# clean:
# 	echo $(src)
# 	$(my-test)
# 	@echo ${src}
# 	${my-val}
# 	@echo ${objs}
# 	@echo ${objs2}
# 	@echo $(source)


# #version 3: 使用条件编译
# src := $(wildcard *.c) $(wildcard ./sub/*.c)
# objs := $(src:%.c=%.o)
# deps := $(src:%.c=%.d)


# PROGRAM := test-bin

# libs_for_gcc := -lgnu
# normal_libs :=

# #CC=gcc
# #条件判断编译: 
# #	ifeq(a,b) ...endif
# #	ifneq(q,b) ...endif
# #	ifdef a  ...endif
# #	ifndef a ...endif
# ifeq ($(CC),gcc)
# CFLAGS= -Wall -O -g $(libs_for_gcc) -I ./sub/
# else
# CFLAGS= -Wall -O -g $(normal_libs) -I ./sub/
# endif

# all: $(PROGRAM)

# $(PROGRAM): $(objs) $(deps)
# 	@echo $(objs)
# 	$(CC) $(CFLAGS) -o $@ $(objs)

# %.d:%.c
# 	$(CC) -MM $(CFLAGS) $<  >$@
# 	#$(CC) -MM $(CFLAGS) $< | sed 's/\\.o/.d/'g >>$@
# %.o:%.c
# 	$(CC) $(CFLAGS) -c -o $@ $<

# .PHONY: clean
# clean:
# 	rm -f $(objs) $(deps) $(PROGRAM)

# -include $(deps)



# #version4: 使用各种字符串操作函数: $(<func_name>  <arguments>) or ${<func_name>  <arguments>}
# #<function_name>就是函数名,后面用空格隔开参数.<arguments>就是参数,参数之间用逗号隔开.


# #subst: 替换函数 $(subst <from>,<to>,<text>)
# # input1: 被替换子串(原来子串)
# # input2: 替换子串(新的子串)
# # input3: 替换操作的对象
# comma := ,
# empty := 
# space := $(empty) $(empty)
# foo := a b c
# bar := $(subst $(space),$(comma),$(foo))
# define my-fun-test
# @echo $(bar)
# endef


# #patsubst: 模式字符串替换函数  $(patsubst <pattern>,<replacement>,<text>)
# # input1: 被替换子串(原来子串)
# # input2: 替换子串(新的子串)
# # input3: 替换操作的对象
# src :=$(wildcard *.c)
# objs :=$(patsubst %.c,%.o, $(src))
# objs2 :=$(src:%.c=%.o)


# #strip: 去字符串空头或者空尾的函数  $(strip " a b c ")
# tmp := $(strip  a b c  )


# #findstring: 查找字符串的函数   $(findstring <find>,<in>)
# tmp := $(findstring a,"a b c")
# tmp2 := $(findstring a,"b c")


# #filter: 过滤函数    $(filter <pattern...>,<text>)
# allfile :=$(wildcard *.c) $(wildcard *.h)
# tmp :=$(filter %.h %.a,$(allfile))


# #filter-out: 反过滤函数    $(filter-out <pattern...>, <text>)
# allfile :=$(wildcard *.c) $(wildcard *.h)
# tmp2 :=$(filter-out %.h %.a,$(allfile))

# #sort: 排序函数   $(sort <list>)
# allfile :=$(wildcard *.c) $(wildcard *.h)
# list :=$(sort $(allfile))




# #word: 取单个单词函数    $(Word <n>,<text>)  去text中第n个单词
# allfile :=$(wildcard *.c) $(wildcard *.h)
# third-word :=$(word 3,$(allfile))



# #wordlist: 去一个区间的单词    $(wordlist <m>,<n>,<text>)
# allfile :=$(wildcard *.c) $(wildcard *.h)
# third-six :=$(wordlist 3,6,$(allfile))


# #words: 统计单词个数     $(words <text>)
# allfile :=$(wildcard *.c) $(wildcard *.h)
# number :=$(words $(allfile))

# #firstword: 提取第一个单词函数    $(firstword <text>) 
# #这个函数等价于: $(word 1,<text>)
# allfile :=$(wildcard *.c) $(wildcard *.h)
# first :=$(firstword $(allfile))


# #字符串函数的综合应用: 使用VPATH变量来指定依赖文件的搜索路径.
# VPATH := src:../sub:/usr/lib/include
# override CFLAGS += $(patsubst %, -I%, $(subst :, , $(VPATH)))




# clean:
# 	$(my-fun-test)
# 	@echo $(objs)
# 	@echo $(objs2)
# 	@echo $(tmp)
# 	@echo $(tmp2)
# 	@echo $(list)
# 	@echo $(allfile)
# 	@echo $(third-word)
# 	@echo $(third-six)
# 	@echo $(number)
# 	@echo $(first)
# 	@echo $(CFLAGS)


# #version5: 目录文件名操作函数:
#  #dir:  取目录函数    $(dir <names...>)
#  tmp :=$(dir src/foo.c hello)


# #notdir: 取文件    $(notdir <names...>)
# tmp :=$(notdir src/foo.c hello)



# #suffix: 取后缀函数    $(suffix <names...>)
# tmp :=$(suffix src/foo.c abc/a.h hello)


# #basename: 取前缀函数   $(basename <names...>)
# tmp :=$(basename src/foo.c abc/a.h hello)

# #addsuffix: 添加后缀函数   $(addsuffix <suffix>, <names...>)

# #addprefix: 添加前缀函数   $(addprefix  <prefix>, <names...>)

# #join: 添加前缀函数   $(join <list1>, <list2>)
# tmp :=$(join "aaa  bbb", "111 222 333")



# #foreach函数： 类似编程语言里面的循环语句， 
# # $(foreach <var>,<list>,<text>)
# # 把<list>中的单词逐个取出放到<var>里，然后执行<text>所包含的表达式。
# # 每次<text>会返回一个字符串，循环过程中，<text>的所有返回值会议空格间隔，最后<text>返回整个字符串。
# names := a b c d
# files :=$(foreach n, $(names),$(n).o)


# #origin 函数： 返回变量是从哪里定义的。
# tmp :=$(origin CC)


# #shell 函数： $(shell command)
# #command 就是操作系统支持的shell命令
# files :=$(shell ls *.c)


# ERROR_001 := xxx

# ifdef ERROR_001
# $(error error is $(ERROR_001))
# endif

#call函数：用来创建新的参数话的函数: $(call <expression>,<parm1>,<parm2>...)
# 当make执行整个函数时，<expression>中的变量，如$(1),$(2)等，就会被参数<parm1>,<parm2>等依次取代。最终返回了替换后的<expression>。
# replace = $(1) $(2)
# tmp = $(call replace,a,b,c)

# depend = $(depend_$(1)) $(1)
# depend_libCom      :=
# depend_test1       :=$(call depend,libCom)

#  clean:
# 	@echo $(tmp)
# 	@echo $(depend_test1)
# 	@echo $(CC)
# 	echo $(files)
	


# #version 6: 使用外部的文件定义的各种编译时需要的变量，如CC， CFLAGS, LDFLAGS, define values...
# include makefile pattern.

~~~

## 函数：
~~~
语法 ： $(<function> <arguments>) 
字符串函数
$(subst <from>,<to>,<text>) ： 把字串<text>中的<from>字符串替换成<to>
$(patsubst <pattern>,<replacement>,<text>) ：模式字符串替换函数
$(patsubst %.o,%.c,$(objects)) = $(objects:.o=.c)
$(strip <string>) ： 去空格函数
$(findstring <find>,<in>) ： 查找字符串函数
$(filter <pattern...>,<text>) ：过滤函数
sources := foo.c bar.c baz.s ugh.h
$(filter %.c %.s,$(sources))返回的值是“foo.c bar.c baz.s”
$(filter-out <pattern...>,<text>) ： 反过滤函数
$(sort <list>) ： 排序函数
$(word <n>,<text>) ，$(wordlist <s>,<e>,<text>) ，$(words <text>) ，$(firstword <text>) 

文件名操作函数
$(dir <names...>) ：取目录函数
$(notdir <names...>) ： 取文件函数
$(suffix <names...>)  ：取后缀函数
$(basename <names...>) ： 取前缀函数
$(addsuffix <suffix>,<names...>)  ：加后缀函数
$(addprefix <prefix>,<names...>)  ： 加前缀函数
$(join <list1>,<list2>) ： 连接函数
foreach 函数 
$(foreach <var>,<list>,<text>) 
es := a b c d 
files := $(foreach n,$(names),$(n).o) ===>a.o b.o c.o d.o
if 函数
origin函数 : 告诉变量是哪里来的
“undefined”,“default” ,“environment",“file”  ,“command line” ,“override” ,“automatic” 
shell

~~~





