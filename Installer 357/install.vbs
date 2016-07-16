Dim objWsh, fso
On Error Resume Next
code="357"

Set objArgs = WScript.Arguments.Named
If (objArgs.Item("Init")) Then
  InitStatement = " /init:start"
  Mode = "Install"
ElseIf (objArgs.Item("SInit")) Then
  InitStatement = " /sinit:start"
  Mode = "Silent"
Else
  WScript.Quit
End If
If WScript.Arguments.length =0 Then
Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "wscript.exe", Chr(34) & _
WScript.ScriptFullName & InitStatement & Chr(34) & " uac", "", "runas", 1
Else

REM - Iniciando Configuração
Set fso = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments.Named
Set objWsh = CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set oShell = CreateObject("WScript.Shell")
Set objShell = CreateObject("Shell.Application")
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
REM - Definindo localização da pasta de operações da Tradução
If code = "350-2" Then
code="350"
End If
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
GameName = "Warhammer 40,000 Dawn of War e Winter Assault"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War\InstallLocation")
GameConst = "\W40k.exe"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
GameName = "Warhammer 40,000 Dawn of War - Dark Crusade"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War - Dark Crusade\InstallLocation")
GameConst = "\DarkCrusade.exe"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
GameName = "Warhammer 40,000 Dawn of War - Soulstorm"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War - Soulstorm\InstallLocation")
GameConst = "\Soulstorm.exe"
ElseIf code = "357" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
GameName = "Warhammer 40,000 Dawn of War II - Retribution"
GameAuto = 0
GameConst = "\DOW2.exe"
ElseIf code = "358" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
GameName = "Warhammer 40,000 Dawn of War II e Chaos Rising"
GameAuto = 0
GameConst = "\DOW2.exe"
End If
Path3 = "\Base da Traduções de Jogos"
Path4 = "\Traduções de Jogos\Uninstall"
If code = "350" Then
Destination = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\InstallLocation")
Else
Destination = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\InstallLocation")
End If
Instalation = Path & Path2 &"\UpCore\UpInstalation"
If NOT fso.FolderExists(Instalation) Then
   fso.CreateFolder(Instalation)
End If
oShell.CurrentDirectory = Instalation
FormSelect = "No"
LocatedD = "No"
If (Destination) Then
LocatedD = "Yes"
FileC = Destination & GameConst
oShell.CurrentDirectory = FolderPath
If (fso.FileExists(FileC)) Then
  oShell.CurrentDirectory = Instalation
Else
  oShell.CurrentDirectory = Instalation
If Mode = "Silent" Then
File = Path & Path2 &"\UpCore\UpSilent\UpdateLog.txt"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 8, True)
  objRead.WriteLine "Não foi possível detectar "& GameName &" nesta pasta! ("& Destination &")"
  Set objFSO = Nothing
  Set objRead = Nothing
  WScript.Quit
End If
FormSelect = "Yes"
End If
Else
LocatedD = "No"
FormSelect = "Yes"
End If
If FormSelect = "Yes" Then
REM - Destino não disponível (Seleção de Pasta)
File = Path & Path2 &"\UpCore\StatusP.log"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 2, True)
  objRead.WriteLine "fselect"
  Set objFSO = Nothing
  Set objRead = Nothing
If LocatedD = "No" Then
Message = "Não foi possível obter o diretório do Jogo!"
ElseIf LocatedD = "Yes" Then
Message = "Jogo não detectado nesta pasta!"
End If
Set Bff = objShell.BrowseForFolder(0, Message &Chr(13)&"Selecione a pasta onde "& GameName &" está instalado:",&H0001 + &H0200)
If NOT (Bff Is Nothing) Then
FolderPath = Bff.Self.Path
FileC = FolderPath & GameConst
oShell.CurrentDirectory = FolderPath
If (fso.FileExists(FileC)) Then
  oShell.CurrentDirectory = Instalation
  Destination = FolderPath
Else
  oShell.CurrentDirectory = Instalation
resultado = msgbox("O Jogo não foi detectado nesta pasta!"&Chr(13)&"Tentar Novamente?"&Chr(13)&Chr(13)&"Clique em 'Sim' para tentar novamente ou 'Não' para Sair.",vbYesNo,"Pasta Inválida!") 
If resultado = vbYes Then
  oShell.Run "Install.vbs /Init:Start", 1, 0
  WScript.Quit
Else
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  WScript.Quit
End If
End If
Else
resultado = msgbox("Deseja realmente cancelar?"&Chr(13)&Chr(13)&"Clique em 'Sim' Cancelar ou 'Não' para tentar novamente.",vbYesNo,"Cancelar?") 
If resultado = vbNo Then
  oShell.Run "Install.vbs /Init:Start", 1, 0
  WScript.Quit
Else
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
  WScript.Quit
End If
End If
End If
File = Path & Path2 &"\UpCore\StatusP.log"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 2, True)
  objRead.WriteLine "ipinit"
  Set objFSO = Nothing
  Set objRead = Nothing
StringL = Destination
StringL = Replace(StringL,"ç","‡")
StringL = Replace(StringL,"õ","ä")
Destination = StringL
StringL = Path2
StringL = Replace(StringL,"ç","‡")
StringL = Replace(StringL,"õ","ä")
Path2 = StringL
StringL = Path3
StringL = Replace(StringL,"ç","‡")
StringL = Replace(StringL,"õ","ä")
Path3 = StringL
StringL = Path4
StringL = Replace(StringL,"ç","‡")
StringL = Replace(StringL,"õ","ä")
Path4 = StringL
Base = Path & Path3
OPFolder = Path & Path2
If Mode = "Silent" Then
UpCore = Path & Path2 &"\UpCore\UpSilent"
Else
UpCore = Path & Path2 &"\UpCore"
End If
Uninstall = Path & Path4

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("cmdinstall.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "@set code="& code
objRead.WriteLine "@set Destination="& Destination
objRead.WriteLine "@set Base="& Base
objRead.WriteLine "@set OPFolder="& OPFolder
objRead.WriteLine "@set UpCore="& Upcore
objRead.WriteLine "@set Uninstall="& Uninstall
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "echo Iniciando..."
objRead.WriteLine "CLS"
objRead.WriteLine "install.bat"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("cmdinstall.bat")) Then
  objWsh.Run "cmdinstall.bat Init", 0, 0
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  msgbox"Erro! Está faltando um arquivo necessário! (cmdinstall.bat)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If

End If