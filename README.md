<p align="center"><img src="https://i.ibb.co/pj0Pnj7/ADB-and-Fastboot-Plus-Plus.png" width="200"></a>
<h1 align="center"><b>ADB & Fastboot++</b></h1>
<h4 align="center">A small Application for Windows that allows you to install the latest Version of ADB and Fastboot Files on the Computer without installing the entire Android SDK Package + Toolkit & Commands</h4>
<br />

<p align="center">
<a href="https://forum.xda-developers.com/t/tool-windows-adb-fastboot-march-2022.3944288/" alt="XDA Thread"><img src="https://img.shields.io/badge/XDA-Thread-orange.svg"></a>
<a href="" alt="Latest Release"><img src="https://img.shields.io/github/v/release/K3V1991/ADB-and-FastbootPlusPlus?color=blueviolet&label=Latest%20Release"></a>
<a href="" alt="Downloads"><img src="https://img.shields.io/github/downloads/K3V1991/ADB-and-FastbootPlusPlus/total?label=Downloads"></a>
<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HW8B98TVDLKWA" alt="Donate-PayPal"><img src="https://img.shields.io/badge/Donate-PayPal-blue"></a>
<a href="https://github.com/K3V1991/Donate-Crypto/blob/main/README.md" alt="Donate-Crypto"><img src="https://img.shields.io/badge/Donate-Crypto-yellow"></a>
</p>
<hr>
<br />
<br />

## NFO:
* Versions: Installer & Portable
* Android Debug Bridge & Fastboot updated to latest v1.0.41 (Version 33.0.1-8253317, March 2022)

## Features:
* Installation Folder chooseable (Installer)
* Desktop & Start Menu Shortcuts (Installer)
* Toolkit
* View Commands, How-To enable Developer Options & USB Debugging
* Add to System Path Environment (Installer)
* Optional Universal ADB Driver Installation (Installer)

## Toolkit Features:
* Uninstall Bloatware without Root Access (They are just being uninstalled for the current User)
* Re-install uninstalled Apps
* Install Kernel (Popup Menu, reboots automatically to Bootloader)
* Install Recovery (Popup Menu, reboots automatically to Bootloader)
* Install APKs (Popup Menu)
* Push Files (Popup Menu)
* Check Firmware Version
* Check Android Version
* Check Kernel Version                
* Check Firmware Build Date           
* Check Kernel Build Date             
* Check Security Patch Date           
* Check IMEI                          
* Check IP Adresses          
* Check App Packages                  
* Check Process Activity (Real Time)
* Take Screenshots (PNG Format)
* Video recoding -  30 Seconds (Without Device Sound)
* Video recoding -  60 Seconds (Without Device Sound)
* Video recoding - 120 Seconds (Without Device Sound)
* Video recoding - 180 Seconds (Without Device Sound)
* Reboot the Device               
* Reboot to Bootloader
* Exit Bootloader to System
* Reboot to Recovery             
* Create Logcat
* Exit (adb kill-server & close Toolkit)

## Requirements:
* Windows OS
* USB Driver for your Device or Universal ADB Driver (Included in the Installer)
* PowerShell for the Toolkit

## Developer Options & USB Debugging:
1. Install the USB Driver for your Phone or Universal Adb Driver.
2. On your Phone, go to Settings > About Phone. Find the Build Number and tap on it 7 times to enable Developer Options.
3. Now enter System > Developer Options and find "USB debugging" and enable it.
4. Plug your Phone into the Computer and change it from "Charge only" to "File Transfer" Mode.
5. On your Computer, browse to the directory where you extracted the Portable Version or use Tiny ADB & Fastboot Shortcut.
6. Launch a Command Prompt with Open CMD.bat or use Tiny ADB & Fastboot Shortcut.
7. Once you’re in the Command Prompt, enter the following Command: adb devices
8. System is starting the ADB Daemon (If this is your first Time running ADB, you will see a Prompt on your Phone asking you to authorize a Connection with the Computer. Click OK.).
9. Succesful enabled USB Debugging.

## Unable to connect to ADB:
1. AMD Bug? - https://forum.xda-developers.com/t/fix-fastboot-issues-on-ryzen-based-pcs.4186321/
2. Switch Device from "Charging" to "File Transfer" Mode
3. Install the latest Device Driver or Universal USB Driver
4. Try another USB Cable
5. Use another USB Port (USB 3.0 Port to USB 2.0)
6. Try to execute Fastboot Command without connecting your Phone,
and once it says "waiting for device" plug in your USB Cable
7. Windows: Click "Change advanced power setting" on your chosen Plan and expand "USB Settings". Under "USB Settings" Section, expand "USB selective suspend setting" and change it to "Disabled" for On Battery and Plugged In.
8. Try another PC

## Installer:
1. Download ADB_&_Fastboot++_vXXX.exe
2. Follow the Installers Instructions and select where you would like to install ADB & Fastboot++
3. After the Installation Wizard has completed you can select to start ADB & Fastboot++
4. You should see a Command Window open, now you can use ADB and Fastboot Commands

## Portable:
1. Download ADB_&_Fastboot++_vXXX_Portable.zip
2. Extract the Zip Archive
3. Double click on Open CMD.bat
4. You should see a Command Window open, now you can use ADB and Fastboot Commands