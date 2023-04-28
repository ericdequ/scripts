@echo off
setlocal enabledelayedexpansion

echo Fetching the latest Go version...
powershell -Command "& { (Invoke-WebRequest -Uri 'https://golang.org/dl/?mode=json' -UseBasicParsing).Content }" > go_versions.json
for /F "usebackq tokens=1 delims=," %%A in (`type go_versions.json ^| findstr /C:"\"version\""`) do (
    set "latest_version=%%~A"
    goto :end
)
:end
set "latest_version=%latest_version:~10%"
echo The latest Go version is %latest_version%

set /P user_version="Enter the Go version you want to install (default is %latest_version%): "
if "%user_version%" == "" set "user_version=%latest_version%"

echo Installing Go %user_version%...

set "os="
set "processor="

if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  set "processor=amd64"
) else (
  set "processor=386"
)

if "%OS%" == "Windows_NT" (
  set "os=windows"
) else (
  set "os=darwin"
)

set "ext="
if "%os%" == "windows" (
  set "ext=msi"
) else (
  set "ext=pkg"
)

set "filename=go%user_version%.%os%-%processor%.%ext%"
set "download_url=https://golang.org/dl/%filename%"

echo Downloading %filename%...
powershell -Command "& { Invoke-WebRequest -Uri '%download_url%' -OutFile '%filename%' }"

if not exist "%filename%" (
  echo An error occurred while downloading the Go installer. Please check your internet connection and try again.
  goto :eof
)

echo Installing Go...
if "%os%" == "windows" (
  msiexec /i "%filename%" /qn /norestart
) else (
  sudo installer -pkg "%filename%" -target /
)
if errorlevel 1 (
  echo An error occurred while installing Go. Please check the logs for more information.
  goto :eof
)

echo Go %user_version% installed successfully.

echo Configuring Go environment variables...
set "GOROOT=%ProgramFiles%\Go"
set "GOPATH=%USERPROFILE%\go"
set "PATH=%PATH%;%GOROOT%\bin;%GOPATH%\bin"

echo Creating GOPATH directory...
if not exist "%GOPATH%" (
    mkdir "%GOPATH%"
)

echo Updating system environment variables...
reg add "HKCU\Environment" /v "Path" /t REG_SZ /d "%PATH%" /f
reg add "HKCU\Environment" /v "GOPATH" /t REG_SZ /d "%GOPATH%" /f
reg add "HKCU\Environment" /v "GOROOT" /t REG_SZ /d "%GOROOT%" /f

echo Go environment configured successfully. Please restart your terminal for the changes to take effect.

endlocal
