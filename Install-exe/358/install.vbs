Dim objWsh, fso, strx, GetDecimalChar, Mode, Path, Path2
On Error Resume Next
code="358"

Set objArgs = WScript.Arguments.Named
If (objArgs.Item("Init")) Then
  Mode = "Install"
ElseIf (objArgs.Item("SInit")) Then
  Mode = "Silent"
Else
  msgbox"O Instalador deve ser aberto somente pelo Atualizador!",vbCritical,"Abertura Cancelada!"
  WScript.Quit
End If

REM - Iniciando Configura��o
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
	OSname = replace(OSname,"Microsoft� ","")
	OSname = replace(OSname,"�","")
	OSname = replace(OSname,"�","")
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
REM - Obtendo ou Criando Configura��o
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
REM - In�cio Precau��es
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
REM - Fim Precau��es
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
REM - In�cio config = null
AutoOp = "Ativar"
TimeOp = "10800"
LimitOp = "Ilimitado"
REM - Atualiza��o Autom�tica restrita ao Windows XP ou +
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
REM - Definindo localiza��o da pasta de opera��es da Tradu��o
If code = "350" Then
Path2 = "\Tradu��es de Jogos\Warhammer 40,000 Dawn of War"
GameName = "Warhammer 40,000 Dawn of War e Winter Assault"
DisplayName = "Tradu��o de Dawn of War"
DisplayName2 = "Tradu��o de Dawn of War - Winter Assault"
Comments = "Tradu��o em Portugu�s(BR) para Dawn of War"
Comments2 = "Tradu��o em Portugu�s(BR) para Dawn of War - Winter Assault"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War\InstallLocation")
GameConst = "\W40k.exe"
ElseIf code = "350-3" Then
Path2 = "\Tradu��es de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
GameName = "Warhammer 40,000 Dawn of War - Dark Crusade"
DisplayName = "Tradu��o de Dawn of War - Dark Crusade"
Comments = "Tradu��o em Portugu�s(BR) para Dawn of War - Dark Crusade"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War - Dark Crusade\InstallLocation")
GameConst = "\DarkCrusade.exe"
ElseIf code = "350-4" Then
Path2 = "\Tradu��es de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
GameName = "Warhammer 40,000 Dawn of War - Soulstorm"
DisplayName = "Tradu��o de Dawn of War - Soulstorm"
Comments = "Tradu��o em Portugu�s(BR) para Dawn of War - Soulstorm"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\THQ\Dawn of War - Soulstorm\InstallLocation")
GameConst = "\Soulstorm.exe"
ElseIf code = "356" Then
Path2 = "\Tradu��es de Jogos\Age of Mythology"
GameName = "Age of Mythology"
DisplayName = "Tradu��o de Age of Mythology"
Comments = "Tradu��o em Portugu�s(BR) para Age of Mythology"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Age of Mythology\1.0\AppPath")
GameConst = "\aom.exe"
ElseIf code = "356-2" Then
Path2 = "\Tradu��es de Jogos\Age of Mythology\The Titans Expansion"
GameName = "Age of Mythology The Titans Expansion"
DisplayName = "Tradu��o de Age of Mythology: The Titans Expansion"
Comments = "Tradu��o em Portugu�s(BR) para Age of Mythology: The Titans Expansion"
GameAuto = oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Age of Mythology\1.0\AppPath")
GameConst = "\aomx.exe"
ElseIf code = "357" Then
Path2 = "\Tradu��es de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
GameName = "Warhammer 40,000 Dawn of War II - Retribution"
DisplayName = "Tradu��o de Dawn of War II - Retribution"
Comments = "Tradu��o em Portugu�s(BR) para Dawn of War II - Retribution"
GameAuto = 0
GameConst = "\DOW2.exe"
ElseIf code = "358" Then
Path2 = "\Tradu��es de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
GameName = "Warhammer 40,000 Dawn of War II e Chaos Rising"
DisplayName = "Tradu��o de Dawn of War II e Chaos Rising"
Comments = "Tradu��o em Portugu�s(BR) para Dawn of War II e Chaos Rising"
GameAuto = 0
GameConst = "\DOW2.exe"
End If
Path3 = "\Base da Tradu��es de Jogos"
Path4 = "\Tradu��es de Jogos\Uninstall"
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

Function ActualTime()
dteCurrent = Date()
dteCurrentT = Time()
dteDay = Day(dteCurrent)
dteMonth = Month(dteCurrent)
dteYear = Year(dteCurrent)
dteHour = Hour(dteCurrentT)
dteMinute = Minute(dteCurrentT)
dteSecond = Second(dteCurrentT)
If len(dteDay) = 1 OR dteDay < 10 OR dteDay = 0 Then
dteDay = "0"& CStr(dteDay)
End If
If len(dteMonth) = 1 OR dteMonth < 10 OR dteMonth = 0 Then
dteMonth = "0"& CStr(dteMonth)
End If
If len(dteHour) = 1 OR dteHour < 10 OR dteHour = 0 Then
dteHour = "0"& CStr(dteHour)
End If
If len(dteMinute) = 1 OR dteMinute < 10 OR dteMinute = 0 Then
dteMinute = "0"& CStr(dteMinute)
End If
If len(dteSecond) = 1 OR dteSecond < 10 OR dteSecond = 0 Then
dteSecond = "0"& CStr(dteSecond)
End If
dteDateTime = dteDay&"/"&dteMonth&"/"&dteYear&"-"&dteHour&":"&dteMinute&":"&dteSecond
ActualTime = dteDateTime
End Function

Function WriteLog(txt)
If Mode = "Silent" Then
FileU = Path & Path2 &"\UpCore\UpSilent\UpdateLog.txt"
Else
FileU = Path & Path2 &"\UpCore\UpdateLog.txt"
End If
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine ActualTime()&" "&txt
Set objFSO = Nothing
Set objRead = Nothing
End Function

Function WriteN(txt,file)
FileU = file
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
objRead.WriteLine txt
Set objFSO = Nothing
Set objRead = Nothing
End Function

Function ReadF(file)
FileU = file
Set objFSO = CreateObject("Scripting.FileSystemObject")
If (objFSO.FileExists(FileU)) Then
Set objRead = objFSO.OpenTextFile(FileU, 1, False)
Data = objRead.ReadLine
Set objRead = Nothing
Else
Data = ""
End If
Set objFSO = Nothing
Data = Replace(Data,vbCrLf,"")
ReadF = Data
End Function

Instalation = Path & Path2 &"\UpCore\UpInstalation"
If NOT fso.FolderExists(Instalation) Then
   fso.CreateFolder(Instalation)
End If
oShell.CurrentDirectory = Instalation
FileDF = Instalation &"\InstallData.tgdf"
FileU = Path & Path2 &"\UpCore\StatusP.log"
If (fso.FileExists(FileDF)) Then
DInstall = ReadF(FileDF)
DInstallc = Split(DInstall, "!=!.!=!")
   For i = 1 to (Ubound(DInstallc))
	code2 = DInstallc(0)
	Version = DInstallc(1)
	EstimatedSize = DInstallc(2)
	EstimatedSize2 = DInstallc(3)
   Next
If NOT code2 = code Then
Temp = WriteN("stop",FileU)
msgbox "O Arquivo de Dados n�o passou na valida��o!",vbCritical,"Arquivo Inv�lido!"
WScript.Quit
End If
Else
Temp = WriteN("stop",FileU)
msgbox "Um Arquivo necess�rio n�o foi encontrado.(InstallData.tgdf)",vbCritical,"Faltando Arquivo!"
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
Temp = WriteLog("N�o foi poss�vel detectar "& GameName &" nesta pasta! ("& Destination &")")
Temp = WriteLog("Tentando obter localiza��o autom�ticamente...")
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
Temp = WriteLog("N�o foi poss�vel detectar "& GameName &" autom�ticamente!")
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
REM - Destino n�o dispon�vel (Sele��o de Pasta)
File = Path & Path2 &"\UpCore\StatusP.log"
Temp = WriteN("fselect",File)
If LocatedD = "No" Then
Message = "N�o foi poss�vel obter o diret�rio do Jogo!"
ElseIf LocatedD = "Yes" Then
Message = "Jogo n�o detectado nesta pasta!"
ElseIf LocatedD = "AutoNo" Then
Message = "N�o foi poss�vel obter o diret�rio do Jogo!"
ElseIf LocatedD = "AutoYes" Then
Message = "Jogo n�o detectado na pasta definida no registro!"
End If
Set Bff = objShell.BrowseForFolder(0, Message &Chr(13)&"Selecione a pasta onde "& GameName &" est� instalado:",&H0001 + &H0200)
If NOT (Bff Is Nothing) Then
FolderPath = Bff.Self.Path
FileC = FolderPath & GameConst
oShell.CurrentDirectory = FolderPath
If (fso.FileExists(FileC)) Then
  oShell.CurrentDirectory = Instalation
  Destination = FolderPath
Else
  oShell.CurrentDirectory = Instalation
resultado = msgbox("O Jogo n�o foi detectado nesta pasta!"&Chr(13)&"Tentar Novamente?"&Chr(13)&Chr(13)&"Clique em 'Sim' para tentar novamente ou 'N�o' para Sair.",vbYesNo,"Pasta Inv�lida!") 
If resultado = vbYes Then
  oShell.Run "Install.exe /Q /T:""%TEMP%\Installer-"& code &"-"& RString &".tmp"" /C:""wscript Install.vbs /Init:Start""", 1, 0
  WScript.Quit
Else
Temp = WriteN("stop",File)
  WScript.Quit
End If
End If
Else
resultado = msgbox("Deseja realmente cancelar?"&Chr(13)&Chr(13)&"Clique em 'Sim' para Cancelar ou 'N�o' para tentar novamente.",vbYesNo,"Cancelar?") 
If resultado = vbNo Then
  oShell.Run "Install.exe /Q /T:""%TEMP%\Installer-"& code &"-"& RString &".tmp"" /C:""wscript Install.vbs /Init:Start""", 1, 0
  WScript.Quit
Else
Temp = WriteN("stop",File)
  WScript.Quit
End If
End If
End If
File = Path & Path2 &"\UpCore\StatusP.log"
Temp = WriteN("ipinit",File)
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
Publisher = "Tradu��es de Jogos�"
DisplayIcon = InstallL2 & GameConst
If code = "350" Then
DisplayIcon2 = InstallL2 &"\W40kWA.exe"
End If
If code = "350" Then
UninstallString = Path &"\Tradu��es de Jogos\Uninstall\Warhammer 40,000 Dawn of War\Uninstall.exe"
UninstallString2 = Path &"\Tradu��es de Jogos\Uninstall\Warhammer 40,000 Dawn of War - Winter Assault\Uninstall.exe"
Else
UninstallString = Path &"\Tradu��es de Jogos\Uninstall\"& GameName &"\Uninstall.exe"
End If
NoRepair = "1"
NoModify = "1"
URLInfoAbout = "http://www.sourceforge.net/projects/translategames"
RunTG = """"& Path & Path2 &"\Start.exe"""
PostData = "UID="& UniqueCode &"&code="& code &"&version="& version &"&OSversion="& OSversionA &"&OSarq="& WinArq &"&OSname="& OSname &"&SYSname="& SYSname &"&Memory="& Memory &"&config="& AutoOP &"|.|"& TimeOP &"|.|"& LimitOp

Temp = WriteLog("Mapeando Pastas...")

fso.CreateFolder Base
fso.CreateFolder Base&"\GameRanger"
fso.CreateFolder OPFolder&"\Settings"
fso.CreateFolder OPFolder&"\Settings\Images"
fso.CreateFolder Destination&"\GameAssets"
fso.CreateFolder Destination&"\GameAssets\Locale"
fso.CreateFolder Destination&"\GameAssets\Locale\English"
fso.CreateFolder Destination&"\GameAssets\Locale\French"
fso.CreateFolder Destination&"\GameAssets\Locale\German"
fso.CreateFolder Destination&"\GameAssets\Locale\Italian"
fso.CreateFolder Destination&"\GameAssets\Locale\Spanish"
fso.CreateFolder Uninstall&"\Warhammer 40,000 Dawn of War II e Chaos Rising"

Temp = WriteLog("Finalizando Processos...")

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

Dim Install(12)
Install(0) = "5|.|Processando Atualizador...|.|Start.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(1) = "10|.|Processando Atualizador...|.|Update.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(2) = "25|.|Processando Atualizador...|.|Config.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(3) = "30|.|Processando Atualizador...|.|AutoPlay.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(4) = "35|.|Processando Atualizador...|.|AutoPlay.ucs|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(5) = "40|.|Processando Atualizador...|.|autoplay.ini|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(6) = "50|.|Copiando Arquivos...|.|DOW2.bmp|.|"& InstallLocation &"\Settings\Images|.|"& OPFolder &"\Settings\Images|.|"
Install(7) = "65|.|Copiando Arquivos...|.|DOW2 2.ucs|.|"& InstallLocation &"\GameAssets\Locale\English|.|"& Destination &"\GameAssets\Locale\English|.|"
Install(8) = "70|.|Copiando Arquivos...|.|DOW2 2.ucs|.|"& InstallLocation &"\GameAssets\Locale\French|.|"& Destination &"\GameAssets\Locale\French|.|"
Install(9) = "75|.|Copiando Arquivos...|.|DOW2 2.ucs|.|"& InstallLocation &"\GameAssets\Locale\German|.|"& Destination &"\GameAssets\Locale\German|.|"
Install(10) = "80|.|Copiando Arquivos...|.|DOW2 2.ucs|.|"& InstallLocation &"\GameAssets\Locale\Italian|.|"& Destination &"\GameAssets\Locale\Italian|.|"
Install(11) = "85|.|Copiando Arquivos...|.|DOW2 2.ucs|.|"& InstallLocation &"\GameAssets\Locale\Spanish|.|"& Destination &"\GameAssets\Locale\Spanish|.|"
Install(12) = "95|.|Preparando Desinstalador...|.|Uninstall.exe|.|"& InstallLocation &"|.|"& Uninstall &"\Warhammer 40,000 Dawn of War II e Chaos Rising|.|"

FileU = UpCore &"\ProgressT.log"
Temp = WriteN("- Iniciando...",FileU)
FileU = UpCore &"\ProgressBar.log"
Temp = WriteN("-1-2-",FileU)
FileU = UpCore &"\StatusP.log"
Temp = WriteN("IS",FileU)
Temp = WriteLog("Copiando Arquivos...")

ERROS = 0

For Each InstallT In Install

InstallTC = Split(InstallT, "|.|")
   For i = 1 to (Ubound(InstallTC))
	Progress = InstallTC(0)
	ProgressDESC = InstallTC(1)
	File = InstallTC(2)
	FileL = InstallTC(3)
	FileD = InstallTC(4)
	FolderV = InstallTC(5)
   Next

FileO = UpCore &"\ProgressT.log"
Temp = WriteN("- "& ProgressDESC,FileO)

If FolderV = "Folder" Then

Set objFSOI = CreateObject("Scripting.FileSystemObject")
If NOT objFSOI.FolderExists(FileD) Then
  objFSOI.CreateFolder(FileD)
End If
If (objFSOI.FolderExists(FileL&"\"&File)) Then
objFSOI.CopyFolder FileL&"\"&File, FileD&"\"&File, true
Temp = WriteLog("Pasta: "& File &", copiada para: "& FileD)
Else
ERROS = ERROS + 1
Temp = WriteLog("ERRO "& ERROS &": Pasta local n�o encontrada para a instala��o: "&FileL&"\"&File)
End If

Else

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
ERROS = ERROS + 1
Temp = WriteLog("ERRO "& ERROS &": N�o foi poss�vel fazer backup do arquivo no destino: "&FileD&"\"&File)
End If
End If
objFSOI.CopyFile FileL&"\"&File, FileD&"\"&File
If NOT (objFSOI.FileExists(FileD&"\"&File)) Then
objFSOI.MoveFile FileD&"\"&File&".temp", FileD&"\"&File
ERROS = ERROS + 1
Temp = WriteLog("ERRO "& ERROS &": Falha ao copiar arquivo em: "&FileD&"\"&File&", Backup restaurado!")
Else
Temp = WriteLog("Arquivo: "& File &", copiado para: "& FileD)
objFSOI.DeleteFile FileD&"\"&File&".temp"
End If
Else
ERROS = ERROS + 1
Temp = WriteLog("ERRO "& ERROS &": Arquivo local n�o encontrado para a instala��o: "&FileL&"\"&File)
End If
Set objFSOI = Nothing

End If

FileP = UpCore &"\ProgressBar.log"
Temp = WriteN("-"& Progress &"-2-",FileP)

Next

If ERROS > 0 Then

FileU = UpCore &"\ProgressT.log"
Temp = WriteN("- Ocorreram "& ERROS &" erro(s) durante a instala��o!",FileU)
Temp = WriteLog("Ocorreram "& ERROS &" erro(s) durante a instala��o.")
Temp = WriteLog("A Instala��o n�o foi conclu�da.")
FileU = UpCore &"\ProgressBar.log"
Temp = WriteN("-100-21-",FileU)

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
Temp = WriteN("- Atualizando Registro...",FileU)
Temp = WriteLog("Atualizando Registro...")

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
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\HasInstalled", "1", "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-2)\HasInstalled", "1", "REG_SZ"
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
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\HasInstalled", "1", "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\EstimatedSize", EstimatedSize, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UninstallString", UninstallString, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\NoRepair", NoRepair, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\NoModify", NoModify, "REG_DWORD"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\URLInfoAbout", URLInfoAbout, "REG_SZ"
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\TranslateGames("& code &")", RunTG, "REG_SZ"
End If

Temp = WriteLog("Criando Atalhos...")

PathProgramData = oShell.ExpandEnvironmentStrings("%PROGRAMDATA%")
PathStartMenu = PathProgramData &"\Microsoft\Windows\Start Menu\Programs\Tradu��es de Jogos"
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
fso.DeleteFile PathSMTranslation&"\Configurar Tradu��o.lnk"
fso.DeleteFile PathSMTranslationW&"\Configurar Tradu��o.lnk"

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Atualizar Tradu��o.lnk")
lnk.TargetPath = OPFolder&"\Update.exe"
lnk.Arguments = ""
lnk.Description = "Atualizar Tradu��o"
lnk.IconLocation = OPFolder&"\Update.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Configurar Atualizador.lnk")
lnk.TargetPath = OPFolder&"\Config.exe"
lnk.Arguments = ""
lnk.Description = "Configurar Tradu��o"
lnk.IconLocation = OPFolder&"\Config.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Op��es.lnk")
lnk.TargetPath = OPFolder&"\Installer.exe"
lnk.Arguments = ""
lnk.Description = "Op��es"
lnk.IconLocation = OPFolder&"\Installer.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Desinstalar Tradu��o.lnk")
lnk.TargetPath = Uninstall &"\Warhammer 40,000 Dawn of War\Uninstall.exe"
lnk.Arguments = ""
lnk.Description = "Desinstalar Tradu��o"
lnk.IconLocation = Uninstall &"\Warhammer 40,000 Dawn of War\Uninstall.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = Uninstall &"\Warhammer 40,000 Dawn of War"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Atualizar Tradu��o.lnk")
lnk.TargetPath = OPFolder&"\Winter Assault\Update.exe"
lnk.Arguments = ""
lnk.Description = "Atualizar Tradu��o"
lnk.IconLocation = OPFolder&"\Winter Assault\Update.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder&"\Winter Assault"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Configurar Atualizador.lnk")
lnk.TargetPath = OPFolder&"\Winter Assault\Config.exe"
lnk.Arguments = ""
lnk.Description = "Configurar Tradu��o"
lnk.IconLocation = OPFolder&"\Winter Assault\Config.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder&"\Winter Assault"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Op��es.lnk")
lnk.TargetPath = OPFolder&"\Winter Assault\AutoPlay.exe"
lnk.Arguments = ""
lnk.Description = "Op��es"
lnk.IconLocation = OPFolder&"\Winter Assault\AutoPlay.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder&"\Winter Assault"
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslationW&"\Desinstalar Tradu��o.lnk")
lnk.TargetPath = Uninstall &"\Warhammer 40,000 Dawn of War - Winter Assault\Uninstall.exe"
lnk.Arguments = ""
lnk.Description = "Desinstalar Tradu��o"
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
fso.DeleteFile PathSMTranslation&"\Configurar Tradu��o.lnk"

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Atualizar Tradu��o.lnk")
lnk.TargetPath = OPFolder&"\Update.exe"
lnk.Arguments = ""
lnk.Description = "Atualizar Tradu��o"
lnk.IconLocation = OPFolder&"\Update.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Configurar Atualizador.lnk")
lnk.TargetPath = OPFolder&"\Config.exe"
lnk.Arguments = ""
lnk.Description = "Configurar Tradu��o"
lnk.IconLocation = OPFolder&"\Config.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Op��es.lnk")
lnk.TargetPath = OPFolder&"\AutoPlay.exe"
lnk.Arguments = ""
lnk.Description = "Op��es"
lnk.IconLocation = OPFolder&"\AutoPlay.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = OPFolder
lnk.Save
Set lnk = Nothing

Set lnk = oShell.CreateShortcut(PathSMTranslation&"\Desinstalar Tradu��o.lnk")
lnk.TargetPath = Uninstall &"\"& GameName &"\Uninstall.exe"
lnk.Arguments = ""
lnk.Description = "Desinstalar Tradu��o"
lnk.IconLocation = Uninstall &"\"& GameName &"\Uninstall.exe, 0"
lnk.WindowStyle = "1"
lnk.WorkingDirectory = Uninstall &"\"& GameName
lnk.Save
Set lnk = Nothing

End If

FileU = UpCore &"\ProgressT.log"
Temp = WriteN("- Instala��o Conclu�da!",FileU)
Temp = WriteLog("Instala��o Conclu�da!")
FileU = UpCore &"\ProgressBar.log"
Temp = WriteN("-100-2-",FileU)

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