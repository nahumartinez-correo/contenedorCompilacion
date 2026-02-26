@echo off
REM Script de limpieza de diccionarios mejorado para Mosaic
REM Lee la ubicacion del MOAPROJ desde el registro de Windows

REM Obtener ubicación del MOAPROJ desde el registro
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Mosaic\MOAPROJ" /v "Path" 2^>nul') do set MOAPROJ_PATH=%%i

REM Si no se encuentra en HKLM, buscar en HKCU
if "%MOAPROJ_PATH%"=="" (
    for /f "tokens=3" %%i in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Mosaic\MOAPROJ" /v "Path" 2^>nul') do set MOAPROJ_PATH=%%i
)

REM Si no se encuentra en el registro, usar variable de entorno
if "%MOAPROJ_PATH%"=="" set MOAPROJ_PATH=%MOAPROJ%

REM Si no se encuentra, usar ubicación por defecto
if "%MOAPROJ_PATH%"=="" (
    set MOAPROJ_PATH=C:\MOAPROJ
    echo ADVERTENCIA: No se encontro la ubicación del MOAPROJ en el registro.
    echo Usando ubicación por defecto: %MOAPROJ_PATH%
    echo Para configurar la ubicación, ejecute: configurar_moaproj.bat
    echo.
)

echo Usando MOAPROJ en: %MOAPROJ_PATH%
echo.

REM Verificar que se proporciono el parametro del proyecto
if "%1"=="" (
    echo ERROR: Debe especificar el nombre del proyecto.
    echo Uso: ddclr.bat [PROYECTO]
    echo Ejemplo: ddclr.bat V47.08
    exit /b 1
)

REM Ejecutar comandos de limpieza usando la ubicación dinámica
expdsc -n%1 -q -xBuildVersion lib | grep "BuildVersion" >>"%MOAPROJ_PATH%\%1\inte"
ddclrmod -n%1 -v >>"%MOAPROJ_PATH%\%1\inte"

echo Limpieza de diccionarios completada para el proyecto %1
echo Archivo inte actualizado en: %MOAPROJ_PATH%\%1\inte

