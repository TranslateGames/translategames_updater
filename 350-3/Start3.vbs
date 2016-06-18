Dim objWsh, fso
On Error Resume Next
code="350-3"

REM - Iniciando Configuração
Set fso = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments.Named
Set objWsh = CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
Set oShell = CreateObject("WScript.Shell")
For Each objOperatingSystem in colOperatingSystems
	sArq = replace(objOperatingSystem.OSArchitecture,"-bits","")
	sArq = replace(sArq,"-bit","")
	sArq = replace(sArq," bits","")
	sArq = replace(sArq," bit","")
	OSversion = replace(objOperatingSystem.Version,".","")
	If sArq = "32" then
		WinArq="32"
	elseif sArq = "64" then
		WinArq="64"
	else
		WinArq="0"
	end if
Next
Function RandomString( ByVal strLen )
    Dim str, min, max

    Const LETTERS = "abcdefghijklmnopqrstuvwxyz0123456789"
    min = 1
    max = Len(LETTERS)

    Randomize
    For i = 1 to strLen
        str = str & Mid( LETTERS, Int((max-min+1)*Rnd+min), 1 )
    Next
    RandomString = str
End Function
RString = RandomString(8)
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
Else
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
REM - Definindo localização da pasta de operações da Tradução
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
End If
If code = "350-2" Then
code="350"
End If
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
CleanL= Path & Path2

oShell.CurrentDirectory = CleanL

If (fso.FileExists("Update.exe")) Then
  objWsh.Run "Update.exe /Q /T:""%TEMP%\Update"& code &"-"& RString &".tmp"" /C:""wscript InitUpdate.vbs /silent:silent""", 0, 0
Else
  msgbox"Erro! Está faltando um arquivo necessário! (Update.exe)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If