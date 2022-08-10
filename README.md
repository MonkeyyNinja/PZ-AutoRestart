# PZ-AutoRestart
Windows script to automatically start a Project Zomboid server. 

Used with  https://github.com/gorcon/rcon-cli/releases/tag/v0.10.1

https://www.reddit.com/r/projectzomboid/comments/rx29ci/windows_dedicated_server_autorestart/

# Important information
* you need to start `StartServer64.bat` from powershell.
* go to `C:\Users\%username%\Zomboid\Server` edit the `servertest.ini`
  * put the same secretpassword that you've put in **secret.txt** in `RCONPassword`
* To ease the usage I just put the `rcon.exe` in the same place as for my `10m.bat`,`1m.bat` & `quit.bat`

# Killing the 3 task
If for some reason you need to kill the task and dont know how look at this info: https://www.makeuseof.com/disable-scheduled-tasks-windows-10/

if you dont want to click just do that:
1. `windows+R`
1. enter __taskschd.msc__ and press enter
1. under ` Task Scheduler Library`=>`PZ` you can find the 3 script there

then you can do what you need :D 
