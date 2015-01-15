@echo off

bin\fastboot.exe boot img/twrp.img
timeout 20
bin\adb.exe push mods\busybox.zip /tmp/.
bin\adb.exe shell twrp install /tmp/busybox.zip
bin\adb.exe reboot-bootloader
