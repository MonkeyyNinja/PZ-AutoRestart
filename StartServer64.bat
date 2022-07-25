:start

@echo off
::============================================
:: 2H
::============================================
SET intervalInMinuteToRestart=120

::============================================
:: doDeleteAllMod
:: 1==true, 0==false
::============================================
SET /A doDeleteAllMod = 1

::============================================
::10 Minute Warning
::============================================
SET /A mintoadd=%intervalInMinuteToRestart%-10
for /f "tokens=1*" %%A in ('
  powershell -NoP -C "(Get-Date).AddMinutes(%mintoadd%).ToString('MM/dd/yyyy HH:mm:ss')"
') do (
  Set "NEWDATE=%%A"
  set "NEWTIME=%%B"
)

SCHTASKS /Create /SC ONCE /ST %NEWTIME% /SD %NEWDATE% /TN "PZ\10m" /F /TR C:\SteamCMD\rcon\10m.bat

::============================================
::1 Minute Warning
::============================================
SET /A mintoadd=%intervalInMinuteToRestart%-1
for /f "tokens=1*" %%A in ('
  powershell -NoP -C "(Get-Date).AddMinutes(%mintoadd%).ToString('MM/dd/yyyy HH:mm:ss')"
') do (
  Set "NEWDATE=%%A"
  set "NEWTIME=%%B"
)

SCHTASKS /Create /SC ONCE /ST %NEWTIME% /SD %NEWDATE% /TN "PZ\1m" /F /TR C:\SteamCMD\rcon\1m.bat
::============================================
::Restart
::============================================
SET mintoadd=%intervalInMinuteToRestart%
for /f "tokens=1*" %%A in ('
  powershell -NoP -C "(Get-Date).AddMinutes(%mintoadd%).ToString('MM/dd/yyyy HH:mm:ss')"
') do (
  Set "NEWDATE=%%A"
  set "NEWTIME=%%B"
)
SCHTASKS /Create /SC ONCE /ST %NEWTIME% /SD %NEWDATE% /TN "PZ\quit" /F /TR C:\SteamCMD\rcon\quit.bat

@echo on

if %doDeleteAllMod%==1 (
goto :deletecache 
) else (
 goto :startserver
)

::============================================
::Delete workshop cache and start server
::============================================
:deletecache
del /f "C:\SteamCMD\steamapps\common\Project Zomboid Dedicated Server\steamapps\workshop\appworkshop_108600.acf"


::============================================
::NOTE: I think you should replace the section below with the current text in the original file
::============================================
:startserver
@setlocal enableextensions
@cd /d "%~dp0"
SET _JAVA_OPTIONS=-Djava.awt.headless=true
SET PZ_CLASSPATH=commons-compress-1.18.jar;istack-commons-runtime.jar;jassimp.jar;javacord-2.0.17-shaded.jar;javax.activation-api.jar;jaxb-api.jar;jaxb-runtime.jar;lwjgl.jar;lwjgl-natives-windows.jar;lwjgl-glfw.jar;lwjgl-glfw-natives-windows.jar;lwjgl-jemalloc.jar;lwjgl-jemalloc-natives-windows.jar;lwjgl-opengl.jar;lwjgl-opengl-natives-windows.jar;lwjgl_util.jar;sqlite-jdbc-3.27.2.1.jar;trove-3.0.3.jar;uncommons-maths-1.2.3.jar;./
".\jre64\bin\java.exe" -XX:+UseZGC -XX:-CreateCoredumpOnCrash -XX:-OmitStackTraceInFastThrow -Xmx3072m -XX:+UseZGC -Djava.library.path=./natives/;./natives/win64/;./ -cp %PZ_CLASSPATH% zombie.network.GameServer
::============================================
goto start

