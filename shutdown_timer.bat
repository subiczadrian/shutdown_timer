```bat
@echo off
chcp 65001 >nul
setlocal
title Windows 11 Leállítás Időzítő

:MENU
cls

echo.
echo ╔══════════════════════════════════════════╗
echo ║           LEÁLLÍTÁS IDŐZÍTŐ              ║
echo ╠══════════════════════════════════════════╣
echo ║                                          ║
echo ║   1.  1 óra                              ║
echo ║   2.  2 óra                              ║
echo ║   3.  4 óra                              ║
echo ║   4.  6 óra                              ║
echo ║   5.  8 óra                              ║
echo ║                                          ║
echo ║   C.  Időzítés törlése                   ║
echo ║   0.  Kilépés                            ║
echo ║                                          ║
echo ╚══════════════════════════════════════════╝
echo.

set /p CHOICE=  Választás: 

if "%CHOICE%"=="1" set "HOURS=1" & goto CONFIRM
if "%CHOICE%"=="2" set "HOURS=2" & goto CONFIRM
if "%CHOICE%"=="3" set "HOURS=4" & goto CONFIRM
if "%CHOICE%"=="4" set "HOURS=6" & goto CONFIRM
if "%CHOICE%"=="5" set "HOURS=8" & goto CONFIRM

if /i "%CHOICE%"=="C" goto CANCEL
if "%CHOICE%"=="0" goto EXIT

echo.
echo  Hibás választás!
pause
goto MENU


:CONFIRM
cls

echo.
echo ╔══════════════════════════════════════════╗
echo ║          LEÁLLÍTÁS MEGERŐSÍTÉSE          ║
echo ╚══════════════════════════════════════════╝
echo.
echo   A Windows %HOURS% óra múlva le fog állni.
echo.
echo   Biztosan beállítod?
echo.
echo   I = Igen
echo   N = Nem
echo.

set /p CONFIRM=  Választás: 

if /i "%CONFIRM%"=="I" goto SET_SHUTDOWN
if /i "%CONFIRM%"=="N" goto MENU

goto CONFIRM


:SET_SHUTDOWN

set /a SECONDS=HOURS*3600

rem Pontos leállítási idő kiszámítása
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-Date).AddSeconds(%SECONDS%).ToString('yyyy-MM-dd HH:mm:ss')"') do set "ENDTIME=%%A"

rem Windows leállítás beállítása
shutdown /s /t %SECONDS%

cls

echo.
echo ╔══════════════════════════════════════════╗
echo ║            LEÁLLÍTÁS BEÁLLÍTVA           ║
echo ╠══════════════════════════════════════════╣
echo ║                                          ║
echo ║   Időtartam:     %HOURS% óra                   ║
echo ║                                          ║
echo ║   Leállítás:     %ENDTIME%     ║
echo ║                                          ║
echo ╠══════════════════════════════════════════╣
echo ║                                          ║
echo ║   C = Időzítés törlése                   ║
echo ║   M = Főmenü                             ║
echo ║   0 = Kilépés                            ║
echo ║                                          ║
echo ╚══════════════════════════════════════════╝
echo.

choice /c CM0 /n /m "  Választás: "

if errorlevel 3 goto EXIT
if errorlevel 2 goto MENU
if errorlevel 1 goto CANCEL


:CANCEL
cls

echo.
echo ╔══════════════════════════════════════════╗
echo ║           IDŐZÍTÉS TÖRLÉSE               ║
echo ╚══════════════════════════════════════════╝
echo.

shutdown /a >nul 2>&1

if errorlevel 1 (
    echo  Nincs aktív leállítási időzítés.
) else (
    echo  A leállítási időzítés törölve.
)

echo.
pause
goto MENU


:EXIT
endlocal
exit /b
```
