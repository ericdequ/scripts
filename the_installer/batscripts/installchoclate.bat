@echo off
SET "choco_installed=0"
SET "script_path=C:\Users\ericd\Desktop\scripts\the_installer\shellscripts"

cd /D "%script_path%"

for /F %%I in ('where choco 2^>NUL') do (
  SET "choco_installed=1"
)

if %choco_installed% == 1 (
  echo Chocolatey is installed, updating...
  choco upgrade chocolatey -y
  if errorlevel 1 (
    echo An error occurred while updating Chocolatey. Please check the logs for more information.
  ) else (
    echo Chocolatey updated successfully.
  )
) else (
  echo Chocolatey not found, installing...
  powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
  if errorlevel 1 (
    echo An error occurred while installing Chocolatey. Please check the logs for more information.
  ) else (
    echo Chocolatey installed successfully.
    SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
  )
)
