@echo off
if %1==boot goto unlock
if %1==flash goto relock

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
bin\fastboot.exe oem lock
echo "Your bootloader is now locked"

:exit
