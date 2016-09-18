REM - Iniciando Configuração
On Error Resume Next
Set objArgs = WScript.Arguments.Named
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set colComputerSystems = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
Set oShell = CreateObject("WScript.Shell")
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
For Each objOperatingSystem in colOperatingSystems
	sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
	sArq = replace(sArq,"-bit","")
	sArq = replace(sArq," bits","")
	sArq = replace(sArq," bit","")
	OSname = replace(objOperatingSystem.Name,"Microsoft ","")
	OSname1 = Split(OSname, "|")
	   For i = 1 to (Ubound(OSname1))
		OSname = OSname1(0)
	   Next
	OSversion = replace(objOperatingSystem.Version,".","")
	If sArq = "32" then
		WinArq="32"
	elseif sArq = "64" then
		WinArq="64"
	else
		WinArq="32"
	end if
Next
For Each objComputerSystem in colComputerSystems
	SYSname = objComputerSystem.Name
	Memory = objComputerSystem.TotalPhysicalMemory
	Memory = Memory/1024/1024/1024
	Memoryc = Split(Memory, ",")
	   For i = 1 to (Ubound(Memoryc))
		FMEM = Memoryc(0)
		SMEM = Memoryc(1)
	   Next
	DN = Chr(48)
	SMEM = Replace(SMEM,0,DN)
	SMEM = left(SMEM,2)
	FMEM = Replace(FMEM,0,DN)
	Memory = FMEM &","& SMEM &" GB"
Next
Function RandomString( ByVal strLen )
    Dim str, min, max

    Const LETTERS = "abcdefghijklmnopqrstuvwxyz0123456789"
    min = 1
    max = Len(LETTERS)

    Randomize
    For i = 1 to strLen
        str = str & Mid( LETTERS, Int((max-min+1)*Rnd+min), 1 )
    Next
    RandomString = str
End Function
UniqueCode = RandomString(1) & RandomString(6) & RandomString(7) & RandomString(8) & RandomString(9) & RandomString(1)
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
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
If code = "350" Then
UCcheck = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UniqueCode")
Else
UCcheck = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UniqueCode")
End If
If (UCcheck) Then
UniqueCode = UCcheck
Else
If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UniqueCode", UniqueCode, "REG_SZ"
Else
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UniqueCode", UniqueCode, "REG_SZ"
End If
End If
REM - Obtendo ou Criando Configuração
If code = "350" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig")
Else
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UpConfig")
End If
If (config) Then
config = Split(config, "|.|")
   For i = 1 to (Ubound(config))
	AutoOp = config(0)
	TimeOp = config(1)
   Next
Else
AutoOp = "Ativar"
TimeOp = "10800"
REM - Atualização Automática restrita ao Windows XP ou +
If OSversion < 500000 Then
AutoOp = "Desativar"
End If
Result = AutoOp &"|.|"& TimeOp
If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig", Result, "REG_SZ"
Else
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UpConfig", Result, "REG_SZ"
End If
If code = "350" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig")
Else
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UpConfig")
End If
config = Split(config, "|.|")
   For i = 1 to (Ubound(config))
	AutoOp = config(0)
	TimeOp = config(1)
   Next
End If
dteCurrent = Date()
dteDay = Day(dteCurrent)
dteMonth = Month(dteCurrent)
dteYear = Year(dteCurrent)
InstallDate = dteYear & dteMonth & dteDay
Version = "1.0.0.0860"
InstallLocation = Destination
Publisher = "Traduções de Jogos™"
DisplayName = "Tradução de Dawn of War II - Retribution"
Comments = "Tradução em Português(BR) para Dawn of War II - Retribution"
DisplayIcon = InstallLocation &"\DOW2.exe"
EstimatedSize = "37466,373"
UninstallString = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War II - Retribution\Uninstall.exe"
NoRepair = "1"
NoModify = "1"
URLInfoAbout = "http://www.sourceforge.net/projects/translategames"
RunTG = """"& Path &"\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution\Start.exe"""
PostData = "UID="& UniqueCode &"&code="& code &"&version="& version &"&OSversion="& OSversion &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP
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
objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
objXMLHTTP.send PostData
Set objXMLHTTP = nothing