:: launch docker if not active
@echo off
echo Checking if Docker is already running...

docker info >nul 2>&1
if %errorlevel%==0 (
    echo Docker is already running.
) else (
    echo Docker is not running. Starting Docker Desktop...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

    echo Waiting for Docker to start...
    :wait_loop
    docker info >nul 2>&1
    if errorlevel 1 (
        timeout /t 5 >nul
        goto wait_loop
    )
    echo Docker is now running.
)

:: Check pull status of models
docker compose logs -f ollama-init

pause