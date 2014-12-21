@echo off

bin\fastboot.exe boot img/twrp.img
bin\adb.exe wait-for-device push supersu\UPDATE-SuperSU-v2.40.zip /tmp/.
bin\adb.exe wait-for-device shell twrp install /tmp/UPDATE-SuperSU-v2.40.zip
bin\adb.exe wait-for-device reboot-bootloader
