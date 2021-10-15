Linux下面如何一步一个的通过makefile来管理工程
- makefile 基本语法联系:  ./test-program/Makefile, 这个文件包含两个基本的语法测试代码.最新的代码是把他们注释掉了.你可以根据需要打开先关部分进行测试.
- 目前根目录下的两个makefile主要就是控制整个工程的总体编译: 
    > mkEnv.mk: 整个文件主要是定义了整体项目的相关变量,它会被其他的各个小工程的makfile包含/调用.
    > Makefile: 整个是整个工程的makefile,你可以在里面按照一定的规则添加新的小工程进来.
    > 当前有两个小工程,一个是bin文件的编译,一个是sharelibrary的编译.
- 基本上我们可以整个makefile的架构去组织自己的大型项目了,这样也就方便我们集成我们的软件项目的自动测试和的脚本发布.


使用变量覆盖的方式切换编译工具链：
- makefile里面用CC ?= gcc
- 在命令行重新定义CC, 如make CC=aarch64-linux-gnu-gcc， 那么就会使用这个CC替换makefile里面的gcc， 如果CC没有定义，那就使用gcc。




