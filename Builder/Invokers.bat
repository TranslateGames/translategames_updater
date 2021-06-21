@echo off
@set code=%1
@set arch=%2
@set root=%~3
for %%f in ("%root%") do @set root=%%~sf
@set local=%root%\Build\%code%
@set temp=%root%\Builder\Temp
@set file=Config.exe
@set file2=Start.exe
@set sedfile=Config.SED
@set sedfile2=Start.SED
@set mode=Invoker
@set reshacker=Utils\ResourceHacker.exe

CLS
echo Preparando Arquivos dos Invocadores...
DefineInvokerData.vbs /code:%code% /root:"%root%"
CLS

del "%local%\%file%"
CLS
echo Criando Configurador %code%...
if %arch%==64 (
%windir%\SysWOW64\iexpress /N /Q %temp%\%sedfile%
) else (
%windir%\System32\iexpress /N /Q %temp%\%sedfile%
)
CLS
echo Preparando Configurador %code%...
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
%reshacker% -open "%root%\Builder\%mode%Resources\VersionConfigR.rc" -save "%root%\Builder\%mode%Resources\VersionConfig.res" -action compile -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action add -res "%root%\Builder\%mode%Resources\Icon.res" -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action add -res "%root%\Builder\%mode%Resources\VersionConfig.res" -log NUL
%reshacker% -open "%local%\%file%" -save "%local%\%file%" -action add -res "%root%\Builder\%mode%Resources\Manifest.res" -log NUL
CLS
del "%root%\Builder\%mode%Resources\VersionConfigR.rc"
del "%root%\Builder\%mode%Resources\VersionConfig.res"
CLS

del "%local%\%file2%"
CLS
echo Criando Inicializador %code%...
if %arch%=="64" (
%windir%\SysWOW64\iexpress /N /Q %temp%\%sedfile2%
) else (
%windir%\System32\iexpress /N /Q %temp%\%sedfile2%
)
CLS
echo Preparando Inicializador %code%...
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask ICON,,1033 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask ICONGROUP,,1033 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,1031 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,1033 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,1036 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,1040 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,1046 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,2070 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask VERSIONINFO,1,3082 -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action delete -mask MANIFEST,,1033 -log NUL
%reshacker% -open "%root%\Builder\%mode%Resources\VersionStartR.rc" -save "%root%\Builder\%mode%Resources\VersionStart.res" -action compile -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action add -res "%root%\Builder\%mode%Resources\Icon.res" -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action add -res "%root%\Builder\%mode%Resources\VersionStart.res" -log NUL
%reshacker% -open "%local%\%file2%" -save "%local%\%file2%" -action add -res "%root%\Builder\%mode%Resources\Manifest.res" -log NUL
CLS
del "%root%\Builder\%mode%Resources\VersionStartR.rc"
del "%root%\Builder\%mode%Resources\VersionStart.res"
CLS
echo Pronto!
exit