@echo off
cd /d d:
cd D:\Test\runjava\prod
start cmd /c "title ����Ǩ�ƹ���-pro && java -jar ordermigratedbtool-prod.jar"
cd D:\Test\runjava\test
start cmd /c "title ����Ǩ�ƹ���-test && java -jar ordermigratedbtool-0.0.1-SNAPSHOT.jar"
::pause                   // ��ֹ������Ϻ�ֱ�ӹرս���
::��bat�ļ����Ƶ�����Ŀ¼
::C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup