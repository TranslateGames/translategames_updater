REM ***********************************************
REM Post Installation Script v0.3 By TranslateGames
REM ***********************************************

Dim objWsh, fso, oShell, CurPath, mode, dexec
On Error Resume Next

Set objArgs = WScript.Arguments.Named
If NOT (IsEmpty(objArgs.Item("mode"))) Then
mode=objArgs.Item("mode")
Else
  WScript.Quit
End If
If NOT (IsEmpty(objArgs.Item("dexec"))) Then
dexec="disable"
Else
dexec="enable"
End If

REM - Iniciando Configuração
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
Set oShell = CreateObject("WScript.Shell")
oShell.CurrentDirectory = CurPath
Set fso = CreateObject("Scripting.FileSystemObject")
Set objWsh = CreateObject("WScript.Shell")
WScript.Sleep 3000
PostInstall()

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
If mode = "Silent" Then
FileU = CurPath &"\UpSilent\UpdateLog.txt"
Else
FileU = CurPath &"\UpdateLog.txt"
End If
Set objFSO = CreateObject("Scripting.FileSystemObject")
If (objFSO.FileExists(FileU)) Then
Set objRead = objFSO.OpenTextFile(FileU, 8, True)
objRead.WriteLine "["&ActualTime()&"] "&txt
Set objRead = Nothing
End If
Set objFSO = Nothing
End Function

Function PostInstall()
FileLocation = CurPath &"\UpInstalation\Install.exe"
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'Install.exe'")
For Each objProcess in colProcessList
	Location = objProcess.ExecutablePath
	If Location = FileLocation Then
	objProcess.Terminate()
	End If
Next

Temp = WriteLog("Limpando conteúdo extraído...")

WorkFolder = CurPath &"\UpInstalation"
Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FolderExists(WorkFolder) Then
  objFSO.DeleteFolder(WorkFolder)
End If
If objFSO.FolderExists(WorkFolder) Then
Temp = WriteLog("Falha ao limpar a pasta temporária!")
Else
Temp = WriteLog("Limpeza concluída!")
End If
Set objFSO = Nothing

If dexec = "enable" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("clean.bat", 2, True)
objRead.WriteLine "@echo off"
objRead.WriteLine "if %1 gtr ""0"" ("
objRead.WriteLine "CLS"
objRead.WriteLine "timeout 5"
objRead.WriteLine "cd ..\"
objRead.WriteLine "start start.exe"
objRead.WriteLine "exit"
objRead.WriteLine ") else ("
objRead.WriteLine "exit"
objRead.WriteLine ")"
objRead.WriteLine "exit"
Set objRead = Nothing

If objFSO.FileExists("clean.bat") Then
  objWsh.Run "clean.bat Init", 0, 0
End If
Set objFSO = Nothing

End If

Exit Function
End Function