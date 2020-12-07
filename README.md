# IOS-CrashAnalysis
IOS对Crash进行分析的脚本

###使用方法


```
bash iOSCrashAnalyticScript.sh -u -p [APP名称]
```
-u : 用来查看APP和dSYM文件的UUID，可以比对是否一致

-p : 接工程名，Mach-O的名称

-a : 开始解析

最后的解析指令：

```
bash iOSCrashAnalyticScript.sh -a -p [APP名称]
```
查看输出的carsh.log文件，就是最后的解析结构