@echo off
@set ERROS=0
@set FATOR=1
Title Installing...
echo Translate Games Installer
if %code% gtr "0" (
echo %date%-%time% Copiando Arquivos... >> "%UpCore%\UpdateLog.txt"
goto initInstall
) else (
exit
)

:initInstall
del /Q /F /S %TEMP%\Update357.tmp\*
rd /Q /S %TEMP%\Update357.tmp
taskkill /F /IM update.exe
taskkill /F /IM start.exe
taskkill /F /IM autoplay.exe
goto Install

:Install
@set file=Start.exe
@set fileD=%OPFolder%
@set fileD2=%OPFolder%
echo - Processando Atualizador... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 1 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 1%%

@set file=Update.exe
@set fileD=%OPFolder%
@set fileD2=%OPFolder%
echo - Processando Atualizador... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 10 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 10%%

@set file=Config.exe
@set fileD=%OPFolder%
@set fileD2=%OPFolder%
echo - Processando Atualizador... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 25 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 25%%

@set file=AutoPlay.exe
@set fileD=%OPFolder%
@set fileD2=%OPFolder%
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 30 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 30%%

@set file=AutoPlay.ucs
@set fileD=%OPFolder%
@set fileD2=%OPFolder%
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 35 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 35%%

@set file=autoplay.ini
@set fileD=%OPFolder%
@set fileD2=%OPFolder%
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 40 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 40%%

@set file=Settings\Images\DOW2R.bmp
@set fileD=%OPFolder%
@set fileD2=%OPFolder%\Settings\Images
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 45 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 45%%

@set file=Badges\Traducoes de Jogos.png
@set fileD=%UserProfile%\Documents\My Games\Dawn of War II - Retribution
@set fileD2=%UserProfile%\Documents\My Games\Dawn of War II - Retribution\Badges
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 50 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 50%%

@set file=Badges\Brasil.png
@set fileD=%UserProfile%\Documents\My Games\Dawn of War II - Retribution
@set fileD2=%UserProfile%\Documents\My Games\Dawn of War II - Retribution\Badges
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 55 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 55%%

@set file=Badges\Brasil Botao.png
@set fileD=%UserProfile%\Documents\My Games\Dawn of War II - Retribution
@set fileD2=%UserProfile%\Documents\My Games\Dawn of War II - Retribution\Badges
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 60 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 60%%

@set file=GameAssets\Locale\English\DOW2 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GameAssets\Locale\English
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 65 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 65%%

@set file=GameAssets\Locale\French\DOW2 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GameAssets\Locale\French
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 70 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 70%%

@set file=GameAssets\Locale\German\DOW2 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GameAssets\Locale\German
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 75 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 75%%

@set file=GameAssets\Locale\Italian\DOW2 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GameAssets\Locale\Italian
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 80 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 80%%

@set file=GameAssets\Locale\Spanish\DOW2 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GameAssets\Locale\Spanish
echo - Copiando Arquivos... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD%\%file%" (
del "%fileD%\%file%"
if exist "%fileD%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 85 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 85%%

@set file=Uninstall.exe
@set fileD2=%Uninstall%\Warhammer 40,000 Dawn of War II - Retribution
echo - Preparando Desinstalador... > "%UpCore%\ProgressT.log"
if exist "%file%" (
if exist "%fileD2%\%file%" (
del "%fileD2%\%file%"
if exist "%fileD2%\%file%" (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Não foi possível apagar o arquivo no destino: "%fileD2%\%file%" >> "%UpCore%\UpdateLog.txt"
)
)
xcopy /Y "%file%" "%fileD2%"
) else (
set /a ERROS=ERROS+FATOR
echo %date%-%time% ERRO %ERROS%: Arquivo local não encontrado para a instalação: "%file%" >> "%UpCore%\UpdateLog.txt"
)
echo 95 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 95%%

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
exit