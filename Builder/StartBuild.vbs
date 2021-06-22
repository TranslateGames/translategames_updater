Dim code, root, Temp, BuilderF, BuildF, Build, UpFolder, IntegrityFile, IntegrityList, ResHacker, UpCore, z7F, Status, IntegrityTemplate, USED, SSED, CSED, Update, Start, Config, WinDir
On Error Resume Next
Set objArgs = WScript.Arguments.Named
Set oShell = CreateObject("WScript.Shell")

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

BuilderF = root &"\Builder"
Temp = BuilderF &"\Temp"
BuildF = root &"\Build"
Build = BuildF &"\"& code
UpFolder = root &"\Updater"
UpCore = root &"\UpCore"
ResHacker = """"& BuilderF &"\Utils\ResourceHacker.exe"""
z7F = """"& BuilderF &"\Utils\7z.exe"""
Status = BuilderF &"\Status.log"
IntegrityTemplate = BuilderF &"\Definitions\UpCoreIntegrity.log"
IntegrityFile = Temp &"\IUpCore.log"
USED = Temp &"\Updater.SED"
SSED = Temp &"\Start.SED"
CSED = Temp &"\Config.SED"
Update = """"& Build &"\Update.exe"""
Start = """"& Build &"\Start.exe"""
Config = """"& Build &"\Config.exe"""
WinDir = oShell.ExpandEnvironmentStrings("%WINDIR%")

Target1 = Build
Target2 = Temp

Set fso = CreateObject("Scripting.FileSystemObject")
Set objRead = fso.OpenTextFile(Status, 2, True)
objRead.WriteLine("|Creating|Preparando|")
Set objRead = Nothing
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
For Each objOperatingSystem in colOperatingSystems
	If NOT (IsEmpty(objOperatingSystem.OSArchitecture)) Then
		sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
		sArq = replace(sArq,"-bit","")
		sArq = replace(sArq," bits","")
		sArq = replace(sArq," bit","")
	Else
		sArq = 32
	End If
	If sArq = "32" Then
		WinArq="32"
	ElseIf sArq = "64" Then
		WinArq="64"
	Else
		WinArq="32"
	End If
Next

If NOT fso.FolderExists(Temp) Then
  fso.CreateFolder(Temp)
Else
  fso.DeleteFolder(Temp)
  fso.CreateFolder(Temp)
End If

If NOT fso.FolderExists(BuildF) Then
  fso.CreateFolder(BuildF)
End If

If NOT fso.FolderExists(Build) Then
  fso.CreateFolder(Build)
Else
  fso.DeleteFolder(Build)
  fso.CreateFolder(Build)
End If

fso.CopyFile UpFolder&"\7z.exe", Temp&"\7z.exe"
fso.CopyFile UpFolder&"\App.exe", Temp&"\App.exe"
fso.CopyFile UpFolder&"\Boot.tgapp", Temp&"\Boot.tgapp"
fso.CopyFile UpFolder&"\Icon.png", Temp&"\Icon.png"
fso.CopyFile UpFolder&"\wscript.exe", Temp&"\wscript.exe"

File = USED
File2 = Temp &"\InitUpdate.vbs"
File3 = BuilderF &"\Definitions\Updater.SED"
File4 = UpFolder &"\InitUpdate.vbs"
File5 = BuilderF &"\VersionData\UpCore.log"
File6 = BuilderF &"\UpdateResources\Version.rc"
File7 = BuilderF &"\UpdateResources\VersionR.rc"

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(File5, 1, False)
UpCore2 = objRead2.ReadLine
UpCorec = Split(UpCore2, "UpCore-->")
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

If fso.FileExists(UpCore&"UpCoreN.7z") Then
  fso.DeleteFile(UpCore&"UpCoreN.7z")
End If
If fso.FileExists(UpCore&"UpCore.tgpf") Then
  fso.DeleteFile(UpCore&"UpCore.tgpf")
End If

oShell.CurrentDirectory = UpCore

oShell.Run z7F &" a UpCoreN.7z Config.tgapp CheckWgetCorrupt.vbs error.png Hash.tmp ImageData.tgib64 InterfaceMaintainer.vbs PostInstall.vbs UpdaterUI.tgapp RoutineRestart.vbs SilentService.vbs ProgressData.tgpd timeout.tmp UpdaterService.vbs wget.tmp", 0, 1

If fso.FileExists(Temp&"\UpCore.tgpf") Then
  fso.DeleteFile(Temp&"\UpCore.tgpf")
End If
If fso.FileExists(UpCore&"\UpCoreN.7z") Then
  fso.MoveFile UpCore&"\UpCoreN.7z", Temp&"\UpCore.tgpf"
End If

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objRead2 = objFSO2.OpenTextFile(IntegrityTemplate, 1, False)
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

PDTemp = UpCore&"\"&PD2&".temp"
PD2c = UpCore&"\"&PD2

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
Set objFile = objFSO.GetFile(UpCore&"\"&PD)
FSize = objFile.SIZE
FIntegrity = PD&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

Else

If PD2 = "7z.tmp" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(UpFolder&"\"&PDC)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

ElseIf PD2 = "App.tmp" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(UpFolder&"\"&PDC)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

ElseIf PD2 = "wscript.tmp" Then

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(UpFolder&"\"&PDC)
FSize = objFile.SIZE
FIntegrity = PDC&"$"&FSize
IntegrityList = IntegrityList & FIntegrity & "|"
Set objFSO = Nothing
Set objRead = Nothing

Else

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(UpCore&"\"&PD2)
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

Set objRead = fso.OpenTextFile(Status, 2, True)
objRead.WriteLine("|Creating|Criando Atualizador|")
Set objRead = Nothing

If fso.FileExists(Build&"\Update.exe") Then
  fso.DeleteFile(Build&"\Update.exe")
End If

If WinArq = "64" Then
oShell.Run WinDir &"\SysWOW64\iexpress /N /Q "& USED, 0, 1
Else
oShell.Run WinDir &"\System32\iexpress /N /Q "& USED, 0, 1
End If

If fso.FileExists(Build&"\Update.exe") Then
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask ICON,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask ICONGROUP,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,1031 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,1036 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,1040 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,1046 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,2070 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask VERSIONINFO,1,3082 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action delete -mask MANIFEST,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open """& BuilderF &"\UpdateResources\VersionR.rc"" -save """& BuilderF &"\UpdateResources\Version.res"" -action compile -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action add -res """& BuilderF &"\UpdateResources\Icon.res"" -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action add -res """& BuilderF &"\UpdateResources\Version.res"" -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Update&" -save "&Update&" -action add -res """& BuilderF &"\UpdateResources\Manifest.res"" -log NUL", 0, 1
End If

If fso.FileExists(BuilderF &"\UpdateResources\VersionR.rc") Then
  fso.DeleteFile(BuilderF &"\UpdateResources\VersionR.rc")
End If
If fso.FileExists(BuilderF &"\UpdateResources\Version.res") Then
  fso.DeleteFile(BuilderF &"\UpdateResources\Version.res")
End If

Set objRead = fso.OpenTextFile(Status, 2, True)
objRead.WriteLine("|Creating|Criando Invocadores|")
Set objRead = Nothing

File = CSED
File2 = SSED
File3 = Temp &"\Config-"&code&".vbs"
File4 = Temp &"\Start-"&code&".vbs"
File5 = BuilderF &"\Definitions\Config.SED"
File6 = BuilderF &"\Definitions\Start.SED"
File7 = UpFolder &"\Config.vbs"
File8 = UpFolder &"\Start.vbs"
File9 = BuilderF &"\InvokerResources\VersionConfig.rc"
File10 = BuilderF &"\InvokerResources\VersionStart.rc"
File11 = BuilderF &"\InvokerResources\VersionConfigR.rc"
File12 = BuilderF &"\InvokerResources\VersionStartR.rc"

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

If fso.FileExists(Build&"\Config.exe") Then
  fso.DeleteFile(Build&"\Config.exe")
End If

If WinArq = "64" Then
oShell.Run WinDir &"\SysWOW64\iexpress /N /Q "& CSED, 0, 1
Else
oShell.Run WinDir &"\System32\iexpress /N /Q "& CSED, 0, 1
End If

If fso.FileExists(Build&"\Config.exe") Then
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask ICON,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask ICONGROUP,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,1031 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,1036 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,1040 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,1046 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,2070 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask VERSIONINFO,1,3082 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action delete -mask MANIFEST,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open """& BuilderF &"\InvokerResources\VersionConfigR.rc"" -save """& BuilderF &"\InvokerResources\VersionConfig.res"" -action compile -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action add -res """& BuilderF &"\InvokerResources\Icon.res"" -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action add -res """& BuilderF &"\InvokerResources\VersionConfig.res"" -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Config&" -save "&Config&" -action add -res """& BuilderF &"\InvokerResources\Manifest.res"" -log NUL", 0, 1
End If

If fso.FileExists(BuilderF &"\InvokerResources\VersionConfigR.rc") Then
  fso.DeleteFile(BuilderF &"\InvokerResources\VersionConfigR.rc")
End If
If fso.FileExists(BuilderF &"\InvokerResources\VersionConfig.res") Then
  fso.DeleteFile(BuilderF &"\InvokerResources\VersionConfig.res")
End If

If fso.FileExists(Build&"\Start.exe") Then
  fso.DeleteFile(Build&"\Start.exe")
End If

If WinArq = "64" Then
oShell.Run WinDir &"\SysWOW64\iexpress /N /Q "& SSED, 0, 1
Else
oShell.Run WinDir &"\System32\iexpress /N /Q "& SSED, 0, 1
End If

If fso.FileExists(Build&"\Start.exe") Then
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask ICON,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask ICONGROUP,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,1031 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,1036 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,1040 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,1046 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,2070 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask VERSIONINFO,1,3082 -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action delete -mask MANIFEST,,1033 -log NUL", 0, 1
oShell.Run ResHacker &" -open """& BuilderF &"\InvokerResources\VersionStartR.rc"" -save """& BuilderF &"\InvokerResources\VersionStart.res"" -action compile -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action add -res """& BuilderF &"\InvokerResources\Icon.res"" -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action add -res """& BuilderF &"\InvokerResources\VersionStart.res"" -log NUL", 0, 1
oShell.Run ResHacker &" -open "&Start&" -save "&Start&" -action add -res """& BuilderF &"\InvokerResources\Manifest.res"" -log NUL", 0, 1
End If

If fso.FileExists(BuilderF &"\InvokerResources\VersionStartR.rc") Then
  fso.DeleteFile(BuilderF &"\InvokerResources\VersionStartR.rc")
End If
If fso.FileExists(BuilderF &"\InvokerResources\VersionStart.res") Then
  fso.DeleteFile(BuilderF &"\InvokerResources\VersionStart.res")
End If

Set objRead = fso.OpenTextFile(Status, 2, True)
objRead.WriteLine("|Creating|Finalizando|")
Set objRead = Nothing

If fso.FolderExists(Temp) Then
  fso.DeleteFolder(Temp)
End If
If fso.FileExists(BuilderF &"\Utils\ResourceHacker.ini") Then
  fso.DeleteFile(BuilderF &"\Utils\ResourceHacker.ini")
End If

Set objRead = fso.OpenTextFile(Status, 2, True)
objRead.WriteLine("|Created|Pronto|")
Set objRead = Nothing

WScript.Quit