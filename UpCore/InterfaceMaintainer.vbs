REM *******************************************
REM Interface Maintainer v0.5 By TranslateGames
REM *******************************************

Dim objWsh, fso, oShell, CurPath, code, mode2
On Error Resume Next

Set objArgs = WScript.Arguments.Named
If NOT (IsEmpty(objArgs.Item("code"))) Then
code=objArgs.Item("code")
Else
  WScript.Quit
End If
If NOT (IsEmpty(objArgs.Item("mode"))) Then
mode2=objArgs.Item("mode")
Else
  WScript.Quit
End If

REM - Iniciando Configuração
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
Set oShell = CreateObject("WScript.Shell")
oShell.CurrentDirectory = CurPath
Set fso = CreateObject("Scripting.FileSystemObject")
Set objWsh = CreateObject("WScript.Shell")
firstline = ReadF("InterfaceMaintainer.log")
If firstline = "yes" Then
WScript.Quit
End If
InterfaceMaintainer()

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

Function InterfaceMaintainer()
Temp = WriteN("yes","InterfaceMaintainer.log")
Check = 0
FileLocation = CurPath &"\App.exe"
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'App.exe'")
For Each objProcess in colProcessList
	Location = objProcess.ExecutablePath
	If Location = FileLocation Then
	Check = 1
	End If
Next

firstline = "0"
firstline = ReadF("StatusPS.log")
If firstline = "forceclose" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
ElseIf firstline = "fail" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
End If

firstline = "0"
firstline = ReadF("Status.log")
If firstline = "cancelar" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
End If

firstline = "0"
firstline = ReadF("StatusP.log")
If firstline = "fail" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
ElseIf firstline = "stop" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
End If

firstline = "0"
firstline = ReadF("ProgressBar.log")
If firstline = "-100-2-" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
End If

firstline = "0"
firstline = ReadF("StatusIS.log")
If firstline = "updated" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
End If

firstline = "0"
firstline = ReadF("Result.txt")
If firstline = "cancelar" Then
Temp = WriteN("not","InterfaceMaintainer.log")
WScript.Quit
Exit Function
End If

If Check = 1 Then
WScript.Sleep 1000
InterfaceMaintainer()
Else
Temp = WriteLog("Interface fechada inesperadamente! Reabrindo...")
mode3 = ReadF("UpdateMode.log")
If mode3 = "update" Then
	mode = "update"
ElseIf mode3 = "install" Then
	mode = "install"
Else
	mode = mode2
End If
objWsh.Run "App.exe """&CurPath&"\UpdaterUI.tgapp"" /:Init /:"&mode&" /:"&code, 0, 0
WScript.Sleep 1000
InterfaceMaintainer()
End If

Exit Function
End Function