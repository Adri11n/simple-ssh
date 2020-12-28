:1
@echo off
title installer-simple-ssh.exe
cls
echo.
echo This is the installer-script to download, unzip and start the simple-ssh programm.
echo.
echo The programm will be downloaded and unzipt on your desktop. All things will be automatic done so lean back and drink an tee or something else.


echo.
set asw=0
set /p asw="do you wanna contiue the installation (yes/no)?:"

if %asw%==yes goto check
if %asw%==no goto End
goto error_input


:check
cls
echo.
echo Now i will check if your system is compatible
echo.
echo.
ping localhost -n 3 >nul
IF EXIST C:\Windows\System32\tar.exe (echo checking for tar.exe	[ok]) ELSE goto missing-tar
echo.
ping localhost -n 3 >nul
IF EXIST C:\Windows\System32\curl.exe (echo checking for curl.exe	[ok]) ELSE goto missing-curl
ping localhost -n 3 >nul
echo.
IF EXIST C:\Windows\System32\OpenSSH (echo checking for openssh	[ok]) ELSE goto missing-openssh
echo.
ping localhost -n 3 >nul
ping google.com -n 1 -w 5000 >nul && (
echo checking for internet connection [ok]
) || (
goto missing-internet
)
ping localhost -n 5 >nul
goto next


:next
title download simple-ssh
echo.
set asw=0
set /p asw="Start Download (yes/no) ?:"

if %asw%==yes goto download-nextcloud-check
if %asw%==no goto 1
goto error_input


:download-nextcloud-check
cls
echo.
echo I will now lock if my storage is online
echo.
ping localhost -n 3 >nul
ping github.io -n 1 -w 5000 >nul && (
echo checking for the status of my storage [ok]
) || (
goto missing-nextcloud
)
ping localhost -n 3 >nul
goto download-nextcloud


:download-nextcloud
cls
curl https://adri11n.github.io/web/projects/simple-ssh/simple-ssh.zip --output %userprofile%/Desktop/simple-ssh.zip
echo.
echo download done [ok]
ping localhost -n 2 >nul
cd %userprofile%/Desktop/
tar -xf simple-ssh.zip
echo.
echo extraction [ok]
ping localhost -n 2 >nul
del /f simple-ssh.zip
echo.
echo removed .zip archieve [ok]
ping localhost -n 2 >nul
echo.
echo done [ok]
pause
start %windir%\explorer.exe "%userprofile%\Desktop\simple-ssh"
del /f installer-simple-ssh.bat
exit


:missing-nextcloud
cls
title error
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 										My Storage isnt avaidebile now try it later then my cloud will be online
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
goto END


:missing-curl
cls
title error
color cf
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo The curl.exe is missing in your System32 folder so the installer cant dowload the programm. Download and install the curl.exe manuelly in the System 32 foler or download the programm manuelly
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
goto END


:missing-tar
cls
title error
color cf
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo The tar.exe is missing in your System32 folder so the installer cant unzip the programm. Download and install the tar.exe manuelly in the System 32 foler or unzip the programm manuelly
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
goto END


:missing-openssh
cls
title error
color cf
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 					The OpenSSH-Client feature is missing in your system32 folder please install it or this script wouldend work
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo.
echo.
set asw=0
set /p asw="do you wanna install the openssh client (it must be there for the programm) (this will take an minute)(yes/no)?:"

if %asw%==yes goto install-openssh
if %asw%==no goto End
goto error_input


:install-openssh
cls
color 0f
powershell -command " Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 "
echo.
echo.
echo openssh client installation [ok]
ping localhost -n 3 >nul
goto 1


:missing-internet
cls
title error
color cf
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 									no connection to the internet could be established
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
goto END


:error_input
cls
title error
echo.
echo invalide input.
echo Press enter to go back to the option list.
pause >nul
goto 1


:END
cls
title END
echo.
echo.
echo.
color C
echo 											script will end now.
ping localhost -n 3 >nul
exit