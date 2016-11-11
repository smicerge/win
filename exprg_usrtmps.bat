@echo off
REM exprg_usrtmps
REM Author smicerge

REM TESTED ON = 
REM WIndows Server 2008 R2

echo start expurgating !

set usersfile=C:\temp\users.info
set logfile=C:\temp\expurgatetempfolders.log
set zeilen=0
set counter=0

IF EXIST %usersfile% del %usersfile% /f /s /q

dir /b %systemdrive%\users>C:\Temp\users.info
FOR /F "delims=:" %%A IN (C:\Temp\users.info) DO set /a "zeilen+=1"

echo.
echo %zeilen% >> %logfile%
echo.


:expurgate
rem echo %counter%

IF %zeilen% == 0 goto expurgated

for /f "tokens=1,* delims=:" %%i in ('findstr /n  $ %usersfile%') do @(
        for /L %%a in (%counter%,1,%counter%) do @if %%i==%%a set actuser=%%j
)

set tempu=%systemdrive%\users\%actuser%\appdata\local\Temp

IF EXIST %tempu% (
	rmdir "%tempu%" /s /q >> %logfile%
	IF NOT EXIST "%tempu%" mkdir "%tempu%"
	echo.
	echo "%tempu%" expurgated >> %logfile%
	echo. )


set /a counter=%counter%+1
set /a "zeilen-=1"

goto expurgate

:expurgated

echo Tempfolders expurgated
