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
If (objArgs.Item("destination")) Then
  destination = objArgs.Item("destination")
Else
  WScript.Quit
End If
StringL = Destination
StringL = Replace(StringL,"‡","ç")
StringL = Replace(StringL,"ä","õ")
Destination = StringL
dteCurrent = Date()
dteDay = Day(dteCurrent)
dteMonth = Month(dteCurrent)
dteYear = Year(dteCurrent)
InstallDate = dteYear & dteMonth & dteDay
Version = "6.0.0.11590"
InstallLocation = Destination
Publisher = "Traduções de Jogos™"
DisplayName = "Tradução de Dawn of War"
DisplayName2 = "Tradução de Dawn of War - Winter Assault"
DisplayName3 = "Tradução de Dawn of War - Dark Crusade"
DisplayName4 = "Tradução de Dawn of War - Soulstorm"
Comments = "Tradução em Português(BR) para Dawn of War"
Comments2 = "Tradução em Português(BR) para Dawn of War - Winter Assault"
Comments3 = "Tradução em Português(BR) para Dawn of War - Dark Crusade"
Comments4 = "Tradução em Português(BR) para Dawn of War - Soulstorm"
DisplayIcon = InstallLocation &"\W40k.exe"
DisplayIcon2 = InstallLocation &"\W40kWA.exe"
DisplayIcon3 = InstallLocation &"\DarkCrusade.exe"
DisplayIcon4 = InstallLocation &"\Soulstorm.exe"
EstimatedSize = "13849,137"
EstimatedSize2 = "8268,452"
EstimatedSize3 = "37242,891"
EstimatedSize4 = "63746,259"
UninstallString = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War\Uninstall.exe"
UninstallString2 = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War - Winter Assault\Uninstall.exe"
UninstallString3 = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War - Dark Crusade\Uninstall.exe"
UninstallString4 = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War - Soulstorm\Uninstall.exe"
NoRepair = "1"
NoModify = "1"
URLInfoAbout = "http://www.sourceforge.net/projects/w40kbr"
RunTG = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War\Start.exe"""
RunTG3 = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Start.exe"""
RunTG4 = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm\Start.exe"""
If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayName", DisplayName, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayName", DisplayName2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\Comments", Comments, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\Comments", Comments2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayIcon", DisplayIcon, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayIcon", DisplayIcon2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\InstallLocation", InstallLocation, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\InstallLocation", InstallLocation, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\EstimatedSize", EstimatedSize2, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UninstallString", UninstallString, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\UninstallString", UninstallString2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350)", RunTG, "REG_SZ"
ElseIf code = "350-3" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\DisplayName", DisplayName3, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\Comments", Comments3, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\DisplayIcon", DisplayIcon3, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\InstallLocation", InstallLocation, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\EstimatedSize", EstimatedSize3, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\UninstallString", UninstallString3, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350-3)", RunTG3, "REG_SZ"
ElseIf code = "350-4" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\DisplayName", DisplayName4, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\Comments", Comments4, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\DisplayIcon", DisplayIcon4, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\InstallLocation", InstallLocation, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\EstimatedSize", EstimatedSize4, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\UninstallString", UninstallString4, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350-4)", RunTG4, "REG_SZ"
End If