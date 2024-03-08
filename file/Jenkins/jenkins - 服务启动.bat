
::将CMD的字符编码设置为UTF-8，防止乱码
chcp 65001
@echo off
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (
    echo Administrator rights confirmed.
) else (
    echo Requesting administrator rights...
    powershell Start-Process -FilePath "%0" -Verb RunAs
    exit /b
)
::
echo 关闭服务
net stop "jenkins"
echo 开启服务
net start "jenkins"
::pause
::cd /d C:\Program Files\Jenkins\jenkins.exe
 
