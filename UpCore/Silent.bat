@echo off
@set caller=t
@set verifica=%1
@set code=%2
@set timer=%3
@set timer=%timer%%caller%
@set secondsvr=%4
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
if not exist UpSilent (
md UpSilent
)
if not exist UpSilent\7z.exe (
xcopy 7z.exe UpSilent
)
del UpSilent\timeout.exe
del UpSilent\wget.exe
CLS
xcopy timeout.exe UpSilent
xcopy wget.exe UpSilent
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
CLS
echo %date%-%time% Conectando... >> "UpdateLog.txt"
echo Conectando...
wget.exe https://dl.dropboxusercontent.com/u/57685514/Update/%code%/update.temp --output-document=update.temp --no-check-certificate --append-output=UpdateLog.txt --timeout=10 --tries=2
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
goto secondcnx
)
)

:initUP
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto secondcnx
) else (
echo %date%-%time% Iniciando Processo de Verificação... >> "UpdateLog.txt"
update.bat
exit
)

:secondcnx
del update.bat
del update.temp
del update.7z
CLS
wget.exe %secondsvr% --output-document=update.temp --no-check-certificate --append-output=UpdateLog.txt --timeout=10 --tries=2
title UpSilent%code%t
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
goto initUP2
) else (
CLS
goto thirdcnx
)

:initUP2
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if %tamanho%==0 (
goto thirdcnx
) else (
echo %date%-%time% Iniciando Processo de Verificação... >> "UpdateLog.txt"
update.bat
exit
)

:thirdcnx
del update.bat
del update.temp
del update.7z
CLS
wget.exe https://dl.dropboxusercontent.com/u/57685514/Update/%code%/update.bat --output-document=update.bat --no-check-certificate --append-output=UpdateLog.txt --timeout=10 --tries=2
title UpSilent%code%t
CLS
FOR %%a in (dir "update.bat") do (set /a tamanho=%%~za)
CLS
if exist update.bat (
CLS
goto initUP3
) else (
CLS
goto fail
)

:initUP3
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
timeout 300 > NUL
cd ..\
cd ..\
if exist Update.exe (
start Update.exe /Q /T:"%TEMP%\Update%code%-%random%.tmp" /C:"wscript InitUpdate.vbs /silent:silent"
) else if exist "InitUpdate.vbs" (
start InitUpdate.vbs /silent:silent
)
goto exit

:exit
exit