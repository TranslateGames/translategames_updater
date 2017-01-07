@echo off
@set ERROS=0
@set FATOR=1
Title Installing...
echo Translate Games Installer
if %code% gtr "0" (
echo %date%-%time% Copiando Arquivos... >> "%UpCore%\UpdateLog.txt"
goto FolderMap
) else (
exit
)

:FolderMap
md "%Base%"
md "%Base%\GameRanger"
md "%OPFolder%\Settings"
md "%OPFolder%\Settings\Images"
md "%Destination%\startup"
md "%Uninstall%\Age of Mythology The Titans Expansion"
goto initInstall

:initInstall
del /Q /F /S %TEMP%\Update356-2.tmp\*
rd /Q /S %TEMP%\Update356-2.tmp
taskkill /F /IM update.exe
taskkill /F /IM start.exe
taskkill /F /IM autoplay.exe
goto Install

:Install
echo IS > "%UpCore%\StatusP.log"
@set file=Start.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=10
echo - Processando Atualizador... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Update.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=20
echo - Processando Atualizador... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Config.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=30
echo - Processando Atualizador... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=AutoPlay.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=40
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=AutoPlay.ucs
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=50
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=autoplay.ini
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=60
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=XAOM.bmp
@set fileL=%Instalation%\Settings\Images
@set fileD=%OPFolder%\Settings\Images
@set progress=70
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

if not exist "%Destination%\startup\localex.cfg.tgbackup" (
move "%Destination%\startup\localex.cfg" "%Destination%\startup\localex.cfg.tgbackup"
)

@set file=localex.cfg
@set fileL=%Instalation%\startup
@set fileD=%Destination%\startup
@set progress=80
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

if not exist "%Destination%\xpacklanguage.dll.tgbackup" (
move "%Destination%\xpacklanguage.dll" "%Destination%\xpacklanguage.dll.tgbackup"
)

@set file=xpacklanguage.dll
@set fileL=%Instalation%
@set fileD=%Destination%
@set progress=90
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Uninstall.exe
@set fileL=%Instalation%
@set fileD=%Uninstall%\Age of Mythology The Titans Expansion
@set progress=95
echo - Preparando Desinstalador... > "%UpCore%\ProgressT.log"
if exist "%fileL%\%file%" (
if exist "%fileD%\%file%" (
if exist "%fileD%\%file%.temp" (
del "%fileD%\%file%.temp"
)
move "%fileD%\%file%" "%fileD%\%file%.temp"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível fazer backup do arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%fileL%\%file%" "%fileD%"
if not exist "%fileD%\%file%" (
move "%fileD%\%file%.temp" "%fileD%\%file%"
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Falha ao copiar arquivo em: "%fileD%\%file%", Backup restaurado! >> "%UpCore%\UpdateLog.txt"
) else (
del "%fileD%\%file%.temp"
)
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%fileL%\%file%" >> "%UpCore%\UpdateLog.txt"
)
echo -%progress%-2- > "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

if %ERROS% gtr 0 (
echo - Ocorreram %ERROS% erros durante a instalação! > "%UpCore%\ProgressT.log"
echo %date%-%time% Instalação Concluída! Erros: %ERROS% >> "%UpCore%\UpdateLog.txt"
echo -100-21- > "%UpCore%\ProgressBar.log"
) else (
if exist "registry.vbs" (
echo - Atualizando Registro... > "%UpCore%\ProgressT.log"
echo %date%-%time% Atualizando Registro... >> "%UpCore%\UpdateLog.txt"
registry.vbs /code:%code% /destination:"%Destination%"
echo %date%-%time% Instalação Concluída! >> "%UpCore%\UpdateLog.txt"
echo - Instalação Concluída! > "%UpCore%\ProgressT.log"
echo -100-2- > "%UpCore%\ProgressBar.log"
) else (
echo - Falha ao Atualizar Registro! > "%UpCore%\ProgressT.log"
echo %date%-%time% Falha ao Atualizar Registro! >> "%UpCore%\UpdateLog.txt"
echo %date%-%time% Arquivo de registro não encontrado! >> "%UpCore%\UpdateLog.txt"
echo -100-21- > "%UpCore%\ProgressBar.log"
)
)
CLS
echo 100%%
cd ..\
del /Q /F /S UpInstalation\*
rd /Q /S UpInstalation
cd ..\
timeout 10
start.exe
exit