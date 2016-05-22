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
Version = "1.0.0.0000"
EstimatedSize = "37486,488"
RunTG = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution\Start.exe"""
If code = "357" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(357)\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(357)", RunTG, "REG_SZ"
End If