@echo off
if %1==titan_retaildsds bin\fastboot.exe boot autoroot/titan_retaildsds.img
if %1==titan_retde bin\fastboot.exe boot autoroot/titan_retde.img
if %1==titan_retuglb bin\fastboot.exe boot autoroot/titan_retuglb.img
if %1==titan_* echo "Unsupported Device"
if %1==* echo "You have to type root.bat device ( titan_ret*** )"
esac
