REM *************************************
REM Hash Validator v1.4 By TranslateGames
REM *************************************

On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments.Named
Set objWsh = CreateObject("WScript.Shell")
If NOT (IsEmpty(objArgs.Item("file"))) Then
File = objArgs.Item("file")
Else
  WScript.Quit
End If

If NOT (IsEmpty(objArgs.Item("hash"))) Then
Hash = objArgs.Item("hash")
Hash = UCASE(Hash)
Else
  WScript.Quit
End If

If fso.Fileexists("output.txt") Then fso.DeleteFile "output.txt"
If fso.Fileexists("hash.bat") Then fso.DeleteFile "hash.bat"

If NOT fso.Fileexists("Hash.exe") Then
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("Hash.log", 2, True)
	objRead.WriteLine("MissingFile")
Set objFSO = Nothing
Set objRead = Nothing
  WScript.Quit
End If

Dim clean(5)
clean(0)="@echo off"
clean(1)="@set verifica=%1t"
clean(2)="if %verifica%==Initt ("
clean(3)="Hash.exe "&File&" > output.txt"
clean(4)=")"
clean(5)="exit"

oShell.CurrentDirectory = CleanL

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("hash.bat", 2, True)
   For Each cleanT In clean
	objRead.WriteLine(cleanT)
   Next
Set objFSO = Nothing
Set objRead = Nothing

If (fso.FileExists("hash.bat")) Then
  objWsh.Run "hash.bat Init", 0, 1
End If

Separator = Chr(32)&Chr(32)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("output.txt", 1, False)
D1 = objRead.ReadLine
D1c = Split(D1, Separator)
   For i = 1 to (Ubound(D1c))
	D1 = D1c(0)
   Next
D1 = UCASE(D1)

Set objFSO = Nothing
Set objRead = Nothing

If fso.Fileexists("output.txt") Then fso.DeleteFile "output.txt"
If fso.Fileexists("hash.bat") Then fso.DeleteFile "hash.bat"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("Hash.log", 2, True)
If D1 = Hash Then
	objRead.WriteLine("Valid")
Else
	objRead.WriteLine("Invalid")
End If
Set objFSO = Nothing
Set objRead = Nothing