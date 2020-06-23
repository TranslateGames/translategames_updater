REM *************************************
REM Silent Service v0.7 By TranslateGames
REM *************************************

Dim objWsh, fso, strx, GetDecimalChar, oShell, CurPath, objXMLHTTP, version, code, TimeOp, LimitOp, versionT, UpCoreVersion, UpCoreCVersion, Slimit, useragentstring, ExtractTo, SilentFolder, UpdaterFolder
On Error Resume Next

strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
If GetDecimalChar = "" Then
GetDecimalChar = ","
End If

Set objArgs = WScript.Arguments.Named
If NOT (IsEmpty(objArgs.Item("version"))) Then
If NOT (IsEmpty(objArgs.Item("code"))) Then
If NOT (IsEmpty(objArgs.Item("TimeOp"))) Then
If NOT (IsEmpty(objArgs.Item("LimitOp"))) Then
If NOT (IsEmpty(objArgs.Item("versionT"))) Then
If NOT (IsEmpty(objArgs.Item("UpCoreVersion"))) Then
If NOT (IsEmpty(objArgs.Item("UpCoreCVersion"))) Then
version=objArgs.Item("version")
code=objArgs.Item("code")
TimeOp=objArgs.Item("TimeOp")
LimitOp=objArgs.Item("LimitOp")
versionT=objArgs.Item("versionT")
UpCoreVersion=objArgs.Item("UpCoreVersion")
UpCoreCVersion=objArgs.Item("UpCoreCVersion")
useragentstring="""TranslateGamesUpdater/"&UpCoreVersion&" Translation/"&code&" Version/"&versionT&""""
Else
  WScript.Quit
End If
Else
  WScript.Quit
End If
Else
  WScript.Quit
End If
Else
  WScript.Quit
End If
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
For Each objOperatingSystem in colOperatingSystems
	sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
	sArq = replace(sArq,"-bit","")
	sArq = replace(sArq," bits","")
	sArq = replace(sArq," bit","")
	If sArq = "32" then
		WinArq="32"
	elseif sArq = "64" then
		WinArq="64"
	else
		WinArq="32"
	end if
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
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
If code = "350-2" Then
code="350"
End If
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
ElseIf code = "356" Then
Path2 = "\Traduções de Jogos\Age of Mythology"
ElseIf code = "356-2" Then
Path2 = "\Traduções de Jogos\Age of Mythology\The Titans Expansion"
ElseIf code = "357" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
ElseIf code = "358" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
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

ExtractTo= Path & Path2 &"\UpCore"
SilentFolder= Path & Path2 &"\UpCore\UpSilent"
UpdaterFolder= Path & Path2

If NOT fso.FolderExists(SilentFolder) Then
  fso.CreateFolder(SilentFolder)
End If
StartFunction()

Function ActualTime()
dteCurrent = Date()
dteCurrentT = Time()
dteDay = Day(dteCurrent)
dteMonth = Month(dteCurrent)
dteYear = Year(dteCurrent)
dteHour = Hour(dteCurrentT)
dteMinute = Minute(dteCurrentT)
dteSecond = Second(dteCurrentT)
If len(dteDay) = 1 OR dteDay = 0 Then
dteDay = "0"& CStr(dteDay)
End If
If len(dteMonth) = 1 OR dteMonth = 0 Then
dteMonth = "0"& CStr(dteMonth)
End If
If len(dteHour) = 1 OR dteHour = 0 Then
dteHour = "0"& CStr(dteHour)
End If
If len(dteMinute) = 1 OR dteMinute = 0 Then
dteMinute = "0"& CStr(dteMinute)
End If
If len(dteSecond) = 1 OR dteSecond = 0 Then
dteSecond = "0"& CStr(dteSecond)
End If
dteDateTime = dteDay&"/"&dteMonth&"/"&dteYear&"-"&dteHour&":"&dteMinute&":"&dteSecond
ActualTime = dteDateTime
End Function

Function WriteLog(txt)
FileU = CurPath &"\UpdateLog.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine ActualTime()&" "&txt
Set objFSO = Nothing
Set objRead = Nothing
End Function

Function ReadFS(file)
FileU = file
Set objFSO = CreateObject("Scripting.FileSystemObject")
If (objFSO.FileExists(FileU)) Then
Set objFile = objFSO.GetFile(FileU)
FSize = objFile.SIZE
Else
FSize = 0
End If
FSize = FSize + 1
FSize = FSize - 1
Set objFSO = Nothing
ReadFS = FSize
End Function

Function DeleteF(file)
FileU = file
Set objFSO = CreateObject("Scripting.FileSystemObject")
If (objFSO.FileExists(FileU)) Then
objFSO.DeleteFile FileU
End If
Set objFSO = Nothing
End Function

Function BatchC(txt)
FileU = "temp.bat"
Dim clean(5)
clean(0)="@echo off"
clean(1)="@set verifica=%1t"
clean(2)="if %verifica%==Initt ("
clean(3)=txt
clean(4)=")"
clean(5)="exit"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(FileU, 2, True)
   For Each cleanT In clean
	objRead.WriteLine(cleanT)
   Next
Set objFSO = Nothing
Set objRead = Nothing
If (fso.FileExists("temp.bat")) Then
objWsh.Run "temp.bat Init", 0, 1
fso.DeleteFile FileU
End If
End Function

Function MoveF(file1,file2)
Set objFSO = CreateObject("Scripting.FileSystemObject")
If (objFSO.Fileexists(file1)) Then
If (objFSO.Fileexists(file2)) Then
objFSO.DeleteFile file2
End If
objFSO.MoveFile file1, file2
End If
Set objFSO = Nothing
End Function

Function StartFunction()

oShell.CurrentDirectory = CurPath

If NOT (fso.FileExists("wget.exe")) Then
msgbox"Erro! Está faltando um arquivo necessário! (Wget.exe)",vbCritical,"Faltando Arquivo!"
WScript.Quit
Exit Function
End If

If fso.Fileexists("update.bat") Then fso.DeleteFile "update.bat"
If fso.Fileexists("update.temp") Then fso.DeleteFile "update.temp"
If fso.Fileexists("update.tguf") Then fso.DeleteFile "update.tguf"
If fso.Fileexists("Update.vbs") Then fso.DeleteFile "Update.vbs"
If fso.Fileexists("update.7z") Then fso.DeleteFile "update.7z"

If version = "UNINSTALLED" Then
Temp = WriteLog("A Tradução foi desinstalada!")
WScript.Quit
ElseIf version = "N.INSTALLED" Then
Temp = WriteLog("A Tradução não está instalada!")
WScript.Quit
Else
Temp = WriteLog("Iniciando... Versão: "&versionT)
Init()
End If

Exit Function
End Function

Function Init()
If LimitOp = "Ilimitado" Then
Slimit=""
ElseIf LimitOp = "50k" Then
Slimit=" --limit-rate=50k"
Temp = WriteLog("Velocidade de Download Limitada em: 50 KB/s")
ElseIf LimitOp = "100k" Then
Slimit=" --limit-rate=100k"
Temp = WriteLog("Velocidade de Download Limitada em: 100 KB/s")
ElseIf LimitOp = "300k" Then
Slimit=" --limit-rate=300k"
Temp = WriteLog("Velocidade de Download Limitada em: 300 KB/s")
ElseIf LimitOp = "500k" Then
Slimit=" --limit-rate=500k"
Temp = WriteLog("Velocidade de Download Limitada em: 500 KB/s")
ElseIf LimitOp = "1m" Then
Slimit=" --limit-rate=1m"
Temp = WriteLog("Velocidade de Download Limitada em: 1 MB/s")
ElseIf LimitOp = "2m" Then
Slimit=" --limit-rate=2m"
Temp = WriteLog("Velocidade de Download Limitada em: 2 MB/s")
ElseIf LimitOp = "5m" Then
Slimit=" --limit-rate=5m"
Temp = WriteLog("Velocidade de Download Limitada em: 5 MB/s")
Else
Slimit=""
End If
ConnectionInit()
Exit Function
End Function

Function ConnectionInit()

Temp = WriteLog("Conectando...")
objWsh.Run "wget.exe https://translategames.com.br/updater/"&code&"/tguf --output-document=update.tguf --user-agent="&useragentstring&" --no-check-certificate"&Slimit&" --append-output=UpdateLog.txt --timeout=5 --tries=2", 0, 1

If (fso.FileExists("update.tguf")) Then
fso.MoveFile "update.tguf", "update.7z"
objWsh.Run "7z.exe e update.7z -o.\", 0, 1
If fso.Fileexists("update.7z") Then fso.DeleteFile "update.7z"
End If

If (fso.FileExists("Update.vbs")) Then
InitUP()
Else
Connection2()
End If

Exit Function
End Function

Function Connection2()

If fso.Fileexists("update.bat") Then fso.DeleteFile "update.bat"
If fso.Fileexists("update.temp") Then fso.DeleteFile "update.temp"
If fso.Fileexists("update.tguf") Then fso.DeleteFile "update.tguf"
If fso.Fileexists("Update.vbs") Then fso.DeleteFile "Update.vbs"
If fso.Fileexists("update.7z") Then fso.DeleteFile "update.7z"

objWsh.Run "wget.exe https://raw.githubusercontent.com/TranslateGames/translategames_server/master/Service/"&code&"/update.tguf --output-document=update.tguf --user-agent="&useragentstring&" --no-check-certificate"&Slimit&" --append-output=UpdateLog.txt --timeout=5 --tries=2", 0, 1

If (fso.FileExists("update.tguf")) Then
fso.MoveFile "update.tguf", "update.7z"
objWsh.Run "7z.exe e update.7z -o.\", 0, 1
If fso.Fileexists("update.7z") Then fso.DeleteFile "update.7z"
End If

If (fso.FileExists("Update.vbs")) Then
InitUP2()
Else
Fail()
End If

Exit Function
End Function

Function InitUP()
tamanho = ReadFS("Update.vbs")
If tamanho = 0 Then
Connection2()
Else
Temp = WriteLog("Iniciando Processo de Verificação...")
objWsh.Run "wscript ""Update.vbs"" /version:"&version&" /code:"&code&" /TimeOp:"&TimeOp&" /LimitOp:"&LimitOp&" /versionT:"&versionT&" /UpCoreVersion:"&UpCoreVersion&" /UpCoreCVersion:"&UpCoreCVersion&" /Silent:Silent", 0, 0
WScript.Quit
End If
Exit Function
End Function

Function InitUP2()
tamanho = ReadFS("Update.vbs")
If tamanho = 0 Then
Fail()
Else
Temp = WriteLog("Iniciando Processo de Verificação...")
objWsh.Run "wscript ""Update.vbs"" /version:"&version&" /code:"&code&" /TimeOp:"&TimeOp&" /LimitOp:"&LimitOp&" /versionT:"&versionT&" /UpCoreVersion:"&UpCoreVersion&" /UpCoreCVersion:"&UpCoreCVersion&" /Silent:Silent", 0, 0
WScript.Quit
End If
Exit Function
End Function

Function Fail()
Temp = WriteLog("Falha ao Conectar!")
WScript.Sleep 1800000
oShell.CurrentDirectory = ExtractTo
If (fso.FileExists("RoutineRestart.vbs")) Then
objWsh.Run "wscript ""RoutineRestart.vbs"" /Init:Start /code:"&code&" /upcore:"&UpCoreVersion, 0, 0
Else
oShell.CurrentDirectory = UpdaterFolder
If (fso.FileExists("Update.exe")) Then
objWsh.Run "Update.exe /Q /T:""%TEMP%\Update"& code &"-"& RString &".tmp"" /C:""wscript InitUpdate.vbs /silent:silent""", 0, 0
ElseIf (fso.FileExists("InitUpdate.vbs")) Then
objWsh.Run "wscript ""InitUpdate.vbs"" /silent:silent", 0, 0
start InitUpdate.vbs /silent:silent
End If
End If
WScript.Quit
Exit Function
End Function