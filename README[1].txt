CROSSHAIR STUDIO — ONE-CLICK INSTALLER PROJECT

This produces a normal Windows Setup.exe:
Download Setup.exe -> open -> Install -> desktop shortcut + Start Menu -> launch app.

The installed app is a GUI WinExe, so it does not open a CMD window.

BUILD:
1. Install Visual Studio or Build Tools with .NET Framework desktop build tools.
2. Install Inno Setup 6.
3. Open PowerShell in this folder.
4. Run .\Build-Installer.ps1
5. Your installer will be:
   Installer\installer\Crosshair-Studio-Setup.exe

The end user only needs Setup.exe. They do not need to extract a ZIP or run PowerShell.
