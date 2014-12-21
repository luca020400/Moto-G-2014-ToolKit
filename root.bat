@echo off
if %1==titan_retaildsds goto titan_retaildsds 
if %1==titan_retde goto titan_retde
if %1==titan_retuglb goto titan_retuglb

echo "You have to type root.bat device ( titan_ret*** )"
goto :exit

:titan_retaildsds
bin\fastboot.exe boot autoroot/titan_retaildsds.img
goto exit

:titan_retde
bin\fastboot.exe boot autoroot/titan_retde.img
goto exit

:titan_retuglb
bin\fastboot.exe boot autoroot/titan_retuglb.img
goto exit

:unsupported
echo "Unsupported Device"

:exit