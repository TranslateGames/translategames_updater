Dim objWsh, fso, strx, GetDecimalChar
On Error Resume Next
code="356"
UpCoreVersion="1.5.0.0318"

REM - Iniciando Configuração
strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
If GetDecimalChar = "" Then
GetDecimalChar = ","
End If
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
Set oShell = CreateObject("WScript.Shell")
oShell.CurrentDirectory = CurPath
Set objArgs = WScript.Arguments.Named
FileT= "Boot.tgapp"
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(FileT, 1, True)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileT, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
objRead.WriteLine "0"
Set objFSO = Nothing
Set objRead = Nothing
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
If code = "350" Then
HasInstalled = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\HasInstalled")
Else
HasInstalled = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\HasInstalled")
End If
If code = "350" Then
ExecCount = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\ExecCount")
Else
ExecCount = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\ExecCount")
End If
If ExecCount = "" Then
ExecCount = 0
ElseIf ExecCount = 0 Then
ExecCount = 0
ElseIf ExecCount < 0 Then
ExecCount = 0
ElseIf ExecCount > 10 Then
ExecCount = 10
End If
If ExecCount = 10 Then
ExecCount2 = 0
Else
ExecCount2 = ExecCount + 1
End If
If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\ExecCount", ExecCount2, "REG_SZ"
Else
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\ExecCount", ExecCount2, "REG_SZ"
End If
REM - Obtendo versão da Tradução
If code = "350" Then
versionT = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayVersion")
Else
versionT = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\DisplayVersion")
End If
If (versionT) Then
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
If (objArgs.Item("silent")) Then
If AutoOp = "Desativar" Then
  WScript.Quit
End If
ZipFile= CurPath &"\UpCore.tgpf"
ExtractTo= Path & Path2 &"\UpCore"
CleanL= Path & Path2
TGL= Path & PathTG
If code = "350" Then
WinterL= Path & Path2W
End If
zFile= CurPath
Else
ZipFile= CurPath &"\UpCore.tgpf"
ExtractTo= Path & Path2 &"\UpCore"
CleanL= Path & Path2
TGL= Path & PathTG
If code = "350" Then
WinterL= Path & Path2W
End If
zFile= CurPath
End If
PostData = "UID="& UniqueCode &"&code="& code &"&version="& versionT &"&OSversion="& OSversionA &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP &"|.|"& LimitOp
UpCoreNFName= "UpCore-"& RString
NewZipFile= CurPath &"\"& UpCoreNFName &".tgpf"
z7File= ExtractTo &"\7z.exe"
z7FileT= ExtractTo &"\7z."& RString &".tmp"
AppFile= ExtractTo &"\App.exe"
AppFileT= ExtractTo &"\App."& RString &".tmp"
WgetFile= ExtractTo &"\wget.exe"
WgetFileT= ExtractTo &"\wget."& RString &".tmp"
WscriptFile= ExtractTo &"\wscript.exe"
WscriptFileT= ExtractTo &"\wscript."& RString &".tmp"
TimeoutFile= ExtractTo &"\timeout.exe"
TimeoutFileT= ExtractTo &"\timeout."& RString &".tmp"
If NOT fso.FolderExists(TGL) Then
  fso.CreateFolder(TGL)
End If
If NOT fso.FolderExists(CleanL) Then
  fso.CreateFolder(CleanL)
End If

oShell.CurrentDirectory = ExtractTo

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ErroI7z.vbs", 2, True)
objRead.WriteLine "msgbox"&Chr(34)&"Erro! Uma outra instância do atualizador desta tradução pode estar aberta!"&Chr(34)&"&Chr(13)&"&Chr(34)&"Caso não haja outra instância aberta: abra o 'Gerenciador de Tarefas' e finalize '7z.exe' ou '7-Zip Reduced Standalone Console'."&Chr(34)&",vbCritical,"&Chr(34)&"Falha ao tentar iniciar!"&Chr(34)&""
Set objFSO = Nothing
Set objRead = Nothing
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ErroIApp.vbs", 2, True)
objRead.WriteLine "msgbox"&Chr(34)&"Erro! Uma outra instância do atualizador desta tradução pode estar aberta!"&Chr(34)&"&Chr(13)&"&Chr(34)&"Caso não haja outra instância aberta: abra o 'Gerenciador de Tarefas' e finalize 'App.exe' ou 'Traduções de Jogos App'."&Chr(34)&",vbCritical,"&Chr(34)&"Falha ao tentar iniciar!"&Chr(34)&""
Set objFSO = Nothing
Set objRead = Nothing
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ErroIWget.vbs", 2, True)
objRead.WriteLine "msgbox"&Chr(34)&"Erro! Uma outra instância do atualizador desta tradução pode estar aberta!"&Chr(34)&"&Chr(13)&"&Chr(34)&"Caso não haja outra instância aberta: abra o 'Gerenciador de Tarefas' e finalize 'wget.exe' ou 'Translate Games Connection Engine'."&Chr(34)&",vbCritical,"&Chr(34)&"Falha ao tentar iniciar!"&Chr(34)&""
Set objFSO = Nothing
Set objRead = Nothing
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ErroIWscript.vbs", 2, True)
objRead.WriteLine "msgbox"&Chr(34)&"Erro! Uma outra instância do atualizador desta tradução pode estar aberta!"&Chr(34)&"&Chr(13)&"&Chr(34)&"Caso não haja outra instância aberta: abra o 'Gerenciador de Tarefas' e finalize 'wscript.exe' ou 'Translate Games Script Host'."&Chr(34)&",vbCritical,"&Chr(34)&"Falha ao tentar iniciar!"&Chr(34)&""
Set objFSO = Nothing
Set objRead = Nothing
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ErroITimeout.vbs", 2, True)
objRead.WriteLine "msgbox"&Chr(34)&"Erro! Uma outra instância do atualizador desta tradução pode estar aberta!"&Chr(34)&"&Chr(13)&"&Chr(34)&"Caso não haja outra instância aberta: abra o 'Gerenciador de Tarefas' e finalize 'timeout.exe' ou 'Translate Games Timeout'."&Chr(34)&",vbCritical,"&Chr(34)&"Falha ao tentar iniciar!"&Chr(34)&""
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
Erro = 0
If objFSO.Fileexists(z7File) Then objFSO.CopyFile z7File, z7FileT
If objFSO.Fileexists(z7File) Then objFSO.DeleteFile z7File
If (objArgs.Item("silent")) Then
If objFSO.Fileexists(z7File) Then
Set objRead = objFSO.OpenTextFile("RebootSilent.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 300"
objRead.WriteLine "cd ..\"
objRead.WriteLine "CLS"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
objWsh.Run "RebootSilent.bat Init", 0, 0
Set objRead = Nothing
End If
Else
If objFSO.Fileexists(z7File) Then
  Set objOsh = CreateObject("WScript.Shell")
  objOsh.CurrentDirectory = zFile
  Set objFSO2 = CreateObject("Scripting.FileSystemObject")
  Set objRead2 = objFSO2.OpenTextFile("Boot.log", 2, True)
  objRead2.WriteLine "stop"
  Set objFSO2 = Nothing
  Set objRead2 = Nothing
  objOsh.CurrentDirectory = ExtractTo
  objWsh.Run "wscript ErroI7z.vbs", 1, 0
End If
End If
If objFSO.Fileexists(z7File) Then Erro = 1
If NOT objFSO.Fileexists(z7File) Then objFSO.MoveFile z7FileT, z7File
If objFSO.Fileexists(z7File) Then objFSO.DeleteFile z7FileT
If Erro = 1 Then WScript.Quit
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
Erro = 0
If objFSO.Fileexists(AppFile) Then objFSO.CopyFile AppFile, AppFileT
If objFSO.Fileexists(AppFile) Then objFSO.DeleteFile AppFile
If (objArgs.Item("silent")) Then
If objFSO.Fileexists(AppFile) Then
Set objRead = objFSO.OpenTextFile("RebootSilent.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 300"
objRead.WriteLine "cd ..\"
objRead.WriteLine "CLS"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
objWsh.Run "RebootSilent.bat Init", 0, 0
Set objRead = Nothing
End If
Else
If objFSO.Fileexists(AppFile) Then
  Set objOsh = CreateObject("WScript.Shell")
  objOsh.CurrentDirectory = zFile
  Set objFSO2 = CreateObject("Scripting.FileSystemObject")
  Set objRead2 = objFSO2.OpenTextFile("Boot.log", 2, True)
  objRead2.WriteLine "stop"
  Set objFSO2 = Nothing
  Set objRead2 = Nothing
  objOsh.CurrentDirectory = ExtractTo
  objWsh.Run "wscript ErroIApp.vbs", 1, 0
End If
End If
If objFSO.Fileexists(AppFile) Then Erro = 1
If NOT objFSO.Fileexists(AppFile) Then objFSO.MoveFile AppFileT, AppFile
If objFSO.Fileexists(AppFile) Then objFSO.DeleteFile AppFileT
If Erro = 1 Then WScript.Quit
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
Erro = 0
If objFSO.Fileexists(WgetFile) Then objFSO.CopyFile WgetFile, WgetFileT
If objFSO.Fileexists(WgetFile) Then objFSO.DeleteFile WgetFile
If (objArgs.Item("silent")) Then
If objFSO.Fileexists(WgetFile) Then
Set objRead = objFSO.OpenTextFile("RebootSilent.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 300"
objRead.WriteLine "cd ..\"
objRead.WriteLine "CLS"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
objWsh.Run "RebootSilent.bat Init", 0, 0
Set objRead = Nothing
End If
Else
If objFSO.Fileexists(WgetFile) Then
  Set objOsh = CreateObject("WScript.Shell")
  objOsh.CurrentDirectory = zFile
  Set objFSO2 = CreateObject("Scripting.FileSystemObject")
  Set objRead2 = objFSO2.OpenTextFile("Boot.log", 2, True)
  objRead2.WriteLine "stop"
  Set objFSO2 = Nothing
  Set objRead2 = Nothing
  objOsh.CurrentDirectory = ExtractTo
  objWsh.Run "wscript ErroIWget.vbs", 1, 0
End If
End If
If objFSO.Fileexists(WgetFile) Then Erro = 1
If NOT objFSO.Fileexists(WgetFile) Then objFSO.MoveFile WgetFileT, WgetFile
If objFSO.Fileexists(WgetFile) Then objFSO.DeleteFile WgetFileT
If Erro = 1 Then WScript.Quit
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
Erro = 0
If objFSO.Fileexists(WscriptFile) Then objFSO.CopyFile WscriptFile, WscriptFileT
If objFSO.Fileexists(WscriptFile) Then objFSO.DeleteFile WscriptFile
If (objArgs.Item("silent")) Then
If objFSO.Fileexists(WscriptFile) Then
Set objRead = objFSO.OpenTextFile("RebootSilent.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 300"
objRead.WriteLine "cd ..\"
objRead.WriteLine "CLS"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
objWsh.Run "RebootSilent.bat Init", 0, 0
Set objRead = Nothing
End If
Else
If objFSO.Fileexists(WscriptFile) Then
  Set objOsh = CreateObject("WScript.Shell")
  objOsh.CurrentDirectory = zFile
  Set objFSO2 = CreateObject("Scripting.FileSystemObject")
  Set objRead2 = objFSO2.OpenTextFile("Boot.log", 2, True)
  objRead2.WriteLine "stop"
  Set objFSO2 = Nothing
  Set objRead2 = Nothing
  objOsh.CurrentDirectory = ExtractTo
  objWsh.Run "wscript ErroIWscript.vbs", 1, 0
End If
End If
If objFSO.Fileexists(WscriptFile) Then Erro = 1
If NOT objFSO.Fileexists(WscriptFile) Then objFSO.MoveFile WscriptFileT, WscriptFile
If objFSO.Fileexists(WscriptFile) Then objFSO.DeleteFile WscriptFileT
If Erro = 1 Then WScript.Quit
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
Erro = 0
If objFSO.Fileexists(TimeoutFile) Then objFSO.CopyFile TimeoutFile, TimeoutFileT
If objFSO.Fileexists(TimeoutFile) Then objFSO.DeleteFile TimeoutFile
If (objArgs.Item("silent")) Then
If objFSO.Fileexists(TimeoutFile) Then
Set objRead = objFSO.OpenTextFile("RebootSilent.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 300"
objRead.WriteLine "cd ..\"
objRead.WriteLine "CLS"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
objWsh.Run "RebootSilent.bat Init", 0, 0
Set objRead = Nothing
End If
Else
If objFSO.Fileexists(TimeoutFile) Then
  Set objOsh = CreateObject("WScript.Shell")
  objOsh.CurrentDirectory = zFile
  Set objFSO2 = CreateObject("Scripting.FileSystemObject")
  Set objRead2 = objFSO2.OpenTextFile("Boot.log", 2, True)
  objRead2.WriteLine "stop"
  Set objFSO2 = Nothing
  Set objRead2 = Nothing
  objOsh.CurrentDirectory = ExtractTo
  objWsh.Run "wscript ErroITimeout.vbs", 1, 0
End If
End If
If objFSO.Fileexists(TimeoutFile) Then Erro = 1
If NOT objFSO.Fileexists(TimeoutFile) Then objFSO.MoveFile TimeoutFileT, TimeoutFile
If objFSO.Fileexists(TimeoutFile) Then objFSO.DeleteFile TimeoutFileT
If Erro = 1 Then WScript.Quit
Set objFSO = Nothing

UpCore2 = ExtractTo
IntegrityFile = zFile &"\IUpCore.log"
IntegrityCancel = 0

If (objArgs.Item("force")) Then
If objArgs.Item("force") = "extract" Then
IntegrityCancel = 1
End If
End If

If ExecCount = 10 Then
IntegrityCancel = 1
End If

If IntegrityCancel > 0 Then
IntegrityCheck = 1
Else

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(IntegrityFile, 1, False)
D2 = objRead2.ReadAll

D2c = Split(D2, "|")
IntegrityCheck = 0

For Each PD In D2c

If PD = "" Then

Else

PDC = ""

D2b = Split(PD, "$")
   For i = 1 to (Ubound(D2b))
	PD2 = D2b(0)
	PDC = D2b(1)
   Next

If PDC = "" Then

Else

Set objFSO = CreateObject("Scripting.FileSystemObject")
If (objFSO.FileExists(UpCore2&"\"&PD2)) Then
Set objFile = objFSO.GetFile(UpCore2&"\"&PD2)
FSize = objFile.SIZE
PDC = PDC + 1
PDC = PDC - 1
If PDC = FSize Then

Else
IntegrityCheck = IntegrityCheck + 1
End If
Else
IntegrityCheck = IntegrityCheck + 1
End If

Set objFSO = Nothing
Set objRead = Nothing

End If

End If

Next

End If

If IntegrityCheck > 0 Then

If (objArgs.Item("silent")) Then

Else
oShell.CurrentDirectory = CurPath
If (fso.FileExists("App.exe")) Then
If (fso.FileExists("Boot.tgapp")) Then
  objWsh.Run "App.exe """& CurPath &"\Boot.tgapp"" /:Init", 0, 0
End If
End If
End If

oShell.CurrentDirectory = ExtractTo

Dim clean(103)
clean(0)="@echo off"
clean(1)="@set verifica=%1t"
clean(2)="if %verifica%==Initt ("
clean(3)="if exist UpCore ("
clean(4)="CLS"
clean(5)="del UpCore\7z.tmp"
clean(6)="del UpCore\Config.hta"
clean(7)="del UpCore\Config.vbs"
clean(8)="del UpCore\Icon.ico"
clean(9)="del UpCore\Progress.bat"
clean(10)="del UpCore\Progress.hta"
clean(11)="del UpCore\Progress.vbs"
clean(12)="del UpCore\Save.vbs"
clean(13)="del UpCore\Silent.bat"
clean(14)="del UpCore\StartInterf.hta"
clean(15)="del UpCore\timeout.tmp"
clean(16)="del UpCore\UpTranslation.bat"
clean(17)="del UpCore\wget.tmp"
clean(18)="del UpCore\*.tgapp"
clean(19)="del 7z.exe"
clean(20)="del 7z.dll"
clean(21)="del Atualizar.exe"
clean(22)="del Atualizador350.exe"
clean(23)="del Atualizador350-3.exe"
clean(24)="del Atualizador350-4.exe"
clean(25)="del Atualizado.vbs"
clean(26)="del CheckOpen.exe"
clean(27)="del ErroAOpened.vbs"
clean(28)="del ErroCheckOpen.vbs"
clean(29)="del ErroConnection.vbs"
clean(30)="del ErroDownload.vbs"
clean(31)="del ErroIConnection.vbs"
clean(32)="del ErroInstalation.vbs"
clean(33)="del ErroVersion.vbs"
clean(34)="del UpToDate.vbs"
clean(35)="del ErroWget.vbs"
clean(36)="del InitUpdate.vbs"
clean(37)="del update.bat"
clean(38)="del UpdateEncontrado.vbs"
clean(39)="del UpCore.zip"
clean(40)="del Progress.exe"
clean(41)="del Progress.hta"
clean(42)="del Progress.vbs"
clean(43)="del Progress.bat"
clean(44)="del *.dll"
clean(45)="del Start.vbs"
clean(46)="del Silent.exe"
clean(47)="del *.log"
clean(48)="del wget.exe"
clean(49)="del DCBR.exe"
clean(50)="del SSBR.exe"
clean(51)="del W4BR.exe"
clean(52)="del /Q /F /S Silent\*"
clean(53)="rd /Q /S Silent"
clean(54)="del /Q /F /S %TEMP%\*.tmp"
clean(55)="del /Q /F /S /A:H %TEMP%\*.tmp"
clean(56)="del /Q /F /S %TEMP%\Config.hta"
clean(57)="del /Q /F /S /A:H %TEMP%\Config.hta"
clean(58)="del /Q /F /S %TEMP%\Progress.hta"
clean(59)="del /Q /F /S /A:H %TEMP%\Progress.hta"
clean(60)="del /Q /F /S %TEMP%\StartInterf.hta"
clean(61)="del /Q /F /S /A:H %TEMP%\StartInterf.hta"
clean(62)="del /Q /F /S %TEMP%\Icon.ico"
clean(63)="del /Q /F /S /A:H %TEMP%\Icon.ico"
clean(64)="del /Q /F /S %TEMP%\*.bat"
clean(65)="del /Q /F /S /A:H %TEMP%\*.bat"
clean(66)="del /Q /F /S %TEMP%\Config.vbs"
clean(67)="del /Q /F /S /A:H %TEMP%\Config.vbs"
clean(68)="del /Q /F /S %TEMP%\Progress.vbs"
clean(69)="del /Q /F /S /A:H %TEMP%\Progress.vbs"
clean(70)="del /Q /F /S %TEMP%\Save.vbs"
clean(71)="del /Q /F /S /A:H %TEMP%\Save.vbs"
clean(72)="del /Q /F /S %TEMP%\Config.tgapp"
clean(73)="del /Q /F /S /A:H %TEMP%\Config.tgapp"
clean(74)="del /Q /F /S %TEMP%\Progress.tgapp"
clean(75)="del /Q /F /S /A:H %TEMP%\Progress.tgapp"
clean(76)="del /Q /F /S %TEMP%\StartInterf.tgapp"
clean(77)="del /Q /F /S /A:H %TEMP%\StartInterf.tgapp"
clean(78)="del /Q /F /S %TEMP%\*.tgib64"
clean(79)="del /Q /F /S /A:H %TEMP%\*.tgib64"
clean(80)="del /Q /F /S %TEMP%\error.png"
clean(81)="del /Q /F /S /A:H %TEMP%\error.png"
clean(82)="del /Q /F /S %TEMP%\RoutineRestart.vbs"
clean(83)="del /Q /F /S /A:H %TEMP%\RoutineRestart.vbs"
clean(84)="del /Q /F /S %TEMP%\Hash.vbs"
clean(85)="del /Q /F /S /A:H %TEMP%\Hash.vbs"
clean(86)="del /Q /F /S %TEMP%\Hash.exe"
clean(87)="del /Q /F /S /A:H %TEMP%\Hash.exe"
clean(88)="del /Q /F /S %TEMP%\ExtractSize.vbs"
clean(89)="del /Q /F /S /A:H %TEMP%\ExtractSize.vbs"
clean(90)="del UpCore\App.tmp"
clean(91)="del UpCore\Hash.exe"
clean(92)="del UpCore\Hash.vbs"
clean(93)="del UpCore\ImageData.tgib64"
clean(94)="del UpCore\error.png"
clean(95)="del UpCore\wscript.tmp"
clean(96)="del UpCore\RoutineRestart.vbs"
clean(97)="del UpCore\ExtractSize.vbs"
clean(98)="del UpCore\ProgressData.tgpd"
clean(99)="del UpCore\CheckWgetCorrupt.vbs"
clean(100)="CLS"
clean(101)=")"
clean(102)=")"
clean(103)="exit"

oShell.CurrentDirectory = CleanL

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
   For Each cleanT In clean
	objRead.WriteLine(cleanT)
   Next
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("clean.bat")) Then
  objWsh.Run "clean.bat Init", 0, 1
End If

If code = "350" Then
oShell.CurrentDirectory = WinterL

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
   For Each cleanT In clean
	objRead.WriteLine(cleanT)
   Next
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("clean.bat")) Then
  objWsh.Run "clean.bat Init", 0, 1
End If
End If

oShell.CurrentDirectory = zFile
If (fso.FileExists(ZipFile)) Then
  If NOT fso.FolderExists(ExtractTo) Then
     fso.CreateFolder(ExtractTo)
  End If
fso.MoveFile ZipFile, NewZipFile
If (fso.FileExists(NewZipFile)) Then
Set objOsh = CreateObject("WScript.Shell")
objOsh.Run "7z.exe x """& NewZipFile &""" -y -o"""& ExtractTo &"""", 0, 1
Set objFSO = CreateObject("Scripting.FileSystemObject")
objFSO.DeleteFile NewZipFile
Set objFSO = Nothing
Set objOsh = Nothing
Else
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  msgbox"Erro! Está faltando um arquivo necessário! ("& UpCoreNFName &".tgpf)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If
Else
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore.tgpf)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

oShell.CurrentDirectory = zFile

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(z7File) Then objFSO.DeleteFile z7File
If objFSO.Fileexists("7z.exe") Then objFSO.CopyFile "7z.exe", z7File
If objFSO.Fileexists(AppFile) Then objFSO.DeleteFile AppFile
If objFSO.Fileexists("App.exe") Then objFSO.CopyFile "App.exe", AppFile
If objFSO.Fileexists(WscriptFile) Then objFSO.DeleteFile WscriptFile
If objFSO.Fileexists("wscript.exe") Then objFSO.CopyFile "wscript.exe", WscriptFile
Set objFSO = Nothing

oShell.CurrentDirectory = ExtractTo

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(WgetFile) Then objFSO.DeleteFile WgetFile
If objFSO.Fileexists("wget.tmp") Then objFSO.MoveFile "wget.tmp", WgetFile
If objFSO.Fileexists(TimeoutFile) Then objFSO.DeleteFile TimeoutFile
If objFSO.Fileexists("timeout.tmp") Then objFSO.MoveFile "timeout.tmp", TimeoutFile
Set objFSO = Nothing

FileT= "Config.tgapp"
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(FileT, 1, True)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileT, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

FileT= "UpdaterUI.tgapp"
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(FileT, 1, True)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileT, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

End If

If (objArgs.Item("only")) Then
If objArgs.Item("only") = "extract" Then

  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing

  WScript.Quit
End If
End If

If (objArgs.Item("init")) Then
If objArgs.Item("init") = "config" Then

oShell.CurrentDirectory = ExtractTo

If (fso.FileExists("App.exe")) Then
If (fso.FileExists("Config.tgapp")) Then
  If IntegrityCheck > 0 Then
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objFile = objFSO.GetFile("App.exe")
  AppTGLocation = objFile.Path
  Set objFSO = Nothing
  Set objRead = Nothing
  Set objWMIService2 = GetObject("winmgmts:\\.\root\cimv2")
  Set colProcessList = objWMIService2.ExecQuery("Select * from Win32_Process Where Name = 'App.exe'")
For Each objProcess in colProcessList
	Location = objProcess.ExecutablePath
	If Location = AppTGLocation Then
	objProcess.Terminate()
	End If
Next
  End If
  oShell.CurrentDirectory = ExtractTo
  objWsh.Run "App.exe """& ExtractTo &"\Config.tgapp"" /:"& code, 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  If objFSO.Fileexists("Boot.log") Then objFSO.DeleteFile "Boot.log"
  Set objFSO = Nothing
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  oShell.CurrentDirectory = CurPath
  If IntegrityCheck > 0 Then
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  End If
  msgbox"Erro! Está faltando um arquivo necessário! (Config.tgapp)",vbCritical,"Faltando Arquivo!"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  If objFSO.Fileexists("Boot.log") Then objFSO.DeleteFile "Boot.log"
  Set objFSO = Nothing
  Set(objWsh)=Nothing
  WScript.Quit
End If
Else
  oShell.CurrentDirectory = CurPath
  If IntegrityCheck > 0 Then
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  End If
  msgbox"Erro! Está faltando um arquivo necessário! (App.exe)",vbCritical,"Faltando Arquivo!"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  If objFSO.Fileexists("Boot.log") Then objFSO.DeleteFile "Boot.log"
  Set objFSO = Nothing
  Set(objWsh)=Nothing
  WScript.Quit
End If

  WScript.Quit
End If
End If

oShell.CurrentDirectory = ExtractTo
If objArgs.Item("silent") = "silent" Then

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

  WScript.Quit
End If

If (fso.FileExists("UpTranslation.bat")) Then
  If IntegrityCheck > 0 Then
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objFile = objFSO.GetFile("App.exe")
  AppTGLocation = objFile.Path
  Set objFSO = Nothing
  Set objRead = Nothing
  Set objWMIService2 = GetObject("winmgmts:\\.\root\cimv2")
  Set colProcessList = objWMIService2.ExecQuery("Select * from Win32_Process Where Name = 'App.exe'")
For Each objProcess in colProcessList
	Location = objProcess.ExecutablePath
	If Location = AppTGLocation Then
	objProcess.Terminate()
	End If
Next
  End If
  oShell.CurrentDirectory = ExtractTo
  objWsh.Run "UpTranslation.bat "& version &" "& code &" """& GameName &""" "& LimitOp &" "& versionT &" "& UpCoreVersion &" "& UpCoreCVersion, 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.setRequestHeader "User-Agent", "TranslateGamesUpdater/"& UpCoreVersion &" Translation/"& code &" Version/"& versionT &" Sync"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  If objFSO.Fileexists("Boot.log") Then objFSO.DeleteFile "Boot.log"
  Set objFSO = Nothing
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  oShell.CurrentDirectory = CurPath
  If IntegrityCheck > 0 Then
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  End If
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore\UpTranslation.bat)",vbCritical,"Faltando Arquivo!"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  If objFSO.Fileexists("Boot.log") Then objFSO.DeleteFile "Boot.log"
  Set objFSO = Nothing
  Set(objWsh)=Nothing
  WScript.Quit
End If