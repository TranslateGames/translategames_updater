@echo off
@set caller=t
@set version="%1"
@set code=%2
@set sversion=1500277
@set translationof=%3
@set limiter=%4
@set limiter=%limiter%%caller%
@set mode=update
title Atualizador%code%t
cd UpCore
if not %version% gtr "0" (
goto exit
)
del ErroInstalation.vbs
del ErroConnection.vbs
del ErroWget.vbs
echo msgbox"A Tradução não está instalada!",vbInformation,"Tradução não instalada" > "ErroInstalation.vbs"
echo msgbox"Ocorreu um erro ao tentar conectar ao servidor!",vbCritical,"Falha ao se Conectar" > "ErroConnection.vbs"
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
del update.temp
del update.7z
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
if %limiter%==Ilimitadot (
@set Slimit=
) else if %limiter%==50kt (
@set Slimit= --limit-rate=50k
echo %date%-%time% Velocidade de Download Limitada em: 50 KB/s >> "UpdateLog.txt"
) else if %limiter%==100kt (
@set Slimit= --limit-rate=100k
echo %date%-%time% Velocidade de Download Limitada em: 100 KB/s >> "UpdateLog.txt"
) else if %limiter%==300kt (
@set Slimit= --limit-rate=300k
echo %date%-%time% Velocidade de Download Limitada em: 300 KB/s >> "UpdateLog.txt"
) else if %limiter%==500kt (
@set Slimit= --limit-rate=500k
echo %date%-%time% Velocidade de Download Limitada em: 500 KB/s >> "UpdateLog.txt"
) else if %limiter%==1mt (
@set Slimit= --limit-rate=1m
echo %date%-%time% Velocidade de Download Limitada em: 1 MB/s >> "UpdateLog.txt"
) else if %limiter%==2mt (
@set Slimit= --limit-rate=2m
echo %date%-%time% Velocidade de Download Limitada em: 2 MB/s >> "UpdateLog.txt"
) else if %limiter%==5mt (
@set Slimit= --limit-rate=5m
echo %date%-%time% Velocidade de Download Limitada em: 5 MB/s >> "UpdateLog.txt"
) else (
@set Slimit=
)
cd .\
echo 1-1> "ServerS.log"
start App.exe "%CD%\StartInterf.tgapp" /:Init /:%mode%
wget.exe http://translategames.tk/updater/%code%/temp --output-document=update.temp --no-check-certificate%Slimit% --append-output=UpdateLog.txt --timeout=5 --tries=2
title Atualizador%code%t
CLS
if exist update.temp (
move update.temp update.7z
7z.exe e update.7z -o.\
del update.7z
)
CLS
if exist update.bat (
CLS
goto initUP
) else (
CLS
goto firstcnx
)

:initUP
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto firstcnx
) else (
echo 1-2> "ServerS.log"
echo %date%-%time% Iniciando Processo de Verificação... >> "UpdateLog.txt"
update.bat
exit
)

:firstcnx
del update.bat
del update.temp
del update.7z
CLS
echo 2-1> "ServerS.log"
wget.exe https://raw.githubusercontent.com/TranslateGames/translategames_server/master/Service/%code%/update.temp --output-document=update.temp --no-check-certificate%Slimit% --append-output=UpdateLog.txt --timeout=5 --tries=2
title Atualizador%code%t
CLS
if exist update.temp (
move update.temp update.7z
7z.exe e update.7z -o.\
del update.7z
)
CLS
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if exist update.bat (
CLS
goto initUP1
) else (
CLS
goto fail
)

:initUP1
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto fail
) else (
echo 2-2> "ServerS.log"
echo %date%-%time% Iniciando Processo de Verificação... >> "UpdateLog.txt"
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