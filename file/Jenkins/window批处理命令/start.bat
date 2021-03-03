@echo off
::避免Jenkins杀掉衍生进程
set BUILD_ID=dontKillMe
::重启之前杀掉之前运行的进程。根据端口号找进程
set port=8101
for /f "tokens=1-5" %%i in ('netstat -ano^|findstr ":%port%"') do (
  taskkill /pid %%m /f
)
::复制目录下的jar文件
set sourcePath=C:\Windows\System32\config\systemprofile\AppData\Local\Jenkins\.jenkins\workspace\ordermigratedbtool\ordermigratedbtool\target\ordermigratedbtool-0.0.1-SNAPSHOT.jar
set desPath=D:\Jenkins\output\ordermigratedbtool
xcopy sourcePath desPath /Y
echo 复制ordermigratedbtool-0.0.1-SNAPSHOT.jar完成
::目录切换到jar路径，日志写在当前路径
d:
cd D:\Jenkins\output\ordermigratedbtool
::执行jar
java -jar D:\Jenkins\output\ordermigratedbtool\ordermigratedbtool-0.0.1-SNAPSHOT.jar
echo 执行jar成功
exit