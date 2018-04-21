@echo off
@set caller=t
@set verifica=%1
@set code=%2
@set sversion=%7
@set sversion3=%6
@set timer=%3
@set timer=%timer%%caller%
@set limiter=%4
@set limiter=%limiter%%caller%
@set tversion=%5
@set silent=Silent
title Checking for Open %code%...
CLS
tasklist /v /fo csv | findstr /i "UpSilent%code%t"
if %ERRORLEVEL%==0 (
CLS
echo %date%-%time% O Modo Silencioso já está aberto! >> "UpdateLog.txt"
echo Modo Silencioso ja em Andamento!
) else if %ERRORLEVEL%==1 (
CLS
goto initA
)
goto exit

:initA
title UpSilent%code%t
cd UpCore
if %verifica% gtr "0" (
CLS
@set version="%verifica%"
@set useragentstring="TranslateGamesUpdater/%sversion3% Translation/%code% Version/%tversion% Silent"
if not exist UpSilent (
md UpSilent
)
del UpSilent\7z.exe
del UpSilent\ExtractSize.vbs
del UpSilent\Hash.exe
del UpSilent\Hash.vbs
del UpSilent\timeout.exe
del UpSilent\wget.exe
CLS
xcopy /Y 7z.exe UpSilent
xcopy /Y ExtractSize.vbs UpSilent
xcopy /Y Hash.exe UpSilent
xcopy /Y Hash.vbs UpSilent
xcopy /Y timeout.exe UpSilent
xcopy /Y wget.exe UpSilent
CLS
cd UpSilent
CLS
goto initP
) else (
CLS
goto exit
)

:initP
if exist wget.exe (
goto initC
) else (
CLS
echo %date%-%time% Erro! Faltando Arquivos. >> "UpdateLog.txt"
goto exit
)

:initC
echo %date%-%time% Iniciando... Versão: %version% >> "UpdateLog.txt"
del update.bat
del update.temp
del update.7z
CLS
if %version%=="UNINSTALLED" (
CLS
echo %date%-%time% A Tradução não está instalada! >> "UpdateLog.txt"
echo A Traducao nao esta instalada!
goto exit
) else (
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
CLS
echo %date%-%time% Conectando... >> "UpdateLog.txt"
echo Conectando...
wget.exe http://translategames.tk/updater/%code%/temp --output-document=update.temp --user-agent=%useragentstring% --no-check-certificate%Slimit% --append-output=UpdateLog.txt --timeout=5 --tries=2
title UpSilent%code%t
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
)

:initUP
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto firstcnx
) else (
echo %date%-%time% Iniciando Processo de Verificação... >> "UpdateLog.txt"
update.bat
exit
)

:firstcnx
del update.bat
del update.temp
del update.7z
CLS
wget.exe https://raw.githubusercontent.com/TranslateGames/translategames_server/master/Service/%code%/update.temp --output-document=update.temp --user-agent=%useragentstring% --no-check-certificate%Slimit% --append-output=UpdateLog.txt --timeout=5 --tries=2
title UpSilent%code%t
CLS
if exist update.temp (
move update.temp update.7z
7z.exe e update.7z -o.\
del update.7z
)
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
echo %date%-%time% Iniciando Processo de Verificação... >> "UpdateLog.txt"
update.bat
exit
)

:fail
title UpSilent%code%t
echo %date%-%time% Falha ao Conectar! >> "UpdateLog.txt"
echo Falha ao Conectar!
timeout 1800 > NUL
cd ..\
if exist "RoutineRestart.vbs" (
start RoutineRestart.vbs /Init:Start /code:%code% /upcore:%sversion3%
) else (
cd ..\
if exist "Update.exe" (
start Update.exe /Q /T:"%TEMP%\Update%code%-%random%.tmp" /C:"wscript InitUpdate.vbs /silent:silent"
) else if exist "InitUpdate.vbs" (
start InitUpdate.vbs /silent:silent
)
)
goto exit

:exit
exit