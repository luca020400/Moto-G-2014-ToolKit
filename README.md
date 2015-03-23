# Moto G 2014 ToolKit

### This tool includes :

1. Universal Moto G 2014 Support
2. Unlock / Relock the bootloader
3. Twrp and Philz Touch Recovery
4. Automatic Root Script
5. Automatic BusyBox Installer
6. Remove/Restore Unlocked Bootloader Warning
7. Reboot to Bootloader/Recovery/Phone

## How to use:

### Drivers:

Windows: https://www.motorola.com/getmdmwin

Mac OS X: https://www.motorola.com/getmdmmac

Linux: Already Included

### Linux and Mac OS X:

Double Click on `toolkit.sh`

### Windows:

Double Click on `toolkit.bat`

### Download:

https://github.com/luca020400/Moto-G-2014-Tool/archive/stable.zip

### Note:
If _adb_ detects your device as offline try the following:
- Make sure you installed MDM
- Reboot your phone
- Reboot your computer
- Try another USB port

If after trying this the phone is still detected as offline, download the [Android-SDK](http://developer.android.com/sdk/) and follow these steps:
- Extract the .zip
- Open a terminal on the extracted folder
- Execute `./tools/android`
- A prompt will open to install android SDK software and API
- Install the newest API and the platform tools

In the extracted folder you will find a new folder `platform-tools` containing adb and fastboot; copy those to this project under the bin folder.
