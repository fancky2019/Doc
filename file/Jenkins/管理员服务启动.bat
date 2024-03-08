
::将CMD的字符编码设置为UTF-8，防止乱码
chcp 65001
@echo off
::加上管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
::
echo 关闭服务
net stop "jenkins"
echo 开启服务
net start "jenkins"
pause
::cd /d C:\Program Files\Jenkins\jenkins.exe
 
