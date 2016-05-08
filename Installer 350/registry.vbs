REM - Iniciando Configuração
On Error Resume Next
Set objArgs = WScript.Arguments.Named
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set oShell = CreateObject("WScript.Shell")
For Each objOperatingSystem in colOperatingSystems
	sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
	sArq = replace(sArq,"-bit","")
	sArq = replace(sArq," bits","")
	sArq = replace(sArq," bit","")
	OSversion = replace(objOperatingSystem.Version,".","")
	If sArq = "32" then
		WinArq="32"
	elseif sArq = "64" then
		WinArq="64"
	else
		WinArq="0"
	end if
Next
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
Else
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
If (objArgs.Item("code")) Then
  code = objArgs.Item("code")
Else
  WScript.Quit
End If
dteCurrent = Date()
dteDay = Day(dteCurrent)
dteMonth = Month(dteCurrent)
dteYear = Year(dteCurrent)
InstallDate = dteYear & dteMonth & dteDay
Version = "6.0.0.11476"
EstimatedSize = "13849,137"
EstimatedSize2 = "8268,452"
EstimatedSize3 = "37242,891"
EstimatedSize4 = "63746,259"
RunTG = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War\Start.exe"""
RunTG3 = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Start.exe"""
RunTG4 = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm\Start.exe"""
If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\EstimatedSize", EstimatedSize2, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350)", RunTG, "REG_SZ"
ElseIf code = "350-3" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\EstimatedSize", EstimatedSize3, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350-3)", RunTG3, "REG_SZ"
ElseIf code = "350-4" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\EstimatedSize", EstimatedSize4, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350-4)", RunTG4, "REG_SZ"
End If