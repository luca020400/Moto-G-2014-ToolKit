@echo off
if %1==boot bin\fastboot.exe boot img\twrp.img
if %1==flash bin\fastboot.exe flash recovery img\tpwr.img
else echo "You have to type twrp.bat flash or boot"
