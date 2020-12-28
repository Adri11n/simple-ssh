@echo off
title simple-ssh.exe
cls
IF EXIST C:\Windows\System32\OpenSSH (goto eula) ELSE goto missing-openssh


:eula
cls
IF EXIST license-gpl-yes.txt  goto menu
IF EXIST license-gpl-no.txt goto notaccept
goto missing


:menu
cls
title simple-ssh.bat
set version=1.6
echo simple-ssh  Copyright (C) 2020  Adriaan van Vliet
echo This program comes with ABSOLUTELY NO WARRANTY; for details type "%cd%\license-gpl-yes.txt".
echo This is free software, and you are welcome to redistribute it under certain conditions; type "%cd%\license-gpl-yes.txt" for details.
echo.
echo.
echo This script will support you when using the openssh client in the windows terminal .
echo.
echo Please select a function in the menu below
echo =================================================================================================================================================================================================
echo.
echo.
echo Press 1 to connect to a ssh-server
echo.
echo Press 2 to save your ssh connection
echo.
echo Press 3 to manage the ssh-keygen options
echo.
echo Press 4 to report a bug
echo.
echo Press 5 to open an openssh matrix ;)
echo.
echo Type "version" to get the version number
echo.
echo Type "update" for avaideble
echo.
echo Type "exit" to exit
echo.
echo After you selected an option press enter
echo.
set asw=0
set /p asw="> "

if %asw%==1 goto ssh-server-connection
if %asw%==2 goto ssh-server-connection-save
if %asw%==3 goto ssh-keygen
if %asw%==4 goto bug-report
if %asw%==5 goto matrix
if %asw%==version goto version
if %asw%==update goto check-update
if %asw%==exit goto End
goto error_input


:ssh-server-connection
cls
title ssh-server-connection
set user=0
set hostname=0
set id=0
set /p user="Please enter your username of your ssh-server ?:"
set /p hostname="Please enter ip/domain of your ssh-server ?:"
set /p id="do you want to use a keyfile for your connection (yes/no) ?:"

if %id%==yes goto ssh-server-connection-keyfile
if %id%==no goto ssh-server-connection-port
goto error_input
:ssh-server-connection-keyfile
cls
set id1=0
set /p id1="Please enter path to your keyfile:"
goto ssh-server-connection-port
:ssh-server-connection-port
cls
set port=0
set /p port="Please enter the port of your ssh-server. Liefe this field empty for the default port:"
goto ssh-server-connection-2
:ssh-server-connection-2
cls
if %id%==yes goto next
if %id%==no goto next
goto error_input


:next
if %port%==0 goto next2
if %port% GTR 0 goto next1
:next1
cls
if %id%==yes goto option4
if %id%==no goto option3
goto next2
:next2
cls
if %id%==yes goto option2
goto option1



:option1
cls
ssh %user%@%hostname%
goto menu
:option2
cls
ssh %user%@%hostname% -i %id1%
goto menu
:option3
cls
ssh %user%@%hostname% -p %port%
goto menu
:option4
ssh %user%@%hostname% -i %id1% -p %port%
goto menu


:ssh-server-connection-save
title ssh-server-connection-save
cls
echo.
echo In this command line interface you can save ssh-connections.
echo They will be saved on your desktop, just double click them and you will have an ssh-session.
echo.
echo.
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
cls
set filename=0
set /p filename="Please enter a name for your connection that will be saved ?:"
goto ssh-server-connection-save-1


:ssh-server-connection-save-1
title ssh-server-connection-save-1
cls
set user=0
set hostname=0
set id=0
set /p user="Please enter your username of your ssh-server ?:"
set /p hostname="Please enter ip/domain of your ssh-server ?:"
set /p id="do you want to use a keyfile for your connection (yes/no)) ?:"

if %id%==yes goto ssh-server-connection-save-keyfile
if %id%==no goto ssh-server-connection-save-port
goto error_input
:ssh-server-connection-save-keyfile
cls
set id1=0
set /p id1="Please enter path to your keyfile:"
goto ssh-server-connection-save-port
:ssh-server-connection-save-port
cls
set port=0
set /p port="Please enter the port of your ssh-server. Liefe this field empty for the default port:"
goto ssh-server-connection-save-2
:ssh-server-connection-save-2
cls
if %id%==yes goto next-save
if %id%==no goto next-save
goto error_input


:next-save
if %port%==0 goto next2-save
if %port% GTR 0 goto next1-save

:next1-save
cls
if %id%==yes goto option-save-4
if %id%==no goto option-save-3
goto next2-save
:next2-save
cls
if %id%==yes goto option-save-2
goto option-save-1



:option-save-1
cls
echo @echo off> %userprofile%/Desktop/%filename%.bat
echo cls>> %userprofile%/Desktop/%filename%.bat
echo ssh %user%@%hostname%>> %userprofile%/Desktop/%filename%.bat
cls
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:option-save-2
cls
echo @echo off> %userprofile%/Desktop/%filename%.bat
echo cls>> %userprofile%/Desktop/%filename%.bat
echo ssh %user%@%hostname% -i %id1%>> %userprofile%/Desktop/%filename%.bat
cls
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:option-save-3
cls
echo @echo off> %userprofile%/Desktop/%filename%.bat
echo cls>> %userprofile%/Desktop/%filename%.bat
echo ssh %user%@%hostname% -p %port%>> %userprofile%/Desktop/%filename%.bat
cls
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:option-save-4
cls
echo @echo off> %userprofile%/Desktop/%filename%.bat
echo cls>> %userprofile%/Desktop/%filename%.bat
echo ssh %user%@%hostname% -i %id1% -p %port%>> %userprofile%/Desktop/%filename%.bat
cls
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:ssh-keygen
title ssh-keygen
cls
echo This part of the script you can create, configure and export ssh-keys
echo.
echo.
echo Press a number in the menu below followed by enter
echo =================================================================================================================================================================================================
echo.
echo Press 1 to create a ssh-key-pair
echo.
echo Press 2 to change the password. en or decrypt your key
echo.
echo Press 3 to export the key.pub file to your ssh-server 
echo.
echo Type "back" to go to the main menu
echo.




set asw=0
set /p asw="select an option: "

if %asw%==1 goto ssh-keygen-create
if %asw%==2 goto ssh-keygen-pass
if %asw%==3 goto ssh-keygen-export
if %asw%==back goto menu
goto error_input


:ssh-keygen-create
cls
set filename=0
set /p filename="how should the keys be called ? (the ssh-key-pair will be saved on your dekstop):"
echo.
set asw=0
set /p asw="which type of ssh-key-pair you want (rsa | ecdsa | ed25519 | dsa) just type one of these options, the most common type is rsa:"
, 
if %asw%==dsa goto ssh-keygen-dsa
if %asw%==ecdsa goto ssh-keygen-ecdsa
if %asw%==ed25519 goto ssh-keygen-ed25519
if %asw%==rsa goto ssh-keygen-rsa
goto error_input


:ssh-keygen-dsa
cls
ssh-keygen -b 1024 -t dsa -f %userprofile%/Desktop/%filename%
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:ssh-keygen-ecdsa
cls
ssh-keygen -b 521 -t ecdsa -f %userprofile%/Desktop/%filename%
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:ssh-keygen-ed25519
cls
ssh-keygen -t ed25519 -f %userprofile%/Desktop/%filename%
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:ssh-keygen-rsa
cls
ssh-keygen -b 4096 -f %userprofile%/Desktop/%filename%
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu



:ssh-keygen-pass
cls
title ssh-keygen-pass
echo.
echo First you must type or copy and paste the hole path of your private key, thats the key without an ending, without quotation marks (if you generatet the keys with this script the will be locatet on your desktop
echo Then the rest will explained in the called script
echo.
echo.
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
ssh-keygen -p
goto menu


:ssh-keygen-export
cls
title ssh-keygen-export
set user=0
set hostname=0
set id=0
set file.pub=0
set /p file.pub="enter the correctly and full path of you .pub key:"
set /p user="Please enter your username of your ssh-server ?:"
set /p hostname="Please enter ip/domain of your ssh-server ?:"
set /p id="do you want to use a keyfile for your connection (yes/no) ?:"

if %id%==yes goto scp-server-connection-keyfile
if %id%==no goto scp-server-connection-port
goto error_input
:scp-server-connection-keyfile
cls
set id1=0
set /p id1="enter her the correctly path of your keyfile that you want to use to connect to the ssh-server:"
goto scp-server-connection-port
:scp-server-connection-port
cls
set port=0
set /p port="Please enter the port of your ssh-server. Liefe this field empty for the default port:"
goto scp-server-connection-2
:scp-server-connection-2
cls
if %id%==yes goto scp-next
if %id%==no goto scp-next
goto error_input


:scp-next
if %port%==0 goto scp-next2
if %port% GTR 0 goto scp-next1
:scp-next1
cls
if %id%==yes goto scp-option4
if %id%==no goto scp-option3
goto next2
:scp-next2
cls
if %id%==yes goto scp-option2
goto scp-option1



:scp-option1
cls
scp %file.pub% %user%@%hostname%:~/.ssh/authorized_keys
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu
:scp-option2
cls
scp -i %id1% %file.pub% %user%@%hostname%:~/.ssh/authorized_keys
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu
:scp-option3
cls
scp -p %port% %file.pub% %user%@%hostname%:~/.ssh/authorized_keys
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu
:scp-option4
scp -i %id1% -p %port% %file.pub% %user%@%hostname%:~/.ssh/authorized_keys
echo.
echo.
echo.
echo 										   done
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:bug-report
cls
start https://adriaanvanvliet.com/?p=479#comments
start https://github.com/Adri11n/simple-ssh/issues
echo.
echo 									###########################
echo 									# Press enter to continue #
echo 									###########################
pause >nul
goto menu


:matrix
title matrix
color 2
cls
goto openssh-matrix
:openssh-matrix
echo.
echo 																					```                 									
echo                                                                                 oN/            										    
echo      ````       `  ````        ````       `  ````        ````         ````      sM/ ```             										
echo    :yhyyyho.   :msoyyhdy.    :yhyyyh+`   /m+osyhds.    /hyyyyh+`    /hyyyyh+`   sMosyyhdo` 										        
echo   /Ny.` `:Nd`  /Mm:` `:Nd`  +Ns`  `/Ny   +Md-` `oMs   .Nh`  `:+.   .Nh`  `:+.   sMh.` `sM+ 												        
echo   dM-     hM:  /My    `dN-  mMyoooosmN-  +Mo    :Mh   `smdyo/-`    `smdyo/-`    sM/    /Ms 												        
echo   dM-     hM:  /My    `dN-  dM/-------`  +Mo    :Mh     `.:+shm/     `.:+sdm:   sM/    /Ms 												        
echo   /Nh.  `/Nh`  /Mm:   /Nh`  /Ny.  `-o:   +Mo    :Mh   -s:    /Ny   -s-    /Ns   sM/    /Ms 											        
echo    :yyysyy+`   /Myossyhs.    :yyyyyyo.   /d/    -ds   `oyyssyyo.   `oyyssyyo`   +d:    :d+   											     
echo      ``.`      /Ms ````        ``.``      `      ``     ``..``       ``..`      ``      ``       
echo                :Ns                                                                                  
echo                `-. 
echo ##################################################################################################################################################################
ping localhost -n 2 >nul
goto openssh-matrix


:version
title version=%version%
cls
echo.
echo 									Press enter to continue
echo.
echo.
echo 									###################
echo 									#   Version=%version%	  #
echo 									###################
pause >nul
goto menu


:check-update
cls
title update
ping google.com -n 1 -w 5000 >nul && (
echo checking for internet connection [ok]
) || (
goto missing-internet
)
ping github.io -n 1 -w 5000 >nul && (
echo checking for the status of my storage [ok]
) || (
goto missing-nextcloud
)
curl https://adri11n.github.io/web/projects/simple-ssh/version.txt --output version.txt
set/p versionupdate=< version.txt
cls
if %version%==%versionupdate% goto no-update
if %versionupdate% GTR %version% goto update
goto END

:no-update
echo.
echo.
echo There is no update avaideble
del /f version.txt
pause
goto menu


:update
echo.
echo.
echo There is an update avaideble from version %version% to version %versionupdate%
del /f version.txt
set /p awnser="do you wanna update to version %versionupdate% (yes/no):"
if %awnser%==yes goto update2
if %awnser%==no goto menu
goto error_input


:update2
cls
ping localhost -n 3 >nul
ping google.com -n 1 -w 5000 >nul && (
echo checking for internet connection [ok]
) || (
goto missing-internet
ping localhost -n 1 >nul
echo you must close now all windows where you opened the simple-ssh skript or the simple-ssh folder, if you done this press enter
set lol=%cd%
pause
curl https://adri11n.github.io/web/projects/simple-ssh/updater.bat --output %USERPROFILE%\AppData\Local\Temp\updater.bat
start /MAX %USERPROFILE%\AppData\Local\Temp\updater.bat %lol%
exit


:notaccept
cls
echo.
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 									Please accept the license first
echo.
echo										Please read the license-gpl-no.txt file first
echo.
echo 									rename license-gpl-no.txt to license-gpl-yes.txt to accept the license
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ping localhost -n 30 >nul
goto END


:missing
cls
title error
color cf
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 					unfortunately one or more parts of the package are missing. Please download the packet again correctly
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
exit


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
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 				To install the OpenSSH-Client go to your settings then apps then optional features then add features and search OpenSSH-Client and install it
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
exit


:missing-nextcloud
cls
title error
echo.
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo 										My Personal Cloud isnt avaidebile now try it later then my cloud will be online
echo -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pause
goto END


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
goto menu


:END
cls
title END
echo.
echo.
echo.
color C
echo 											script will end now.
ping localhost -n 5 >nul
exit