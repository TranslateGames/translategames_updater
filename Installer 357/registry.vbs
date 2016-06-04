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
Version = "1.0.0.0000"
InstallLocation = Destination
Publisher = "Traduções de Jogos™"
DisplayName = "Tradução de Dawn of War II - Retribution"
Comments = "Tradução em Português(BR) para Dawn of War II - Retribution"
DisplayIcon = InstallLocation &"\DOW2.exe"
EstimatedSize = "37486,488"
UninstallString = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War II - Retribution\Uninstall.exe"
NoRepair = "1"
NoModify = "1"
URLInfoAbout = "http://www.sourceforge.net/projects/translategames"
RunTG = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution\Start.exe"""
If code = "357" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\DisplayName", DisplayName, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\Comments", Comments, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\DisplayIcon", DisplayIcon, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\InstallLocation", InstallLocation, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\UninstallString", UninstallString, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(357)", RunTG, "REG_SZ"
End If