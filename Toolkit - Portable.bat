@echo off
title Toolkit v1.3
color 0a
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=75;height=50};}"
chcp 65001 >nul 2>&1
set "path=%path%;%~dp0ADB and Fastboot++ v1.0.5 Portable"
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                                                                        ║
echo ║                                                                        ║
echo ║   ______   ______     ______     __         __  __     __     ______   ║
echo ║  /\__  _\ /\  __ \   /\  __ \   /\ \       /\ \/ /    /\ \   /\__  _\  ║
echo ║  \/_/\ \/ \ \ \/\ \  \ \ \/\ \  \ \ \____  \ \  _"-.  \ \ \  \/_/\ \/  ║
echo ║     \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\  \ \_\    \ \_\  ║
echo ║      \/_/   \/_____/   \/_____/   \/_____/   \/_/\/_/   \/_/     \/_/  ║
echo ║                                                                        ║
echo ║                                                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
echo.
echo. 
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                        Starting ADB Connection...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb kill-server
adb start-server
echo. 
echo. 
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                    Checking connected Device(s)...                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb devices > %temp%/devices.txt
if "%1"=="-v" (
	type devices.txt
)
pushd %temp%
findstr /c:"device" devices.txt | find /c /v "" > %temp%/connected.txt
set /p devicecount=<connected.txt
del connected.txt
del devices.txt
popd

IF "%devicecount%"=="1" (
echo No Devices found. 
echo Please make sure your Device is connected, USB Debugging is enabled, 
echo and that they are authorised ^(check Device Screen^),
echo then run the Batch again.
echo.
echo. 
pause
exit /B 0
)
IF "%devicecount%" NEQ "2" (
echo Multiple Devices found. 
echo Disconnect all and reconnect the Device you wish to work with, 
echo then run the Batch again.
echo.
echo. 
pause
exit /B 0
)

for /F "delims=" %%a in ('adb shell getprop ro.product.device') do set DEVICE=%%a
for /F "delims=" %%a in ('adb shell getprop ro.product.model') do set MODEL=%%a
for /F "delims=" %%a in ('adb shell getprop ro.product.brand') do set BRAND=%%a
for /F "delims=" %%a in ('adb shell getprop ro.build.version.release') do set ANDROID=%%a
for /F "delims=" %%a in ('adb shell getprop ro.build.id') do set ID=%%a
for /F "delims=" %%a in ('adb shell getprop ro.build.version.security_patch') do set SECURITY=%%a

echo Device:             %DEVICE%                                        
echo Model:              %MODEL%                                                  
echo Brand:              %BRAND%
echo Android:            %ANDROID%
echo Firmware:           %ID%   
echo Security Patch:     %SECURITY%                    
echo.
echo. 
pause

:menu
color 0a
cls
echo ╔════════════════════════════════════════════════════════════════════════╗  
echo ║                                                                        ║
echo ║              __    __     ______     __   __     __  __                ║
echo ║             /\ "-./  \   /\  ___\   /\ "-.\ \   /\ \/\ \               ║
echo ║             \ \ \-./\ \  \ \  __\   \ \ \-.  \  \ \ \_\ \              ║
echo ║              \ \_\ \ \_\  \ \_____\  \ \_\\"\_\  \ \_____\             ║
echo ║               \/_/  \/_/   \/_____/   \/_/ \/_/   \/_____/             ║
echo ║                                                                        ║
echo ║                                                                        ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║    1   =   Debloat Google Apps                                         ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    2   =   Debloat Android Apps                                        ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    3   =   Install Kernel, Recovery, APKs and Push                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    4   =   Show Versions, Build Dates, IMEI, IP, Packages, Processes   ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    5   =   Screenshot and Screenrecoder                                ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    6   =   Reboot, Reboot to X, Bugreport and Logcat                   ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    7   =   Exit                                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr=Make your Choice:

IF %menunr%==1 (goto gg)
IF %menunr%==2 (goto ot)
IF %menunr%==3 (goto ins)
IF %menunr%==4 (goto chk)
IF %menunr%==5 (goto scrr)
IF %menunr%==6 (goto rbt)
IF %menunr%==7 (goto ext)
goto menu

:gg
color 01
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Google Apps                               ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   Android Accessiblity Suite                                 ║
echo ║     2   =   Android Auto                                               ║
echo ║     3   =   Android Setup                                              ║
echo ║     4   =   Calculator                                                 ║
echo ║     5   =   Calendar                                                   ║
echo ║     6   =   Chrome                                                     ║
echo ║     7   =   Device Health Services                                     ║
echo ║     8   =   Device Personalization Service                             ║
echo ║     9   =   Digital Wellbeing                                          ║
echo ║    10   =   Docs                                                       ║
echo ║    11   =   Drive                                                      ║
echo ║    12   =   Duo                                                        ║
echo ║    13   =   Gboard                                                     ║
echo ║    14   =   Gmail                                                      ║
echo ║    15   =   Google Assistant                                           ║
echo ║    16   =   Google Location History                                    ║
echo ║    17   =   Google One Time Init                                       ║
echo ║    18   =   Google Pay                                                 ║
echo ║    19   =   Google Play Movies and TV                                  ║
echo ║    20   =   Google Play Music                                          ║
echo ║    21   =   Google Play Services for AR                                ║
echo ║    22   =   Google Play Store                                          ║
echo ║    23   =   Google Search                                              ║
echo ║    24   =   Google Text-to-Speech                                      ║
echo ║    25   =   Maps                                                       ║
echo ║    26   =   Market Feedback Agent                                      ║
echo ║    27   =   Google Photos                                              ║
echo ║    28   =   Sheets                                                     ║
echo ║    29   =   Slides                                                     ║
echo ║    30   =   YouTube                                                    ║
echo ║    31   =   YouTube Music                                              ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    32   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    33   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr2=Make your Choice:

IF %menunr2%==1 (goto gg1)
IF %menunr2%==2 (goto gg2)
IF %menunr2%==3 (goto gg3)
IF %menunr2%==4 (goto gg4)
IF %menunr2%==5 (goto gg5)
IF %menunr2%==6 (goto gg6)
IF %menunr2%==7 (goto gg7)
IF %menunr2%==8 (goto gg8)
IF %menunr2%==9 (goto gg9)
IF %menunr2%==10 (goto gg10)
IF %menunr2%==11 (goto gg11)
IF %menunr2%==12 (goto gg12)
IF %menunr2%==13 (goto gg13)
IF %menunr2%==14 (goto gg14)
IF %menunr2%==15 (goto gg15)
IF %menunr2%==16 (goto gg16)
IF %menunr2%==17 (goto gg17)
IF %menunr2%==18 (goto gg18)
IF %menunr2%==19 (goto gg19)
IF %menunr2%==20 (goto gg20)
IF %menunr2%==21 (goto gg21)
IF %menunr2%==22 (goto gg22)
IF %menunr2%==23 (goto gg23)
IF %menunr2%==24 (goto gg24)
IF %menunr2%==25 (goto gg25)
IF %menunr2%==26 (goto gg26)
IF %menunr2%==27 (goto gg27)
IF %menunr2%==28 (goto gg28)
IF %menunr2%==29 (goto gg29)
IF %menunr2%==30 (goto gg30)
IF %menunr2%==31 (goto gg31)
IF %menunr2%==31 (goto gg32)
IF %menunr2%==32 (goto gg32)
IF %menunr2%==33 (goto menu)
goto gg:

:gg1
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Accessiblity Suite...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.marvin.talkback
echo.
pause
goto gg:

:gg2
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Android Auto...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.projection.gearhead
echo.
pause
goto gg:

:gg3
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Android Setup...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.restore
echo.
pause
goto gg:

:gg4
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Calculator...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.calculator
echo.
pause
goto gg:

:gg5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Calendar...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.calendar
echo.
pause
goto gg:

:gg6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Chrome...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.chrome
echo.
pause
goto gg:

:gg7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Device Health Services...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.turbo
echo.
pause
goto gg:

:gg8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Device Personalization Service...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.as
echo.
pause
goto gg:

:gg9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Digital Wellbeing...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.wellbeing
echo.
pause
goto gg:

:gg10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Docs...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs.editors.docs
echo.
pause
goto gg:

:gg11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Drive...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs
echo.
pause
goto gg:

:gg12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Duo...                                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.tachyon
echo.
pause
goto gg:

:gg13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Gboard...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.inputmethod.latin
echo.
pause
goto gg:

:gg14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Gmail...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.gm
echo.
pause
goto gg:

:gg15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Assistant...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.hotwordenrollment.okgoogle
adb shell pm uninstall -k --user 0 com.android.hotwordenrollment.xgoogle
echo.
pause
goto gg:

:gg16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Location History...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.gms.location.history
echo.
pause
goto gg:

:gg17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google One Time Init...                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.onetimeinitializer
echo.
pause
goto gg:

:gg18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Pay...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.walletnfcrel
echo.
pause
goto gg:

:gg19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Movies and TV...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.videos
echo.
pause
goto gg:

:gg20
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Music...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.music
echo.
pause
goto gg:

:gg21
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Services for AR...                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.ar.core
echo.
pause
goto gg:

:gg22
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Store...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.vending
echo.
pause
goto gg:

:gg23
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Search...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.googlequicksearchbox
echo.
pause
goto gg:

:gg24
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Text-to-Speech...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.tts
echo.
pause
goto gg:

:gg25
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Maps...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.maps
echo.
pause
goto gg:

:gg26
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Market Feedback Agent...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.feedback
echo.
pause
goto gg:

:gg27
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Photos...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.photos
echo.
pause
goto gg:

:gg28
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Sheets...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs.editors.sheets
echo.
pause
goto gg:

:gg29
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Slides...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs.editors.slides
echo.
pause
goto gg:

:gg30
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling YouTube...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.youtube
echo.
pause
goto gg:

:gg31
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling YouTube Music...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.youtube.music
echo.
pause
goto gg:

:gg32
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all Google Apps...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.google.android.marvin.talkback
adb shell cmd package install-existing com.google.android.projection.gearhead
adb shell cmd package install-existing com.google.android.apps.restore
adb shell cmd package install-existing com.google.android.calculator
adb shell cmd package install-existing com.google.android.calendar
adb shell cmd package install-existing com.android.chrome
adb shell cmd package install-existing com.google.android.apps.turbo
adb shell cmd package install-existing com.google.android.as
adb shell cmd package install-existing com.google.android.apps.wellbeing
adb shell cmd package install-existing com.google.android.apps.docs.editors.docs
adb shell cmd package install-existing com.google.android.apps.docs
adb shell cmd package install-existing com.google.android.apps.tachyon
adb shell cmd package install-existing com.google.android.inputmethod.latin
adb shell cmd package install-existing com.google.android.gm
adb shell cmd package install-existing com.android.hotwordenrollment.okgoogle
adb shell cmd package install-existing com.android.hotwordenrollment.xgoogle
adb shell cmd package install-existing com.google.android.gms.location.history
adb shell cmd package install-existing com.google.android.onetimeinitializer
adb shell cmd package install-existing com.google.android.apps.walletnfcrel
adb shell cmd package install-existing com.google.android.videos
adb shell cmd package install-existing com.google.android.music
adb shell cmd package install-existing com.google.ar.core
adb shell cmd package install-existing com.android.vending
adb shell cmd package install-existing com.google.android.googlequicksearchbox
adb shell cmd package install-existing com.google.android.tts
adb shell cmd package install-existing com.google.android.apps.maps
adb shell cmd package install-existing com.google.android.feedback
adb shell cmd package install-existing com.google.android.apps.photos
adb shell cmd package install-existing com.google.android.apps.docs.editors.sheets
adb shell cmd package install-existing com.google.android.apps.docs.editors.slides
adb shell cmd package install-existing com.google.android.youtube
adb shell cmd package install-existing com.google.android.apps.youtube.music
echo.
pause
goto gg:

:gg33
goto menu:

:ot
color 0b
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                               Android Apps                             ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   ANT HAL Service                                            ║
echo ║     2   =   Android Easter Egg                                         ║
echo ║     3   =   Basic Daydreams                                            ║
echo ║     4   =   Bluetooth MIDI Service                                     ║
echo ║     5   =   Bookmark Provider                                          ║
echo ║     6   =   Call Log Backup/Restore                                    ║
echo ║     7   =   CaptivePortalLogin                                         ║
echo ║     8   =   Default Print Service                                      ║
echo ║     9   =   Emergency rescue                                           ║
echo ║    10   =   Facebook Installer and App Manager                         ║
echo ║    11   =   HTML Viewer                                                ║
echo ║    12   =   Live Wallpaper Picker                                      ║
echo ║    13   =   Print Service Recommendation Service                       ║
echo ║    14   =   Print Spooler                                              ║
echo ║    15   =   SIM Toolkit                                                ║
echo ║    16   =   System Tracing                                             ║
echo ║    17   =   Wireless emergency alerts                                  ║
echo ║    18   =   Work Setup                                                 ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    19   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    20   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr3=Make your Choice:

IF %menunr3%==1 (goto ot1)
IF %menunr3%==2 (goto ot2)
IF %menunr3%==3 (goto ot3)
IF %menunr3%==4 (goto ot4)
IF %menunr3%==5 (goto ot5)
IF %menunr3%==6 (goto ot6)
IF %menunr3%==7 (goto ot7)
IF %menunr3%==8 (goto ot8)
IF %menunr3%==9 (goto ot9)
IF %menunr3%==10 (goto ot10)
IF %menunr3%==11 (goto ot11)
IF %menunr3%==12 (goto ot12)
IF %menunr3%==13 (goto ot13)
IF %menunr3%==14 (goto ot14)
IF %menunr3%==15 (goto ot15)
IF %menunr3%==16 (goto ot16)
IF %menunr3%==17 (goto ot17)
IF %menunr3%==18 (goto ot18)
IF %menunr3%==19 (goto ot19)
IF %menunr3%==20 (goto menu)
pause
goto ot:

:ot1
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling ANT HAL Service...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.dsi.ant.server
echo.
pause
goto ot:

:ot2
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Android Easter Egg...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.egg
echo.
pause
goto ot:

:ot3
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Basic Daydreams...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.dreams.basic
echo.
pause
goto ot:

:ot4
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Bluetooth MIDI Service...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.bluetoothmidiservice
echo.
pause
goto ot:

:ot5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Bookmark Provider...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.bookmarkprovider
echo.
pause
goto ot:

:ot6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Call Log Backup/Restore...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.calllogbackup
echo.
pause
goto ot:

:ot7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling CaptivePortalLogin...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.captiveportallogin
echo.
pause
goto ot:

:ot8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Default Print Service...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.bips
echo.
pause
goto ot:

:ot9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Emergency rescue...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.emergency
echo.
pause
goto ot:

:ot10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Facebook Installer and App Manager...                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.facebook.appmanager
adb shell pm uninstall -k --user 0 com.facebook.system
echo.
pause
goto ot:

:ot11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HTML Viewer...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.htmlviewer
echo.
pause
goto ot:

:ot12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Live Wallpaper Picker...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.wallpaper.livepicker
echo.
pause
goto ot:

:ot13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Print Service Recommendation Service...                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.printservice.recommendation
echo.
pause
goto ot:
  
:ot14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Print Spooler...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.printspooler
echo.
pause
goto ot:

:ot15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling SIM Toolkit...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.stk
echo.
pause
goto ot:

:ot16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling System Tracing...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.traceur
echo.
pause
goto ot:

:ot17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Wireless emergency alerts...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.cellbroadcastreceiver
echo.
pause
goto ot:

:ot18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Work Setup...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.managedprovisioning
echo.
pause
goto ot:

:ot19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling All Other Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.dsi.ant.server
adb shell cmd package install-existing com.android.egg
adb shell cmd package install-existing com.android.dreams.basic
adb shell cmd package install-existing com.android.bluetoothmidiservice
adb shell cmd package install-existing com.android.bookmarkprovider
adb shell cmd package install-existing com.android.calllogbackup
adb shell cmd package install-existing com.android.captiveportallogin
adb shell cmd package install-existing com.android.bips
adb shell cmd package install-existing com.android.emergency
adb shell cmd package install-existing com.facebook.appmanager
adb shell cmd package install-existing com.facebook.system
adb shell cmd package install-existing com.android.htmlviewer
adb shell cmd package install-existing com.android.wallpaper.livepicker
adb shell cmd package install-existing com.google.android.printservice.recommendation
adb shell cmd package install-existing com.android.printspooler
adb shell cmd package install-existing com.android.stk
adb shell cmd package install-existing com.android.traceur
adb shell cmd package install-existing com.google.android.cellbroadcastreceiver
adb shell cmd package install-existing com.android.managedprovisioning
echo.
pause
goto ot:

:ot20
goto menu:

:ins
color 0d
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                            Install and Push                            ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║      1   =   Install App (APK)                                         ║
echo ║      2   =   Install APKs (Bundle Installer)                           ║
echo ║      3   =   Install Kernel (IMG)                                      ║
echo ║      4   =   Install Recovery (IMG)                                    ║
echo ║      5   =   Push a File to Device                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║      6   =   Back to the Main Selection                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr4=Make your Choice:

IF %menunr4%==1 (goto insa)
IF %menunr4%==2 (goto abi)
IF %menunr4%==3 (goto insb)
IF %menunr4%==4 (goto insr)
IF %menunr4%==5 (goto psh)
IF %menunr4%==6 (goto menu)
goto ins:

:insa
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║             Select the APK you want to install from the Popup          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
setlocal enabledelayedexpansion
:: Does powershell.exe exist within %PATH%?
for %%I in (`powershell.exe`) do if "%%~$PATH:I" neq "" (
    set chooser=powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.OpenFileDialog;$f.InitialDirectory='%cd%';$f.Filter='All Files (*.*)|*.*';$f.showHelp=$true;$f.ShowDialog()|Out-Null;$f.FileName"
) else (
rem :: If not, compose and link C# application to open file browser dialog
    set chooser=%temp%\chooser.exe
    >"%temp%\c.cs" echo using System;using System.Windows.Forms;
    >>"%temp%\c.cs" echo class dummy{
    >>"%temp%\c.cs" echo public static void Main^(^){
    >>"%temp%\c.cs" echo OpenFileDialog f=new OpenFileDialog^(^);
    >>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
    >>"%temp%\c.cs" echo f.Filter="App (*.apk)|*.apk";
    >>"%temp%\c.cs" echo f.ShowHelp=true;
    >>"%temp%\c.cs" echo f.ShowDialog^(^);
    >>"%temp%\c.cs" echo Console.Write^(f.FileName^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"    
)

:: Capture choice to a variable
for /f "delims=" %%I in ('%chooser%') do set "filename=%%I"
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                         Installing App now...                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb install "%filename%"

:: Clean up
del "%temp%\chooser.exe" 2>NUL
echo.
pause
goto ins:

:abi
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                          APK Bundle Installer                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
set "reply=y"
set /p "reply=Install APKs from ABI Folder (Y/N)?: "
if /i not "%reply%" == "y" goto :ins
setlocal enabledelayedexpansion
set SCRIPT_PATH=%~dps0
set TARGET_PATH=/data/local/tmp/
adb shell mkdir -p %TARGET_PATH%
cd ABI
set TOTAL_APK_SIZE_BYTES=0
for %%A IN (*.apk) DO (
set /A "TOTAL_APK_SIZE_BYTES+=%%~zA"
)
echo.
echo.
echo ══════════════════════════════════════════════════════════════════════════
echo Total APK Size Bytes=[%TOTAL_APK_SIZE_BYTES%]
set PM_SESSION=
for /F "tokens=2 delims=[]" %%A IN ('%SCRIPT_PATH%adb shell pm install-create -S %TOTAL_APK_SIZE_BYTES%') DO SET PM_SESSION=%%A
echo PM Session=[%PM_SESSION%]
echo ══════════════════════════════════════════════════════════════════════════
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                           Installing App...                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
set APK_INDEX=0
for %%A IN (*.apk) DO (
set APK_SIZE=%%~zA
echo APK: idx=!APK_INDEX!, size=!APK_SIZE!
%SCRIPT_PATH%adb shell pm install-write -S !APK_SIZE! %PM_SESSION% !APK_INDEX! %TARGET_PATH%%%A
set /A "APK_INDEX+=1"
)
adb shell pm install-commit %PM_SESSION%
echo.
echo.
pause
goto ins:

:insb
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║          Select the Kernel you want to install from the Popup          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot bootloader
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║              Device reboots to Bootloader, please wait...              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb start-server
timeout /t 10
setlocal enabledelayedexpansion
:: Does powershell.exe exist within %PATH%?
for %%I in (`powershell.exe`) do if "%%~$PATH:I" neq "" (
    set chooser=powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.OpenFileDialog;$f.InitialDirectory='%cd%';$f.Filter='All Files (*.*)|*.*';$f.showHelp=$true;$f.ShowDialog()|Out-Null;$f.FileName"
) else (
rem :: If not, compose and link C# application to open file browser dialog
    set chooser=%temp%\chooser.exe
    >"%temp%\c.cs" echo using System;using System.Windows.Forms;
    >>"%temp%\c.cs" echo class dummy{
    >>"%temp%\c.cs" echo public static void Main^(^){
    >>"%temp%\c.cs" echo OpenFileDialog f=new OpenFileDialog^(^);
    >>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
    >>"%temp%\c.cs" echo f.Filter="Image (*.img)|*.img";
    >>"%temp%\c.cs" echo f.ShowHelp=true;
    >>"%temp%\c.cs" echo f.ShowDialog^(^);
    >>"%temp%\c.cs" echo Console.Write^(f.FileName^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"    
)

:: Capture choice to a variable
for /f "delims=" %%I in ('%chooser%') do set "filename=%%I"
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                        Installing Kernel now...                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
fastboot flash boot "%filename%"
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                  Press a Button to restart Device...                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
pause
fastboot reboot
:: Clean up
del "%temp%\chooser.exe" 2>NUL
echo.
pause
goto ins:

:insr
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║         Select the Recovery you want to install from the Popup         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot bootloader
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║              Device reboots to Bootloader, please wait...              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb start-server
timeout /t 10
setlocal enabledelayedexpansion
:: Does powershell.exe exist within %PATH%?
for %%I in (`powershell.exe`) do if "%%~$PATH:I" neq "" (
    set chooser=powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.OpenFileDialog;$f.InitialDirectory='%cd%';$f.Filter='All Files (*.*)|*.*';$f.showHelp=$true;$f.ShowDialog()|Out-Null;$f.FileName"
) else (
rem :: If not, compose and link C# application to open file browser dialog
    set chooser=%temp%\chooser.exe
    >"%temp%\c.cs" echo using System;using System.Windows.Forms;
    >>"%temp%\c.cs" echo class dummy{
    >>"%temp%\c.cs" echo public static void Main^(^){
    >>"%temp%\c.cs" echo OpenFileDialog f=new OpenFileDialog^(^);
    >>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
    >>"%temp%\c.cs" echo f.Filter="Image (*.img)|*.img";
    >>"%temp%\c.cs" echo f.ShowHelp=true;
    >>"%temp%\c.cs" echo f.ShowDialog^(^);
    >>"%temp%\c.cs" echo Console.Write^(f.FileName^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"    
)

:: Capture choice to a variable
for /f "delims=" %%I in ('%chooser%') do set "filename=%%I"
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                        Installing Kernel now...                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
fastboot flash recovery "%filename%"
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                  Press a Button to restart Device...                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
pause
fastboot reboot
:: Clean up
del "%temp%\chooser.exe" 2>NUL
echo.
pause
goto ins:

:psh
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║             Select a File you want to push from the Popup              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
setlocal enabledelayedexpansion
:: Does powershell.exe exist within %PATH%?
for %%I in (`powershell.exe`) do if "%%~$PATH:I" neq "" (
    set chooser=powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.OpenFileDialog;$f.InitialDirectory='%cd%';$f.Filter='All Files (*.*)|*.*';$f.showHelp=$true;$f.ShowDialog()|Out-Null;$f.FileName"
) else (
rem :: If not, compose and link C# application to open file browser dialog
    set chooser=%temp%\chooser.exe
    >"%temp%\c.cs" echo using System;using System.Windows.Forms;
    >>"%temp%\c.cs" echo class dummy{
    >>"%temp%\c.cs" echo public static void Main^(^){
    >>"%temp%\c.cs" echo OpenFileDialog f=new OpenFileDialog^(^);
    >>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
    >>"%temp%\c.cs" echo f.Filter="All Files (*.*)|*.*";
    >>"%temp%\c.cs" echo f.ShowHelp=true;
    >>"%temp%\c.cs" echo f.ShowDialog^(^);
    >>"%temp%\c.cs" echo Console.Write^(f.FileName^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"    
)

:: Capture choice to a variable
for /f "delims=" %%I in ('%chooser%') do set "filename=%%I"
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                          Pushing File now...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb push "%filename%" /sdcard/
:: Clean up
del "%temp%\chooser.exe" 2>NUL
echo.
pause
goto ins:

:chk
color 0e
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║     Check Versions, Build Dates, IMEI, IP, Packages and Processes      ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║      1   =   Firmware Version                                          ║
echo ║      2   =   Android Version                                           ║
echo ║      3   =   Kernel Version                                            ║
echo ║      4   =   Firmware Build Date                                       ║
echo ║      5   =   Kernel Build Date                                         ║
echo ║      6   =   Security Patch Date                                       ║
echo ║      7   =   IMEI                                                      ║
echo ║      8   =   IP Adresses                                               ║
echo ║      9   =   App Packages                                              ║
echo ║     10   =   Process Activity (Real Time)                              ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║     11   =   Back to the Main Selection                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr5=Make your Choice:

IF %menunr5%==1 (goto cfw)
IF %menunr5%==2 (goto candr)
IF %menunr5%==3 (goto ckv)
IF %menunr5%==4 (goto cfbd)
IF %menunr5%==5 (goto ckbd)
IF %menunr5%==6 (goto cspd)
IF %menunr5%==7 (goto cimei)
IF %menunr5%==8 (goto cipa)
IF %menunr5%==9 (goto cawp)
IF %menunr5%==10 (goto cpcs)
IF %menunr5%==11 (goto menu)
goto chk:

:cfw
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                        Show Firmware Version...                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell getprop ro.build.id
echo.
pause
goto chk:

:candr
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                        Show Android Version...                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell getprop ro.build.version.release
echo.
pause
goto chk:

:ckv
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                         Show Kernel Version...                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cat /proc/version
echo.
pause
goto chk:

:cfbd
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                      Show Firmware Build Date...                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell getprop ro.build.date
echo.
pause
goto chk:

:ckbd
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                       Show Kernel Build Date...                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell getprop ro.bootimage.build.date
echo.
pause
goto chk:

:cspd
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                      Show Security Patch Date...                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell getprop ro.build.version.security_patch
echo.
pause
goto chk:

:cimei
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Show IMEI...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell "service call iphonesubinfo 1 | toybox cut -d \"'\" -f2 | toybox grep -Eo '[0-9]' | toybox xargs | toybox sed 's/\ //g'"
echo.
pause
goto chk:

:cipa
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                          Show IP Adresses...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell ifconfig wlan0
echo.
pause
goto chk:

:cawp
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                          Show App Packages...                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm list packages
echo.
pause
goto chk:

:cpcs
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                        Show Process Activity...                        ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║                        Press Q + Enter to stop                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
echo.
pause
adb shell top
goto chk:

:scrr
color 0e
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                     Screenshots and Video recoding                     ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║      1   =   Screenshot (PNG)                                          ║
echo ║      2   =   Record Video -  30 Seconds  (Without Device Sound)        ║
echo ║      3   =   Record Video -  60 Seconds  (Without Device Sound)        ║
echo ║      4   =   Record Video - 120 Seconds  (Without Device Sound)        ║
echo ║      5   =   Record Video - 180 Seconds  (Without Device Sound)        ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║      6   =   Back to the Main Selection                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr6=Make your Choice:

IF %menunr6%==1 (goto scrs)
IF %menunr6%==2 (goto scrv30)
IF %menunr6%==3 (goto scrv60)
IF %menunr6%==4 (goto scrv120)
IF %menunr6%==5 (goto scrv180)
IF %menunr6%==6 (goto menu)
goto scrr:

:scrs
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                          Take a Screenshot...                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb exec-out screencap -p > %userprofile%/Desktop/Screenshot.png
echo.
pause
goto scrr:

:scrv30
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                       Recording 30 Seconds now...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell screenrecord --time-limit=30 /sdcard/Screenrecording-30.mp4
adb pull /sdcard/Screenrecording-30.mp4 %userprofile%/Desktop/Screenrecording-30.mp4
adb shell rm sdcard/Screenrecording-30.mp4
echo.
pause
goto scrr:

:scrv60
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                       Recording 60 Seconds now...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell screenrecord --time-limit=60 /sdcard/Screenrecording-60.mp4
adb pull /sdcard/Screenrecording-60.mp4 %userprofile%/Desktop/Screenrecording-60.mp4
adb shell rm sdcard/Screenrecording-60.mp4
echo.
pause
goto scrr:

:scrv120
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                      Recording 120 Seconds now...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell screenrecord --time-limit=120 /sdcard/Screenrecording-120.mp4
adb pull /sdcard/Screenrecording-120.mp4 %userprofile%/Desktop/Screenrecording-120.mp4
adb shell rm sdcard/Screenrecording-120.mp4
echo.
pause
goto scrr:

:scrv180
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                      Recording 180 Seconds now...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell screenrecord --time-limit=180 /sdcard/Screenrecording-180.mp4
adb pull /sdcard/Screenrecording-180.mp4 %userprofile%/Desktop/Screenrecording-180.mp4
adb shell rm sdcard/Screenrecording-180.mp4
echo.
pause
goto scrr:

:rbt
color 04
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                                                                        ║
echo ║               Reboot, Reboot to X, Bugreport and Logcat                ║
echo ║                                                                        ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║   1   =   Reboot the Device                                            ║
echo ║   2   =   Reboot to Bootloader                                         ║
echo ║   3   =   Exit Bootloader to System                                    ║
echo ║   4   =   Reboot to Recovery                                           ║
echo ║   5   =   Create Bugreport                                             ║
echo ║   6   =   Create Logcat                                                ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║   7   =   Back to the Main Selection                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr7=Make your Choice:

IF %menunr7%==1 (goto rbot)
IF %menunr7%==2 (goto rbtb)
IF %menunr7%==3 (goto extb)
IF %menunr7%==4 (goto rbtr)
IF %menunr7%==5 (goto bugr)
IF %menunr7%==6 (goto logc)
IF %menunr7%==7 (goto menu)
goto rbt

:rbot
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                    Your Device will now restart...                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot
echo.
pause
goto rbt:

:rbtb
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║              Your Device will now boot into Bootloader...              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot bootloader
echo.
pause
goto rbt:

:extb
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                Your Device will now boot into System...                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell start-server
fastboot reboot
echo.
pause
goto rbt:

:rbtr
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║               Your Device will now boot into Recovery...               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot recovery
echo.
pause
goto rbt:

:bugr
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                          Create Bugreport...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb bugreport %userprofile%/Desktop/
echo.
pause
goto rbt:

:logc
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                            Create Logcat...                            ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║                         Press CTRL + C to stop                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell logcat > %userprofile%/Desktop/Logcat.txt
echo.
pause
goto rbt:

:ext
cls
adb kill-server
exit