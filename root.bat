@echo off

bin\fastboot.exe boot img/twrp.img
timeout 20
bin\adb.exe push supersu\UPDATE-SuperSU-v2.40.zip /tmp/.
bin\adb.exe shell twrp install /tmp/UPDATE-SuperSU-v2.40.zip
bin\adb.exe reboot-bootloader
