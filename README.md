# PZ-AutoRestart
Windows script to automatically start a Project Zomboid server. 

Used with  https://github.com/gorcon/rcon-cli/releases/tag/v0.10.1

https://www.reddit.com/r/projectzomboid/comments/rx29ci/windows_dedicated_server_autorestart/

# Important information
* you need to start `StartServer64.bat` from powershell.
* go to `C:\Users\%username%\Zomboid\Server` edit the `servertest.ini`
  * put the same secretpassword that you've put in **secret.txt** in `RCONPassword`
* To ease the usage I just put the `rcon.exe` in the same place as for my `10m.bat`,`1m.bat` & `quit.bat`
