REM **************************************
REM Updater Service v0.9 By TranslateGames
REM **************************************

Dim objWsh, fso, strx, GetDecimalChar, oShell, CurPath, objXMLHTTP, version, code, GameName, LimitOp, versionT, UpCoreVersion, UpCoreCVersion, mode, Slimit, useragentstring, sinterface
On Error Resume Next

strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
If GetDecimalChar = "" Then
GetDecimalChar = ","
End If

Set objArgs = WScript.Arguments.Named
If NOT (IsEmpty(objArgs.Item("version"))) Then
If NOT (IsEmpty(objArgs.Item("code"))) Then
If NOT (IsEmpty(objArgs.Item("GameName"))) Then
If NOT (IsEmpty(objArgs.Item("LimitOp"))) Then
If NOT (IsEmpty(objArgs.Item("versionT"))) Then
If NOT (IsEmpty(objArgs.Item("UpCoreVersion"))) Then
If NOT (IsEmpty(objArgs.Item("UpCoreCVersion"))) Then
version=objArgs.Item("version")
code=objArgs.Item("code")
GameName=objArgs.Item("GameName")
LimitOp=objArgs.Item("LimitOp")
versionT=objArgs.Item("versionT")
UpCoreVersion=objArgs.Item("UpCoreVersion")
UpCoreCVersion=objArgs.Item("UpCoreCVersion")
If NOT (IsEmpty(objArgs.Item("sinterface"))) Then
sinterface=objArgs.Item("sinterface")
Else
sinterface=""
End If
mode="update"
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
ExitS()
Exit Function
End If

If fso.Fileexists("UpdateLog.txt") Then fso.DeleteFile "UpdateLog.txt"
If fso.Fileexists("update.bat") Then fso.DeleteFile "update.bat"
If fso.Fileexists("update.temp") Then fso.DeleteFile "update.temp"
If fso.Fileexists("update.tguf") Then fso.DeleteFile "update.tguf"
If fso.Fileexists("Update.vbs") Then fso.DeleteFile "Update.vbs"
If fso.Fileexists("update.7z") Then fso.DeleteFile "update.7z"

If version = "UNINSTALLED" Then
Temp = WriteLog("Iniciando...")
InstallPrompt()
ElseIf version = "N.INSTALLED" Then
Temp = WriteLog("Iniciando...")
InstallPrompt()
Else
Temp = WriteLog("Iniciando... Versão: "&versionT)
Init()
End If

Exit Function
End Function

Function InstallPrompt()

If sinterface = "NOT" Then
Temp = WriteLog("A Tradução não está instalada!")
Temp = WriteLog("Solicitando a instalação...")
version="1"
mode="install"
Temp = WriteLog("O usuário aceitou a instalação!")
Init()
Exit Function
Else
Temp = WriteLog("A Tradução não está instalada!")
Temp = WriteLog("Solicitando a instalação...")
End If

translationof = GameName
resultado = msgbox("Deseja instalar a Tradução de "& translationof &"?"&Chr(13)&Chr(13)&"Clique em 'Sim' para Baixar e Instalar ou 'Não' para Sair.",vbYesNo,"Tradução não Instalada!")
If resultado = vbYes Then
version="1"
mode="install"
Temp = WriteLog("O usuário aceitou a instalação!")
Init()
Else
Temp = WriteLog("Instalação cancelada pelo usuário!")
ExitS()
End If

Exit Function
End Function

Function Init()
Temp = WriteN("0","Status.log")
Temp = WriteN("0","StatusP.log")
Temp = WriteN("0","StatusPS.log")
Temp = WriteN("0","StatusIS.log")
Temp = WriteN("0","UpCoreFCE.log")
Temp = WriteN("0","ProgressBarS.log")
Temp = WriteN("1-1","ServerS.log")
Temp = WriteN("1","StatusPSC.log")
Temp = WriteN("0","Result.txt")
Temp = WriteN("not","InterfaceMaintainer.log")
Temp = WriteN(mode,"UpdateMode.log")
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

If sinterface = "NOT" Then
Temp = WriteN("ready","StatusIS.log")
ConnectionInit()
Else
objWsh.Run "App.exe """&CurPath&"\UpdaterUI.tgapp"" /:Init /:"&mode&" /:"&code, 0, 0
Temp = WriteLog("Iniciando Interface...")
InterfaceCheck()
End If
Exit Function
End Function

Function InterfaceCheck()
firstline = ReadF("StatusIS.log")
If firstline = "ready" Then
Temp = WriteLog("Interface Iniciada!")
objWsh.Run "wscript ""InterfaceMaintainer.vbs"" /mode:"&mode&" /code:"&code, 0, 0
ConnectionInit()
Else
WScript.Sleep 500
InterfaceCheck()
End If
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

Temp = WriteN("2-1","ServerS.log")
Temp = WriteN("1","StatusPSC.log")

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
Temp = WriteN("1-2","ServerS.log")
Temp = WriteN("2","StatusPSC.log")
Temp = WriteLog("Iniciando Processo de Verificação...")
objWsh.Run "wscript ""Update.vbs"" /version:"&version&" /code:"&code&" /LimitOp:"&LimitOp&" /versionT:"&versionT&" /UpCoreVersion:"&UpCoreVersion&" /UpCoreCVersion:"&UpCoreCVersion&" /sinterface:"&sinterface&" /mode:"&mode, 0, 0
WScript.Quit
End If
Exit Function
End Function

Function InitUP2()
tamanho = ReadFS("Update.vbs")
If tamanho = 0 Then
Fail()
Else
Temp = WriteN("2-2","ServerS.log")
Temp = WriteN("2","StatusPSC.log")
Temp = WriteLog("Iniciando Processo de Verificação...")
objWsh.Run "wscript ""Update.vbs"" /version:"&version&" /code:"&code&" /LimitOp:"&LimitOp&" /versionT:"&versionT&" /UpCoreVersion:"&UpCoreVersion&" /UpCoreCVersion:"&UpCoreCVersion&" /sinterface:"&sinterface&" /mode:"&mode, 0, 0
WScript.Quit
End If
Exit Function
End Function

Function Fail()
Temp = WriteN("-"&UpCoreVersion&"-","UpCoreFCE.log")
Temp = WriteN("fail","StatusPS.log")
Temp = WriteLog("Falha ao Conectar!")
objWsh.Run "wscript ""CheckWgetCorrupt.vbs"" /Init:Start", 0, 0
WScript.Quit
Exit Function
End Function

Function ExitS()
Temp = WriteN("forceclose","StatusPS.log")
WScript.Quit
Exit Function
End Function