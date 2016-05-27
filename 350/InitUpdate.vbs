Dim objWsh, fso
On Error Resume Next
code="350"
ssvr="https://www.cubbyusercontent.com/pl/update.bat/_d2ff0be6a23a4b33a4bbca832eb4fc4f"

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
If (objArgs.Item("silent")) Then

Else
If (fso.FileExists("Boot.hta")) Then
  objWsh.Run "Boot.hta /:Init", 0, 0
End If
End If
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
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
REM - Obtendo versão da Tradução
If code = "350" Then
version = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayVersion")
ElseIf code = "350-3" Then
version = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\DisplayVersion")
ElseIf code = "350-4" Then
version = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\DisplayVersion")
End If
If (version) Then
version = Replace(Version, ".", "")
Else
version = "UNINSTALLED"
End If
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
Else
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
REM - Definindo localização da pasta de operações da Tradução
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
Path2W = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
End If
If code = "350-2" Then
code="350"
End If
REM - Obtendo ou Criando Configuração
If code = "350" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig")
ElseIf code = "350-3" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\UpConfig")
ElseIf code = "350-4" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\UpConfig")
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
ElseIf code = "350-3" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\UpConfig", Result, "REG_SZ"
ElseIf code = "350-4" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\UpConfig", Result, "REG_SZ"
End If
If code = "350" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig")
ElseIf code = "350-3" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-3)\UpConfig")
ElseIf code = "350-4" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-4)\UpConfig")
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
If code = "350" Then
WinterL= Path & Path2W
End If
zFile= CurPath
Else
ZipFile= CurPath &"\UpCore.zip"
ExtractTo= Path & Path2 &"\UpCore"
CleanL= Path & Path2
If code = "350" Then
WinterL= Path & Path2W
End If
zFile= CurPath
End If

Dim clean(74)
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
clean(18)="del 7z.exe"
clean(19)="del 7z.dll"
clean(20)="del Atualizar.exe"
clean(21)="del Atualizador350.exe"
clean(22)="del Atualizador350-3.exe"
clean(23)="del Atualizador350-4.exe"
clean(24)="del Atualizado.vbs"
clean(25)="del CheckOpen.exe"
clean(26)="del ErroAOpened.vbs"
clean(27)="del ErroCheckOpen.vbs"
clean(28)="del ErroConnection.vbs"
clean(29)="del ErroDownload.vbs"
clean(30)="del ErroIConnection.vbs"
clean(31)="del ErroInstalation.vbs"
clean(32)="del ErroVersion.vbs"
clean(33)="del UpToDate.vbs"
clean(34)="del ErroWget.vbs"
clean(35)="del InitUpdate.vbs"
clean(36)="del update.bat"
clean(37)="del UpdateEncontrado.vbs"
clean(38)="del UpCore.zip"
clean(39)="del Progress.exe"
clean(40)="del Progress.hta"
clean(41)="del Progress.vbs"
clean(42)="del Progress.bat"
clean(43)="del *.dll"
clean(44)="del Start.vbs"
clean(45)="del Silent.exe"
clean(46)="del *.log"
clean(47)="del wget.exe"
clean(48)="del DCBR.exe"
clean(49)="del SSBR.exe"
clean(50)="del W4BR.exe"
clean(51)="del /Q /F /S Silent\*"
clean(52)="rd /Q /S Silent"
clean(53)="del /Q /F /S %TEMP%\*.exe"
clean(54)="del /Q /F /S /A:H %TEMP%\*.exe"
clean(55)="del /Q /F /S %TEMP%\Config.hta"
clean(56)="del /Q /F /S /A:H %TEMP%\Config.hta"
clean(57)="del /Q /F /S %TEMP%\Progress.hta"
clean(58)="del /Q /F /S /A:H %TEMP%\Progress.hta"
clean(59)="del /Q /F /S %TEMP%\StartInterf.hta"
clean(60)="del /Q /F /S /A:H %TEMP%\StartInterf.hta"
clean(61)="del /Q /F /S %TEMP%\Icon.ico"
clean(62)="del /Q /F /S /A:H %TEMP%\Icon.ico"
clean(63)="del /Q /F /S %TEMP%\*.bat"
clean(64)="del /Q /F /S /A:H %TEMP%\*.bat"
clean(65)="del /Q /F /S %TEMP%\Config.vbs"
clean(66)="del /Q /F /S /A:H %TEMP%\Config.vbs"
clean(67)="del /Q /F /S %TEMP%\Progress.vbs"
clean(68)="del /Q /F /S /A:H %TEMP%\Progress.vbs"
clean(69)="del /Q /F /S %TEMP%\Save.vbs"
clean(70)="del /Q /F /S /A:H %TEMP%\Save.vbs"
clean(71)="CLS"
clean(72)=")"
clean(73)=")"
clean(74)="exit"

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
If (fso.FileExists("UpCore.zip")) Then
  If NOT fso.FolderExists(ExtractTo) Then
     fso.CreateFolder(ExtractTo)
  End If
  set objShell = CreateObject("Shell.Application")
  set FilesInZip=objShell.NameSpace(ZipFile).items
  objShell.NameSpace(ExtractTo).CopyHere FilesInZip, 4 + 16
  Set objShell = Nothing
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
If (fso.FileExists("Config.hta")) Then
  objWsh.Run "Config.hta /:"& code, 0, 0
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
  oShell.CurrentDirectory = CurPath
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile("Boot.log", 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  oShell.CurrentDirectory = ExtractTo
  objWsh.Run "UpTranslation.bat "& version &" "& code &" "& ssvr, 0, 0
  Set fso = Nothing
  Set(objWsh)=Nothing
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