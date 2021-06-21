Dim Temp, BuildF, Build, UpFolder, Invokers, Updater
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

Temp = "Temp"
BuildF = root &"\Build"
Build = BuildF &"\"& code
UpFolder = root &"\Updater"
Invokers = "Invokers.bat"
Updater = "Updater.bat"

Set fso = CreateObject("Scripting.FileSystemObject")
Set objRead = fso.OpenTextFile("Status.log", 2, True)
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

Set objRead = fso.OpenTextFile("Status.log", 2, True)
objRead.WriteLine("|Creating|Criando Atualizador|")
Set objRead = Nothing

oShell.Run Updater &" "& code &" "& WinArq &" """&root&"""", 0, 1

Set objRead = fso.OpenTextFile("Status.log", 2, True)
objRead.WriteLine("|Creating|Criando Invocadores|")
Set objRead = Nothing

oShell.Run Invokers &" "& code &" "& WinArq &" """&root&"""", 0, 1

Set objRead = fso.OpenTextFile("Status.log", 2, True)
objRead.WriteLine("|Creating|Finalizando|")
Set objRead = Nothing

If fso.FolderExists(Temp) Then
  fso.DeleteFolder(Temp)
End If

Set objRead = fso.OpenTextFile("Status.log", 2, True)
objRead.WriteLine("|Created|Pronto|")
Set objRead = Nothing

WScript.Quit