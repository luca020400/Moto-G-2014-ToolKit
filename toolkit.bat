@echo off

set adb=bin\adb.exe
set fastboot=bin\fastboot.exe
set supersuver=2.46
set supersuzip=UPDATE-SuperSU-v$supersuver.zip
set twrp=img\openrecovery-twrp-2.8.5.0-titan.img

goto toolkit
goto disclaimer
goto menu

:toolkit
echo Universal Moto G 2014 Toolkit
echo By luca020400
echo Version 2.0
echo.
echo Press Enter to continue
echo Press CTRL+c to abort
pause > nul
echo.

:disclaimer
echo /*
echo  * Your warranty is now void. Knox 0x1.
echo  *
echo  * I am not responsible for bricked devices, dead SD cards,
echo  * thermonuclear war, or you getting fired because the alarm app failed.
echo  * Please do some research if you have any concerns about this tool !
echo  * YOU are choosing to make these modifications, and if
echo  * you point the finger at me for messing up your device, I will laugh at you. Hard. A lot.
echo  */
echo.

:adb_authorization
echo You have to enable USB Debugging in Developer Settings
echo When done Press Enter
pause > nul
echo Click 'Always allow from this computer'
echo And then OK
echo When done Press Enter
%adb% wait-for-device > nul
pause > nul
echo.

:menu
cls
echo Universal Moto G 2014 Toolkit Menu
echo.
echo [rb] Reboot to Bootloader from Phone/Recovery
echo [rp] Reboot to Phone from Bootloader
echo [rr] Reboot to Recovery from Phone
echo [1] TWRP 2.8.5.0 Flash
echo [2] TWRP 2.8.5.0 Boot
echo [3] Philz Flash
echo [4] Philz Boot
echo [5] Root with SuperSU %supersuver%
echo [6] Logo Without Warning
echo [7] Logo With Warning
echo [8] Busybox Installer
echo [9] Bootloader Unlock
echo [10] Bootloader Relock
echo [q] Exit
echo.
SET /P choice="> 
echo.
if %choice%==rb %adb% reboot-bootloader > nul & cls
if %choice%==rp %fastboot% reboot > nul & cls
if %choice%==rr %adb% reboot Recovery > nul & cls
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
if %choice%==q echo Exiting ... & exit /b
echo Unknown Command
goto menu

:twrp_flash
%fastboot% flash recovery %twrp%
cls
goto :menu

:twrp_boot
%fastboot% boot %twrp%
cls
goto :menu

:philz_flash
&fastboot% flash recovery img\philz.img
cls
goto :menu

:philz_boot
%fastboot% boot img\philz.img
cls
goto :menu

:root
%fastboot% boot %twrp%
ping 1.1.1.1 -n 1 -w 20000 > nul
%adb% push mods\%supersu% /tmp/.
%adb% shell twrp install /tmp/%supersu%
%adb% reboot-bootloader
cls
goto :menu

:logo_nowarn
%fastboot% flash logo mods/logo-nowarning.bin
cls
goto :menu

:logo_warn
%fastboot% flash logo mods/logo-warning.bin
cls
goto :menu

:busybox
%fastboot% boot %twrp%
ping 1.1.1.1 -n 1 -w 20000 > nul
%adb% push mods\busybox.zip /tmp/.
%adb% shell twrp install /tmp/busybox.zip
%adb% reboot-bootloader
cls
goto :menu

:bootloader_unlock
echo Are you sure ?? Do you know the risks ?? Are you willing to do this ??
echo If so Press Enter
pause > nul
echo Go to http://bit.ly/UpVtsa and read the risks
ping 1.1.1.1 -n 1 -w 3000 > nul
echo When done press Enter
pause > nul
echo Follow the guide inside the site and then
echo Enter this code
%fastboot% oem get_unlock_data
echo As shown in the example
echo Enter the key emailed to you here
SET /P code="> "
%fastboot% oem unlock $code
cls
goto :menu

:bootloader_relock
%fastboot% lock begin
echo Now you have to flash the stock image
echo This is an example http://forum.xda-developers.com/moto-g-2014/general/restore-to-stock-t2873657
echo When done press Enter
pause > nul
%fastboot% oem lock
echo Your bootloader is now locked
cls
goto :menu
