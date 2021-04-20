@echo off
cd /d d:
cd D:\Test\runjava\prod
start cmd /c "title 订单迁移工具-pro && java -jar ordermigratedbtool-prod.jar"
cd D:\Test\runjava\test
start cmd /c "title 订单迁移工具-test && java -jar ordermigratedbtool-0.0.1-SNAPSHOT.jar"
::pause                   // 防止运行完毕后直接关闭界面
::将bat文件复制到启动目录
::C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup