Dim objWsh, fso, strx, GetDecimalChar
On Error Resume Next
code="356"

Set objArgs = WScript.Arguments.Named
If (objArgs.Item("Init")) Then
  Mode = "Install"
ElseIf (objArgs.Item("SInit")) Then
  Mode = "Silent"
Else
  msgbox"O Instalador deve ser aberto somente pelo Atualizador!",vbCritical,"Abertura Cancelada!"
  WScript.Quit
End If

REM - Iniciando Configuração
strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
Set fso = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments.Named
Set objWsh = CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set colComputerSystems = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
Set oShell = CreateObject("WScript.Shell")
Set objShell = CreateObject("Shell.Application")
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
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
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
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
If code = "350-2" Then
code="350"
End If
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
REM - Definindo localização da pasta de operações da Tradução
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
GameName = "Warhammer 40,000 Dawn of War e Winter Assault"
DisplayName = "Tradução de Dawn of War"
DisplayName2 = "Tradução de Dawn of War - Winter Assault"
Comments = "Tradução em Português(BR) para Dawn of War"
Comments2 = "Tradução em Português(BR) para Dawn of War - Winter Assault"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War\InstallLocation")
GameConst = "\W40k.exe"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
GameName = "Warhammer 40,000 Dawn of War - Dark Crusade"
DisplayName = "Tradução de Dawn of War - Dark Crusade"
Comments = "Tradução em Português(BR) para Dawn of War - Dark Crusade"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War - Dark Crusade\InstallLocation")
GameConst = "\DarkCrusade.exe"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
GameName = "Warhammer 40,000 Dawn of War - Soulstorm"
DisplayName = "Tradução de Dawn of War - Soulstorm"
Comments = "Tradução em Português(BR) para Dawn of War - Soulstorm"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War - Soulstorm\InstallLocation")
GameConst = "\Soulstorm.exe"
ElseIf code = "356" Then
Path2 = "\Traduções de Jogos\Age of Mythology"
GameName = "Age of Mythology"
DisplayName = "Tradução de Age of Mythology"
Comments = "Tradução em Português(BR) para Age of Mythology"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Age of Mythology\1.0\AppPath")
GameConst = "\aom.exe"
ElseIf code = "356-2" Then
Path2 = "\Traduções de Jogos\Age of Mythology\The Titans Expansion"
GameName = "Age of Mythology The Titans Expansion"
DisplayName = "Tradução de Age of Mythology: The Titans Expansion"
Comments = "Tradução em Português(BR) para Age of Mythology: The Titans Expansion"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Age of Mythology\1.0\AppPath")
GameConst = "\aomx.exe"
ElseIf code = "357" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
GameName = "Warhammer 40,000 Dawn of War II - Retribution"
DisplayName = "Tradução de Dawn of War II - Retribution"
Comments = "Tradução em Português(BR) para Dawn of War II - Retribution"
GameAuto = 0
GameConst = "\DOW2.exe"
ElseIf code = "358" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
GameName = "Warhammer 40,000 Dawn of War II e Chaos Rising"
DisplayName = "Tradução de Dawn of War II e Chaos Rising"
Comments = "Tradução em Português(BR) para Dawn of War II e Chaos Rising"
GameAuto = 0
GameConst = "\DOW2.exe"
End If
Path3 = "\Base da Traduções de Jogos"
Path4 = "\Traduções de Jogos\Uninstall"
If (GameAuto) Then
If (Mid(GameAuto,Len(GameAuto),1) = "/") Then
GameAuto = Mid(GameAuto,1,Len(GameAuto)-1)
End if
If (Mid(GameAuto,Len(GameAuto),1) = "\") Then
GameAuto = Mid(GameAuto,1,Len(GameAuto)-1)
End if
End If
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
FileDF = Instalation &"\InstallData.tgdf"
FileU = Path & Path2 &"\UpCore\StatusP.log"
If (fso.FileExists(FileDF)) Then
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileDF, 1, True)
DInstall = objRead.ReadAll
DInstallc = Split(DInstall, "!=!.!=!")
   For i = 1 to (Ubound(DInstallc))
	code2 = DInstallc(0)
	Version = DInstallc(1)
	EstimatedSize = DInstallc(2)
	EstimatedSize2 = DInstallc(3)
   Next
If NOT code2 = code Then
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(FileU, 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
msgbox "O Arquivo de Dados não passou na validação!",vbCritical,"Arquivo Inválido!"
WScript.Quit
End If
Else
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(FileU, 2, True)
  objRead.WriteLine "stop"
  Set objFSO = Nothing
  Set objRead = Nothing
msgbox "Um Arquivo necessário não foi encontrado.(InstallData.tgdf)",vbCritical,"Faltando Arquivo!"
WScript.Quit
End If
FormSelect = "No"
LocatedD = "No"
AutoSelect = "Yes"
If (Destination) Then
LocatedD = "Yes"
FileC = Destination & GameConst
If (fso.FileExists(FileC)) Then
  oShell.CurrentDirectory = Instalation
AutoSelect = "No"
Else
  oShell.CurrentDirectory = Instalation
If Mode = "Silent" Then
File = Path & Path2 &"\UpCore\UpSilent\UpdateLog.txt"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 8, True)
  objRead.WriteLine "Não foi possível detectar "& GameName &" nesta pasta! ("& Destination &")"
  objRead.WriteLine "Tentando obter localização automáticamente..."
  Set objFSO = Nothing
  Set objRead = Nothing
End If
FormSelect = "Yes"
End If
Else
LocatedD = "No"
FormSelect = "Yes"
End If
If AutoSelect = "Yes" Then
If (GameAuto) Then
LocatedD = "AutoYes"
FileC = GameAuto & GameConst
If (fso.FileExists(FileC)) Then
  oShell.CurrentDirectory = Instalation
Destination = GameAuto
FormSelect = "No"
Else
  oShell.CurrentDirectory = Instalation
If Mode = "Silent" Then
File = Path & Path2 &"\UpCore\UpSilent\UpdateLog.txt"
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objRead = objFSO.OpenTextFile(File, 8, True)
  objRead.WriteLine "Não foi possível detectar "& GameName &" automáticamente!"
  Set objFSO = Nothing
  Set objRead = Nothing
  WScript.Quit
End If
FormSelect = "Yes"
End If
Else
LocatedD = "AutoNo"
FormSelect = "Yes"
End If
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
ElseIf LocatedD = "AutoNo" Then
Message = "Não foi possível obter o diretório do Jogo!"
ElseIf LocatedD = "AutoYes" Then
Message = "Jogo não detectado na pasta definida no registro!"
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
  oShell.Run "Install.exe /Q /T:""%TEMP%\Installer-"& code &"-"& RString &".tmp"" /C:""wscript Install.vbs /Init:Start""", 1, 0
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
resultado = msgbox("Deseja realmente cancelar?"&Chr(13)&Chr(13)&"Clique em 'Sim' para Cancelar ou 'Não' para tentar novamente.",vbYesNo,"Cancelar?") 
If resultado = vbNo Then
  oShell.Run "Install.exe /Q /T:""%TEMP%\Installer-"& code &"-"& RString &".tmp"" /C:""wscript Install.vbs /Init:Start""", 1, 0
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
Base = Path & Path3
OPFolder = Path & Path2
InstallLocation = Path & Path2 &"\UpCore\UpInstalation"
If Mode = "Silent" Then
UpCore = Path & Path2 &"\UpCore\UpSilent"
Else
UpCore = Path & Path2 &"\UpCore"
End If
Uninstall = Path & Path4
If NOT fso.FolderExists(Uninstall) Then
  fso.CreateFolder(Uninstall)
End If
dteCurrent = Date()
dteDay = Day(dteCurrent)
dteMonth = Month(dteCurrent)
dteYear = Year(dteCurrent)
InstallDate = dteYear & dteMonth & dteDay
InstallL2 = Destination
Publisher = "Traduções de Jogos™"
DisplayIcon = InstallL2 & GameConst
If code = "350" Then
DisplayIcon2 = InstallL2 &"\W40kWA.exe"
End If
If code = "350" Then
UninstallString = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War\Uninstall.exe"
UninstallString2 = Path &"\Traduções de Jogos\Uninstall\Warhammer 40,000 Dawn of War - Winter Assault\Uninstall.exe"
Else
UninstallString = Path &"\Traduções de Jogos\Uninstall\"& GameName &"\Uninstall.exe"
End If
NoRepair = "1"
NoModify = "1"
URLInfoAbout = "http://www.sourceforge.net/projects/translategames"
RunTG = """"& Path & Path2 &"\Start.exe"""
PostData = "UID="& UniqueCode &"&code="& code &"&version="& version &"&OSversion="& OSversionA &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP &"|.|"& LimitOp

FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Mapeando Pastas..."
Set objFSO = Nothing
Set objRead = Nothing

fso.CreateFolder Base
fso.CreateFolder Base&"\GameRanger"
fso.CreateFolder OPFolder&"\The Titans Expansion"
fso.CreateFolder OPFolder&"\The Titans Expansion\Settings"
fso.CreateFolder OPFolder&"\The Titans Expansion\Settings\Images"
fso.CreateFolder Destination&"\startup"
fso.CreateFolder Uninstall&"\Age of Mythology"

FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Finalizando Processos..."
Set objFSO = Nothing
Set objRead = Nothing

Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'update.exe'")
For Each objProcess in colProcessList
	objProcess.Terminate()
Next
Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'start.exe'")
For Each objProcess in colProcessList
	objProcess.Terminate()
Next
Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'autoplay.exe'")
For Each objProcess in colProcessList
	objProcess.Terminate()
Next

Dim Install(9)
Install(0) = "10|.|Processando Atualizador...|.|Start.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(1) = "20|.|Processando Atualizador...|.|Update.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(2) = "30|.|Processando Atualizador...|.|Config.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(3) = "40|.|Processando Atualizador...|.|AutoPlay.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(4) = "50|.|Processando Atualizador...|.|AutoPlay.ucs|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(5) = "60|.|Processando Atualizador...|.|autoplay.ini|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(6) = "70|.|Copiando Arquivos...|.|AOM.bmp|.|"& InstallLocation &"\The Titans Expansion\Settings\Images|.|"& OPFolder &"\The Titans Expansion\Settings\Images|.|"
Install(7) = "80|.|Copiando Arquivos...|.|locale.cfg|.|"& InstallLocation &"\startup|.|"& Destination &"\startup|.|"
Install(8) = "90|.|Copiando Arquivos...|.|language.dll|.|"& InstallLocation &"|.|"& Destination &"|.|"
Install(9) = "95|.|Preparando Desinstalador...|.|Uninstall.exe|.|"& InstallLocation &"|.|"& Uninstall &"\Age of Mythology|.|"

FileU = UpCore &"\ProgressT.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "- Iniciando..."
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\ProgressBar.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "-1-2-"
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\StatusP.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "IS"
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Copiando Arquivos..."
Set objFSO = Nothing
Set objRead = Nothing

If NOT (fso.FileExists(Destination&"\startup\locale.cfg.tgbackup")) Then
fso.MoveFile Destination&"\startup\locale.cfg", Destination&"\startup\locale.cfg.tgbackup"
End If

If NOT (fso.FileExists(Destination&"\language.dll.tgbackup")) Then
fso.MoveFile Destination&"\language.dll", Destination&"\language.dll.tgbackup"
End If

ERROS = 0

For Each InstallT In Install

InstallTC = Split(InstallT, "|.|")
   For i = 1 to (Ubound(InstallTC))
	Progress = InstallTC(0)
	ProgressDESC = InstallTC(1)
	File = InstallTC(2)
	FileL = InstallTC(3)
	FileD = InstallTC(4)
   Next

FileO = UpCore &"\ProgressT.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileO, 2, True)
objRead.WriteLine "- "& ProgressDESC
Set objFSO = Nothing
Set objRead = Nothing

Set objFSOI = CreateObject("Scripting.FileSystemObject")
If NOT objFSOI.FolderExists(FileD) Then
  objFSOI.CreateFolder(FileD)
End If
If (objFSOI.FileExists(FileL&"\"&File)) Then
If (objFSOI.FileExists(FileD&"\"&File)) Then
If (objFSOI.FileExists(FileD&"\"&File&".temp")) Then
objFSOI.DeleteFile FileD&"\"&File&".temp"
End If
objFSOI.MoveFile FileD&"\"&File, FileD&"\"&File&".temp"
If (objFSOI.FileExists(FileD&"\"&File)) Then
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
ERROS = ERROS + 1
objRead.WriteLine "ERRO "& ERROS &": Não foi possível fazer backup do arquivo no destino: "&FileD&"\"&File
Set objFSO = Nothing
Set objRead = Nothing
End If
End If
objFSOI.CopyFile FileL&"\"&File, FileD&"\"&File
If NOT (objFSOI.FileExists(FileD&"\"&File)) Then
objFSOI.MoveFile FileD&"\"&File&".temp", FileD&"\"&File
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
ERROS = ERROS + 1
objRead.WriteLine "ERRO "& ERROS &": Falha ao copiar arquivo em: "&FileD&"\"&File&", Backup restaurado!"
Set objFSO = Nothing
Set objRead = Nothing
Else
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Arquivo: "& File &", copiado para: "& FileD
Set objFSO = Nothing
Set objRead = Nothing
objFSOI.DeleteFile FileD&"\"&File&".temp"
End If
Else
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
ERROS = ERROS + 1
objRead.WriteLine "ERRO "& ERROS &": Arquivo local não encontrado para a instalação: "&FileL&"\"&File
Set objFSO = Nothing
Set objRead = Nothing
End If
Set objFSOI = Nothing

FileP = UpCore &"\ProgressBar.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileP, 2, True)
objRead.WriteLine "-"& Progress &"-2-"
Set objFSO = Nothing
Set objRead = Nothing

Next

If ERROS > 0 Then

FileU = UpCore &"\ProgressT.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "- Ocorreram "& ERROS &" erro(s) durante a instalação!"
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Ocorreram "& ERROS &" erro(s) durante a instalação."
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "A Instalação não foi concluída."
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\ProgressBar.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "-100-21-"
Set objFSO = Nothing
Set objRead = Nothing

oShell.CurrentDirectory = Path & Path2 &"\UpCore"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 3"
objRead.WriteLine "del /Q /F /S UpInstalation\*"
objRead.WriteLine "rd /Q /S UpInstalation"
objRead.WriteLine "cd ..\"
objRead.WriteLine "timeout 7"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("clean.bat")) Then
  objWsh.Run "clean.bat Init", 0, 0
  Set fso = Nothing
  Set(objWsh)=Nothing
End If
WScript.Quit

End If

FileU = UpCore &"\ProgressT.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "- Atualizando Registro..."
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Atualizando Registro..."
Set objFSO = Nothing
Set objRead = Nothing

If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayName", DisplayName, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayName", DisplayName2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\Comments", Comments, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\Comments", Comments2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\DisplayIcon", DisplayIcon, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\DisplayIcon", DisplayIcon2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\InstallLocation", InstallL2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\InstallLocation", InstallL2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\EstimatedSize", EstimatedSize2, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UninstallString", UninstallString, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\UninstallString", UninstallString2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames(350)", RunTG, "REG_SZ"
Else
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\DisplayName", DisplayName, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\Comments", Comments, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\DisplayVersion", Version, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\InstallDate", InstallDate, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\DisplayIcon", DisplayIcon, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\InstallLocation", InstallL2, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\Publisher", Publisher, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UninstallString", UninstallString, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames("& code &")", RunTG, "REG_SZ"
End If

FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Criando Atalhos..."
Set objFSO = Nothing
Set objRead = Nothing

PathProgramData = oShell.ExpandEnvironmentStrings("%PROGRAMDATA%")
PathStartMenu = PathProgramData &"\Microsoft\Windows\Start Menu\Programs\Traduções de Jogos"
If NOT fso.FolderExists(PathStartMenu) Then
   fso.CreateFolder(PathStartMenu)
End If
If code = "350" Then
PathSMTranslation = PathStartMenu &"\Warhammer 40,000 Dawn of War"
PathSMTranslationW = PathStartMenu &"\Warhammer 40,000 Dawn of War - Winter Assault"
If NOT fso.FolderExists(PathSMTranslation) Then
   fso.CreateFolder(PathSMTranslation)
End If
If NOT fso.FolderExists(PathSMTranslationW) Then
   fso.CreateFolder(PathSMTranslationW)
End If
fso.DeleteFile PathSMTranslation&"\Configurar Tradução.lnk"
fso.DeleteFile PathSMTranslationW&"\Configurar Tradução.lnk"

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Atualizar Tradução.lnk")
lnk.TargetPath = OPFolder&"\Update.exe"
lnk.Arguments = ""
lnk.Description = "Atualizar Tradução"
lnk.IconLocation = OPFolder&"\Update.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Configurar Atualizador.lnk")
lnk.TargetPath = OPFolder&"\Config.exe"
lnk.Arguments = ""
lnk.Description = "Configurar Tradução"
lnk.IconLocation = OPFolder&"\Config.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Opções.lnk")
lnk.TargetPath = OPFolder&"\Installer.exe"
lnk.Arguments = ""
lnk.Description = "Opções"
lnk.IconLocation = OPFolder&"\Installer.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Desinstalar Tradução.lnk")
lnk.TargetPath = Uninstall &"\Warhammer 40,000 Dawn of War\Uninstall.exe"
lnk.Arguments = ""
lnk.Description = "Desinstalar Tradução"
lnk.IconLocation = Uninstall &"\Warhammer 40,000 Dawn of War\Uninstall.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = Uninstall &"\Warhammer 40,000 Dawn of War"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Atualizar Tradução.lnk")
lnk.TargetPath = OPFolder&"\Winter Assault\Update.exe"
lnk.Arguments = ""
lnk.Description = "Atualizar Tradução"
lnk.IconLocation = OPFolder&"\Winter Assault\Update.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder&"\Winter Assault"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Configurar Atualizador.lnk")
lnk.TargetPath = OPFolder&"\Winter Assault\Config.exe"
lnk.Arguments = ""
lnk.Description = "Configurar Tradução"
lnk.IconLocation = OPFolder&"\Winter Assault\Config.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder&"\Winter Assault"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Opções.lnk")
lnk.TargetPath = OPFolder&"\Winter Assault\AutoPlay.exe"
lnk.Arguments = ""
lnk.Description = "Opções"
lnk.IconLocation = OPFolder&"\Winter Assault\AutoPlay.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder&"\Winter Assault"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Desinstalar Tradução.lnk")
lnk.TargetPath = Uninstall &"\Warhammer 40,000 Dawn of War - Winter Assault\Uninstall.exe"
lnk.Arguments = ""
lnk.Description = "Desinstalar Tradução"
lnk.IconLocation = Uninstall &"\Warhammer 40,000 Dawn of War - Winter Assault\Uninstall.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = Uninstall &"\Warhammer 40,000 Dawn of War - Winter Assault"
lnk.Save
Set lnk = Nothing

Else

PathSMTranslation = PathStartMenu &"\"& GameName
If NOT fso.FolderExists(PathSMTranslation) Then
   fso.CreateFolder(PathSMTranslation)
End If
fso.DeleteFile PathSMTranslation&"\Configurar Tradução.lnk"

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Atualizar Tradução.lnk")
lnk.TargetPath = OPFolder&"\Update.exe"
lnk.Arguments = ""
lnk.Description = "Atualizar Tradução"
lnk.IconLocation = OPFolder&"\Update.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Configurar Atualizador.lnk")
lnk.TargetPath = OPFolder&"\Config.exe"
lnk.Arguments = ""
lnk.Description = "Configurar Tradução"
lnk.IconLocation = OPFolder&"\Config.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Opções.lnk")
lnk.TargetPath = OPFolder&"\AutoPlay.exe"
lnk.Arguments = ""
lnk.Description = "Opções"
lnk.IconLocation = OPFolder&"\AutoPlay.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Desinstalar Tradução.lnk")
lnk.TargetPath = Uninstall &"\"& GameName &"\Uninstall.exe"
lnk.Arguments = ""
lnk.Description = "Desinstalar Tradução"
lnk.IconLocation = Uninstall &"\"& GameName &"\Uninstall.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = Uninstall &"\"& GameName
lnk.Save
Set lnk = Nothing

End If

FileU = UpCore &"\ProgressT.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "- Instalação Concluída!"
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "Instalação Concluída!"
Set objFSO = Nothing
Set objRead = Nothing
FileU = UpCore &"\ProgressBar.log"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine "-100-2-"
Set objFSO = Nothing
Set objRead = Nothing

oShell.CurrentDirectory = Path & Path2 &"\UpCore"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 3"
objRead.WriteLine "del /Q /F /S UpInstalation\*"
objRead.WriteLine "rd /Q /S UpInstalation"
objRead.WriteLine "cd ..\"
objRead.WriteLine "timeout 7"
objRead.WriteLine "start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("clean.bat")) Then
  objWsh.Run "clean.bat Init", 0, 0
  objXMLHTTP.open "POST", "http://translategames.tk/updater/sync", false
  objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  objXMLHTTP.setRequestHeader "User-Agent", "TranslateGamesInstaller/Update Translation/"& code &" Version/"& Version
  objXMLHTTP.send PostData
  Set objXMLHTTP = nothing
  Set fso = Nothing
  Set(objWsh)=Nothing
End If