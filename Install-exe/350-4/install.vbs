Dim objWsh, fso, strx, GetDecimalChar, Mode, Path, Path2
On Error Resume Next
code="350-4"

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
DocumentsFolder = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\Personal")
If DocumentsFolder = "" Then
DocumentsFolder = oShell.ExpandEnvironmentStrings("%USERPROFILE%")&"\Documents"
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
msgbox "O Arquivo de Dados não passou na validação!",vbCritical,"Arquivo Inválido!"
WScript.Quit
End If
Else
Temp = WriteN("stop",FileU)
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
Temp = WriteLog("Não foi possível detectar "& GameName &" nesta pasta! ("& Destination &")")
Temp = WriteLog("Tentando obter localização automáticamente...")
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
Temp = WriteLog("Não foi possível detectar "& GameName &" automáticamente!")
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
Temp = WriteN("fselect",File)
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
Temp = WriteN("stop",File)
  WScript.Quit
End If
End If
Else
resultado = msgbox("Deseja realmente cancelar?"&Chr(13)&Chr(13)&"Clique em 'Sim' para Cancelar ou 'Não' para tentar novamente.",vbYesNo,"Cancelar?") 
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

Temp = WriteLog("Mapeando Pastas...")

fso.CreateFolder Base
fso.CreateFolder OPFolder&"\Setings"
fso.CreateFolder OPFolder&"\Setings\Images"
fso.CreateFolder Destination&"\Badges"
fso.CreateFolder Destination&"\Banners"
fso.CreateFolder Destination&"\BugReport"
fso.CreateFolder Destination&"\BugReport\Chinese"
fso.CreateFolder Destination&"\BugReport\Czech"
fso.CreateFolder Destination&"\BugReport\English"
fso.CreateFolder Destination&"\BugReport\French"
fso.CreateFolder Destination&"\BugReport\German"
fso.CreateFolder Destination&"\BugReport\Italian"
fso.CreateFolder Destination&"\BugReport\Korean"
fso.CreateFolder Destination&"\BugReport\Korean_Blood"
fso.CreateFolder Destination&"\BugReport\Polish"
fso.CreateFolder Destination&"\BugReport\Russian"
fso.CreateFolder Destination&"\BugReport\Spanish"
fso.CreateFolder Destination&"\BugReport\Ukraine"
fso.CreateFolder Destination&"\Chaos_Daemons"
fso.CreateFolder Destination&"\Daemons"
fso.CreateFolder Destination&"\DXP2"
fso.CreateFolder Destination&"\DXP2\Locale"
fso.CreateFolder Destination&"\DXP2\Locale\Chinese"
fso.CreateFolder Destination&"\DXP2\Locale\Czech"
fso.CreateFolder Destination&"\DXP2\Locale\English"
fso.CreateFolder Destination&"\DXP2\Locale\French"
fso.CreateFolder Destination&"\DXP2\Locale\German"
fso.CreateFolder Destination&"\DXP2\Locale\Italian"
fso.CreateFolder Destination&"\DXP2\Locale\Korean"
fso.CreateFolder Destination&"\DXP2\Locale\Korean_Blood"
fso.CreateFolder Destination&"\DXP2\Locale\Polish"
fso.CreateFolder Destination&"\DXP2\Locale\Russian"
fso.CreateFolder Destination&"\DXP2\Locale\Spanish"
fso.CreateFolder Destination&"\DXP2\Locale\Ukraine"
fso.CreateFolder Destination&"\Engine"
fso.CreateFolder Destination&"\Engine\Locale"
fso.CreateFolder Destination&"\Engine\Locale\Chinese"
fso.CreateFolder Destination&"\Engine\Locale\Czech"
fso.CreateFolder Destination&"\Engine\Locale\English"
fso.CreateFolder Destination&"\Engine\Locale\French"
fso.CreateFolder Destination&"\Engine\Locale\German"
fso.CreateFolder Destination&"\Engine\Locale\Italian"
fso.CreateFolder Destination&"\Engine\Locale\Korean"
fso.CreateFolder Destination&"\Engine\Locale\Korean_Blood"
fso.CreateFolder Destination&"\Engine\Locale\Polish"
fso.CreateFolder Destination&"\Engine\Locale\Russian"
fso.CreateFolder Destination&"\Engine\Locale\Spanish"
fso.CreateFolder Destination&"\Engine\Locale\Ukraine"
fso.CreateFolder Destination&"\GraphicsOptions"
fso.CreateFolder Destination&"\GraphicsOptions\Locale"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Chinese"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Czech"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\English"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\French"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\German"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Italian"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Korean"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Korean_Blood"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Polish"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Russian"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Spanish"
fso.CreateFolder Destination&"\GraphicsOptions\Locale\Ukraine"
fso.CreateFolder Destination&"\inquisition_daemonhunt"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Chinese"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Czech"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\English"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\French"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\German"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Italian"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Korean"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Korean_Blood"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Polish"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Russian"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Spanish"
fso.CreateFolder Destination&"\inquisition_daemonhunt\Locale\Ukraine"
fso.CreateFolder Destination&"\Tyranids"
fso.CreateFolder Destination&"\Tyranids\Locale"
fso.CreateFolder Destination&"\Tyranids\Locale\Chinese"
fso.CreateFolder Destination&"\Tyranids\Locale\Czech"
fso.CreateFolder Destination&"\Tyranids\Locale\English"
fso.CreateFolder Destination&"\Tyranids\Locale\French"
fso.CreateFolder Destination&"\Tyranids\Locale\German"
fso.CreateFolder Destination&"\Tyranids\Locale\Italian"
fso.CreateFolder Destination&"\Tyranids\Locale\Korean"
fso.CreateFolder Destination&"\Tyranids\Locale\Korean_Blood"
fso.CreateFolder Destination&"\Tyranids\Locale\Polish"
fso.CreateFolder Destination&"\Tyranids\Locale\Russian"
fso.CreateFolder Destination&"\Tyranids\Locale\Spanish"
fso.CreateFolder Destination&"\Tyranids\Locale\Ukraine"
fso.CreateFolder Destination&"\UltimateApocalypse"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Chinese"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Czech"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\English"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\French"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\German"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Italian"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Korean"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Korean_Blood"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Polish"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Russian"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Spanish"
fso.CreateFolder Destination&"\UltimateApocalypse\Locale\Ukraine"
fso.CreateFolder Destination&"\UltimateApocalypse_THB"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Chinese"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Czech"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\English"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\French"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\German"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Italian"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Korean"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Korean_Blood"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Polish"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Russian"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Spanish"
fso.CreateFolder Destination&"\UltimateApocalypse_THB\Locale\Ukraine"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Chinese"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Czech"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\English"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\French"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\German"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Italian"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Korean"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Korean_Blood"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Polish"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Russian"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Spanish"
fso.CreateFolder Destination&"\UltimateApocalypse_Tyranids\Locale\Ukraine"
fso.CreateFolder Destination&"\W40k"
fso.CreateFolder Destination&"\W40k\Locale"
fso.CreateFolder Destination&"\W40k\Locale\Chinese"
fso.CreateFolder Destination&"\W40k\Locale\Czech"
fso.CreateFolder Destination&"\W40k\Locale\English"
fso.CreateFolder Destination&"\W40k\Locale\French"
fso.CreateFolder Destination&"\W40k\Locale\German"
fso.CreateFolder Destination&"\W40k\Locale\Italian"
fso.CreateFolder Destination&"\W40k\Locale\Korean"
fso.CreateFolder Destination&"\W40k\Locale\Polish"
fso.CreateFolder Destination&"\W40k\Locale\Russian"
fso.CreateFolder Destination&"\W40k\Locale\Spanish"
fso.CreateFolder Uninstall&"\Warhammer 40,000 Dawn of War - Soulstorm"

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

Dim Install(91)
Install(0) = "1|.|Processando Atualizador...|.|Start.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(1) = "5|.|Processando Atualizador...|.|Update.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(2) = "7|.|Processando Atualizador...|.|Config.exe|.|"& InstallLocation &"|.|"& OPFolder &"|.|"
Install(3) = "10|.|Processando Atualizador...|.|AutoPlay.exe|.|"& InstallLocation &"\Winter Assault\Dark Crusade\Soulstorm|.|"& OPFolder &"|.|"
Install(4) = "11|.|Processando Atualizador...|.|AutoPlay.ucs|.|"& InstallLocation &"\Winter Assault\Dark Crusade\Soulstorm|.|"& OPFolder &"|.|"
Install(5) = "12|.|Processando Atualizador...|.|autoplay.ini|.|"& InstallLocation &"\Winter Assault\Dark Crusade\Soulstorm|.|"& OPFolder &"|.|"
Install(6) = "13|.|Copiando Arquivos...|.|Banner Brazil Badge.tga|.|"& InstallLocation &"\Badges|.|"& Destination &"\Badges|.|"
Install(7) = "14|.|Copiando Arquivos...|.|Brazil Badge.tga|.|"& InstallLocation &"\Badges|.|"& Destination &"\Badges|.|"
Install(8) = "15|.|Copiando Arquivos...|.|Traduções de Jogos Badge.tga|.|"& InstallLocation &"\Badges|.|"& Destination &"\Badges|.|"
Install(9) = "16|.|Copiando Arquivos...|.|Brazil Banner.tga|.|"& InstallLocation &"\Banners|.|"& Destination &"\Banners|.|"
Install(10) = "17|.|Copiando Arquivos...|.|Traduções de Jogos Banner.tga|.|"& InstallLocation &"\Banners|.|"& Destination &"\Banners|.|"
Install(11) = "18|.|Copiando Arquivos...|.|DXP2.bmp|.|"& InstallLocation &"\Winter Assault\Dark Crusade\Soulstorm\Setings\Images|.|"& OPFolder &"\Setings\Images|.|"
Install(12) = "19|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Chinese|.|"& Destination &"\DXP2\Locale\Chinese|.|"
Install(13) = "20|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Czech|.|"& Destination &"\DXP2\Locale\Czech|.|"
Install(14) = "21|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\English|.|"& Destination &"\DXP2\Locale\English|.|"
Install(15) = "22|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\French|.|"& Destination &"\DXP2\Locale\French|.|"
Install(16) = "23|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\German|.|"& Destination &"\DXP2\Locale\German|.|"
Install(17) = "24|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Italian|.|"& Destination &"\DXP2\Locale\Italian|.|"
Install(18) = "25|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Korean|.|"& Destination &"\DXP2\Locale\Korean|.|"
Install(19) = "26|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Korean_Blood|.|"& Destination &"\DXP2\Locale\Korean_Blood|.|"
Install(20) = "27|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Polish|.|"& Destination &"\DXP2\Locale\Polish|.|"
Install(21) = "28|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Russian|.|"& Destination &"\DXP2\Locale\Russian|.|"
Install(22) = "29|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Spanish|.|"& Destination &"\DXP2\Locale\Spanish|.|"
Install(23) = "30|.|Copiando Arquivos...|.|DXP2_VO 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Ukraine|.|"& Destination &"\DXP2\Locale\Ukraine|.|"
Install(24) = "31|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Chinese|.|"& Destination &"\BugReport\Chinese|.|"
Install(25) = "32|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Czech|.|"& Destination &"\BugReport\Czech|.|"
Install(26) = "33|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\English|.|"& Destination &"\BugReport\English|.|"
Install(27) = "34|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\French|.|"& Destination &"\BugReport\French|.|"
Install(28) = "35|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\German|.|"& Destination &"\BugReport\German|.|"
Install(29) = "36|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Italian|.|"& Destination &"\BugReport\Italian|.|"
Install(30) = "37|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Korean|.|"& Destination &"\BugReport\Korean|.|"
Install(31) = "38|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Korean_Blood|.|"& Destination &"\BugReport\Korean_Blood|.|"
Install(32) = "39|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Polish|.|"& Destination &"\BugReport\Polish|.|"
Install(33) = "40|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Russian|.|"& Destination &"\BugReport\Russian|.|"
Install(34) = "41|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Spanish|.|"& Destination &"\BugReport\Spanish|.|"
Install(35) = "42|.|Copiando Arquivos...|.|BugReport 2.ucs|.|"& InstallLocation &"\BugReport\Ukraine|.|"& Destination &"\BugReport\Ukraine|.|"
Install(36) = "43|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Chinese|.|"& Destination &"\Engine\Locale\Chinese|.|"
Install(37) = "44|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Czech|.|"& Destination &"\Engine\Locale\Czech|.|"
Install(38) = "45|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\English|.|"& Destination &"\Engine\Locale\English|.|"
Install(39) = "46|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\French|.|"& Destination &"\Engine\Locale\French|.|"
Install(40) = "47|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\German|.|"& Destination &"\Engine\Locale\German|.|"
Install(41) = "48|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Italian|.|"& Destination &"\Engine\Locale\Italian|.|"
Install(42) = "49|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Korean|.|"& Destination &"\Engine\Locale\Korean|.|"
Install(43) = "50|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Korean_Blood|.|"& Destination &"\Engine\Locale\Korean_Blood|.|"
Install(44) = "51|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Polish|.|"& Destination &"\Engine\Locale\Polish|.|"
Install(45) = "52|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Russian|.|"& Destination &"\Engine\Locale\Russian|.|"
Install(46) = "53|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Spanish|.|"& Destination &"\Engine\Locale\Spanish|.|"
Install(47) = "54|.|Copiando Arquivos...|.|Engine 2.ucs|.|"& InstallLocation &"\Engine\Locale\Ukraine|.|"& Destination &"\Engine\Locale\Ukraine|.|"
Install(48) = "55|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Chinese|.|"& Destination &"\GraphicsOptions\Locale\Chinese|.|"
Install(49) = "56|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Czech|.|"& Destination &"\GraphicsOptions\Locale\Czech|.|"
Install(50) = "57|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\English|.|"& Destination &"\GraphicsOptions\Locale\English|.|"
Install(51) = "58|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\French|.|"& Destination &"\GraphicsOptions\Locale\French|.|"
Install(52) = "59|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\German|.|"& Destination &"\GraphicsOptions\Locale\German|.|"
Install(53) = "60|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Italian|.|"& Destination &"\GraphicsOptions\Locale\Italian|.|"
Install(54) = "61|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Korean|.|"& Destination &"\GraphicsOptions\Locale\Korean|.|"
Install(55) = "62|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Korean_Blood|.|"& Destination &"\GraphicsOptions\Locale\Korean_Blood|.|"
Install(56) = "63|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Polish|.|"& Destination &"\GraphicsOptions\Locale\Polish|.|"
Install(57) = "64|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Russian|.|"& Destination &"\GraphicsOptions\Locale\Russian|.|"
Install(58) = "65|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Spanish|.|"& Destination &"\GraphicsOptions\Locale\Spanish|.|"
Install(59) = "66|.|Copiando Arquivos...|.|GraphicsOptionsUtility 2.ucs|.|"& InstallLocation &"\GraphicsOptions\Locale\Ukraine|.|"& Destination &"\GraphicsOptions\Locale\Ukraine|.|"
Install(60) = "67|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Chinese|.|"& Destination &"\W40k\Locale\Chinese|.|"
Install(61) = "68|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Czech|.|"& Destination &"\W40k\Locale\Czech|.|"
Install(62) = "69|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\English|.|"& Destination &"\W40k\Locale\English|.|"
Install(63) = "70|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\French|.|"& Destination &"\W40k\Locale\French|.|"
Install(64) = "71|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\German|.|"& Destination &"\W40k\Locale\German|.|"
Install(65) = "72|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Italian|.|"& Destination &"\W40k\Locale\Italian|.|"
Install(66) = "73|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Korean|.|"& Destination &"\W40k\Locale\Korean|.|"
Install(67) = "74|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Polish|.|"& Destination &"\W40k\Locale\Polish|.|"
Install(68) = "75|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Russian|.|"& Destination &"\W40k\Locale\Russian|.|"
Install(69) = "76|.|Copiando Arquivos...|.|W40k 2.ucs|.|"& InstallLocation &"\W40k\Locale\Spanish|.|"& Destination &"\W40k\Locale\Spanish|.|"
Install(70) = "77|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Chinese|.|"& Destination &"\DXP2\Locale\Chinese|.|"
Install(71) = "78|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Czech|.|"& Destination &"\DXP2\Locale\Czech|.|"
Install(72) = "79|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\English|.|"& Destination &"\DXP2\Locale\English|.|"
Install(73) = "80|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\French|.|"& Destination &"\DXP2\Locale\French|.|"
Install(74) = "81|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\German|.|"& Destination &"\DXP2\Locale\German|.|"
Install(75) = "82|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Italian|.|"& Destination &"\DXP2\Locale\Italian|.|"
Install(76) = "83|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Korean|.|"& Destination &"\DXP2\Locale\Korean|.|"
Install(77) = "84|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Korean_Blood|.|"& Destination &"\DXP2\Locale\Korean_Blood|.|"
Install(78) = "85|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Polish|.|"& Destination &"\DXP2\Locale\Polish|.|"
Install(79) = "86|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Russian|.|"& Destination &"\DXP2\Locale\Russian|.|"
Install(80) = "87|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Spanish|.|"& Destination &"\DXP2\Locale\Spanish|.|"
Install(81) = "88|.|Copiando Arquivos...|.|DXP2 2.ucs|.|"& InstallLocation &"\DXP2\Locale\Ukraine|.|"& Destination &"\DXP2\Locale\Ukraine|.|"
Install(82) = "89|.|Copiando Arquivos...|.|TranslationInfo.module|.|"& InstallLocation &"|.|"& Destination &"|.|"
Install(83) = "90|.|Copiando Arquivos...|.|Traduções de Jogos Windows Ícone.ico|.|"& InstallLocation &"|.|"& Base &"|.|"
Install(84) = "92|.|Copiando Arquivos...|.|Chaos_Daemons|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(85) = "93|.|Copiando Arquivos...|.|Daemons|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(86) = "94|.|Copiando Arquivos...|.|inquisition_daemonhunt|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(87) = "95|.|Copiando Arquivos...|.|Tyranids|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(88) = "96|.|Copiando Arquivos...|.|UltimateApocalypse|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(89) = "97|.|Copiando Arquivos...|.|UltimateApocalypse_THB|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(90) = "98|.|Copiando Arquivos...|.|UltimateApocalypse_Tyranids|.|"& InstallLocation &"|.|"& Destination &"|.|Folder"
Install(91) = "99|.|Preparando Desinstalador...|.|Uninstall.exe|.|"& InstallLocation &"|.|"& Uninstall &"\Warhammer 40,000 Dawn of War - Soulstorm|.|"

FileU = UpCore &"\ProgressT.log"
Temp = WriteN("- Iniciando...",FileU)
FileU = UpCore &"\ProgressBar.log"
Temp = WriteN("-1-2-",FileU)
FileU = UpCore &"\StatusP.log"
Temp = WriteN("IS",FileU)
Temp = WriteLog("Copiando Arquivos...")

ERROS = 0
NOVIFERROS = 0

For Each InstallT In Install

InstallTC = Split(InstallT, "|.|")
   For i = 1 to (Ubound(InstallTC))
	Progress = InstallTC(0)
	ProgressDESC = InstallTC(1)
	File = InstallTC(2)
	FileL = InstallTC(3)
	FileD = InstallTC(4)
	FolderV = InstallTC(5)
	NoVIF = InstallTC(6)
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
If NoVIF = "NOVIF" Then
NOVIFERROS = NOVIFERROS + 1
End If
Temp = WriteLog("ERRO "& ERROS &": Pasta local não encontrada para a instalação: "&FileL&"\"&File)
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
If NoVIF = "NOVIF" Then
NOVIFERROS = NOVIFERROS + 1
End If
Temp = WriteLog("ERRO "& ERROS &": Não foi possível fazer backup do arquivo no destino: "&FileD&"\"&File)
End If
End If
objFSOI.CopyFile FileL&"\"&File, FileD&"\"&File
If NOT (objFSOI.FileExists(FileD&"\"&File)) Then
objFSOI.MoveFile FileD&"\"&File&".temp", FileD&"\"&File
ERROS = ERROS + 1
If NoVIF = "NOVIF" Then
NOVIFERROS = NOVIFERROS + 1
End If
Temp = WriteLog("ERRO "& ERROS &": Falha ao copiar arquivo em: "&FileD&"\"&File&", Backup restaurado!")
Else
Temp = WriteLog("Arquivo: "& File &", copiado para: "& FileD)
objFSOI.DeleteFile FileD&"\"&File&".temp"
End If
Else
ERROS = ERROS + 1
If NoVIF = "NOVIF" Then
NOVIFERROS = NOVIFERROS + 1
End If
Temp = WriteLog("ERRO "& ERROS &": Arquivo local não encontrado para a instalação: "&FileL&"\"&File)
End If
Set objFSOI = Nothing

End If

FileP = UpCore &"\ProgressBar.log"
Temp = WriteN("-"& Progress &"-2-",FileP)

Next

If NOVIFERROS > 0 Then
Temp = WriteLog("Ocorreram "& NOVIFERROS &" erro(s) em arquivos não importantes.")
End If

If ERROS > NOVIFERROS Then

FileU = UpCore &"\ProgressT.log"
Temp = WriteN("- Ocorreram "& ERROS &" erro(s) durante a instalação!",FileU)
Temp = WriteLog("Ocorreram "& ERROS &" erro(s) durante a instalação.")
Temp = WriteLog("A Instalação não foi concluída.")
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
Temp = WriteN("- Instalação Concluída!",FileU)
Temp = WriteLog("Instalação Concluída!")
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