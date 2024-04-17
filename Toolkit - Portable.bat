@echo off
title Toolkit v1.5
color 0a
chcp 65001 >nul 2>&1
set "path=%path%;%~dp0ADB and Fastboot++ v1.1.1 Portable"
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                                                                        ║
echo ║                                                                        ║
echo ║        ████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗         ║
echo ║        ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝         ║
echo ║           ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║            ║
echo ║           ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║            ║
echo ║           ██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║            ║
echo ║           ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝            ║
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
echo ║                 ███╗   ███╗███████╗███╗   ██╗██╗   ██╗                 ║
echo ║                 ████╗ ████║██╔════╝████╗  ██║██║   ██║                 ║
echo ║                 ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║                 ║
echo ║                 ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║                 ║
echo ║                 ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝                 ║
echo ║                 ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝                  ║
echo ║                                                                        ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║    1   =   Debloat Apps (Non-Root)                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    2   =   Install Kernel, Recovery, APKs and Push                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    3   =   Show Versions, Build Dates, IMEI, IP, Packages, Processes   ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    4   =   Screenshot and Screenrecoder                                ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    5   =   Reboot, Reboot to X, Boot Kernel, Bugreport and Logcat      ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    6   =   Exit                                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr=Make your Choice:

IF %menunr%==1 (goto ua)
IF %menunr%==2 (goto ins)
IF %menunr%==3 (goto chk)
IF %menunr%==4 (goto scrr)
IF %menunr%==5 (goto rbt)
IF %menunr%==6 (goto ext)
goto menu

:ua
color 0a
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                    Uninstall Apps for current User                     ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   Google Apps                                                ║
echo ║     2   =   Android Apps                                               ║
echo ║     3   =   Nothing Apps                                               ║
echo ║     4   =   OnePlus Apps                                               ║
echo ║     5   =   Samsung Apps                                               ║
echo ║     6   =   Huwawei Apps                                               ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║     7   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr2=Make your Choice:

IF %menunr2%==1 (goto gg)
IF %menunr2%==2 (goto ot)
IF %menunr2%==3 (goto nt)
IF %menunr2%==4 (goto op)
IF %menunr2%==5 (goto ss)
IF %menunr2%==6 (goto hw)
IF %menunr2%==7 (goto menu)
goto ua:

:gg
color 01
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Google Apps                               ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   Android Accessiblity Suite                                 ║
echo ║     2   =   Android Auto                                               ║
echo ║     3   =   Android System Intelligence                                ║
echo ║     4   =   Calculator                                                 ║
echo ║     5   =   Calendar                                                   ║
echo ║     6   =   Carrier Services                                           ║
echo ║     7   =   Cell Broadcast Service                                     ║
echo ║     8   =   Chrome                                                     ║
echo ║     9   =   Clock                                                      ║
echo ║    10   =   Contacts                                                   ║
echo ║    11   =   Data restore tool                                          ║
echo ║    12   =   Device Health Services                                     ║
echo ║    13   =   Device Personalization Service                             ║
echo ║    14   =   Digital Wellbeing                                          ║
echo ║    15   =   Docs                                                       ║
echo ║    16   =   Drive                                                      ║
echo ║    17   =   Duo                                                        ║
echo ║    18   =   Files by Google                                            ║
echo ║    19   =   Gboard                                                     ║
echo ║    20   =   Gmail                                                      ║
echo ║    21   =   Google Assistant                                           ║
echo ║    22   =   Google Contacts Sync                                       ║
echo ║    23   =   Google Location History                                    ║
echo ║    24   =   Google One Time Init                                       ║
echo ║    25   =   Google Partner Setup                                       ║
echo ║    26   =   Google Pay                                                 ║
echo ║    27   =   Google Play Movies and TV                                  ║
echo ║    28   =   Google Play Music                                          ║
echo ║    29   =   Google Play Services for AR                                ║
echo ║    30   =   Google Play Store                                          ║
echo ║    31   =   Google Search                                              ║
echo ║    32   =   Keep notes                                                 ║
echo ║    33   =   Maps                                                       ║
echo ║    34   =   Market Feedback Agent                                      ║
echo ║    35   =   Messages                                                   ║
echo ║    36   =   Personal Safety                                            ║
echo ║    37   =   Phone                                                      ║
echo ║    38   =   Photos                                                     ║
echo ║    39   =   Private Compute Services                                   ║
echo ║    40   =   Search Engine Selector                                     ║
echo ║    41   =   Sheets                                                     ║
echo ║    42   =   Slides                                                     ║
echo ║    43   =   Speech Services by Google                                  ║
echo ║    44   =   YouTube                                                    ║
echo ║    45   =   YouTube Music                                              ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    46   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    47   =   Back to the Main Selection                                 ║
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
IF %menunr2%==32 (goto gg32)
IF %menunr2%==33 (goto gg33)
IF %menunr2%==34 (goto gg34)
IF %menunr2%==35 (goto gg35)
IF %menunr2%==36 (goto gg36)
IF %menunr2%==37 (goto gg37)
IF %menunr2%==38 (goto gg38)
IF %menunr2%==39 (goto gg39)
IF %menunr2%==40 (goto gg40)
IF %menunr2%==41 (goto gg41)
IF %menunr2%==42 (goto gg42)
IF %menunr2%==43 (goto gg43)
IF %menunr2%==44 (goto gg44)
IF %menunr2%==45 (goto gg45)
IF %menunr2%==46 (goto gg46)
IF %menunr2%==47 (goto menu)
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
echo ║    Uninstalling Android System Intelligence...                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.as
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
echo ║    Uninstalling Carrier Services...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.ims
echo.
pause
goto gg:

:gg7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Cell Broadcast Service...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.cellbroadcastservice
echo.
pause
goto gg:

:gg8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Chrome...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.chrome
echo.
pause
goto gg:

:gg9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Clock...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.deskclock
echo.
pause
goto gg:

:gg10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Contacts...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.contacts
echo.
pause
goto gg:

:gg11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Data restore tool...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.restore
echo.
pause
goto gg:

:gg12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Device Health Services...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.turbo
echo.
pause
goto gg:

:gg13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Device Personalization Service...                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.as
echo.
pause
goto gg:

:gg14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Digital Wellbeing...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.wellbeing
echo.
pause
goto gg:

:gg15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Docs...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs.editors.docs
echo.
pause
goto gg:

:gg16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Drive...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs
echo.
pause
goto gg:

:gg17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Duo...                                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.tachyon
echo.
pause
goto gg:

:gg18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Files by Google...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.nbu.files
echo.
pause
goto gg:

:gg19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Gboard...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.inputmethod.latin
echo.
pause
goto gg:

:gg20
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Gmail...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.gm
echo.
pause
goto gg:

:gg21
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Assistant...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.hotwordenrollment.okgoogle
adb shell pm uninstall -k --user 0 com.android.hotwordenrollment.xgoogle
echo.
pause
goto gg:

:gg22
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling  Google Contacts Sync...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.syncadapters.contacts
echo.
pause
goto gg:

:gg23
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Location History...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.gms.location.history
echo.
pause
goto gg:

:gg24
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google One Time Init...                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.onetimeinitializer
echo.
pause
goto gg:

:gg25
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Partner Setup...                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.partnersetup
echo.
pause
goto gg:

:gg26
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Pay...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.walletnfcrel
echo.
pause
goto gg:

:gg27
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Movies and TV...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.videos
echo.
pause
goto gg:

:gg28
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Music...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.music
echo.
pause
goto gg:

:gg29
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Services for AR...                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.ar.core
echo.
pause
goto gg:

:gg30
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Play Store...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.vending
echo.
pause
goto gg:

:gg31
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Google Search...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.googlequicksearchbox
echo.
pause
goto gg:

:gg32
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Keep notes...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.keep
echo.
pause
goto gg:

:gg33
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Maps...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.maps
echo.
pause
goto gg:

:gg34
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Market Feedback Agent...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.feedback
echo.
pause
goto gg:

:gg35
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Messages...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.messaging
echo.
pause
goto gg:

:gg36
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Personal Safety...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.safetyhub
echo.
pause
goto gg:

:gg37
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Phone...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.dialer
echo.
pause
goto gg:

:gg38
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Photos...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.photos
echo.
pause
goto gg:

:gg39
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Private Compute Services...                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.as.oss
echo.
pause
goto gg:

:gg40
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Search Engine Selector...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.setupwizard.searchselector
echo.
pause
goto gg:

:gg41
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Sheets...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs.editors.sheets
echo.
pause
goto gg:

:gg42
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Slides...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.docs.editors.slides
echo.
pause
goto gg:

:gg43
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Speech Services by Google...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.tts
echo.
pause
goto gg:

:gg44
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling YouTube...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.youtube
echo.
pause
goto gg:

:gg45
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling YouTube Music...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.apps.youtube.music
echo.
pause
goto gg:

:gg46
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all Google Apps...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.google.android.marvin.talkback
adb shell cmd package install-existing com.google.android.projection.gearhead
adb shell cmd package install-existing com.google.android.as
adb shell cmd package install-existing com.google.android.calculator
adb shell cmd package install-existing com.google.android.calendar
adb shell cmd package install-existing com.google.android.ims
adb shell cmd package install-existing com.google.android.cellbroadcastservice
adb shell cmd package install-existing com.android.chrome
adb shell cmd package install-existing com.google.android.deskclock
adb shell cmd package install-existing com.google.android.contacts
adb shell cmd package install-existing com.google.android.apps.restore
adb shell cmd package install-existing com.google.android.apps.turbo
adb shell cmd package install-existing com.google.android.as
adb shell cmd package install-existing com.google.android.apps.wellbeing
adb shell cmd package install-existing com.google.android.apps.docs.editors.docs
adb shell cmd package install-existing com.google.android.apps.docs
adb shell cmd package install-existing com.google.android.apps.tachyon
adb shell cmd package install-existing com.google.android.apps.nbu.files
adb shell cmd package install-existing com.google.android.inputmethod.latin
adb shell cmd package install-existing com.google.android.gm
adb shell cmd package install-existing com.android.hotwordenrollment.okgoogle
adb shell cmd package install-existing com.android.hotwordenrollment.xgoogle
adb shell cmd package install-existing com.google.android.syncadapters.contacts
adb shell cmd package install-existing com.google.android.gms.location.history
adb shell cmd package install-existing com.google.android.onetimeinitializer
adb shell cmd package install-existing com.google.android.partnersetup
adb shell cmd package install-existing com.google.android.apps.walletnfcrel
adb shell cmd package install-existing com.google.android.videos
adb shell cmd package install-existing com.google.android.music
adb shell cmd package install-existing com.google.ar.core
adb shell cmd package install-existing com.android.vending
adb shell cmd package install-existing com.google.android.googlequicksearchbox
adb shell cmd package install-existing com.google.android.keep
adb shell cmd package install-existing com.google.android.apps.maps
adb shell cmd package install-existing com.google.android.feedback
adb shell cmd package install-existing com.google.android.apps.messaging
adb shell cmd package install-existing com.google.android.apps.safetyhub
adb shell cmd package install-existing com.google.android.dialer
adb shell cmd package install-existing com.google.android.apps.photos
adb shell cmd package install-existing com.google.android.as.oss
adb shell cmd package install-existing com.google.android.apps.setupwizard.searchselector
adb shell cmd package install-existing com.google.android.apps.docs.editors.sheets
adb shell cmd package install-existing com.google.android.apps.docs.editors.slides
adb shell cmd package install-existing com.google.android.tts
adb shell cmd package install-existing com.google.android.youtube
adb shell cmd package install-existing com.google.android.apps.youtube.music
echo.
pause
goto gg:

:gg47
goto menu:

:ot
color 02
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Android Apps                              ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   ANT HAL Service                                            ║
echo ║     2   =   Android Easter Egg                                         ║
echo ║     3   =   Basic Daydreams                                            ║
echo ║     4   =   Blocked Numbers Storage                                    ║
echo ║     5   =   Bluetooth MIDI Service                                     ║
echo ║     6   =   Bookmark Provider                                          ║
echo ║     7   =   Call Log Backup/Restore                                    ║
echo ║     8   =   CaptivePortalLogin                                         ║
echo ║     9   =   Default Print Service                                      ║
echo ║    10   =   Emergency information                                      ║
echo ║    11   =   Facebook Installer and App Manager                         ║
echo ║    12   =   HTML Viewer                                                ║
echo ║    13   =   Live Wallpaper Picker                                      ║
echo ║    14   =   MusicFX                                                    ║
echo ║    15   =   Print Service Recommendation Service                       ║
echo ║    16   =   Print Spooler                                              ║
echo ║    17   =   SIM App Dialog                                             ║
echo ║    18   =   SIM Toolkit                                                ║
echo ║    19   =   System Tracing                                             ║
echo ║    20   =   Wireless emergency alerts                                  ║
echo ║    21   =   Work Setup                                                 ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    22   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    23   =   Back to the Main Selection                                 ║
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
IF %menunr3%==20 (goto ot20)
IF %menunr3%==21 (goto ot21)
IF %menunr3%==22 (goto ot22)
IF %menunr3%==23 (goto menu)
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
echo ║    Uninstalling Blocked Numbers Storage...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.providers.blockednumber
echo.
pause
goto ot:

:ot5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Bluetooth MIDI Service...                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.bluetoothmidiservice
echo.
pause
goto ot:

:ot6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Bookmark Provider...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.bookmarkprovider
echo.
pause
goto ot:

:ot7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Call Log Backup/Restore...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.calllogbackup
echo.
pause
goto ot:

:ot8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling CaptivePortalLogin...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.captiveportallogin
echo.
pause
goto ot:

:ot9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Default Print Service...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.bips
echo.
pause
goto ot:

:ot10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Emergency information...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.emergency
echo.
pause
goto ot:

:ot11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Facebook, Installer, Manager and Services...           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.facebook.katana
adb shell pm uninstall -k --user 0 com.facebook.appmanager
adb shell pm uninstall -k --user 0 com.facebook.system
adb shell pm uninstall -k --user 0 com.facebook.services
echo.
pause
goto ot:

:ot12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HTML Viewer...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.htmlviewer
echo.
pause
goto ot:

:ot13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Live Wallpaper Picker...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.wallpaper.livepicker
echo.
pause
goto ot:

:ot14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling MusicFX...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.musicfx
echo.
pause
goto ot:

:ot15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Print Service Recommendation Service...                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.printservice.recommendation
echo.
pause
goto ot:

:ot16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Print Spooler...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.printspooler
echo.
pause
goto ot:

:ot17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling SIM App Dialog...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.simappdialog
echo.
pause
goto ot:

:ot18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling SIM Toolkit...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.stk
echo.
pause
goto ot:

:ot19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling System Tracing...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.traceur
echo.
pause
goto ot:

:ot20
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Wireless emergency alerts...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.google.android.cellbroadcastreceiver
echo.
pause
goto ot:

:ot21
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Work Setup...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.android.managedprovisioning
echo.
pause
goto ot:

:ot22
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all Android Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.dsi.ant.server
adb shell cmd package install-existing com.android.egg
adb shell cmd package install-existing com.android.dreams.basic
adb shell cmd package install-existing com.android.providers.blockednumber
adb shell cmd package install-existing com.android.bluetoothmidiservice
adb shell cmd package install-existing com.android.bookmarkprovider
adb shell cmd package install-existing com.android.calllogbackup
adb shell cmd package install-existing com.android.captiveportallogin
adb shell cmd package install-existing com.android.bips
adb shell cmd package install-existing com.android.emergency
adb shell cmd package install-existing com.facebook.katana
adb shell cmd package install-existing com.facebook.appmanager
adb shell cmd package install-existing com.facebook.system
adb shell cmd package install-existing com.facebook.services
adb shell cmd package install-existing com.android.htmlviewer
adb shell cmd package install-existing com.android.wallpaper.livepicker
adb shell cmd package install-existing com.android.musicfx
adb shell cmd package install-existing com.google.android.printservice.recommendation
adb shell cmd package install-existing com.android.printspooler
adb shell cmd package install-existing com.android.simappdialog
adb shell cmd package install-existing com.android.stk
adb shell cmd package install-existing com.android.traceur
adb shell cmd package install-existing com.google.android.cellbroadcastreceiver
adb shell cmd package install-existing com.android.managedprovisioning
echo.
pause
goto ot:

:ot23
goto menu:

:nt
color 0f
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Nothing Apps                              ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   Face Recognition                                           ║
echo ║     2   =   LedLightTest                                               ║
echo ║     3   =   Log Tool                                                   ║
echo ║     4   =   NFT Gallery                                                ║
echo ║     5   =   Nothing Agreement                                          ║
echo ║     6   =   Nothing X                                                  ║
echo ║     7   =   Recorder                                                   ║
echo ║     8   =   Tesla                                                      ║
echo ║     9   =   Weather                                                    ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    10   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    11   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr4=Make your Choice:

IF %menunr4%==1 (goto nt1)
IF %menunr4%==2 (goto nt2)
IF %menunr4%==3 (goto nt3)
IF %menunr4%==4 (goto nt4)
IF %menunr4%==5 (goto nt5)
IF %menunr4%==6 (goto nt6)
IF %menunr4%==7 (goto nt7)
IF %menunr4%==8 (goto nt8)
IF %menunr4%==9 (goto nt9)
IF %menunr4%==10 (goto nt10)
IF %menunr4%==11 (goto menu)
goto nt:

:nt1
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Face Recognition...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nt.facerecognition
echo.
pause
goto nt:

:nt2
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling LedLightTest...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nt.ledlighttest
echo.
pause
goto nt:

:nt3
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Log Tool...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.logtool
echo.
pause
goto nt:

:nt4
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling NFT Gallery...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.nft
echo.
pause
goto nt:

:nt5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Nothing Agreement...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.agreement
echo.
pause
goto nt:

:nt6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Nothing X...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.smartcenter
echo.
pause
goto nt:

:nt7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Recorder...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.soundrecorder
echo.
pause
goto nt:

:nt8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Tesla...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.experimental
echo.
pause
goto nt:

:nt9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Weather...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.nothing.weather
echo.
pause
goto nt:

:nt10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all Nothing Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.nt.facerecognition
adb shell cmd package install-existing com.nt.ledlighttest
adb shell cmd package install-existing com.nothing.logtool
adb shell cmd package install-existing com.nothing.nft
adb shell cmd package install-existing com.nothing.agreement
adb shell cmd package install-existing com.nothing.smartcenter
adb shell cmd package install-existing com.nothing.soundrecorder
adb shell cmd package install-existing com.nothing.experimental
adb shell cmd package install-existing com.nothing.weather
echo.
pause
goto nt:

:nt11
goto menu:

:op
color 0c
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              OnePlus Apps                              ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   App Enhancement Services                                   ║
echo ║     2   =   App cloner                                                 ║
echo ║     3   =   BTtestmode                                                 ║
echo ║     4   =   Calculator                                                 ║
echo ║     5   =   Canvas                                                     ║
echo ║     6   =   Clock                                                      ║
echo ║     7   =   CrashBox                                                   ║
echo ║     8   =   Data usage                                                 ║
echo ║     9   =   Emergency SOS                                              ║
echo ║    10   =   Eye comfort                                                ║
echo ║    11   =   Face Unlock                                                ║
echo ║    12   =   Feedback                                                   ║
echo ║    13   =   Games                                                      ║
echo ║    14   =   Global Search                                              ║
echo ║    15   =   Help and feedback                                          ║
echo ║    16   =   HeySynergy                                                 ║
echo ║    17   =   Kid Space                                                  ║
echo ║    18   =   My Files                                                   ║
echo ║    19   =   OPSynergy                                                  ║
echo ║    20   =   OnePlus Account                                            ║
echo ║    21   =   OnePlus Membership                                         ║
echo ║    22   =   OnePlus Widget                                             ║
echo ║    23   =   Photos                                                     ║
echo ║    24   =   Portrait silhouette                                        ║
echo ║    25   =   Private Safe                                               ║
echo ║    26   =   Push                                                       ║
echo ║    27   =   Quick device connect                                       ║
echo ║    28   =   Screen recording                                           ║
echo ║    29   =   Screencast                                                 ║
echo ║    30   =   Shelf                                                      ║
echo ║    31   =   User Experience Program                                    ║
echo ║    32   =   User Manual                                                ║
echo ║    33   =   Wallpapers                                                 ║
echo ║    34   =   Weather and Weather Service                                ║
echo ║    35   =   Work-Life Balance                                          ║
echo ║    36   =   wifitest                                                   ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    37   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    38   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr5=Make your Choice:

IF %menunr5%==1 (goto op1)
IF %menunr5%==2 (goto op2)
IF %menunr5%==3 (goto op3)
IF %menunr5%==4 (goto op4)
IF %menunr5%==5 (goto op5)
IF %menunr5%==6 (goto op6)
IF %menunr5%==7 (goto op7)
IF %menunr5%==8 (goto op8)
IF %menunr5%==9 (goto op9)
IF %menunr5%==10 (goto op10)
IF %menunr5%==11 (goto op11)
IF %menunr5%==12 (goto op12)
IF %menunr5%==13 (goto op13)
IF %menunr5%==14 (goto op14)
IF %menunr5%==15 (goto op15)
IF %menunr5%==16 (goto op16)
IF %menunr5%==17 (goto op17)
IF %menunr5%==18 (goto op18)
IF %menunr5%==19 (goto op19)
IF %menunr5%==20 (goto op20)
IF %menunr5%==21 (goto op21)
IF %menunr5%==22 (goto op22)
IF %menunr5%==23 (goto op23)
IF %menunr5%==24 (goto op24)
IF %menunr5%==25 (goto op25)
IF %menunr5%==26 (goto op26)
IF %menunr5%==27 (goto op27)
IF %menunr5%==28 (goto op28)
IF %menunr5%==29 (goto op29)
IF %menunr5%==30 (goto op30)
IF %menunr5%==31 (goto op31)
IF %menunr5%==32 (goto op32)
IF %menunr5%==33 (goto op33)
IF %menunr5%==34 (goto op34)
IF %menunr5%==35 (goto op35)
IF %menunr5%==36 (goto op36)
IF %menunr5%==37 (goto op37)
IF %menunr5%==38 (goto op38)
IF %menunr5%==39 (goto menu)
goto op:

:op1
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling App Enhancement Services...                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.cosa
echo.
pause
goto op:

:op2
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling App cloner...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.multiapp
echo.
pause
goto op:

:op3
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling BTtestmode...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.bttestmode
echo.
pause
goto op:

:op4
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Calculator...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.calculator
echo.
pause
goto op:

:op5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Canvas...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.canvasresources
echo.
pause
goto op:

:op6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Clock...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.deskclock
echo.
pause
goto op:

:op7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling CrashBox...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.crashbox
echo.
pause
goto op:

:op8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Data usage...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.trafficmonitor
echo.
pause
goto op:

:op9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Emergency SOS...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.sos
echo.
pause
goto op:

:op10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Eye comfort...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.eyeprotect
echo.
pause
goto op:

:op11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Face Unlock...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.faceunlock
echo.
pause
goto op:

:op12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Feedback...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.logkit
echo.
pause
goto op:

:op13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Games...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.games
echo.
pause
goto op:

:op14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Global Search...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oppo.quicksearchbox
echo.
pause
goto op:

:op15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Help and feedback...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.coloros.operationManual
echo.
pause
goto op:

:op16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HeySynergy...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.synergy
echo.
pause
goto op:

:op17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Kid Space...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.coloros.childrenspace
echo.
pause
goto op:

:op18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling My Files...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.filemanager
echo.
pause
goto op:

:op19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling OPSynergy...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.linker
echo.
pause
goto op:

:op20
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling OnePlus Account...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.account
echo.
pause
goto op:

:op21
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling OnePlus Membership...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.membership
echo.
pause
goto op:

:op22
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling OnePlus Widget...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 net.oneplus.widget
echo.
pause
goto op:

:op23
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Photos...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.gallery
echo.
pause
goto op:

:op24
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Portrait silhouette...                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.portrait
echo.
pause
goto op:

:op25
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Private Safe...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.encryption
echo.
pause
goto op:

:op26
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Push...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 net.oneplus.push
echo.
pause
goto op:

:op27
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Quick device connect...                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.heytap.accessory
echo.
pause
goto op:

:op28
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Screen recording...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.screenrecorder
echo.
pause
goto op:

:op29
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Screencast...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.cast
echo.
pause
goto op:

:op30
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Shelf...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.coloros.assistantscreen
adb shell pm uninstall -k --user 0 com.oneplus.opshelf
echo.
pause
goto op:

:op31
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling User Experience Program...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.statistics.rom
echo.
pause
goto op:

:op32
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling User Manual...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.opusermanual
echo.
pause
goto op:

:op33
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Wallpapers...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.wallpapers
echo.
pause
goto op:

:op34
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Weather and Weather Service...                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 net.oneplus.weather
adb shell pm uninstall -k --user 0 com.coloros.weather.service
echo.
pause
goto op:

:op35
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Work-Life Balance...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oneplus.opwlb
echo.
pause
goto op:

:op36
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling wifitest...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.oplus.wifitest
echo.
pause
goto op:

:op37
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all OnePlus Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.oneplus.calculator
adb shell cmd package install-existing com.oneplus.canvasresources
adb shell cmd package install-existing com.oneplus.deskclock
adb shell cmd package install-existing com.oplus.crashbox
adb shell cmd package install-existing com.oplus.trafficmonitor
adb shell cmd package install-existing com.oplus.sos
adb shell cmd package install-existing com.oplus.eyeprotect
adb shell cmd package install-existing com.oneplus.faceunlock
adb shell cmd package install-existing com.oplus.logkit
adb shell cmd package install-existing com.oplus.games
adb shell cmd package install-existing com.oppo.quicksearchbox
adb shell cmd package install-existing com.coloros.operationManual
adb shell cmd package install-existing com.oplus.synergy
adb shell cmd package install-existing com.coloros.childrenspace
adb shell cmd package install-existing com.oneplus.filemanager
adb shell cmd package install-existing com.oplus.linker
adb shell cmd package install-existing com.oneplus.account
adb shell cmd package install-existing com.oneplus.membership
adb shell cmd package install-existing net.oneplus.widget
adb shell cmd package install-existing com.oneplus.gallery
adb shell cmd package install-existing com.oplus.portrait
adb shell cmd package install-existing com.oplus.encryption
adb shell cmd package install-existing net.oneplus.push
adb shell cmd package install-existing com.heytap.accessory
adb shell cmd package install-existing com.oplus.screenrecorder
adb shell cmd package install-existing com.oplus.cast
adb shell cmd package install-existing com.coloros.assistantscreen
adb shell cmd package install-existing com.oneplus.opshelf
adb shell cmd package install-existing com.oplus.statistics.rom
adb shell cmd package install-existing com.oplus.opusermanual
adb shell cmd package install-existing com.oplus.wallpapers
adb shell cmd package install-existing net.oneplus.weather
adb shell cmd package install-existing com.coloros.weather.service
adb shell cmd package install-existing com.oneplus.opwlb
echo.
pause
goto op:

:op38
goto menu:

:ss
color 09
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Samsung Apps                              ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   AR Doodle                                                  ║
echo ║     2   =   AR Emoji Apps                                              ║
echo ║     3   =   Air Command                                                ║
echo ║     4   =   Always on Display                                          ║
echo ║     5   =   Authentication                                             ║
echo ║     6   =   Auto fill                                                  ║
echo ║     7   =   Barcode scanner                                            ║
echo ║     8   =   BeaconManager                                              ║
echo ║     9   =   Bixby                                                      ║
echo ║    10   =   Calculator                                                 ║
echo ║    11   =   Car Mode                                                   ║
echo ║    12   =   China Hidden Menu                                          ║
echo ║    13   =   Cloud                                                      ║
echo ║    14   =   DeX Apps                                                   ║
echo ║    15   =   Digital Wellbeing                                          ║
echo ║    16   =   Dual Messenger                                             ║
echo ║    17   =   Edge Display Apps                                          ║
echo ║    18   =   Email                                                      ║
echo ║    19   =   Email Provider                                             ║
echo ║    20   =   Finance Widget                                             ║
echo ║    21   =   Flipboard                                                  ║
echo ║    22   =   Galaxy Friends                                             ║
echo ║    23   =   Galaxy Watch                                               ║
echo ║    24   =   Game Launcher and Settings                                 ║
echo ║    25   =   Gear VR Apps                                               ║
echo ║    26   =   Handwriting                                                ║
echo ║    27   =   Homescreen Widget                                          ║
echo ║    28   =   Internet Browser                                           ║
echo ║    29   =   Kids Mode Apps                                             ║
echo ║    30   =   LED Cover Apps                                             ║
echo ║    31   =   Live Message                                               ║
echo ║    32   =   Members                                                    ║
echo ║    33   =   Message                                                    ║
echo ║    34   =   Mobile Universal Switch                                    ║
echo ║    35   =   One Hand Mode                                              ║
echo ║    36   =   Pass                                                       ║
echo ║    37   =   Pay and Framework                                          ║
echo ║    38   =   Professional Audio                                         ║
echo ║    39   =   Saftey Information                                         ║
echo ║    40   =   Shop                                                       ║
echo ║    41   =   Smart Switch                                               ║
echo ║    42   =   Smart Things                                               ║
echo ║    43   =   Split Sound Service                                        ║
echo ║    44   =   Sports Widget                                              ║
echo ║    45   =   Story Video Editor                                         ║
echo ║    46   =   StoryService                                               ║
echo ║    47   =   Vision Cloud Agent                                         ║
echo ║    48   =   Voice Input                                                ║
echo ║    49   =   Voice Recorder                                             ║
echo ║    50   =   Wallpapers                                                 ║
echo ║    51   =   Weather                                                    ║
echo ║    52   =   What's New                                                 ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    53   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    54   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr6=Make your Choice:

IF %menunr6%==1 (goto ss1)
IF %menunr6%==2 (goto ss2)
IF %menunr6%==3 (goto ss3)
IF %menunr6%==4 (goto ss4)
IF %menunr6%==5 (goto ss5)
IF %menunr6%==6 (goto ss6)
IF %menunr6%==7 (goto ss7)
IF %menunr6%==8 (goto ss8)
IF %menunr6%==9 (goto ss9)
IF %menunr6%==10 (goto ss10)
IF %menunr6%==11 (goto ss11)
IF %menunr6%==12 (goto ss12)
IF %menunr6%==13 (goto ss13)
IF %menunr6%==14 (goto ss14)
IF %menunr6%==15 (goto ss15)
IF %menunr6%==16 (goto ss16)
IF %menunr6%==17 (goto ss17)
IF %menunr6%==18 (goto ss18)
IF %menunr6%==19 (goto ss19)
IF %menunr6%==20 (goto ss20)
IF %menunr6%==21 (goto ss21)
IF %menunr6%==22 (goto ss22)
IF %menunr6%==23 (goto ss23)
IF %menunr6%==24 (goto ss24)
IF %menunr6%==25 (goto ss25)
IF %menunr6%==26 (goto ss26)
IF %menunr6%==27 (goto ss27)
IF %menunr6%==28 (goto ss28)
IF %menunr6%==29 (goto ss29)
IF %menunr6%==30 (goto ss30)
IF %menunr6%==31 (goto ss31)
IF %menunr6%==32 (goto ss32)
IF %menunr6%==33 (goto ss33)
IF %menunr6%==34 (goto ss34)
IF %menunr6%==35 (goto ss35)
IF %menunr6%==36 (goto ss36)
IF %menunr6%==37 (goto ss37)
IF %menunr6%==38 (goto ss38)
IF %menunr6%==39 (goto ss39)
IF %menunr6%==40 (goto ss40)
IF %menunr6%==41 (goto ss41)
IF %menunr6%==42 (goto ss42)
IF %menunr6%==43 (goto ss43)
IF %menunr6%==44 (goto ss44)
IF %menunr6%==45 (goto ss45)
IF %menunr6%==46 (goto ss46)
IF %menunr6%==47 (goto ss47)
IF %menunr6%==48 (goto ss48)
IF %menunr6%==49 (goto ss49)
IF %menunr6%==50 (goto ss50)
IF %menunr6%==51 (goto ss51)
IF %menunr6%==52 (goto ss52)
IF %menunr6%==53 (goto ss53)
IF %menunr6%==54 (goto menu)
goto ss:

:ss1
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling AR Doodle...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.ardrawing
echo.
pause
goto ss:

:ss2
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling AR Emoji Apps...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.aremoji
adb shell pm uninstall -k --user 0 com.sec.android.mimage.avatarstickers
adb shell pm uninstall -k --user 0 com.samsung.android.emojiupdater
echo.
pause
goto ss:

:ss3
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Air Command...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.service.aircommand
echo.
pause
goto ss:

:ss4
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Always on Display...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.app.aodservice
echo.
pause
goto ss:

:ss5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Authentication...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.authfw
echo.
pause
goto ss:

:ss6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Auto fill...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.samsungpassautofill
echo.
pause
goto ss:

:ss7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Barcode scanner...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.mobeam.barcodeService
echo.
pause
goto ss:

:ss8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling BeaconManager...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.beaconmanager
echo.
pause
goto ss:

:ss9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Bixby Apps...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.wakeup
adb shell pm uninstall -k --user 0 com.samsung.android.app.spage
adb shell pm uninstall -k --user 0 com.samsung.android.app.routines
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.service
adb shell pm uninstall -k --user 0 com.samsung.android.visionintelligence
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.agent
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.agent.dummy
adb shell pm uninstall -k --user 0 com.samsung.android.bixbyvision.framework
echo.
pause
goto ss:

:ss10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Calculator...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.app.popupcalculator
echo.
pause
goto ss:

:ss11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Car Mode...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.drivelink.stub
echo.
pause
goto ss:

:ss12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling China Hidden Menu...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.hidden.china
echo.
pause
goto ss:

:ss13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Cloud...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.scloud
echo.
pause
goto ss:

:ss14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling DeX Apps...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.app.dexonpc
adb shell pm uninstall -k --user 0 com.sec.android.desktopmode.uiservice
adb shell pm uninstall -k --user 0 com.samsung.desktopsystemui
adb shell pm uninstall -k --user 0 com.sec.android.app.desktoplauncher
echo.
pause
goto ss:

:ss15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Digital Wellbeing...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.wellbeing
echo.
pause
goto ss:

:ss16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Dual Messenger...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.da.daagent
echo.
pause
goto ss:

:ss17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Edge Display Apps...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.cnn.mobile.android.phone.edgepanel
adb shell pm uninstall -k --user 0 com.samsung.android.service.peoplestripe
adb shell pm uninstall -k --user 0 com.samsung.android.app.sbrowseredge
adb shell pm uninstall -k --user 0 com.samsung.android.app.appsedge
echo.
pause
goto ss:

:ss18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Email...                                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.wsomacp
echo.
pause
goto ss:

:ss19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Email Provider...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.email.provider
echo.
pause
goto ss:

:ss20
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Finance Widget...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.widgetapp.yahooedge.finance
echo.
pause
goto ss:

:ss21
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Flipboard...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 flipboard.boxer.app
echo.
pause
goto ss:

:ss22
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling  Galaxy Friends...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.mateagent
echo.
pause
goto ss:

:ss23
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Galaxy Watch...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.app.watchmanagerstub
echo.
pause
goto ss:

:ss24
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Game Launcher and Settings...                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.game.gamehome
adb shell pm uninstall -k --user 0 com.enhance.gameservice
adb shell pm uninstall -k --user 0 com.samsung.android.game.gametools
adb shell pm uninstall -k --user 0 com.samsung.android.game.gos
adb shell pm uninstall -k --user 0 com.samsung.android.gametuner.thin
echo.
pause
goto ss:

:ss25
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Gear VR Apps...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.hmt.vrsvc
adb shell pm uninstall -k --user 0 com.samsung.android.app.vrsetupwizardstub
adb shell pm uninstall -k --user 0 com.samsung.android.hmt.vrshell
echo.
pause
goto ss:

:ss26
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Handwriting...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.sdk.handwriting
echo.
pause
goto ss:

:ss27
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Homescreen Widget...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.widgetapp.samsungapps
echo.
pause
goto ss:

:ss28
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Internet Browser...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.app.sbrowser
echo.
pause
goto ss:

:ss29
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Kids Mode Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.kidsinstaller
adb shell pm uninstall -k --user 0 com.samsung.android.app.camera.sticker.facearavatar.preload
adb shell pm uninstall -k --user 0 com.sec.android.app.kidshome
echo.
pause
goto ss:

:ss30
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling LED Cover Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.app.ledbackcover
adb shell pm uninstall -k --user 0 com.sec.android.cover.ledcover
echo.
pause
goto ss:

:ss31
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Live Message...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.service.livedrawing
echo.
pause
goto ss:

:ss32
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Members...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.voc
echo.
pause
goto ss:

:ss33
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Message...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.messaging
echo.
pause
goto ss:

:ss34
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Mobile Universal Switch...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.universalswitch
echo.
pause
goto ss:

:ss35
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling One Hand Mode...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.easyonehand
echo.
pause
goto ss:

:ss36
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Pass...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.samsungpass
echo.
pause
goto ss:

:ss37
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Pay and Framework...                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.spay
adb shell pm uninstall -k --user 0 com.samsung.android.spayfw
echo.
pause
goto ss:

:ss38
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Professional Audio...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.sdk.professionalaudio.utility.jammonitor
echo.
pause
goto ss:

:ss39
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Saftey Information...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.safetyinformation
echo.
pause
goto ss:

:ss40
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Shop...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.ecomm.global
echo.
pause
goto ss:

:ss41
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Smart Switch...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.easyMover.Agent
echo.
pause
goto ss:

:ss42
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Smart Things...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.oneconnect
echo.
pause
goto ss:

:ss43
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Split Sound Service...                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.splitsound
echo.
pause
goto ss:

:ss44
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Sports Widget...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.widgetapp.yahooedge.sport
echo.
pause
goto ss:

:ss45
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Story Video Editor...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.app.highlightplayer
echo.
pause
goto ss:


:ss46
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling StoryService...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.storyservice
echo.
pause
goto ss:

:ss47
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Vision Cloud Agent...                                  ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.visioncloudagent
echo.
pause
goto ss:

:ss48
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Voice Input...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.svoiceime
echo.
pause
goto ss:

:ss49
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Voice Recorder...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.app.voicenote
echo.
pause
goto ss:

:ss50
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Wallpapers...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.app.dressroom
echo.
pause
goto ss:

:ss51
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Weather...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.sec.android.daemonapp
echo.
pause
goto ss:

:ss52
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling What's New...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.app.social
echo.
pause
goto ss:

:ss53
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all Samsung Apps...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.samsung.android.ardrawing
adb shell pm uninstall -k --user 0 com.samsung.android.aremoji
adb shell pm uninstall -k --user 0 com.sec.android.mimage.avatarstickers
adb shell pm uninstall -k --user 0 com.samsung.android.emojiupdater
adb shell pm uninstall -k --user 0 com.samsung.android.service.aircommand
adb shell pm uninstall -k --user 0 com.samsung.android.app.aodservice
adb shell pm uninstall -k --user 0 com.samsung.android.authfw
adb shell pm uninstall -k --user 0 com.samsung.android.samsungpassautofill
adb shell pm uninstall -k --user 0 com.mobeam.barcodeService
adb shell pm uninstall -k --user 0 com.samsung.android.beaconmanager
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.wakeup
adb shell pm uninstall -k --user 0 com.samsung.android.app.spage
adb shell pm uninstall -k --user 0 com.samsung.android.app.routines
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.service
adb shell pm uninstall -k --user 0 com.samsung.android.visionintelligence
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.agent
adb shell pm uninstall -k --user 0 com.samsung.android.bixby.agent.dummy
adb shell pm uninstall -k --user 0 com.samsung.android.bixbyvision.framework
adb shell pm uninstall -k --user 0 com.sec.android.app.popupcalculator
adb shell pm uninstall -k --user 0 com.samsung.android.drivelink.stub
adb shell pm uninstall -k --user 0 com.samsung.hidden.china
adb shell pm uninstall -k --user 0 com.samsung.android.scloud
adb shell pm uninstall -k --user 0 com.sec.android.app.dexonpc
adb shell pm uninstall -k --user 0 com.sec.android.desktopmode.uiservice
adb shell pm uninstall -k --user 0 com.samsung.desktopsystemui
adb shell pm uninstall -k --user 0 com.sec.android.app.desktoplauncher
adb shell pm uninstall -k --user 0 com.samsung.android.wellbeing
adb shell pm uninstall -k --user 0 com.samsung.android.da.daagent
adb shell pm uninstall -k --user 0 com.cnn.mobile.android.phone.edgepanel
adb shell pm uninstall -k --user 0 com.samsung.android.service.peoplestripe
adb shell pm uninstall -k --user 0 com.samsung.android.app.sbrowseredge
adb shell pm uninstall -k --user 0 com.samsung.android.app.appsedge
adb shell pm uninstall -k --user 0 com.wsomacp
adb shell pm uninstall -k --user 0 com.samsung.android.email.provider
adb shell pm uninstall -k --user 0 com.samsung.android.widgetapp.yahooedge.finance
adb shell pm uninstall -k --user 0 flipboard.boxer.app
adb shell pm uninstall -k --user 0 com.samsung.android.mateagent
adb shell pm uninstall -k --user 0 com.samsung.android.app.watchmanagerstub
adb shell pm uninstall -k --user 0 com.samsung.android.game.gamehome
adb shell pm uninstall -k --user 0 com.enhance.gameservice
adb shell pm uninstall -k --user 0 com.samsung.android.game.gametools
adb shell pm uninstall -k --user 0 com.samsung.android.game.gos
adb shell pm uninstall -k --user 0 com.samsung.android.gametuner.thin
adb shell pm uninstall -k --user 0 com.samsung.android.hmt.vrsvc
adb shell pm uninstall -k --user 0 com.samsung.android.app.vrsetupwizardstub
adb shell pm uninstall -k --user 0 com.samsung.android.hmt.vrshell
adb shell pm uninstall -k --user 0 com.samsung.android.sdk.handwriting
adb shell pm uninstall -k --user 0 com.sec.android.widgetapp.samsungapps
adb shell pm uninstall -k --user 0 com.sec.android.app.sbrowser
adb shell pm uninstall -k --user 0 com.samsung.android.kidsinstaller
adb shell pm uninstall -k --user 0 com.samsung.android.app.camera.sticker.facearavatar.preload
adb shell pm uninstall -k --user 0 com.sec.android.app.kidshome
adb shell pm uninstall -k --user 0 com.samsung.android.app.ledbackcover
adb shell pm uninstall -k --user 0 com.sec.android.cover.ledcover
adb shell pm uninstall -k --user 0 com.samsung.android.service.livedrawing
adb shell pm uninstall -k --user 0 com.samsung.android.voc
adb shell pm uninstall -k --user 0 com.samsung.android.messaging
adb shell pm uninstall -k --user 0 com.samsung.android.universalswitch
adb shell pm uninstall -k --user 0 com.sec.android.easyonehand
adb shell pm uninstall -k --user 0 com.samsung.android.samsungpass
adb shell pm uninstall -k --user 0 com.samsung.android.spay
adb shell pm uninstall -k --user 0 com.samsung.android.spayfw
adb shell pm uninstall -k --user 0 com.samsung.android.sdk.professionalaudio.utility.jammonitor
adb shell pm uninstall -k --user 0 com.samsung.safetyinformation
adb shell pm uninstall -k --user 0 com.samsung.ecomm.global
adb shell pm uninstall -k --user 0 com.sec.android.easyMover.Agent
adb shell pm uninstall -k --user 0 com.samsung.android.oneconnect
adb shell pm uninstall -k --user 0 com.sec.android.splitsound
adb shell pm uninstall -k --user 0 com.samsung.android.widgetapp.yahooedge.sport
adb shell pm uninstall -k --user 0 com.samsung.app.highlightplayer
adb shell pm uninstall -k --user 0 com.samsung.storyservice
adb shell pm uninstall -k --user 0 com.samsung.android.visioncloudagent
adb shell pm uninstall -k --user 0 com.samsung.android.svoiceime
adb shell pm uninstall -k --user 0 com.sec.android.app.voicenote
adb shell pm uninstall -k --user 0 com.samsung.android.app.dressroom
adb shell pm uninstall -k --user 0 com.sec.android.daemonapp
adb shell pm uninstall -k --user 0 com.samsung.android.app.social
echo.
pause
goto ss:

:ss54
goto menu:

:hw
color 0e
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║                              Huawei Apps                               ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║     1   =   Augmented Reality Service                                  ║
echo ║     2   =   Browser                                                    ║
echo ║     3   =   Business Card Reader                                       ║
echo ║     4   =   Compass                                                    ║
echo ║     5   =   Default Voice Input                                        ║
echo ║     6   =   Desktop Service                                            ║
echo ║     7   =   Fast ID Online                                             ║
echo ║     8   =   Floating Dock                                              ║
echo ║     9   =   Floating Dock by Huawei                                    ║
echo ║    10   =   Floating Menu                                              ║
echo ║    11   =   Geofence                                                   ║
echo ║    12   =   HiCare                                                     ║
echo ║    13   =   HiGame                                                     ║
echo ║    14   =   HiSearch                                                   ║
echo ║    15   =   HiSuite                                                    ║
echo ║    16   =   Huawei ID                                                  ║
echo ║    17   =   Huawei Services Framework                                  ║
echo ║    18   =   HwChrService                                               ║
echo ║    19   =   Info                                                       ║
echo ║    20   =   Karaoke Entertainment                                      ║
echo ║    21   =   Keyboard                                                   ║
echo ║    22   =   Live Wallpaper                                             ║
echo ║    23   =   Market                                                     ║
echo ║    24   =   Mirror                                                     ║
echo ║    25   =   MirrorShare                                                ║
echo ║    26   =   Online Cloud Folder                                        ║
echo ║    27   =   Payement                                                   ║
echo ║    28   =   Screen recorder                                            ║
echo ║    29   =   Smart Controller                                           ║
echo ║    30   =   Smart Diagnosis                                            ║
echo ║    31   =   Tips/Tricks                                                ║
echo ║    32   =   Video Editor                                               ║
echo ║    33   =   Videos                                                     ║
echo ║    34   =   Voice Assistant                                            ║
echo ║    35   =   Wallet                                                     ║
echo ║    36   =   Watch Sync                                                 ║
echo ║    37   =   Weather                                                    ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    38   =   Re-install all at once                                     ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║    39   =   Back to the Main Selection                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr7=Make your Choice:

IF %menunr7%==1 (goto hw1)
IF %menunr7%==2 (goto hw2)
IF %menunr7%==3 (goto hw3)
IF %menunr7%==4 (goto hw4)
IF %menunr7%==5 (goto hw5)
IF %menunr7%==6 (goto hw6)
IF %menunr7%==7 (goto hw7)
IF %menunr7%==8 (goto hw8)
IF %menunr7%==9 (goto hw9)
IF %menunr7%==10 (goto hw10)
IF %menunr7%==11 (goto hw11)
IF %menunr7%==12 (goto hw12)
IF %menunr7%==13 (goto hw13)
IF %menunr7%==14 (goto hw14)
IF %menunr7%==15 (goto hw15)
IF %menunr7%==16 (goto hw16)
IF %menunr7%==17 (goto hw17)
IF %menunr7%==18 (goto hw18)
IF %menunr7%==19 (goto hw19)
IF %menunr7%==20 (goto hw20)
IF %menunr7%==21 (goto hw21)
IF %menunr7%==22 (goto hw22)
IF %menunr7%==23 (goto hw23)
IF %menunr7%==24 (goto hw24)
IF %menunr7%==25 (goto hw25)
IF %menunr7%==26 (goto hw26)
IF %menunr7%==27 (goto hw27)
IF %menunr7%==28 (goto hw28)
IF %menunr7%==29 (goto hw29)
IF %menunr7%==30 (goto hw30)
IF %menunr7%==31 (goto hw31)
IF %menunr7%==32 (goto hw32)
IF %menunr7%==33 (goto hw33)
IF %menunr7%==34 (goto hw34)
IF %menunr7%==35 (goto hw35)
IF %menunr7%==36 (goto hw36)
IF %menunr7%==37 (goto hw37)
IF %menunr7%==38 (goto hw38)
IF %menunr7%==39 (goto menu)
goto hw:

:hw1
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Augmented Reality Service...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.arengine.service
echo.
pause
goto hw:

:hw2
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Browser...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.browser
echo.
pause
goto hw:

:hw3
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Business Card Reader...                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.contactscamcard
echo.
pause
goto hw:

:hw4
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Compass...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.compass
echo.
pause
goto hw:

:hw5
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Default Voice Input...                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.iflytek.speechsuite
echo.
pause
goto hw:

:hw6
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Desktop Service...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.desktop.explorer
echo.
pause
goto hw:

:hw7
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Fast ID Online...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.fido.uafclient
echo.
pause
goto hw:

:hw8
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Floating Dock...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.FloatTasks
echo.
pause
goto hw:

:hw9
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Floating Dock by Huawei...                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.hitouch
echo.
pause
goto hw:

:hw10
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Floating Menu...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.stylus.floatmenu
echo.
pause
goto hw:

:hw11
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Geofence...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.geofence
echo.
pause
goto hw:

:hw12
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HiCare...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.phoneservice
echo.
pause
goto hw:

:hw13
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HiGame...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.gameassistant
echo.
pause
goto hw:

:hw14
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HiSearch...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.search
echo.
pause
goto hw:

:hw15
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HiSuite...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.pcassistant
echo.
pause
goto hw:

:hw16
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Huawei ID...                                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.hdiw
echo.
pause
goto hw:

:hw17
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Huawei Services Framework...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.hsf
echo.
pause
goto hw:

:hw18
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling HwChrService...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.chr
echo.
pause
goto hw:

:hw19
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Info...                                                ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.iaware
echo.
pause
goto hw:

:hw20
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Karaoke Entertainment...                               ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.karaoke
echo.
pause
goto hw:

:hw21
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Keyboard...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.baidu.input_huawei
echo.
pause
goto hw:

:hw22
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Live Wallpaper...                                      ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.livewallpaper.paradise
echo.
pause
goto hw:

:hw23
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Market...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.appmarket
echo.
pause
goto hw:

:hw24
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Mirror...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.mirror
echo.
pause
goto hw:

:hw25
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling MirrorShare...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.mirrorshare
echo.
pause
goto hw:

:hw26
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Online Cloud Folder...                                 ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.hifolder
echo.
pause
goto hw:

:hw27
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Payement...                                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.hwpay
echo.
pause
goto hw:

:hw28
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Screen recorder...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.screenrecorder
echo.
pause
goto hw:

:hw29
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Smart Controller...                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.remotecontroller
echo.
pause
goto hw:

:hw30
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Smart Diagnosis...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.hwdetectrepair
echo.
pause
goto hw:

:hw31
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Tips/Tricks...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.tips
echo.
pause
goto hw:

:hw32
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Video Editor...                                        ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.videoeditor
echo.
pause
goto hw:

:hw33
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Videos...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.himovie.overseas
echo.
pause
goto hw:

:hw34
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Voice Assistant...                                     ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.vassistant
echo.
pause
goto hw:

:hw35
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Wallet...                                              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.wallet
echo.
pause
goto hw:

:hw36
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Watch Sync...                                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.watch.sync
echo.
pause
goto hw:

:hw37
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Uninstalling Weather...                                             ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell pm uninstall -k --user 0 com.huawei.android.totemweather
echo.
pause
goto hw:

:hw38
cls
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║    Re-install all Huawei Apps...                                       ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb shell cmd package install-existing com.huawei.arengine.service
adb shell cmd package install-existing com.huawei.browser
adb shell cmd package install-existing com.huawei.contactscamcard
adb shell cmd package install-existing com.huawei.compass
adb shell cmd package install-existing com.iflytek.speechsuite
adb shell cmd package install-existing com.huawei.desktop.explorer
adb shell cmd package install-existing com.huawei.fido.uafclient
adb shell cmd package install-existing com.huawei.android.FloatTasks
adb shell cmd package install-existing com.huawei.hitouch
adb shell cmd package install-existing com.huawei.stylus.floatmenu
adb shell cmd package install-existing com.huawei.geofence
adb shell cmd package install-existing com.huawei.phoneservice
adb shell cmd package install-existing com.huawei.gameassistant
adb shell cmd package install-existing com.huawei.search
adb shell cmd package install-existing com.huawei.pcassistant
adb shell cmd package install-existing com.huawei.hdiw
adb shell cmd package install-existing com.huawei.android.hsf
adb shell cmd package install-existing com.huawei.android.chr
adb shell cmd package install-existing com.huawei.iaware
adb shell cmd package install-existing com.huawei.android.karaoke
adb shell cmd package install-existing com.baidu.input_huawei
adb shell cmd package install-existing com.huawei.livewallpaper.paradise
adb shell cmd package install-existing com.huawei.appmarket
adb shell cmd package install-existing com.huawei.mirror
adb shell cmd package install-existing com.huawei.android.mirrorshare
adb shell cmd package install-existing com.huawei.hifolder
adb shell cmd package install-existing com.huawei.android.hwpay
adb shell cmd package install-existing com.huawei.screenrecorder
adb shell cmd package install-existing com.huawei.android.remotecontroller
adb shell cmd package install-existing com.huawei.hwdetectrepair
adb shell cmd package install-existing com.huawei.android.tips
adb shell cmd package install-existing com.huawei.videoeditor
adb shell cmd package install-existing com.huawei.himovie.overseas
adb shell cmd package install-existing com.huawei.vassistant
adb shell cmd package install-existing com.huawei.wallet
adb shell cmd package install-existing com.huawei.watch.sync
adb shell cmd package install-existing com.huawei.android.totemweather
echo.
pause
goto hw:

:hw39
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
SET /P menunr8=Make your Choice:

IF %menunr8%==1 (goto insa)
IF %menunr8%==2 (goto abi)
IF %menunr8%==3 (goto insb)
IF %menunr8%==4 (goto insr)
IF %menunr8%==5 (goto psh)
IF %menunr8%==6 (goto menu)
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
echo ║              Device reboots to Bootloader, please wait...              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot bootloader
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║          Select the Kernel you want to install from the Popup          ║
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
echo ║              Device reboots to Bootloader, please wait...              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot bootloader
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║         Select the Recovery you want to install from the Popup         ║
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
echo ║                      Installing Recovery now...                        ║
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
SET /P menunr9=Make your Choice:

IF %menunr9%==1 (goto cfw)
IF %menunr9%==2 (goto candr)
IF %menunr9%==3 (goto ckv)
IF %menunr9%==4 (goto cfbd)
IF %menunr9%==5 (goto ckbd)
IF %menunr9%==6 (goto cspd)
IF %menunr9%==7 (goto cimei)
IF %menunr9%==8 (goto cipa)
IF %menunr9%==9 (goto cawp)
IF %menunr9%==10 (goto cpcs)
IF %menunr9%==11 (goto menu)
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
SET /P menunr10=Make your Choice:

IF %menunr10%==1 (goto scrs)
IF %menunr10%==2 (goto scrv30)
IF %menunr10%==3 (goto scrv60)
IF %menunr10%==4 (goto scrv120)
IF %menunr10%==5 (goto scrv180)
IF %menunr10%==6 (goto menu)
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
echo ║         Reboot, Reboot to X, Boot Kernel, Bugreport and Logcat         ║
echo ║                                                                        ║
echo ║════════════════════════════════════════════════════════════════════════║
echo ║   1   =   Reboot the Device                                            ║
echo ║   2   =   Reboot to Bootloader                                         ║
echo ║   3   =   Exit Bootloader to System                                    ║
echo ║   4   =   Reboot to Recovery                                           ║
echo ║   5   =   Boot Kernel                                                  ║
echo ║   6   =   Create Bugreport                                             ║
echo ║   7   =   Create Logcat                                                ║
echo ║————————————————————————————————————————————————————————————————————————║
echo ║   8   =   Back to the Main Selection                                   ║
echo ╚════════════════════════════════════════════════════════════════════════╝
SET /P menunr11=Make your Choice:

IF %menunr11%==1 (goto rbot)
IF %menunr11%==2 (goto rbtb)
IF %menunr11%==3 (goto extb)
IF %menunr11%==4 (goto rbtr)
IF %menunr11%==5 (goto bobo)
IF %menunr11%==6 (goto bugr)
IF %menunr11%==7 (goto logc)
IF %menunr11%==8 (goto menu)
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

:bobo
cls
color 0a
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║              Your Device will now boot into Bootloader...              ║
echo ╚════════════════════════════════════════════════════════════════════════╝
adb reboot bootloader
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║           Select the Kernel you want to boot from the Popup            ║
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
echo ║                         Booting Kernel now...                          ║
echo ╚════════════════════════════════════════════════════════════════════════╝
fastboot boot "%filename%"
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
