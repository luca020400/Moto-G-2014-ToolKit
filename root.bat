@echo off

set supersu=UPDATE-SuperSU-v2.40.zip

bin\fastboot.exe boot img/twrp.img
timeout 20
bin\adb.exe push mods\%supersu% /tmp/.
bin\adb.exe shell twrp install /tmp/%supersu%
bin\adb.exe reboot-bootloader
