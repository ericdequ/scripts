function Update-Package {
    param (
        [string]$packageName,
        [string]$installCommand
    )

    Write-Host "Updating $packageName..."
    Invoke-Expression -Command $installCommand
}

$availablePackages = @{
    "npm"           = "npm install -g npm";
    "pnpm"          = "npm install -g pnpm";
    "yarn"          = "npm install -g yarn";
    "Firebase CLI"  = "npm install -g firebase-tools";
    "Vercel CLI"    = "npm install -g vercel";
    "Next.js"       = "npm install -g next";
}

Write-Host "Available packages to update:"
$availablePackages.Keys | ForEach-Object { Write-Host $_ }

$selectedPackages = Read-Host -Prompt "Enter the names of the packages to update, separated by commas"
$packagesToUpdate = $selectedPackages -split ',' | ForEach-Object { $_.Trim() }

foreach ($package in $packagesToUpdate) {
    if ($availablePackages.ContainsKey($package)) {
        if ($package -eq "Git CLI") {
            if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Command git).Path -match '\\cmd\\') {
                Write-Host "Detected Windows, using Git for Windows updater."
                git update-git-for-windows
            } else {
                Write-Host "OS not supported for Git CLI update. Please update manually."
            }
        } else {
            Update-Package -packageName $package -installCommand $availablePackages[$package]
        }
    } else {
        Write-Host "Package '$package' not found. Skipping..."
    }
}

Write-Host "Update complete"
