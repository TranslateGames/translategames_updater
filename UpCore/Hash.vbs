REM *************************************
REM Hash Validator v1.2 By TranslateGames
REM *************************************

On Error Resume Next
strx = CStr(CDbl(1/2))
GetDecimalChar = Mid(strx, 2, 1)
Set fso = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments.Named
Set objWsh = CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
For Each objOperatingSystem in colOperatingSystems
	OSversion = replace(objOperatingSystem.Version,".","")
Next

If (objArgs.Item("file")) Then
File = objArgs.Item("file")
Else
  WScript.Quit
End If

If (objArgs.Item("hash")) Then
Hash = objArgs.Item("hash")
Hash = UCASE(Hash)
Else
  WScript.Quit
End If

NetVersion = NetVCheck()
NetVersionc = Split(NetVersion,".")
   For i = 1 to (Ubound(NetVersionc))
	NetVersion = NetVersionc(0)
   Next
NetVersiond = Split(NetVersion, GetDecimalChar)
   For i = 1 to (Ubound(NetVersiond))
	NetVersion = NetVersiond(0)
   Next

SessionCheck = 0

If OSversion < 520000 Then

SessionCheck = 0

ElseIf NetVersion > 0 Then

SessionCheck = 1

End If

If SessionCheck > 0 then

D1 = BytesToHex(sha256hashBytes(GetBytes(File)))

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("Hash.log", 2, True)
If D1 = Hash Then
	objRead.WriteLine("Valid")
Else
	objRead.WriteLine("Invalid")
End If
Set objFSO = Nothing
Set objRead = Nothing

Else

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

End If

Function sha256hashBytes(aBytes)
    Dim sha256
    set sha256 = CreateObject("System.Security.Cryptography.SHA256Managed")

    sha256.Initialize()

    sha256hashBytes = sha256.ComputeHash_2( (aBytes) )
End Function

Function BytesToHex(aBytes)
    Dim hexStr, x
    For x=1 to lenb(aBytes)
        hexStr= hex(ascb(midb( (aBytes),x,1)))
        if len(hexStr)=1 then hexStr="0" & hexStr
        bytesToHex=bytesToHex & hexStr
    Next
End Function

Function GetBytes(sPath)
    With CreateObject("Adodb.Stream")
        .Type = 1 ' adTypeBinary
        .Open
        .LoadFromFile sPath
        .Position = 0
        GetBytes = .Read
        .Close
    End With
End Function

Function NetVCheck()

Dim strComputer, objWMIService, colItems, strVar, objItem, maxVersion

maxVersion = 0
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_Product Where Name Like 'Microsoft .NET Framework%'")

For Each objItem in colItems

    If objItem.Version > maxVersion Then

        maxVersion = objItem.Version

    End If

Next

NetVCheck = maxVersion

End Function