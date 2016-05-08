@echo off
@set version="%1"
@set code=%2
@set sversion=1500262
@set secondsvr=%3
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
goto initC
) else (
CLS
cd .\
start ErroWget.vbs
goto exit
)

:initC
del UpdateLog.txt
echo %date%-%time% Iniciando... Versão: %version% >> "UpdateLog.txt"
del update.bat
CLS
if %version%=="UNINSTALLED" (
CLS
echo %date%-%time% A Tradução não está instalada! >> "UpdateLog.txt"
echo A Traducao nao esta instalada!
ErroInstalation.vbs
goto exit
) else (
CLS
echo %date%-%time% Conectando... >> "UpdateLog.txt"
echo Conectando...
echo 0 > "StatusPS.log"
echo 0 > "ProgressBarS.log"
cd .\
start StartInterf.hta /:Init
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