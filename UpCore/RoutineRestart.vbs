REM **************************************
REM Routine Restart v2.7 By TranslateGames
REM **************************************

Dim objWsh, fso, strx, GetDecimalChar, oShell, OSversion
On Error Resume Next

strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
If GetDecimalChar = "" Then
GetDecimalChar = ","
End If

Set objArgs = WScript.Arguments.Named
If NOT (IsEmpty(objArgs.Item("Init"))) Then
If NOT (IsEmpty(objArgs.Item("code"))) Then
If NOT (IsEmpty(objArgs.Item("upcore"))) Then
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

If NOT (IsEmpty(objArgs.Item("mode"))) Then
If objArgs.Item("mode") = "UI" Then
mode = "2"
Else
mode = "1"
End If
Else
mode = "1"
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
	If NOT (IsEmpty(objOperatingSystem.OSArchitecture)) Then
		sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
		sArq = replace(sArq,"-bit","")
		sArq = replace(sArq," bits","")
		sArq = replace(sArq," bit","")
	Else
		sArq = 32
	End If
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
	If sArq = "32" Then
		WinArq="32"
	ElseIf sArq = "64" Then
		WinArq="64"
	Else
		WinArq="32"
	End If
Next
For Each objComputerSystem in colComputerSystems
	SYSname = objComputerSystem.Name
	MemoryR = objComputerSystem.TotalPhysicalMemory
	MemoryA = MemoryR/1024/1024/1024
	Memoryc = Split(MemoryA, GetDecimalChar)
	   For i = 1 to (Ubound(Memoryc))
		FMEM = Memoryc(0)
		SMEM = Memoryc(1)
	   Next
	DN = Chr(48)
	SMEM = Replace(SMEM,0,DN)
	SMEM = left(SMEM,2)
	FMEM = Replace(FMEM,0,DN)
	If (FMEM) Then
	If FMEM = "" Then
	FMEM = DN
	Else
	FMEM = FMEM
	End If
	Else
	FMEM = DN
	End If
	If (SMEM) Then
	If SMEM = "" Then
	SMEM = DN
	Else
	SMEM = SMEM
	End If
	Else
	SMEM = DN
	End If
	If SMEM = DN and FMEM = DN Then
	Memory = MemoryR &" B"
	Else
	Memory = FMEM &","& SMEM &" GB"
	End If
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
Function ReadReg(reg)
On Error Resume Next
If NOT (IsEmpty(reg)) Then
reg = Replace(reg,"TG_UNINSTALL","HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
If NOT (IsEmpty(oShell.RegRead(reg))) Then
ReadData = oShell.RegRead(reg)
Else
ReadData = ""
End If
Else
ReadData = ""
End If
ReadReg = ReadData
End Function
Function WriteReg(reg,val,tp)
If NOT (IsEmpty(reg)) Then
If NOT (IsEmpty(val)) Then
If NOT (IsEmpty(tp)) Then
reg = Replace(reg,"TG_UNINSTALL","HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
oShell.RegWrite reg,val,tp
End If
End If
End If
End Function
RString = RandomString(14) & RandomString(18)
UniqueCode = RandomString(1) & RandomString(6) & RandomString(7) & RandomString(8) & RandomString(9) & RandomString(1)
If code = "350" Then
UCcheck = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UniqueCode")
Else
UCcheck = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UniqueCode")
End If
If NOT (IsEmpty(UCcheck)) Then
UniqueCode = UCcheck
Else
If code = "350" Then
Temp = WriteReg("TG_UNINSTALL\TranslateGames(350-1)\UniqueCode", UniqueCode, "REG_SZ")
Else
Temp = WriteReg("TG_UNINSTALL\TranslateGames("& code &")\UniqueCode", UniqueCode, "REG_SZ")
End If
End If
If code = "350" Then
UpCoreUP = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\LastUpCore")
Else
UpCoreUP = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\LastUpCore")
End If
If NOT (IsEmpty(UpCoreUP)) Then
UpCoreVersion = UpCoreUP
End If
If code = "350" Then
HasInstalled = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\HasInstalled")
Else
HasInstalled = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\HasInstalled")
End If
If code = "350" Then
Temp = WriteReg("TG_UNINSTALL\TranslateGames(350-1)\ExecCount", ExecCount2, "REG_SZ")
Else
Temp = WriteReg("TG_UNINSTALL\TranslateGames("& code &")\ExecCount", ExecCount2, "REG_SZ")
End If
REM - Obtendo versão da Tradução
If code = "350" Then
versionT = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\DisplayVersion")
Else
versionT = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\DisplayVersion")
End If
If NOT (IsEmpty(versionT)) Then
version = Replace(VersionT, ".", "")
ElseIf HasInstalled = "1" Then
versionT = "UNINSTALLED"
version = "UNINSTALLED"
Else
versionT = "N.INSTALLED"
version = "N.INSTALLED"
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
config = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig")
Else
config = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig")
End If
If NOT (IsEmpty(config)) Then
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
Temp = WriteReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig", Result, "REG_SZ")
Else
Temp = WriteReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig", Result, "REG_SZ")
End If
If code = "350" Then
config = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig")
Else
config = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig")
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
Temp = WriteReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig", Result, "REG_SZ")
Else
Temp = WriteReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig", Result, "REG_SZ")
End If
If code = "350" Then
config = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig")
Else
config = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig")
End If
config = Split(config, "|.|")
   For i = 1 to (Ubound(config))
	AutoOp = config(0)
	TimeOp = config(1)
	LimitOp = config(2)
   Next
End If
ExtractTo= Path & Path2 &"\UpCore"
SilentFolder= Path & Path2 &"\UpCore\UpSilent"
UpdaterFolder= Path & Path2
PostData = "UID="& UniqueCode &"&code="& code &"&version="& versionT &"&OSversion="& OSversionA &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP &"|.|"& LimitOp

z7File= ExtractTo &"\7z.exe"
WgetFile= ExtractTo &"\wget.exe"
WscriptFile= ExtractTo &"\wscript.exe"
TimeoutFile= ExtractTo &"\timeout.exe"
SilentFile= ExtractTo &"\SilentService.vbs"
HashFile= ExtractTo &"\Hash.exe"
HashVBSFile= ExtractTo &"\Hash.vbs"
ExtractSizeFile= ExtractTo &"\ExtractSize.vbs"

SilentFileS= SilentFolder &"\SilentService.vbs"
z7FileS= SilentFolder &"\7z.exe"
WgetFileS= SilentFolder &"\wget.exe"
WscriptFileS= SilentFolder &"\wscript.exe"
TimeoutFileS= SilentFolder &"\timeout.exe"
HashFileS= SilentFolder &"\Hash.exe"
HashVBSFileS= SilentFolder &"\Hash.vbs"
ExtractSizeFileS= SilentFolder &"\ExtractSize.vbs"

If mode = "1" Then

oShell.CurrentDirectory = SilentFolder

File = "update.tguf"
FileWget = "wget.exe"

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile("UpdateLog.txt", 1, False)
D2 = objRead2.ReadAll
Set objFSO2 = Nothing
Set objRead2 = Nothing

D2r = Split(D2, "Iniciando... ")
Filet = Ubound(D2r)
Filet2 = D2r(Filet)
D2r = Split(Filet2, "Saving to: '"&File&"'")
Filet = Ubound(D2r)
Filet = Filet - 1
Filet2 = D2r(Filet)
D2r = Split(Filet2, "Length: ")
Filet = Ubound(D2r)
Filet2 = D2r(Filet)
D2r = Split(Filet2, " [")
Filet = 0
Filet2 = D2r(Filet)
D2r = Split(Filet2, " (")
Filet = 0
Filet2 = D2r(Filet)

D2dataR = Filet2

Set objFSO = CreateObject("Scripting.FileSystemObject")
If D2dataR = "" Then
	If objFSO.Fileexists(FileWget) Then objFSO.DeleteFile FileWget
	oShell.CurrentDirectory = ExtractTo
	If objFSO.Fileexists(FileWget) Then objFSO.DeleteFile FileWget
	oShell.CurrentDirectory = UpdaterFolder
	If (fso.FileExists("Update.exe")) Then
	  objWsh.Run "Update.exe /Q /T:""%TEMP%\RoutineRestart"& code &"-"& RString &".tmp"" /C:""wscript InitUpdate.vbs /force:extract /only:extract /silent:silent""", 0, 1
	End If
End If
Set objFSO = Nothing

End If

oShell.CurrentDirectory = ExtractTo

If mode = "1" Then

If AutoOp = "Desativar" Then
  WScript.Quit
End If

If NOT fso.FolderExists(SilentFolder) Then
  fso.CreateFolder(SilentFolder)
End If
oShell.CurrentDirectory = SilentFolder

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile("wscript.exe")
WscriptLocation = objFile.Path
Set objFSO = Nothing
Set objRead = Nothing

Check = 0
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'wscript.exe'")
For Each objProcess in colProcessList
	Location = objProcess.ExecutablePath
	If Location = WscriptLocation Then
	Check = 1
	End If
Next

If Check = 1 Then
  WScript.Quit
End If

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(SilentFileS) Then objFSO.DeleteFile SilentFileS
If objFSO.Fileexists(SilentFile) Then objFSO.CopyFile SilentFile, SilentFileS
If objFSO.Fileexists(z7FileS) Then objFSO.DeleteFile z7FileS
If objFSO.Fileexists(z7File) Then objFSO.CopyFile z7File, z7FileS
If objFSO.Fileexists(ExtractSizeFileS) Then objFSO.DeleteFile ExtractSizeFileS
If objFSO.Fileexists(ExtractSizeFile) Then objFSO.CopyFile ExtractSizeFile, ExtractSizeFileS
If objFSO.Fileexists(HashFileS) Then objFSO.DeleteFile HashFileS
If objFSO.Fileexists(HashFile) Then objFSO.CopyFile HashFile, HashFileS
If objFSO.Fileexists(HashVBSFileS) Then objFSO.DeleteFile HashVBSFileS
If objFSO.Fileexists(HashVBSFile) Then objFSO.CopyFile HashVBSFile, HashVBSFileS
If objFSO.Fileexists(TimeoutFileS) Then objFSO.DeleteFile TimeoutFileS
If objFSO.Fileexists(TimeoutFile) Then objFSO.CopyFile TimeoutFile, TimeoutFileS
If objFSO.Fileexists(WgetFileS) Then objFSO.DeleteFile WgetFileS
If objFSO.Fileexists(WgetFile) Then objFSO.CopyFile WgetFile, WgetFileS
If objFSO.Fileexists(WscriptFileS) Then objFSO.DeleteFile WscriptFileS
If objFSO.Fileexists(WscriptFile) Then objFSO.CopyFile WscriptFile, WscriptFileS
Set objFSO = Nothing

If (fso.FileExists("SilentService.vbs")) Then
  objWsh.Run "wscript ""SilentService.vbs"" /version:"& version &" /code:"& code &" /TimeOp:"& TimeOp &" /LimitOp:"& LimitOp &" /versionT:"& versionT &" /UpCoreVersion:"& UpCoreVersion &" /UpCoreCVersion:"& UpCoreCVersion, 0, 0
  If OSversion < 599999 Then
  useragentstring="""TranslateGamesUpdater/"&UpCoreVersion&" Translation/"&code&" Version/"&versionT&" Sync"""
  objWsh.Run "wget.exe https://translategames.com.br/updater/sync --post-data="""&PostData&""" --output-document=post.temp --user-agent="&useragentstring&" --no-check-certificate --timeout=5 --tries=1", 0, 1
  If fso.FileExists("post.temp") Then fso.DeleteFile "post.temp"
  Else
  objXMLHTTP.open "POST", "https://translategames.com.br/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.setRequestHeader "User-Agent", "TranslateGamesUpdater/"& UpCoreVersion &" Translation/"& code &" Version/"& versionT &" Sync"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  End If
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore\Silent.bat)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

ElseIf mode = "2" Then

If (fso.FileExists("UpdaterService.vbs")) Then
  objWsh.Run "wscript ""UpdaterService.vbs"" /version:"& version &" /code:"& code &" /GameName:"""& GameName &""" /LimitOp:"& LimitOp &" /versionT:"& versionT &" /UpCoreVersion:"& UpCoreVersion &" /UpCoreCVersion:"& UpCoreCVersion &" /sinterface:NOT", 0, 0
  If OSversion < 599999 Then
  useragentstring="""TranslateGamesUpdater/"&UpCoreVersion&" Translation/"&code&" Version/"&versionT&" Sync"""
  objWsh.Run "wget.exe https://translategames.com.br/updater/sync --post-data="""&PostData&""" --output-document=post.temp --user-agent="&useragentstring&" --no-check-certificate --timeout=5 --tries=1", 0, 1
  If fso.FileExists("post.temp") Then fso.DeleteFile "post.temp"
  Else
  objXMLHTTP.open "POST", "https://translategames.com.br/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.setRequestHeader "User-Agent", "TranslateGamesUpdater/"& UpCoreVersion &" Translation/"& code &" Version/"& versionT &" Sync"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  End If
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore\UpdaterService.vbs)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

End If