@echo off
@set version="%1"
@set code=%2
@set sversion=1500264
@set secondsvr=%3
@set translationof=%4
@set mode=update
title Atualizador%code%t
cd UpCore
if not %version% gtr "0" (
goto exit
)
del ErroInstalation.vbs
del ErroConnection.vbs
del ErroBandWidth.vbs
del ErroWget.vbs
echo msgbox"A Tradução não está instalada!",vbInformation,"Tradução não instalada" > "ErroInstalation.vbs"
echo msgbox"Ocorreu um erro ao tentar conectar ao servidor!",vbCritical,"Falha ao se Conectar" > "ErroConnection.vbs"
echo msgbox"Ocorreu um erro na transferência de informações! Erro: 'BandWidth'",vbCritical,"Erro Desconhecido" > "ErroBandWidth.vbs"
echo msgbox"Erro! Está faltando um arquivo necessário! (Wget.exe)",vbCritical,"Faltando Arquivo!" > "ErroWget.vbs"
if exist wget.exe (
goto initA
) else (
CLS
cd .\
start ErroWget.vbs
goto exit
)

:initA
del UpdateLog.txt
del update.bat
if %version%=="UNINSTALLED" (
echo %date%-%time% Iniciando... >> "UpdateLog.txt"
goto initB
) else (
echo %date%-%time% Iniciando... Versão: %version% >> "UpdateLog.txt"
goto initC
)

:initB
CLS
echo %date%-%time% A Tradução não está instalada! >> "UpdateLog.txt"
echo A Traducao nao esta instalada!
CLS
echo translationof = %translationof% > "InstallPrompt.vbs"
echo REM - Iniciando Configuração... >> "InstallPrompt.vbs"
echo Set FSO = WScript.CreateObject("Scripting.FileSystemObject") >> "InstallPrompt.vbs"
echo Set OTF = FSO.OpenTextFile("ResultI.txt", 2, True) >> "InstallPrompt.vbs"
echo OTF.WriteLine "" >> "InstallPrompt.vbs"
echo Set OTF = Nothing >> "InstallPrompt.vbs"
echo Set FSO = Nothing >> "InstallPrompt.vbs"
echo resultado = msgbox("Tradução não Instalada!"^&Chr(13)^&"Deseja instalar a Tradução de "^& translationof ^&"?"^&Chr(13)^&Chr(13)^&"Clique em 'Sim' para Baixar e Instalar ou 'Não' para Sair.",vbYesNo,"Tradução não Instalada!") >> "InstallPrompt.vbs"
echo If resultado = vbYes Then >> "InstallPrompt.vbs"
echo     Set FSO = WScript.CreateObject("Scripting.FileSystemObject") >> "InstallPrompt.vbs"
echo     Set OTF = FSO.OpenTextFile("ResultI.txt", 2, True) >> "InstallPrompt.vbs"
echo     OTF.WriteLine "continuar" >> "InstallPrompt.vbs"
echo     Set OTF = Nothing >> "InstallPrompt.vbs"
echo     Set FSO = Nothing >> "InstallPrompt.vbs"
echo Else >> "InstallPrompt.vbs"
echo     Set FSO = WScript.CreateObject("Scripting.FileSystemObject") >> "InstallPrompt.vbs"
echo     Set OTF = FSO.OpenTextFile("ResultI.txt", 2, True) >> "InstallPrompt.vbs"
echo     OTF.WriteLine "cancelar" >> "InstallPrompt.vbs"
echo     Set OTF = Nothing >> "InstallPrompt.vbs"
echo     Set FSO = Nothing >> "InstallPrompt.vbs"
echo End If >> "InstallPrompt.vbs"
CLS
InstallPrompt.vbs
set /p firstline=<ResultI.txt
if %firstline%==cancelar (
CLS
echo %date%-%time% Instalação cancelada pelo usuário! >> "UpdateLog.txt"
echo Cancelando...
goto exit
)
@set version="1"
@set mode=install
echo %date%-%time% O usuário aceitou a instalação! >> "UpdateLog.txt"
goto initC

:initC
CLS
echo %date%-%time% Conectando... >> "UpdateLog.txt"
echo Conectando...
echo 0 > "StatusPS.log"
echo 0 > "ProgressBarS.log"
cd .\
start StartInterf.hta /:Init /:%mode%
wget.exe https://dl.dropboxusercontent.com/u/57685514/Update/%code%/update.bat --output-document=update.bat --no-check-certificate --append-output=UpdateLog.txt --timeout=10 --tries=2
title Atualizador%code%t
CLS
if exist update.bat (
CLS
goto initUP
) else (
CLS
goto secondcnx
)

:initUP
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto secondcnx
) else (
echo %date%-%time% %tamanho% bytes transferidos! >> "UpdateLog.txt"
update.bat
exit
)

:secondcnx
del update.bat
CLS
wget.exe %secondsvr% --output-document=update.bat --no-check-certificate --append-output=UpdateLog.txt --timeout=10 --tries=2
title Atualizador%code%t
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if exist update.bat (
CLS
goto initUP2
) else (
CLS
goto fail
)

:initUP2
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto fail
) else (
echo %date%-%time% %tamanho% bytes transferidos! >> "UpdateLog.txt"
update.bat
exit
)

:fail
title Atualizador%code%t
echo fail>"StatusPS.log"
echo %date%-%time% Falha ao Conectar! >> "UpdateLog.txt"
echo Falha ao Conectar!
ErroConnection.vbs
goto exit

:exit
echo close>"StatusPS.log"
exit