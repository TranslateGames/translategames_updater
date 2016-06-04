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
del /Q /F /S %TEMP%\Update350.tmp\*
rd /Q /S %TEMP%\Update350.tmp
del /Q /F /S %TEMP%\Update350-3.tmp\*
rd /Q /S %TEMP%\Update350-3.tmp
del /Q /F /S %TEMP%\Update350-4.tmp\*
rd /Q /S %TEMP%\Update350-4.tmp
taskkill /F /IM update.exe
taskkill /F /IM start.exe
taskkill /F /IM installer.exe
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
echo 12 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 12%%

@set file=Update.exe
@set fileD=%OPFolder%\Winter Assault
@set fileD2=%OPFolder%\Winter Assault
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
echo 18 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 18%%

@set file=Config.exe
@set fileD=%OPFolder%\Winter Assault
@set fileD2=%OPFolder%\Winter Assault
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
echo 19 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 19%%

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
echo 20 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 20%%

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
echo 22 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 22%%

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
echo 23 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 23%%

@set file=Badges\Banner Brazil Badge.tga
@set fileD=%Destination%
@set fileD2=%Destination%\Badges
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
echo 24 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 24%%

@set file=Badges\Brazil Badge.tga
@set fileD=%Destination%
@set fileD2=%Destination%\Badges
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
echo 25 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 25%%

@set file=Badges\Tradu‡äes de Jogos Badge.tga
@set fileD=%Destination%
@set fileD2=%Destination%\Badges
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
echo 26 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 26%%

@set file=Banners\Brazil Banner.tga
@set fileD=%Destination%
@set fileD2=%Destination%\Banners
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
echo 27 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 27%%

@set file=Banners\Tradu‡äes de Jogos Banner.tga
@set fileD=%Destination%
@set fileD2=%Destination%\Banners
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
echo 28 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 28%%

@set file=Installer.exe
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
echo 29 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 29%%

@set file=BugReport\Chinese\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Chinese
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

@set file=BugReport\Czech\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Czech
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
echo 31 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 31%%

@set file=BugReport\English\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\English
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
echo 32 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 32%%

@set file=Winter Assault\autoplay.ini
@set fileD=%OPFolder%
@set fileD2=%OPFolder%\Winter Assault
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
echo 33 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 33%%

@set file=Winter Assault\AutoPlay.ucs
@set fileD=%OPFolder%
@set fileD2=%OPFolder%\Winter Assault
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
echo 34 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 34%%

@set file=Winter Assault\AutoPlay.exe
@set fileD=%OPFolder%
@set fileD2=%OPFolder%\Winter Assault
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

@set file=Winter Assault\Dark Crusade\Soulstorm\Setings\Images\W40k.bmp
@set fileD=%OPFolder%
@set fileD2=%OPFolder%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images
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
echo 36 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 36%%

@set file=Winter Assault\Dark Crusade\Soulstorm\Setings\Images\WXP.bmp
@set fileD=%OPFolder%
@set fileD2=%OPFolder%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images
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
echo 37 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 37%%

@set file=BugReport\French\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\French
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
echo 38 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 38%%

@set file=BugReport\German\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\German
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
echo 39 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 39%%

@set file=BugReport\Italian\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Italian
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

@set file=BugReport\Korean\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Korean
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
echo 41 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 41%%

@set file=BugReport\Korean_Blood\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Korean_Blood
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
echo 42 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 42%%

@set file=BugReport\Polish\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Polish
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
echo 43 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 43%%

@set file=BugReport\Russian\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Russian
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
echo 44 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 44%%

@set file=BugReport\Spanish\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Spanish
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

@set file=BugReport\Ukraine\BugReport 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\BugReport\Ukraine
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
echo 46 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 46%%

@set file=Engine\Locale\Chinese\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Chinese
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
echo 47 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 47%%

@set file=Engine\Locale\Czech\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Czech
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
echo 48 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 48%%

@set file=Engine\Locale\English\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\English
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
echo 49 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 49%%

@set file=Engine\Locale\French\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\French
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

@set file=Engine\Locale\German\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\German
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
echo 51 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 51%%

@set file=Engine\Locale\Italian\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Italian
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
echo 52 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 52%%

@set file=Engine\Locale\Korean\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Korean
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
echo 53 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 53%%

@set file=Engine\Locale\Korean_Blood\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Korean_Blood
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
echo 54 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 54%%

@set file=Engine\Locale\Polish\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Polish
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

@set file=Engine\Locale\Russian\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Russian
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
echo 56 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 56%%

@set file=Engine\Locale\Spanish\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Spanish
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
echo 57 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 57%%

@set file=Engine\Locale\Ukraine\Engine 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\Engine\Locale\Ukraine
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
echo 58 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 58%%

@set file=GraphicsOptions\Locale\Chinese\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Chinese
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
echo 59 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 59%%

@set file=GraphicsOptions\Locale\Czech\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Czech
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

@set file=GraphicsOptions\Locale\English\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\English
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
echo 61 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 61%%

@set file=GraphicsOptions\Locale\French\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\French
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
echo 62 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 62%%

@set file=GraphicsOptions\Locale\German\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\German
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
echo 63 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 63%%

@set file=GraphicsOptions\Locale\Italian\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Italian
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
echo 64 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 64%%

@set file=GraphicsOptions\Locale\Korean\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Korean
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

@set file=GraphicsOptions\Locale\Korean_Blood\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Korean_Blood
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
echo 66 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 66%%

@set file=GraphicsOptions\Locale\Polish\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Polish
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
echo 67 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 67%%

@set file=GraphicsOptions\Locale\Russian\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Russian
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
echo 68 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 68%%

@set file=GraphicsOptions\Locale\Spanish\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Spanish
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
echo 69 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 69%%

@set file=GraphicsOptions\Locale\Ukraine\GraphicsOptionsUtility 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\GraphicsOptions\Locale\Ukraine
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

@set file=W40k\Locale\Chinese\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Chinese
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
echo 71 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 71%%

@set file=W40k\Locale\Czech\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Czech
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
echo 72 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 72%%

@set file=W40k\Locale\English\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\English
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
echo 73 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 73%%

@set file=W40k\Locale\French\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\French
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
echo 74 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 74%%

@set file=W40k\Locale\German\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\German
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

@set file=W40k\Locale\Italian\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Italian
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
echo 76 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 76%%

@set file=W40k\Locale\Korean\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Korean
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
echo 77 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 77%%

@set file=W40k\Locale\Polish\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Polish
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
echo 78 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 78%%

@set file=W40k\Locale\Russian\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Russian
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
echo 79 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 79%%

@set file=W40k\Locale\Spanish\W40k 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\W40k\Locale\Spanish
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

@set file=WXP\Locale\Chinese\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Chinese
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

@set file=WXP\Locale\Czech\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Czech
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
echo 81 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 81%%

@set file=WXP\Locale\English\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\English
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
echo 82 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 82%%

@set file=WXP\Locale\French\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\French
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
echo 83 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 83%%

@set file=WXP\Locale\German\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\German
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
echo 84 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 84%%

@set file=WXP\Locale\Italian\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Italian
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

@set file=WXP\Locale\Korean\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Korean
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
echo 86 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 86%%

@set file=WXP\Locale\Polish\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Polish
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
echo 87 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 87%%

@set file=WXP\Locale\Russian\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Russian
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
echo 88 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 88%%

@set file=WXP\Locale\Spanish\WXP 2.ucs
@set fileD=%Destination%
@set fileD2=%Destination%\WXP\Locale\Spanish
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
echo 89 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 89%%

@set file=TranslationInfo.module
@set fileD=%Destination%
@set fileD2=%Destination%
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
echo 90 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 90%%

@set file=TranslationInfoW40kConfig.module
@set fileD=%Destination%
@set fileD2=%Destination%
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
echo 91 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 91%%

@set file=Tradu‡äes de Jogos Windows Öcone.ico
@set fileD=%Base%
@set fileD2=%Base%
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
echo 92 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 92%%

@set file=GameRangerSetup.exe
@set fileD=%Base%
@set fileD2=%Base%\GameRanger
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
echo 93 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 93%%

@set file=Uninstall.exe
@set fileD2=%Uninstall%\Warhammer 40,000 Dawn of War - Winter Assault
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
echo 94 > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo 94%%

@set file=Uninstall.exe
@set fileD2=%Uninstall%\Warhammer 40,000 Dawn of War
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