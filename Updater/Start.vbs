Dim objWsh, fso, oShell
On Error Resume Next
code="|CODE|"

REM - Iniciando Configuração
CurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
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
Function ReadReg(reg)
On Error Resume Next
If NOT (IsEmpty(reg)) Then
reg = Replace(reg,"TG_UNINSTALL","HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
If NOT (IsEmpty(oShell.RegRead(reg))) Then
ReadData = oShell.RegRead(reg)
Else
ReadData = ""
End If
Else
ReadData = ""
End If
ReadReg = ReadData
End Function
Function WriteReg(reg,val,tp)
If NOT (IsEmpty(reg)) Then
If NOT (IsEmpty(val)) Then
If NOT (IsEmpty(tp)) Then
reg = Replace(reg,"TG_UNINSTALL","HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
oShell.RegWrite reg,val,tp
End If
End If
End If
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
CleanL= Path & Path2
REM - Obtendo ou Criando Configuração
If code = "350" Then
config = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig")
Else
config = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig")
End If
If NOT (IsEmpty(config)) Then
config = Split(config, "|.|")
   For i = 1 to (Ubound(config))
	AutoOp = config(0)
	TimeOp = config(1)
	LimitOp = config(2)
   Next
REM - Início Precauções
If AutoOp = "0" Then
AutoOp = "Ativar"
ElseIf AutoOp = "" Then
AutoOp = "Ativar"
End If
If TimeOp = "0" Then
TimeOp = "10800"
ElseIf TimeOp = "" Then
TimeOp = "10800"
End If
If LimitOp = "0" Then
LimitOp = "Ilimitado"
ElseIf LimitOp = "" Then
LimitOp = "Ilimitado"
End If
REM - Fim Precauções
Result = AutoOp &"|.|"& TimeOp &"|.|"& LimitOp
If code = "350" Then
Temp = WriteReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig", Result, "REG_SZ")
Else
Temp = WriteReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig", Result, "REG_SZ")
End If
If code = "350" Then
config = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig")
Else
config = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig")
End If
config = Split(config, "|.|")
   For i = 1 to (Ubound(config))
	AutoOp = config(0)
	TimeOp = config(1)
	LimitOp = config(2)
   Next
REM - Fim config = yes
Else
REM - Início config = null
AutoOp = "Ativar"
TimeOp = "10800"
LimitOp = "Ilimitado"
REM - Atualização Automática restrita ao Windows XP ou +
If OSversion < 500000 Then
AutoOp = "Desativar"
End If
Result = AutoOp &"|.|"& TimeOp &"|.|"& LimitOp
If code = "350" Then
Temp = WriteReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig", Result, "REG_SZ")
Else
Temp = WriteReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig", Result, "REG_SZ")
End If
If code = "350" Then
config = ReadReg("TG_UNINSTALL\TranslateGames(350-1)\UpConfig")
Else
config = ReadReg("TG_UNINSTALL\TranslateGames("& code &")\UpConfig")
End If
config = Split(config, "|.|")
   For i = 1 to (Ubound(config))
	AutoOp = config(0)
	TimeOp = config(1)
	LimitOp = config(2)
   Next
End If
If AutoOp = "Desativar" Then
  WScript.Quit
End If

oShell.CurrentDirectory = CleanL

If (fso.FileExists("Update.exe")) Then
  objWsh.Run "Update.exe /Q /T:""%TEMP%\Update"& code &"-"& RString &".tmp"" /C:""wscript InitUpdate.vbs /silent:silent""", 0, 0
Else
  msgbox"Erro! Está faltando um arquivo necessário! (Update.exe)",vbCritical,"Faltando Arquivo!"
  Set(objWsh)=Nothing
  WScript.Quit
End If