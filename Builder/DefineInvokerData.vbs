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

File = "Temp\Config.SED"
File2 = "Temp\Start.SED"
File3 = "Temp\Config-"&code&".vbs"
File4 = "Temp\Start-"&code&".vbs"
File5 = "Definitions\Config.SED"
File6 = "Definitions\Start.SED"
File7 = root &"\Updater\Config.vbs"
File8 = root &"\Updater\Start.vbs"
File9 = "InvokerResources\VersionConfig.rc"
File10 = "InvokerResources\VersionStart.rc"
File11 = "InvokerResources\VersionConfigR.rc"
File12 = "InvokerResources\VersionStartR.rc"
File13 = "VersionData\UpCore.log"

Target1 = root &"\Build\"& code
Target2 = root &"\Builder\Temp"

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File13, 1, False)
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
Set objRead2 = objFSO2.OpenTextFile(File5, 1, False)
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
Set objRead2 = objFSO2.OpenTextFile(File6, 1, False)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)
D2 = Replace(D2,"|TARGET1|",Target1)
D2 = Replace(D2,"|TARGET2|",Target2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File2, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File7, 1, False)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File3, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File8, 1, False)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|CODE|",code)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File4, 2, True)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File9, 1, False, -1)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|VERSIONP|",UpCoreRV)
D2 = Replace(D2,"|VERSIONV|",UpCoreRV2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File11, 2, True, -1)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File10, 1, False, -1)
D2 = objRead2.ReadAll

D2 = Replace(D2,"|VERSIONP|",UpCoreRV)
D2 = Replace(D2,"|VERSIONV|",UpCoreRV2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile(File12, 2, True, -1)
	objRead.WriteLine(D2)
Set objFSO2 = Nothing
Set objRead2 = Nothing
Set objFSO = Nothing
Set objRead = Nothing
WScript.Quit