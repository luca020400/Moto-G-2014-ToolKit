@echo off
if %1==boot bin\fastboot.exe boot img\philz.img
if %1==flash bin\fastboot.exe flash recovery img\philz.img
else echo "You have to type philz.bat flash or boot"
