@echo off
title updater-simpel-ssh
ping localhost -n 3 >nul
rmdir /S /Q %1
echo.
echo removed skript [ok]
ping localhost -n 2 >nul
curl https://cloud.adriaanvanvliet.com/index.php/s/b3G33MZ3Y8NtrCB/download --output %userprofile%/Desktop/simple-ssh.zip
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
del /f updater.bat
exit