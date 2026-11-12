@echo off
setlocal

REM Ir siempre al directorio de este .bat
cd /d "%~dp0"

echo [1/3] Preparando entorno...
REM Anadir java\bin\ al PATH para que JPL encuentre las DLLs de Prolog
set PATH=%CD%\bin;%PATH%

if not exist "lib\jpl.jar" (
    echo ERROR: No se encuentra lib\jpl.jar
    pause
    exit /b 1
)
if not exist "bin" (
    echo ERROR: No existe la carpeta java\bin
    pause
    exit /b 1
)

echo [2/3] Compilando...
if not exist "bin\app" mkdir "bin\app"

REM Usamos sourcepath para que lea src/ y busque dependencias automáticamente.
REM El asterisco en lib/* le dice a Java que use todos los .jar de la carpeta.
javac -encoding UTF-8 ^
      -sourcepath src ^
      -d bin ^
      -cp "lib/*" ^
      src/app/Main.java

if errorlevel 1 (
    echo.
    echo *** ERROR DE COMPILACION ***
    pause
    exit /b 1
)

echo [3/3] Ejecutando...
java -cp "bin;lib/*" ^
     -Djpl.library.path="%CD%\bin" ^
     app.Main

endlocal
pause