#### 常见文本匹配

+ 从文件中过滤出某些行
	- 直接用grep -E 'keyword' srcfile

+ 从文件的每行中过滤出某些字符串

	- 用grep -o -E 'regular pattern' srcfile  //-o 是only-matching的意思,-E指定正则表达式
	
+ awk 和 sed
