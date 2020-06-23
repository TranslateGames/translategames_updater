REM *************************************
REM Size Extractor v1.1 By TranslateGames
REM *************************************

Dim D2
On Error Resume Next

Set objArgs = WScript.Arguments.Named
If NOT (IsEmpty(objArgs.Item("file"))) Then
File = objArgs.Item("file")
Else
  WScript.Quit
End If

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
Set objRead = objFSO.OpenTextFile("DSize.log", 2, True)
If D2dataR = "" Then
	objRead.WriteLine("NoData")
Else
	objRead.WriteLine(D2dataR)
End If
Set objFSO = Nothing
Set objRead = Nothing