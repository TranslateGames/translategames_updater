REM *****************************************
REM Wget Corrupt Check v0.8 By TranslateGames
REM *****************************************

Dim D2
On Error Resume Next
Set objArgs = WScript.Arguments.Named
If NOT (objArgs.Item("Init")) Then
  WScript.Quit
End If

File = "update.tguf"
FileWget = "wget.exe"

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile("UpdateLog.txt", 1, False)
D2 = objRead2.ReadAll
Set objFSO2 = Nothing
Set objRead2 = Nothing

D2r = Split(D2, "Saving to: '"&File&"'")
Filet = Ubound(D2r)
Filet = Filet - 1
Filet2 = D2r(Filet)
D2r = Split(Filet2, "Length: ")
Filet = Ubound(D2r)
Filet2 = D2r(Filet)
D2r = Split(Filet2, " [")
Filet = 0
Filet2 = D2r(Filet)
D2r = Split(Filet2, " (")
Filet = 0
Filet2 = D2r(Filet)

D2dataR = Filet2

Set objFSO = CreateObject("Scripting.FileSystemObject")
If D2dataR = "" Then
	If objFSO.Fileexists(FileWget) Then objFSO.DeleteFile FileWget
Else
  WScript.Quit
End If
Set objFSO = Nothing