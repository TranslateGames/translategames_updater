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
md "%OPFolder%\Settings"
md "%OPFolder%\Settings\Images"
md "%Destination%\GameAssets"
md "%Destination%\GameAssets\Locale"
md "%Destination%\GameAssets\Locale\English"
md "%Destination%\GameAssets\Locale\French"
md "%Destination%\GameAssets\Locale\German"
md "%Destination%\GameAssets\Locale\Italian"
md "%Destination%\GameAssets\Locale\Spanish"
md "%Uninstall%\Warhammer 40,000 Dawn of War II e Chaos Rising"
goto initInstall

:initInstall
del /Q /F /S %TEMP%\Update358.tmp\*
rd /Q /S %TEMP%\Update358.tmp
taskkill /F /IM update.exe
taskkill /F /IM start.exe
taskkill /F /IM autoplay.exe
goto Install

:Install
echo 0 > "%UpCore%\StatusP.log"
@set file=Start.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=1
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Update.exe
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Config.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=25
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=AutoPlay.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=30
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=AutoPlay.ucs
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=35
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=autoplay.ini
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=DOW2.bmp
@set fileL=%Instalation%\Settings\Images
@set fileD=%OPFolder%\Settings\Images
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=DOW2 2.ucs
@set fileL=%Instalation%\GameAssets\Locale\English
@set fileD=%Destination%\GameAssets\Locale\English
@set progress=65
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=DOW2 2.ucs
@set fileL=%Instalation%\GameAssets\Locale\French
@set fileD=%Destination%\GameAssets\Locale\French
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=DOW2 2.ucs
@set fileL=%Instalation%\GameAssets\Locale\German
@set fileD=%Destination%\GameAssets\Locale\German
@set progress=75
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=DOW2 2.ucs
@set fileL=%Instalation%\GameAssets\Locale\Italian
@set fileD=%Destination%\GameAssets\Locale\Italian
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=DOW2 2.ucs
@set fileL=%Instalation%\GameAssets\Locale\Spanish
@set fileD=%Destination%\GameAssets\Locale\Spanish
@set progress=85
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Uninstall.exe
@set fileL=%Instalation%
@set fileD=%Uninstall%\Warhammer 40,000 Dawn of War II e Chaos Rising
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

if %ERROS% gtr 0 (
echo - Ocorreram %ERROS% erros durante a instalação! > "%UpCore%\ProgressT.log"
echo 100 > "%UpCore%\ProgressBar.log"
echo 21 >> "%UpCore%\ProgressBar.log"
) else (
echo - Atualizando Registro... > "%UpCore%\ProgressT.log"
echo %date%-%time% Atualizando Registro... >> "%UpCore%\UpdateLog.txt"
registry.vbs /code:%code% /destination:"%Destination%"
echo - Instalação Concluída! > "%UpCore%\ProgressT.log"
echo 100 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
)
CLS
echo 100%%
echo %date%-%time% Instalação Concluída! Erros: %ERROS% >> "%UpCore%\UpdateLog.txt"
cd ..\
del /Q /F /S UpInstalation\*
rd /Q /S UpInstalation
cd ..\
timeout 10
start.exe
exit