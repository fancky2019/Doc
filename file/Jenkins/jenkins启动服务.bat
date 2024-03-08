
::将CMD的字符编码设置为UTF-8，防止乱码
chcp 65001
@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo run as administrator...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
::
echo 关闭服务
net stop "jenkins"
echo 开启服务
net start "jenkins"
pause
::cd /d C:\Program Files\Jenkins\jenkins.exe
 
