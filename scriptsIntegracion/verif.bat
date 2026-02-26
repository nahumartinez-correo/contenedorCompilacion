@echo off

if "%1"=="" goto noparam

if "%2"=="" goto sinapp
ddstatus -n%1 -c %2
goto fin

:sinapp
ddstatus -n%1 -c -A
goto fin

:noparam
echo .
echo PARAMETROS INCOMPLETOS!!
echo USO: %0  PROJ [APLICACION]
echo .
echo PROJ= PROYECTO A ACTUALIZAR
echo APlICACION= APLICACION A CONSULTAR
goto fin

:fin

