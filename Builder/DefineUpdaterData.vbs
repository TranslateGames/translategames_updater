Dim D2
On Error Resume Next
Set objArgs = WScript.Arguments.Named

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

File = "Temp\Updater.SED"
File2 = "Temp\InitUpdate.vbs"
File3 = "Definitions\Updater.SED"
File4 = root &"\Updater\InitUpdate.vbs"
File5 = "VersionData\UpCore.log"
File6 = "UpdateResources\Version.rc"
File7 = "UpdateResources\VersionR.rc"

Target1 = root &"\Build\"& code
Target2 = root &"\Builder\Temp"

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File5, 1, False)
UpCore = objRead2.ReadAll
UpCorec = Split(UpCore, code&"-->")
   For i = 1 to (Ubound(UpCorec))
	DataResult = UpCorec(1)
   Next
UpCored = Split(DataResult, "<--!")
   For i = 1 to (Ubound(UpCored))
	UpCoreRV = UpCored(0)
   Next
UpCoreRV = Replace(UpCoreRV," ","")
UpCoreRV2 = Replace(UpCoreRV,".",",")

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File3, 1, False)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)
D2 = Replace(D2,"|TARGET1|",Target1)
D2 = Replace(D2,"|TARGET2|",Target2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File4, 1, False)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|REALUPCORE|",UpCoreRV)
D2 = Replace(D2,"|REALCODE|",code)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File2, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File6, 1, False, -1)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|VERSIONP|",UpCoreRV)
D2 = Replace(D2,"|VERSIONV|",UpCoreRV2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File7, 2, True, -1)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing
WScript.Quit