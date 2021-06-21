Dim D2, code, File, IntegrityFile, IntegrityList, UpCore
On Error Resume Next
Set objArgs = WScript.Arguments.Named
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
Set oShell = CreateObject("WScript.Shell")
oShell.CurrentDirectory = CurPath

If (objArgs.Item("code")) Then
  code = objArgs.Item("code")
Else
  WScript.Quit
End If

If (objArgs.Item("root")) Then
  root = objArgs.Item("root")
Else
  WScript.Quit
End If

UpCore = root &"\UpCore\"
Updater = root &"\Updater\"
File = CurPath &"\Definitions\UpCoreIntegrity.log"
IntegrityFile = CurPath &"\Temp\IUpCore.log"
UpCoreCreator = "CreateUpCore.bat"

oShell.Run UpCoreCreator &" "& root, 0, 1

oShell.CurrentDirectory = UpCore

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File, 1, False)
D2 = objRead2.ReadAll

D2c = Split(D2, "|")
IntegrityList = "|"

For Each PD In D2c

If PD = "" Then

Else

PDC = ""

D2b = Split(PD, "$")
   For i = 1 to (Ubound(D2b))
	PD2 = D2b(0)
	PDC = D2b(1)
   Next

If PDC = "NM" Then

PDTemp = UpCore&PD2&".temp"
PD2c = UpCore&PD2

Set objFSO4 = Createobject("Scripting.FileSystemObject")
objFSO4.CopyFile PD2c, PDTemp
Set objFSO4 = Nothing

Set objFSO5 = CreateObject("Scripting.FileSystemObject")
Set objRead5 = objFSO5.OpenTextFile(PDTemp, 1, True)
D2a = objRead5.ReadAll

D2a = Replace(D2a,"|CODE|",code)

Set objFSO6 = CreateObject("Scripting.FileSystemObject")
Set objRead6 = objFSO6.OpenTextFile(PDTemp, 2, True)
	objRead6.WriteLine(D2a)
Set objFSO5 = Nothing
Set objRead5 = Nothing
Set objFSO6 = Nothing
Set objRead6 = Nothing

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(PDTemp)
FSize = objFile.SIZE
FIntegrity = PD2&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO4 = Createobject("Scripting.FileSystemObject")
objFSO4.DeleteFile PDTemp
Set objFSO4 = Nothing

ElseIf PDC = "" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(UpCore&PD)
FSize = objFile.SIZE
FIntegrity = PD&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

Else

If PD2 = "7z.tmp" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(Updater&PDC)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

ElseIf PD2 = "App.tmp" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(Updater&PDC)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

ElseIf PD2 = "wscript.tmp" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(Updater&PDC)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

Else

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(UpCore&PD2)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

End If

End If

End If

Next

Set objFSO2 = Nothing
Set objRead2 = Nothing

Set objFSO3 = CreateObject("Scripting.FileSystemObject")
Set objRead3 = objFSO3.OpenTextFile(IntegrityFile, 2, True)
	objRead3.WriteLine(IntegrityList)
Set objFSO3 = Nothing
Set objRead3 = Nothing