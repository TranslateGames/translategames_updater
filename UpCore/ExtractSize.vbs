REM *************************************
REM Size Extractor v0.9 By TranslateGames
REM *************************************

Dim D2
On Error Resume Next
Set objArgs = WScript.Arguments.Named

If (objArgs.Item("file")) Then
File = objArgs.Item("file")
Else
  WScript.Quit
End If

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile("UpdateLog.txt", 1, False)
D2 = objRead2.ReadAll

D2r = Split(D2, "Length: ")

D2data = ""

For Each D2s In D2r

D2fsr = Split(D2s, "Saving to: '")
   For i = 1 to (Ubound(D2fsr))
	D2ft = D2fsr(1)
   Next
D2ftr = Split(D2ft, "'")
   For i = 1 to (Ubound(D2ftr))
	Filet = D2ftr(0)
   Next

If Filet = File Then

D2sr = Split(D2s, " [")
   For i = 1 to (Ubound(D2sr))
	D2dataNR = D2sr(0)
   Next
D2sr = Split(D2dataNR, " (")
   For i = 1 to (Ubound(D2sr))
	D2dataNR = D2sr(0)
   Next

D2data = D2data &"|"& D2dataNR

End If

Next

D2dt = Split(D2data, "|")

For Each D2dtr In D2dt

D2dataR = D2dtr

Next

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("DSize.log", 2, True)
If D2dataR = "" Then
	objRead.WriteLine("NoData")
Else
	objRead.WriteLine(D2dataR)
End If
Set objFSO = Nothing
Set objRead = Nothing