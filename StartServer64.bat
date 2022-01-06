:start

@echo off

::============================================
::10 Minute Warning
::============================================
SET mintoadd=110
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
SET mintoadd=119
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
SET mintoadd=120
for /f "tokens=1*" %%A in ('
  powershell -NoP -C "(Get-Date).AddMinutes(%mintoadd%).ToString('MM/dd/yyyy HH:mm:ss')"
') do (
  Set "NEWDATE=%%A"
  set "NEWTIME=%%B"
)
SCHTASKS /Create /SC ONCE /ST %NEWTIME% /SD %NEWDATE% /TN "PZ\quit" /F /TR C:\SteamCMD\rcon\quit.bat

@echo on

::============================================
::Delete workshop cache and start server
::============================================

::del /f "C:\SteamCMD\steamapps\common\Project Zomboid Dedicated Server\steamapps\workshop\appworkshop_108600.acf"

@setlocal enableextensions
@cd /d "%~dp0"
SET PZ_CLASSPATH=java/istack-commons-runtime.jar;java/jassimp.jar;java/javacord-2.0.17-shaded.jar;java/javax.activation-api.jar;java/jaxb-api.jar;java/jaxb-runtime.jar;java/lwjgl.jar;java/lwjgl-natives-windows.jar;java/lwjgl-glfw.jar;java/lwjgl-glfw-natives-windows.jar;java/lwjgl-jemalloc.jar;java/lwjgl-jemalloc-natives-windows.jar;java/lwjgl-opengl.jar;java/lwjgl-opengl-natives-windows.jar;java/lwjgl_util.jar;java/sqlite-jdbc-3.27.2.1.jar;java/trove-3.0.3.jar;java/uncommons-maths-1.2.3.jar;java/
".\jre64\bin\java.exe" -Djava.awt.headless=true -Dzomboid.steam=1 -Dzomboid.znetlog=1 -XX:+UseZGC -XX:-CreateCoredumpOnCrash -XX:-OmitStackTraceInFastThrow -Xms16g -Xmx16g -Djava.library.path=natives/;natives/win64/;. -cp %PZ_CLASSPATH% zombie.network.GameServer -statistic 0

goto start

