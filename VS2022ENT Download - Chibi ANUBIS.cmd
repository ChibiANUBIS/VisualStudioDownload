@ECHO OFF
TITLE Download Visual Studio Enterprise 2022
COLOR F0

===========================================================
:: You can edit only this options
:: Languages support : zh-cn, zh-tw, cs-cz, en-us, es-es, fr-fr, de-de, it-it, ja-jp, ko-kr, pl-pl, pt-br, ru-ru, tr-tr

SET OutputDirectory=C:\Download
SET Language=fr-FR
SET VISUALSTUD=vs_enterprise.exe

===========================================================
SET Download=%OutputDirectory%\VS2022ENT
SET DestISO=%OutputDirectory%\ISO
SET AutoRun=%Download%\AutoRun.inf
SET ImgBurnx86=%programfiles%\ImgBurn\ImgBurn.exe
SET ImgBurnx64=%programfiles(x86)%\ImgBurn\ImgBurn.exe

pushd "%~dp0"
if not exist "%VISUALSTUD%" goto ERROR
if not exist "%Download%" mkdir "%Download%"
"%VISUALSTUD%" --layout "%Download%" --lang %Language%
echo Download Complete
if exist "%ImgBurnx64%" SET ImgBurnInstalled=%ImgBurnx64% & goto create
if exist "%ImgBurnx86%" SET ImgBurnInstalled=%ImgBurnx86% & goto create
goto END

:create 
echo.
echo ImgBurn is installed !
:loop
set /p answer=Do you want to create a ISO (Y/N)?
if /i "%answer:~,1%" EQU "Y" goto editit
if /i "%answer:~,1%" EQU "N" goto END
echo Please type Y for Yes or N for No
goto loop

:editit
echo [AutoRun] > "%AutoRun%"
echo OPEN="vs_setup.exe" >> "%AutoRun%"
echo ICON="vs_setup.exe,0" >> "%AutoRun%"
echo LABEL="Visual Studio 2022" >> "%AutoRun%"

"%ImgBurnInstalled%" /mode build /buildoutputmode imagefile /DEST "%DestISO%\Visual Studio 2022.iso" /src "%Download%" /FILESYSTEM "UDF" /UDFREVISION "2.5" /VOLUMELABEL "VS2022ENT" /start /CLOSE /NOIMAGEDETAILS /PRESERVEFULLPATHNAMES no /RECURSESUBDIRECTORIES yes /rootfolder yes

:END
echo X=MsgBox("Visual Studio 2022 Enterprise is complete, ENJOY ! :)",0+64,"Information") > %temp%\TEMPmessage.vbs
goto DELVBS

:ERROR
echo X=MsgBox("Visual Studio 2022 Enterprise is not complete, TOO BAD ! :(",0+48,"Information") > %temp%\TEMPmessage.vbs
goto DELVBS

:DELVBS
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q
exit