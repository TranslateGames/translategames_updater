Dim objWsh, fso
On Error Resume Next
code="|CODE|"

REM - Iniciando Configuração
Set fso = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments.Named
Set objWsh = CreateObject("WScript.Shell")
Set oShell = CreateObject("WScript.Shell")
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
	OSname = replace(objOperatingSystem.Name,"Microsoft ","")
	OSname = replace(OSname,"Microsoft® ","")
	OSname = replace(OSname,"®","")
	OSname = replace(OSname,"™","")
	OSname1 = Split(OSname, "|")
	   For i = 1 to (Ubound(OSname1))
		OSname = OSname1(0)
	   Next
	OSversionA = objOperatingSystem.Version
	OSversion = replace(objOperatingSystem.Version,".","")
	If sArq = "32" Then
		WinArq="32"
	ElseIf sArq = "64" Then
		WinArq="64"
	Else
		WinArq="32"
	End If
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
RString = RandomString(14) & RandomString(18)
REM - Definindo ProgramFiles conforme arquitetura
If WinArq = "64" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%")
ElseIf WinArq = "32" Then
Path = oShell.ExpandEnvironmentStrings("%PROGRAMFILES%")
End If
If code = "350-2" Then
code="350"
End If
REM - Definindo localização da pasta de operações da Tradução
If code = "350" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War"
ElseIf code = "350-3" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade"
ElseIf code = "350-4" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War\Winter Assault\Dark Crusade\Soulstorm"
ElseIf code = "356" Then
Path2 = "\Traduções de Jogos\Age of Mythology"
ElseIf code = "356-2" Then
Path2 = "\Traduções de Jogos\Age of Mythology\The Titans Expansion"
ElseIf code = "357" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II - Retribution"
ElseIf code = "358" Then
Path2 = "\Traduções de Jogos\Warhammer 40,000 Dawn of War II e Chaos Rising"
End If
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
CleanL= Path & Path2

oShell.CurrentDirectory = CleanL
If (fso.FileExists("Update.exe")) Then
  objWsh.Run "Update.exe /Q /T:""%TEMP%\ConfigUp"& code &"-"& RString &".tmp"" /C:""wscript InitUpdate.vbs /init:config""", 0, 0
  Set fso = Nothing
  Set(objWsh)=Nothing
Else
  msgbox"Erro! Está faltando um arquivo necessário! (Update.exe)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If