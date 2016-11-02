Dim objWsh, fso
On Error Resume Next
code="357"
ssvr="https://www.cubbyusercontent.com/pl/update.temp/_7ac2c696d289411ab5d81115ad5ccc06"

REM - Iniciando Configuração
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
Set oShell = CreateObject("WScript.Shell")
oShell.CurrentDirectory = CurPath
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
objRead.WriteLine "0"
Set objFSO = Nothing
Set objRead = Nothing
Set fso = CreateObject("Scripting.FileSystemObject")
Set objWsh = CreateObject("WScript.Shell")
Set objArgs = WScript.Arguments.Named
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
If (objArgs.Item("silent")) Then

Else
If (fso.FileExists("Boot.tgapp")) Then
  objWsh.Run "App.exe """& CurPath &"\Boot.tgapp"" /:Init", 0, 0
End If
End If
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set colComputerSystems = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
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
version = "UNINSTALLED"
End If
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
ElseIf code = "357" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
GameName = "Warhammer 40,000 Dawn of War II - Retribution"
GameConst = "\DOW2.exe"
ElseIf code = "358" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
GameName = "Warhammer 40,000 Dawn of War II e Chaos Rising"
GameConst = "\DOW2.exe"
End If
PathTG = "\Traduções de Jogos"
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
If (objArgs.Item("silent")) Then
If AutoOp = "Desativar" Then
  WScript.Quit
End If
ZipFile= CurPath &"\UpCore.zip"
ExtractTo= Path & Path2 &"\UpCore"
CleanL= Path & Path2
TGL= Path & PathTG
If code = "350" Then
WinterL= Path & Path2W
End If
zFile= CurPath
Else
ZipFile= CurPath &"\UpCore.zip"
ExtractTo= Path & Path2 &"\UpCore"
CleanL= Path & Path2
TGL= Path & PathTG
If code = "350" Then
WinterL= Path & Path2W
End If
zFile= CurPath
End If
PostData = "UID="& UniqueCode &"&code="& code &"&version="& versionT &"&OSversion="& OSversionA &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP
UpCoreNFName= "UpCore-"& RString
NewZipFile= CurPath &"\"& UpCoreNFName &".zip"
If NOT fso.FolderExists(TGL) Then
  fso.CreateFolder(TGL)
End If
If NOT fso.FolderExists(CleanL) Then
  fso.CreateFolder(CleanL)
End If

Dim clean(82)
clean(0)="@echo off"
clean(1)="@set verifica=%1t"
clean(2)="if %verifica%==Initt ("
clean(3)="if exist UpCore ("
clean(4)="CLS"
clean(5)="del UpCore\7z.exe"
clean(6)="del UpCore\Config.hta"
clean(7)="del UpCore\Config.vbs"
clean(8)="del UpCore\Icon.ico"
clean(9)="del UpCore\Progress.bat"
clean(10)="del UpCore\Progress.hta"
clean(11)="del UpCore\Progress.vbs"
clean(12)="del UpCore\Save.vbs"
clean(13)="del UpCore\Silent.bat"
clean(14)="del UpCore\StartInterf.hta"
clean(15)="del UpCore\timeout.exe"
clean(16)="del UpCore\UpTranslation.bat"
clean(17)="del UpCore\wget.exe"
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
clean(54)="del /Q /F /S %TEMP%\*.exe"
clean(55)="del /Q /F /S /A:H %TEMP%\*.exe"
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
clean(78)="del UpCore\App.exe"
clean(79)="CLS"
clean(80)=")"
clean(81)=")"
clean(82)="exit"

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
  set objShell = CreateObject("Shell.Application")
  set FilesInZip=objShell.NameSpace(NewZipFile).items
  objShell.NameSpace(ExtractTo).CopyHere FilesInZip, 4 + 16
  Set objShell = Nothing
Else
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  msgbox"Erro! Está faltando um arquivo necessário! ("& UpCoreNFName &".zip)",vbCritical,"Faltando Arquivo!"
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
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore.zip)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

If (objArgs.Item("only")) Then
If objArgs.Item("only") = "extractCore" Then

  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing

If (objArgs.Item("init")) Then
If objArgs.Item("init") = "config" Then

oShell.CurrentDirectory = ExtractTo
If (fso.FileExists("Config.tgapp")) Then
  objWsh.Run "App.exe """& ExtractTo &"\Config.tgapp"" /:"& code, 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  msgbox"Erro! Está faltando um arquivo necessário! (Config.vbs)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

End If
End If

  WScript.Quit
End If
End If

oShell.CurrentDirectory = ExtractTo
If objArgs.Item("silent") = "silent" Then

If (fso.FileExists("Silent.bat")) Then
  objWsh.Run "Silent.bat "& version &" "& code &" "& TimeOp &" "& ssvr, 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  'Set fso = Nothing
  'Set(objWsh)=Nothing
Else
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore\Silent.bat)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

  WScript.Quit
End If

If (fso.FileExists("UpTranslation.bat")) Then
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  oShell.CurrentDirectory = ExtractTo
  objWsh.Run "UpTranslation.bat "& version &" "& code &" "& ssvr &" """& GameName &"""", 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  'Set fso = Nothing
  'Set(objWsh)=Nothing
Else
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  msgbox"Erro! Está faltando um arquivo necessário! (UpCore\UpTranslation.bat)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

REM - TEMPStart

Path3 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
Location = Path & Path3
Updater = Path & Path3 &"\Update.exe"
UStart = Path & Path3 &"\Start.exe"
UConfig = Path & Path3 &"\Config.exe"
Wget = ExtractTo &"\wget.exe"
Wget2 = Path & Path3 &"\wget.exe"
TFile = Path & Path3 &"\Update.zip"
oShell.CurrentDirectory = Location
versionT = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(358)\DisplayVersion")
If (versionT) Then
version = Replace(VersionT, ".", "")
Else
WScript.Quit
End If
If version < 1000486 Then

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(TFile) Then objFSO.DeleteFile TFile
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(Wget2) Then objFSO.DeleteFile Wget2
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(Wget) Then objFSO.CopyFile Wget, Wget2
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(Wget2) Then objWsh.Run "wget.exe http://translategames.tk/updater/358/updater --output-document=Update.zip --no-check-certificate --timeout=5 --tries=1", 0, 1
Set objFSO = Nothing

If (fso.FileExists(TFile)) Then
Set objFSO = Createobject("Scripting.FileSystemObject")
objFSO.DeleteFile Updater
objFSO.DeleteFile UStart
objFSO.DeleteFile UConfig
Set objFSO = Nothing
  set objShell = CreateObject("Shell.Application")
  set TFilesInZip=objShell.NameSpace(TFile).items
  objShell.NameSpace(Location).CopyHere TFilesInZip, 4 + 16
  Set objShell = Nothing
Else
  WScript.Quit
End If

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(UStart) Then objWsh.Run "Start.exe", 0, 0
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(TFile) Then objFSO.DeleteFile TFile
Set objFSO = Nothing

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(Wget2) Then objFSO.DeleteFile Wget2
Set objFSO = Nothing

End If

REM - TEMPFinish