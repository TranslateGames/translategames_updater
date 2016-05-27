REM - Iniciando Configuração
On Error Resume Next
Set objArgs = WScript.Arguments.Named
Set oShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "0"
Set objFSO = Nothing
Set objRead = Nothing
If (objArgs.Item("code")) Then
  code = objArgs.Item("code")
Else
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "Error"
  WScript.Quit
End If
If (objArgs.Item("AutoOp")) Then
  AutoOp = objArgs.Item("AutoOp")
Else
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "Error"
  WScript.Quit
End If
If (objArgs.Item("TimeOp")) Then
  TimeOp = objArgs.Item("TimeOp")
Else
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "Error"
  WScript.Quit
End If
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "Saving"
Set objFSO = Nothing
Set objRead = Nothing
Result = AutoOp &"|.|"& TimeOp
If code = "350" Then
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig", Result, "REG_SZ"
Else
oShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UpConfig", Result, "REG_SZ"
End If
If code = "350" Then
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames(350-1)\UpConfig")
Else
config = oShell.RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TranslateGames("& code &")\UpConfig")
End If
If config = result Then
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "Sucess"
WScript.Quit
Else
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objRead = objFSO.OpenTextFile("ConfigStats.log", 2, True)
objRead.WriteLine "Error"
WScript.Quit
End If