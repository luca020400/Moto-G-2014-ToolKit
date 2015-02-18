@echo off

set adb="bin\adb.exe"
set fastboot="bin\fastboot.exe"

set log_file=".log_toolkit"
set supersuver="2.46"
set supersuzip="UPDATE-SuperSU-v$supersuver.zip"
set twrp="openrecovery-twrp-2.8.5.0-titan.img"

echo "Universal Moto G 2014 Toolkit"
echo "By luca020400"
echo "Version 2.0"
echo 
echo "Press Enter to continue"
echo "Press CTRL+c to abort"
pause >nul

echo "/*"
echo  "* Your warranty is now void. Knox 0x1."
echo  "*"
echo  "* I am not responsible for bricked devices, dead SD cards,"
echo  "* thermonuclear war, or you getting fired because the alarm app failed."
echo  "* Please do some research if you have any concerns about this tool !"
echo  "* YOU are choosing to make these modifications, and if"
echo  "* you point the finger at me for messing up your device, I will laugh at you. Hard. A lot."
echo  "*/"

:adb_authorization
echo "You have to enable USB Debugging in Developer Settings"
echo "When done Press Enter"
pause >nul
echo "Click 'Always allow from this computer'"
echo "And then OK"
echo "When done Press Enter"
%adb% wait-for-device

:menu
echo "Universal Moto G 2014 Toolkit Menu:"
echo "[rb] Reboot to Bootloader from Phone"
echo "[rp] Reboot to Phone from Bootloader"
echo "[rr] Reboot to Recovery from Phone"
echo "[1] TWRP 2.8.5.0 Flash"
echo "[2] TWRP 2.8.5.0 Boot"
echo "[3] Philz Flash"
echo "[4] Philz Boot"
echo "[5] Root with SuperSU %supersuver%"
echo "[6] Logo Without Warning"
echo "[7] Logo With Warning"
echo "[8] Busybox Installer"
echo "[9] Bootloader Unlock"
echo "[10] Bootloader Relock"
echo "[q] Exit"
echo ""
SET /P choice="> "
echo ""
if %choice%==rb %adb% reboot-bootloader
if %choice%==rp %fastboot% reboot
if %choice%==rr %adb% reboot
if %choice%==1 goto twrp_flash
if %choice%==2 goto twrp_boot
if %choice%==3 goto philz_flash
if %choice%==4 goto philz_boot
if %choice%==5 goto root
if %choice%==6 goto logo_nowarn
if %choice%==7 goto logo_warn
if %choice%==8 goto busybox
if %choice%==9 goto bootloader_unlock
if %choice%==10 goto bootloader_relock
if %choice%==q goto exit
else echo "Error Unknown Command" & goto :menu
