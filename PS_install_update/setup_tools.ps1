# CLI Updater - Update script for npm, pnpm, yarn, Firebase CLI, Git CLI, nvm, Vercel CLI, Next.js, Go, GitHub CLI, Git CLI for Windows, and Python

function Install-Package {
    param (
        [string]$packageName,
        [string]$installCommand
    )

    Write-Host "Installing $packageName..."
    Invoke-Expression -Command $installCommand
}

    Write-Host -ForegroundColor White -BackgroundColor Black " Package Installer v1.0"
    Write-Host -ForegroundColor White -BackgroundColor Black " Easily install software packages from multiple categories."
    
function Update-Package {
    param (
        [string]$packageName,
        [string]$updateCommand
    )

    Write-Host "Updating $packageName..."
    Invoke-Expression -Command $updateCommand
}

function Install-React {
    Write-Host "Installing create-react-app..."
    Install-Package -packageName "create-react-app" -installCommand "npm install -g create-react-app"
}

function Install-TypeScript {
    Write-Host "Installing TypeScript..."
    Install-Package -packageName "TypeScript" -installCommand "npm install -g typescript"
}

function Install-TypeScriptTypes {
    Write-Host "Installing TypeScript type definitions..."
    Install-Package -packageName "TypeScript type definitions" -installCommand "npm install -g @types/node"
}

function Install-ESLint {
    Write-Host "Installing ESLint..."
    Install-Package -packageName "ESLint" -installCommand "npm install -g eslint"
}

function Install-Prettier {
    Write-Host "Installing Prettier..."
    Install-Package -packageName "Prettier" -installCommand "npm install -g prettier"
}

function Install-WSL {
    Write-Host "Installing Windows Subsystem for Linux (WSL)..."
    Start-Process -FilePath "wsl.exe" -ArgumentList "--install" -Wait
    Write-Host "WSL installed successfully. Restart your computer to complete the installation."
}


function Install-Go {
    $url = "https://golang.org/dl/go1.17.1.windows-amd64.msi"
    $output = "go-installer.msi"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output -Wait
    Remove-Item $output
    Write-Host "Go installed successfully"

    Write-Host "Setting Go path..."
    $goPath = Read-Host -Prompt "Enter the desired Go path (e.g., C:\GoPath)"
    $env:GOPATH = $goPath
    [System.Environment]::SetEnvironmentVariable("GOPATH", $goPath, "User")
    Write-Host "Go path set to: $goPath"
}


function Install-GitHubCLI {
    $url = "https://github.com/cli/cli/releases/download/v2.0.0/gh_2.0.0_windows_amd64.msi"
    $output = "gh-installer.msi"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output -Wait
    Remove-Item $output
    Write-Host "GitHub CLI installed successfully"
}

function Install-GitForWindows {
    $url = "https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.1/Git-2.33.0-64-bit.exe"
    $output = "git-installer.exe"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output -Wait
    Remove-Item $output
    Write-Host "Git for Windows installed successfully"
}

function Install-Python {
$url = "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe"
$output = "python-installer.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output -ArgumentList "/passive InstallAllUsers=1 PrependPath=1" -Wait
Remove-Item $output
Write-Host "Python installed successfully"
}

function Install-Nodejs {
    $url = "https://nodejs.org/dist/v16.13.0/node-v16.13.0-x64.msi"
    $output = "nodejs-installer.msi"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output -Wait
    Remove-Item $output
    Write-Host "Node.js and npm installed successfully"
}

function Install-VSCode {
    $url = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"
    $output = "vscode-installer.exe"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output -Wait
    Remove-Item $output
    Write-Host "Visual Studio Code installed successfully"
}

function Install-GitHubDesktop {
    $url = "https://github.com/desktop/desktop/releases/download/release-2.9.3/GitHubDesktopSetup.exe"
    $output = "github-desktop-installer.exe"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output -Wait
    Remove-Item $output
    Write-Host "GitHub Desktop installed successfully"
}

function install_all{
    Install-Nodejs
    Install-Go
    Install-GitForWindows
    Install-GitHubDesktop
    Install-VSCode
    Install-Nodejs
    Install-Python
    Install-WSL
    Install-Prettier
    Install-ESLint
    Install-TypeScript
    Install-React
    Install-TypeScriptTypes
    npm install 
}

function print_instructions {
    Write-Host "----------------------"
    Write-Host "|      UPLOADER      |"
    Write-Host "----------------------"
    Write-Host "Welcome to Uploader, a software for uploading files to the cloud. Please select the actions you wish to perform:"
    Write-Host "Use the arrow keys to navigate and the space bar to select/deselect an option. Press Enter when you're done."
    Write-Host ""
}

function Get-Selection {
    param (
        [array]$Options
    )

    print_instructions
    $selectedOptions = @()
    $optionsLength = $Options.Length

    for ($i = 0; $i -lt $optionsLength; $i++) {
        $selectedOptions += $false
    }

    $selectedIndex = 0
    $done = $false

    while (-not $done) {
        Clear-Host
        for ($i = 0; $i -lt $optionsLength; $i++) {
            $prefix = if ($selectedOptions[$i]) { '[x]' } else { '[ ]' }
            $highlighted = ($i -eq $selectedIndex)

            if ($highlighted) {
                Write-Host ("`e[47m`e[30m{0}`e[0m {1}  <- Currently selected" -f $prefix, $Options[$i])
            } else {
                Write-Host ("{0} {1}" -f $prefix, $Options[$i])
            }
        }

        $keyInfo = $host.UI.RawUI.ReadKey('IncludeKeyUp,NoEcho')
        $key = $keyInfo.VirtualKeyCode

        switch ($key) {
            32 { $selectedOptions[$selectedIndex] = -not $selectedOptions[$selectedIndex] } # Space
            38 { $selectedIndex--; if ($selectedIndex -lt 0) { $selectedIndex = $optionsLength - 1 } } # Up arrow
            40 { $selectedIndex++; if ($selectedIndex -ge $optionsLength) { $selectedIndex = 0 } } # Down arrow
            13 { $done = $true } # Enter
        }
    }

    Clear-Host
    $selectedOptions
}

$availablePackages = @{
    "InstallGo" = { Install-Go };
    "InstallGitHub CLI" = { Install-GitHubCLI };
    "InstallGit CLI" = { Install-GitForWindows };
    "InstallPython" = { Install-Python };
    "InstallNode.js" = { Install-Nodejs };
    "InstallVSCode" = { Install-VSCode };
    "InstallGitHubDesktop" = { Install-GitHubDesktop };
    "npm" = "npm install -g npm";
    "pnpm" = "npm install -g pnpm";
    "yarn" = "npm install -g yarn";
    "FirebaseCLI" = "npm install -g firebase-tools";
    "VercelCLI" = "npm install -g vercel";
    "Next.js" = "npm install -g next";
    "React" = { Install-React };
    "TypeScript" = { Install-TypeScript };
    "TypeScript type definitions" = { Install-TypeScriptTypes };
    "ESLint" = { Install-ESLint };
    "Prettier" = { Install-Prettier };
    "WSL" = { Install-WSL };
}

$packageOptions = $availablePackages.Keys
$selections = Get-Selection -Options $packageOptions

for ($i = 0; $i -lt $packageOptions.Length; $i++) {
    if ($selections[$i]) {
        $selectedPackage = $packageOptions[$i]
        if ($availablePackages.ContainsKey($selectedPackage)) {
            $availablePackages[$selectedPackage].Invoke()
        } else {
            Write-Host "Action '$selectedPackage' not found. Skipping..."
        }
    }
}

Write-Host "All requested actions completed"