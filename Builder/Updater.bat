@echo off
@set code=%1
@set arch=%2
@set root=%~3
for %%f in ("%root%") do @set root=%%~sf
@set local=%root%\Build\%code%
@set temp=%root%\Builder\Temp
@set file=Update.exe
@set sedfile=Updater.SED
@set mode=Update
@set reshacker=Utils\ResourceHacker.exe

CLS
echo Preparando Arquivos do Atualizador...
DefineUpdaterData.vbs /code:%code% /root:"%root%"
CLS
echo Criando Integridade do UpCore...
UpCoreIntegrity.vbs /code:%code% /root:"%root%"
CLS

del "%local%\%file%"
CLS
echo Criando Atualizador %code%...
if %arch%==64 (
%windir%\SysWOW64\iexpress /N /Q %temp%\%sedfile%
) else (
%windir%\System32\iexpress /N /Q %temp%\%sedfile%
)
CLS
echo Preparando Atualizador %code%...
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask ICON,,1033 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask ICONGROUP,,1033 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,1031 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,1033 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,1036 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,1040 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,1046 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,2070 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask VERSIONINFO,1,3082 -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action delete -mask MANIFEST,,1033 -log NUL
%reshacker% -open "%root%\Builder\%mode%Resources\VersionR.rc" -save "%root%\Builder\%mode%Resources\Version.res" -action compile -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action add -res "%root%\Builder\%mode%Resources\Icon.res" -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action add -res "%root%\Builder\%mode%Resources\Version.res" -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action add -res "%root%\Builder\%mode%Resources\Manifest.res" -log NUL
CLS
del "%root%\Builder\%mode%Resources\VersionR.rc"
del "%root%\Builder\%mode%Resources\Version.res"
CLS
echo Pronto!
exit