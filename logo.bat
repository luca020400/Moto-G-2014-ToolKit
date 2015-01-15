@echo off
if %1==nowarning goto nowarning
if %1==warning goto warning

echo "You have to type logo.bat nowarning or warning"
goto exit

:nowarning
bin\fastboot.exe flash logo mods/logo-nowarning.bin
goto exit

:warning
bin\fastboot.exe flash logo mods/logo-warning.bin
goto exit

:exit
