@echo off
echo 🔄 Starting Auto Build Watch for AVtech Project
echo ==========================================
echo.

echo 📝 Initializing file monitoring...
echo.

:watch_loop
echo 👀 Watching for changes... (Press Ctrl+C to stop)
echo.

rem Watch for changes in source files
for /f "tokens=*" %%i in ('dir /s /b src\app\*.ts src\app\*.html src\app\*.css src\index.html src\styles.css angular.json package.json 2^>nul') do (
    call :check_file "%%i"
)

timeout /t 2 /nobreak >nul
goto watch_loop

:check_file
if exist "%~1" (
    for %%f in ("%~1") do (
        if "%%~tf" GTR "%last_check%" (
            echo 📝 Change detected: %~1
            echo 🔧 Building...
            echo Time: %TIME%
            call powershell -Command "./build-enhanced.ps1"
            if %ERRORLEVEL% == 0 (
                echo ✅ Build completed successfully!
                echo 🌐 Your website is updated and ready!
            ) else (
                echo ❌ Build failed!
            )
            echo.
            set "last_check=%%~tf"
        )
    )
)
goto :eof

:end
echo.
echo 👋 Auto build watch terminated.
pause
