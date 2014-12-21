@echo off
if %1==unlock goto unlock
if %1==relock goto relock

echo "You have to type bootloader.bat unlock or relock"
goto exit

:unlock
echo "Go to http://bit.ly/UpVtsa and read the risks, click next"; read line
echo "Are you sure ?? Do you know the risks ?? Are you willing to do this ??"; read line
bin\fastboot.exe oem get_unlock_data
echo "Enter this code as shown in the example:"
echo "Enter code on the website and press enter"; read line
echo "Enter the key emailed to you here:"
read code
bin\fastboot.exe oem unlock $code

:relock
bin\fastboot lock begin
echo "Now you have to flash the stock image"
echo "This is an example http://forum.xda-developers.com/moto-g-2014/general/restore-to-stock-t2873657"
echo "When done press Enter"
pause > null
bin\fastboot.exe oem lock
echo "Your bootloader is now locked"

:exit
