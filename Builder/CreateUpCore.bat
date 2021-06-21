@echo off
@set root=%1
title Criando UpCore...
echo Criando UpCore...
cd %root%\UpCore
del UpCoreN.7z
del UpCore.tgpf
CLS
echo Criando UpCore...
%root%\Builder\Utils\7z.exe a UpCoreN.7z Config.tgapp CheckWgetCorrupt.vbs error.png Hash.tmp ImageData.tgib64 InterfaceMaintainer.vbs PostInstall.vbs UpdaterUI.tgapp RoutineRestart.vbs SilentService.vbs ProgressData.tgpd timeout.tmp UpdaterService.vbs wget.tmp
CLS
echo Criando UpCore...
ren UpCoreN.7z UpCore.tgpf
del %root%\Builder\Temp\UpCore.tgpf
move /Y UpCore.tgpf %root%\Builder\Temp
exit