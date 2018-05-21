REM **************************************
REM Routine Restart v1.0 By TranslateGames
REM **************************************

Dim objWsh, fso, strx, GetDecimalChar
On Error Resume Next

strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
If GetDecimalChar = "" Then
GetDecimalChar = ","
End If

Set objArgs = WScript.Arguments.Named
If (objArgs.Item("Init")) Then
If (objArgs.Item("code")) Then
If (objArgs.Item("upcore")) Then
code=objArgs.Item("code")
UpCoreVersion=objArgs.Item("upcore")
Else
  WScript.Quit
End If
Else
  WScript.Quit
End If
Else
  WScript.Quit
End If

REM - Iniciando Configuração
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
Set oShell = CreateObject("WScript.Shell")
oShell.CurrentDirectory = CurPath
Set fso = CreateObject("Scripting.FileSystemObject")
Set objWsh = CreateObject("WScript.Shell")
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set colComputerSystems = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
For Each objOperatingSystem in colOperatingSystems
	sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
	sArq = replace(sArq,"-bit","")
	sArq = replace(sArq," bits","")
	sArq = replace(sArq," bit","")
	OSname = replace(objOperatingSystem.Name,"Microsoft ","")
	OSname = replace(OSname,"Microsoft® ","")
	OSname = replace(OSname,"®","")
	OSname = replace(OSname,"™","")
	OSname1 = Split(OSname, "|")
	   For i = 1 to (Ubound(OSname1))
		OSname = OSname1(0)
	   Next
	OSversionA = objOperatingSystem.Version
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
	Memoryc = Split(Memory, GetDecimalChar)
	   For i = 1 to (Ubound(Memoryc))
		FMEM = Memoryc(0)
		SMEM = Memoryc(1)
	   Next
	DN = Chr(48)
	SMEM = Replace(SMEM,0,DN)
	SMEM = left(SMEM,2)
	FMEM = Replace(FMEM,0,DN)
	If (FMEM) Then
	FMEM = FMEM
	Else
	FMEM = DN
	End If
	If (SMEM) Then
	SMEM = SMEM
	Else
	SMEM = DN
	End If
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
RString = RandomString(14) & RandomString(18)
UniqueCode = RandomString(1) & RandomString(6) & RandomString(7) & RandomString(8) & RandomString(9) & RandomString(1)
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
REM - Obtendo versão da Tradução
If code = "350" Then
versionT = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayVersion")
Else
versionT = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\DisplayVersion")
End If
If (versionT) Then
version = Replace(VersionT, ".", "")
Else
versionT = "UNINSTALLED"
version = "UNINSTALLED"
End If
UpCoreCVersion = Replace(UpCoreVersion, ".", "")
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
If code = "350-2" Then
code="350"
End If
REM - Definindo localização da pasta de operações da Tradução
PathTG = "\Traduções de Jogos"
TGL = Path & PathTG
If NOT fso.FolderExists(TGL) Then
  fso.CreateFolder(TGL)
End If
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
Path2W = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault"
GameName = "Warhammer 40,000 Dawn of War e Winter Assault"
GameConst = "\W40k.exe"
GameConstW = "\W40kWA.exe"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
GameName = "Warhammer 40,000 Dawn of War - Dark Crusade"
GameConst = "\DarkCrusade.exe"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
GameName = "Warhammer 40,000 Dawn of War - Soulstorm"
GameConst = "\Soulstorm.exe"
ElseIf code = "356" Then
Path2 = "\Traduções de Jogos\Age of Mythology"
GameName = "Age of Mythology"
GameConst = "\aom.exe"
ElseIf code = "356-2" Then
Path2 = "\Traduções de Jogos\Age of Mythology\The Titans Expansion"
GameName = "Age of Mythology: The Titans Expansion"
GameConst = "\aomx.exe"
ElseIf code = "357" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
GameName = "Warhammer 40,000 Dawn of War II - Retribution"
GameConst = "\DOW2.exe"
ElseIf code = "358" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
GameName = "Warhammer 40,000 Dawn of War II e Chaos Rising"
GameConst = "\DOW2.exe"
End If
Path2c = Split(Path2, "\")
PathD2 = Path &"\"

For Each PathD In Path2c

If PathD = "" Then

Else
PathD2 = PathD2 & PathD
If NOT fso.FolderExists(PathD2) Then
  fso.CreateFolder(PathD2)
End If
PathD2 = PathD2 &"\"
End If

Next
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
	LimitOp = config(2)
   Next
REM - Início Precauções
If AutoOp = "0" Then
AutoOp = "Ativar"
ElseIf AutoOp = "" Then
AutoOp = "Ativar"
End If
If TimeOp = "0" Then
TimeOp = "10800"
ElseIf TimeOp = "" Then
TimeOp = "10800"
End If
If LimitOp = "0" Then
LimitOp = "Ilimitado"
ElseIf LimitOp = "" Then
LimitOp = "Ilimitado"
End If
REM - Fim Precauções
Result = AutoOp &"|.|"& TimeOp &"|.|"& LimitOp
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
	LimitOp = config(2)
   Next
REM - Fim config = yes
Else
REM - Início config = null
AutoOp = "Ativar"
TimeOp = "10800"
LimitOp = "Ilimitado"
REM - Atualização Automática restrita ao Windows XP ou +
If OSversion < 500000 Then
AutoOp = "Desativar"
End If
Result = AutoOp &"|.|"& TimeOp &"|.|"& LimitOp
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
	LimitOp = config(2)
   Next
End If
If AutoOp = "Desativar" Then
  WScript.Quit
End If
ExtractTo= CurPath
UpdaterFolder= Path & Path2
PostData = "UID="& UniqueCode &"&code="& code &"&version="& versionT &"&OSversion="& OSversionA &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP &"|.|"& LimitOp

oShell.CurrentDirectory = ExtractTo

File = "update.temp"
FileWget = "wget.exe"

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile("UpSilent\UpdateLog.txt", 1, False)
D2 = objRead2.ReadAll

D2r2 = Split(D2, "Iniciando... ")

For Each D2dtr2 In D2r2

D2dR = D2dtr2

Next

D2r = Split(D2dR, "Length: ")

D2data = ""

For Each D2s In D2r

D2fsr = Split(D2s, "Saving to: '")
   For i = 1 to (Ubound(D2fsr))
	D2ft = D2fsr(1)
   Next
D2ftr = Split(D2ft, "'")
   For i = 1 to (Ubound(D2ftr))
	Filet = D2ftr(0)
   Next

If Filet = File Then

D2sr = Split(D2s, " [")
   For i = 1 to (Ubound(D2sr))
	D2dataNR = D2sr(0)
   Next
D2sr = Split(D2dataNR, " (")
   For i = 1 to (Ubound(D2sr))
	D2dataNR = D2sr(0)
   Next

D2data = D2data &"|"& D2dataNR

End If

Next

D2dt = Split(D2data, "|")

For Each D2dtr In D2dt

D2dataR = D2dtr

Next

Set objFSO = CreateObject("Scripting.FileSystemObject")
If D2dataR = "" Then
	If objFSO.Fileexists(FileWget) Then objFSO.DeleteFile FileWget
	oShell.CurrentDirectory = UpdaterFolder
	If (fso.FileExists("Update.exe")) Then
	  objWsh.Run "Update.exe /Q /T:""%TEMP%\RoutineRestart"& code &"-"& RString &".tmp"" /C:""wscript InitUpdate.vbs /force:extract /only:extract /silent:silent""", 0, 1
	End If
End If
Set objFSO = Nothing

oShell.CurrentDirectory = ExtractTo

If (fso.FileExists("Silent.bat")) Then
  objWsh.Run "Silent.bat "& version &" "& code &" "& TimeOp &" "& LimitOp &" "& versionT &" "& UpCoreVersion &" "& UpCoreCVersion, 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.setRequestHeader "User-Agent", "TranslateGamesUpdater/"& UpCoreVersion &" Translation/"& code &" Version/"& versionT &" Sync"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore\Silent.bat)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If