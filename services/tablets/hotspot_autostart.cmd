PowerShell -Command "Set-ExecutionPolicy Unrestricted" >> "%TEMP%\StartupLog.txt" 2>&1
PowerShell %USERPROFILE%\hotspot\hotspot_autostart.ps1 >> "%TEMP%\StartupLog.txt" 2>&1
