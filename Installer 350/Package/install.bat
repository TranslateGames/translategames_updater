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
md "%OPFolder%\Winter Assault"
md "%OPFolder%\Winter Assault\Dark Crusade"
md "%OPFolder%\Winter Assault\Dark Crusade\Soulstorm"
md "%OPFolder%\Winter Assault\Dark Crusade\Soulstorm\Setings"
md "%OPFolder%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images"
md "%Destination%\Badges"
md "%Destination%\Banners"
md "%Destination%\BugReport"
md "%Destination%\BugReport\Chinese"
md "%Destination%\BugReport\Czech"
md "%Destination%\BugReport\English"
md "%Destination%\BugReport\French"
md "%Destination%\BugReport\German"
md "%Destination%\BugReport\Italian"
md "%Destination%\BugReport\Korean"
md "%Destination%\BugReport\Korean_Blood"
md "%Destination%\BugReport\Polish"
md "%Destination%\BugReport\Russian"
md "%Destination%\BugReport\Spanish"
md "%Destination%\BugReport\Ukraine"
md "%Destination%\Engine"
md "%Destination%\Engine\Locale"
md "%Destination%\Engine\Locale\Chinese"
md "%Destination%\Engine\Locale\Czech"
md "%Destination%\Engine\Locale\English"
md "%Destination%\Engine\Locale\French"
md "%Destination%\Engine\Locale\German"
md "%Destination%\Engine\Locale\Italian"
md "%Destination%\Engine\Locale\Korean"
md "%Destination%\Engine\Locale\Korean_Blood"
md "%Destination%\Engine\Locale\Polish"
md "%Destination%\Engine\Locale\Russian"
md "%Destination%\Engine\Locale\Spanish"
md "%Destination%\Engine\Locale\Ukraine"
md "%Destination%\GraphicsOptions"
md "%Destination%\GraphicsOptions\Locale"
md "%Destination%\GraphicsOptions\Locale\Chinese"
md "%Destination%\GraphicsOptions\Locale\Czech"
md "%Destination%\GraphicsOptions\Locale\English"
md "%Destination%\GraphicsOptions\Locale\French"
md "%Destination%\GraphicsOptions\Locale\German"
md "%Destination%\GraphicsOptions\Locale\Italian"
md "%Destination%\GraphicsOptions\Locale\Korean"
md "%Destination%\GraphicsOptions\Locale\Korean_Blood"
md "%Destination%\GraphicsOptions\Locale\Polish"
md "%Destination%\GraphicsOptions\Locale\Russian"
md "%Destination%\GraphicsOptions\Locale\Spanish"
md "%Destination%\GraphicsOptions\Locale\Ukraine"
md "%Destination%\W40k"
md "%Destination%\W40k\Locale"
md "%Destination%\W40k\Locale\Chinese"
md "%Destination%\W40k\Locale\Czech"
md "%Destination%\W40k\Locale\English"
md "%Destination%\W40k\Locale\French"
md "%Destination%\W40k\Locale\German"
md "%Destination%\W40k\Locale\Italian"
md "%Destination%\W40k\Locale\Korean"
md "%Destination%\W40k\Locale\Polish"
md "%Destination%\W40k\Locale\Russian"
md "%Destination%\W40k\Locale\Spanish"
md "%Destination%\WXP"
md "%Destination%\WXP\Locale"
md "%Destination%\WXP\Locale\Chinese"
md "%Destination%\WXP\Locale\Czech"
md "%Destination%\WXP\Locale\English"
md "%Destination%\WXP\Locale\French"
md "%Destination%\WXP\Locale\German"
md "%Destination%\WXP\Locale\Italian"
md "%Destination%\WXP\Locale\Korean"
md "%Destination%\WXP\Locale\Polish"
md "%Destination%\WXP\Locale\Russian"
md "%Destination%\WXP\Locale\Spanish"
md "%Uninstall%\Warhammer 40,000 Dawn of War"
md "%Uninstall%\Warhammer 40,000 Dawn of War - Winter Assault"
goto initInstall

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
@set progress=2
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

@set file=Installer.exe
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=3
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
@set progress=4
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

@set file=AutoPlay.ucs
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=5
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

@set file=autoplay.ini
@set fileL=%Instalation%
@set fileD=%OPFolder%
@set progress=6
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
@set fileD=%OPFolder%\Winter Assault
@set progress=12
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
@set fileD=%OPFolder%\Winter Assault
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=Autoplay.ini
@set fileL=%Instalation%\Winter Assault
@set fileD=%OPFolder%\Winter Assault
@set progress=22
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

@set file=Autoplay.ucs
@set fileL=%Instalation%\Winter Assault
@set fileD=%OPFolder%\Winter Assault
@set progress=23
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

@set file=Banner Brazil Badge.tga
@set fileL=%Instalation%\Badges
@set fileD=%Destination%\Badges
@set progress=24
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

@set file=Brazil Badge.tga
@set fileL=%Instalation%\Badges
@set fileD=%Destination%\Badges
@set progress=25
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

@set file=Tradu‡äes de Jogos Badge.tga
@set fileL=%Instalation%\Badges
@set fileD=%Destination%\Badges
@set progress=26
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

@set file=Brazil Banner.tga
@set fileL=%Instalation%\Banners
@set fileD=%Destination%\Banners
@set progress=27
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

@set file=Tradu‡äes de Jogos Banner.tga
@set fileL=%Instalation%\Banners
@set fileD=%Destination%\Banners
@set progress=28
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

@set file=AutoPlay.exe
@set fileL=%Instalation%\Winter Assault
@set fileD=%OPFolder%\Winter Assault
@set progress=29
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Chinese
@set fileD=%Destination%\BugReport\Chinese
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Czech
@set fileD=%Destination%\BugReport\Czech
@set progress=31
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\English
@set fileD=%Destination%\BugReport\English
@set progress=32
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

@set file=WXP.bmp
@set fileL=%Instalation%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images
@set fileD=%OPFolder%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images
@set progress=36
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

@set file=W40k.bmp
@set fileL=%Instalation%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images
@set fileD=%OPFolder%\Winter Assault\Dark Crusade\Soulstorm\Setings\Images
@set progress=37
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\French
@set fileD=%Destination%\BugReport\French
@set progress=38
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\German
@set fileD=%Destination%\BugReport\German
@set progress=39
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Italian
@set fileD=%Destination%\BugReport\Italian
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Korean
@set fileD=%Destination%\BugReport\Korean
@set progress=41
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Korean_Blood
@set fileD=%Destination%\BugReport\Korean_Blood
@set progress=42
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Polish
@set fileD=%Destination%\BugReport\Polish
@set progress=43
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Russian
@set fileD=%Destination%\BugReport\Russian
@set progress=44
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Spanish
@set fileD=%Destination%\BugReport\Spanish
@set progress=45
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

@set file=BugReport 2.ucs
@set fileL=%Instalation%\BugReport\Ukraine
@set fileD=%Destination%\BugReport\Ukraine
@set progress=46
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Chinese
@set fileD=%Destination%\Engine\Locale\Chinese
@set progress=47
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Czech
@set fileD=%Destination%\Engine\Locale\Czech
@set progress=48
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\English
@set fileD=%Destination%\Engine\Locale\English
@set progress=49
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\French
@set fileD=%Destination%\Engine\Locale\French
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\German
@set fileD=%Destination%\Engine\Locale\German
@set progress=51
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Italian
@set fileD=%Destination%\Engine\Locale\Italian
@set progress=52
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Korean
@set fileD=%Destination%\Engine\Locale\Korean
@set progress=53
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Korean_Blood
@set fileD=%Destination%\Engine\Locale\Korean_Blood
@set progress=54
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Polish
@set fileD=%Destination%\Engine\Locale\Polish
@set progress=55
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Russian
@set fileD=%Destination%\Engine\Locale\Russian
@set progress=56
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Spanish
@set fileD=%Destination%\Engine\Locale\Spanish
@set progress=57
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

@set file=Engine 2.ucs
@set fileL=%Instalation%\Engine\Locale\Ukraine
@set fileD=%Destination%\Engine\Locale\Ukraine
@set progress=58
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Chinese
@set fileD=%Destination%\GraphicsOptions\Locale\Chinese
@set progress=59
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Czech
@set fileD=%Destination%\GraphicsOptions\Locale\Czech
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\English
@set fileD=%Destination%\GraphicsOptions\Locale\English
@set progress=61
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\French
@set fileD=%Destination%\GraphicsOptions\Locale\French
@set progress=62
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\German
@set fileD=%Destination%\GraphicsOptions\Locale\German
@set progress=63
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Italian
@set fileD=%Destination%\GraphicsOptions\Locale\Italian
@set progress=64
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Korean
@set fileD=%Destination%\GraphicsOptions\Locale\Korean
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Korean_Blood
@set fileD=%Destination%\GraphicsOptions\Locale\Korean_Blood
@set progress=66
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Polish
@set fileD=%Destination%\GraphicsOptions\Locale\Polish
@set progress=67
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Russian
@set fileD=%Destination%\GraphicsOptions\Locale\Russian
@set progress=68
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Spanish
@set fileD=%Destination%\GraphicsOptions\Locale\Spanish
@set progress=69
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

@set file=GraphicsOptionsUtility 2.ucs
@set fileL=%Instalation%\GraphicsOptions\Locale\Ukraine
@set fileD=%Destination%\GraphicsOptions\Locale\Ukraine
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Chinese
@set fileD=%Destination%\W40k\Locale\Chinese
@set progress=71
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Czech
@set fileD=%Destination%\W40k\Locale\Czech
@set progress=72
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\English
@set fileD=%Destination%\W40k\Locale\English
@set progress=73
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\French
@set fileD=%Destination%\W40k\Locale\French
@set progress=74
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\German
@set fileD=%Destination%\W40k\Locale\German
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Italian
@set fileD=%Destination%\W40k\Locale\Italian
@set progress=76
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Korean
@set fileD=%Destination%\W40k\Locale\Korean
@set progress=77
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Polish
@set fileD=%Destination%\W40k\Locale\Polish
@set progress=78
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Russian
@set fileD=%Destination%\W40k\Locale\Russian
@set progress=79
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

@set file=W40k 2.ucs
@set fileL=%Instalation%\W40k\Locale\Spanish
@set fileD=%Destination%\W40k\Locale\Spanish
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Chinese
@set fileD=%Destination%\WXP\Locale\Chinese
@set progress=81
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Czech
@set fileD=%Destination%\WXP\Locale\Czech
@set progress=82
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\English
@set fileD=%Destination%\WXP\Locale\English
@set progress=83
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\French
@set fileD=%Destination%\WXP\Locale\French
@set progress=84
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\German
@set fileD=%Destination%\WXP\Locale\German
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Italian
@set fileD=%Destination%\WXP\Locale\Italian
@set progress=86
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Korean
@set fileD=%Destination%\WXP\Locale\Korean
@set progress=87
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Polish
@set fileD=%Destination%\WXP\Locale\Polish
@set progress=88
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Russian
@set fileD=%Destination%\WXP\Locale\Russian
@set progress=89
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

@set file=WXP 2.ucs
@set fileL=%Instalation%\WXP\Locale\Spanish
@set fileD=%Destination%\WXP\Locale\Spanish
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
echo %progress% > "%UpCore%\ProgressBar.log"
echo 2 >> "%UpCore%\ProgressBar.log"
CLS
echo %progress%%%

@set file=TranslationInfoW40kConfig.module
@set fileL=%Instalation%
@set fileD=%Destination%
@set progress=91
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

@set file=TranslationInfo.module
@set fileL=%Instalation%
@set fileD=%Destination%
@set progress=92
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

@set file=Tradu‡äes de Jogos Windows Öcone.ico
@set fileL=%Instalation%
@set fileD=%Base%
@set progress=93
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

@set file=GameRangerSetup.exe
@set fileL=%Instalation%
@set fileD=%Base%\GameRanger
@set progress=94
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
@set fileD=%Uninstall%\Warhammer 40,000 Dawn of War - Winter Assault
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

@set file=Uninstall.exe
@set fileL=%Instalation%
@set fileD=%Uninstall%\Warhammer 40,000 Dawn of War
@set progress=97
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