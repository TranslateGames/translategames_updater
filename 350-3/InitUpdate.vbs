Dim objWsh, fso
On Error Resume Next
code="350-3"
ssvr="https://www.cubbyusercontent.com/pl/update.bat/_618f4ebc9e8f4311adbe8a584869829e"

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
'REM - Exceção para o Windows XP ou -
'If OSversion < 520000 Then
'fso.DeleteFolder(ExtractTo)
'End If
End If

oShell.CurrentDirectory = CleanL

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "@set verifica=%1t"
objRead.WriteLine "if %verifica%==Initt ("
objRead.WriteLine "if exist UpCore ("
objRead.WriteLine "CLS"
objRead.WriteLine "del UpCore\7z.exe"
objRead.WriteLine "del UpCore\Config.hta"
objRead.WriteLine "del UpCore\Config.vbs"
objRead.WriteLine "del UpCore\Icon.ico"
objRead.WriteLine "del UpCore\Progress.bat"
objRead.WriteLine "del UpCore\Progress.hta"
objRead.WriteLine "del UpCore\Progress.vbs"
objRead.WriteLine "del UpCore\Save.vbs"
objRead.WriteLine "del UpCore\Silent.bat"
objRead.WriteLine "del UpCore\StartInterf.hta"
objRead.WriteLine "del UpCore\timeout.exe"
objRead.WriteLine "del UpCore\UpTranslation.bat"
objRead.WriteLine "del UpCore\wget.exe"
objRead.WriteLine "del 7z.exe"
objRead.WriteLine "del 7z.dll"
objRead.WriteLine "del Atualizar.exe"
objRead.WriteLine "del Atualizador350.exe"
objRead.WriteLine "del Atualizador350-3.exe"
objRead.WriteLine "del Atualizador350-4.exe"
objRead.WriteLine "del Atualizado.vbs"
objRead.WriteLine "del CheckOpen.exe"
objRead.WriteLine "del ErroAOpened.vbs"
objRead.WriteLine "del ErroCheckOpen.vbs"
objRead.WriteLine "del ErroConnection.vbs"
objRead.WriteLine "del ErroDownload.vbs"
objRead.WriteLine "del ErroIConnection.vbs"
objRead.WriteLine "del ErroInstalation.vbs"
objRead.WriteLine "del ErroVersion.vbs"
objRead.WriteLine "del UpToDate.vbs"
objRead.WriteLine "del ErroWget.vbs"
objRead.WriteLine "del InitUpdate.vbs"
objRead.WriteLine "del update.bat"
objRead.WriteLine "del UpdateEncontrado.vbs"
objRead.WriteLine "del UpCore.zip"
objRead.WriteLine "del Progress.exe"
objRead.WriteLine "del Progress.hta"
objRead.WriteLine "del Progress.vbs"
objRead.WriteLine "del Progress.bat"
objRead.WriteLine "del *.dll"
objRead.WriteLine "del Start.vbs"
objRead.WriteLine "del Silent.exe"
objRead.WriteLine "del *.log"
objRead.WriteLine "del wget.exe"
objRead.WriteLine "del DCBR.exe"
objRead.WriteLine "del SSBR.exe"
objRead.WriteLine "del W4BR.exe"
objRead.WriteLine "del /Q /F /S Silent\*"
objRead.WriteLine "rd /Q /S Silent"
objRead.WriteLine "del /Q /F /S %TEMP%\*.exe"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\*.exe"
objRead.WriteLine "del /Q /F /S %TEMP%\Config.hta"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Config.hta"
objRead.WriteLine "del /Q /F /S %TEMP%\Progress.hta"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Progress.hta"
objRead.WriteLine "del /Q /F /S %TEMP%\StartInterf.hta"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\StartInterf.hta"
objRead.WriteLine "del /Q /F /S %TEMP%\Icon.ico"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Icon.ico"
objRead.WriteLine "del /Q /F /S %TEMP%\*.bat"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\*.bat"
objRead.WriteLine "del /Q /F /S %TEMP%\Config.vbs"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Config.vbs"
objRead.WriteLine "del /Q /F /S %TEMP%\Progress.vbs"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Progress.vbs"
objRead.WriteLine "del /Q /F /S %TEMP%\Save.vbs"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Save.vbs"
objRead.WriteLine "CLS"
objRead.WriteLine ")"
objRead.WriteLine ")"
objRead.WriteLine "exit"
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("clean.bat")) Then
  objWsh.Run "clean.bat Init", 0, 1
End If

If code = "350" Then
oShell.CurrentDirectory = WinterL

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "@set verifica=%1t"
objRead.WriteLine "if %verifica%==Initt ("
objRead.WriteLine "if exist UpCore ("
objRead.WriteLine "CLS"
objRead.WriteLine "del UpCore\7z.exe"
objRead.WriteLine "del UpCore\Config.hta"
objRead.WriteLine "del UpCore\Config.vbs"
objRead.WriteLine "del UpCore\Icon.ico"
objRead.WriteLine "del UpCore\Progress.bat"
objRead.WriteLine "del UpCore\Progress.hta"
objRead.WriteLine "del UpCore\Progress.vbs"
objRead.WriteLine "del UpCore\Save.vbs"
objRead.WriteLine "del UpCore\Silent.bat"
objRead.WriteLine "del UpCore\StartInterf.hta"
objRead.WriteLine "del UpCore\timeout.exe"
objRead.WriteLine "del UpCore\UpTranslation.bat"
objRead.WriteLine "del UpCore\wget.exe"
objRead.WriteLine "del 7z.exe"
objRead.WriteLine "del 7z.dll"
objRead.WriteLine "del Atualizar.exe"
objRead.WriteLine "del Atualizador350.exe"
objRead.WriteLine "del Atualizador350-3.exe"
objRead.WriteLine "del Atualizador350-4.exe"
objRead.WriteLine "del Atualizado.vbs"
objRead.WriteLine "del CheckOpen.exe"
objRead.WriteLine "del ErroAOpened.vbs"
objRead.WriteLine "del ErroCheckOpen.vbs"
objRead.WriteLine "del ErroConnection.vbs"
objRead.WriteLine "del ErroDownload.vbs"
objRead.WriteLine "del ErroIConnection.vbs"
objRead.WriteLine "del ErroInstalation.vbs"
objRead.WriteLine "del ErroVersion.vbs"
objRead.WriteLine "del UpToDate.vbs"
objRead.WriteLine "del ErroWget.vbs"
objRead.WriteLine "del InitUpdate.vbs"
objRead.WriteLine "del update.bat"
objRead.WriteLine "del UpdateEncontrado.vbs"
objRead.WriteLine "del UpCore.zip"
objRead.WriteLine "del Progress.exe"
objRead.WriteLine "del Progress.hta"
objRead.WriteLine "del Progress.vbs"
objRead.WriteLine "del Progress.bat"
objRead.WriteLine "del *.dll"
objRead.WriteLine "del Start.vbs"
objRead.WriteLine "del Silent.exe"
objRead.WriteLine "del *.log"
objRead.WriteLine "del wget.exe"
objRead.WriteLine "del DCBR.exe"
objRead.WriteLine "del SSBR.exe"
objRead.WriteLine "del W4BR.exe"
objRead.WriteLine "del /Q /F /S Silent\*"
objRead.WriteLine "rd /Q /S Silent"
objRead.WriteLine "del /Q /F /S %TEMP%\*.exe"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\*.exe"
objRead.WriteLine "del /Q /F /S %TEMP%\Config.hta"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Config.hta"
objRead.WriteLine "del /Q /F /S %TEMP%\Progress.hta"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Progress.hta"
objRead.WriteLine "del /Q /F /S %TEMP%\StartInterf.hta"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\StartInterf.hta"
objRead.WriteLine "del /Q /F /S %TEMP%\Icon.ico"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Icon.ico"
objRead.WriteLine "del /Q /F /S %TEMP%\*.bat"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\*.bat"
objRead.WriteLine "del /Q /F /S %TEMP%\Config.vbs"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Config.vbs"
objRead.WriteLine "del /Q /F /S %TEMP%\Progress.vbs"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Progress.vbs"
objRead.WriteLine "del /Q /F /S %TEMP%\Save.vbs"
objRead.WriteLine "del /Q /F /S /A:H %TEMP%\Save.vbs"
objRead.WriteLine "CLS"
objRead.WriteLine ")"
objRead.WriteLine ")"
objRead.WriteLine "exit"
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
If (fso.FileExists("Config.vbs")) Then
  objWsh.Run "Config.vbs /code:"& code, 0, 0
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