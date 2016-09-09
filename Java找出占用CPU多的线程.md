#### linux下

	+ top命令-H参数可以toggle显示具体的线程号,找出占用CPU最高的线程号,再结合jstack导出的信息,可以大概地定位到代码位置 

#### windows下

	+ 用jstack把进程当前信息dump出来之后用工具(ProcessorExplorer)查看具体的线程号
