@echo off
@set root=%CD%
for %%f in ("%root%") do @set root=%%~sf
title Iniciando...
echo Iniciando...
cd "%CD%\Builder"
start App.exe "%CD%\Builder.tgapp" /:Init /:"%root%"