# Package Updater Script

This PowerShell script updates a selection of packages by running their respective install commands. The available packages are primarily focused on JavaScript development tools and include:

- npm
- pnpm
- yarn
- Firebase CLI
- Vercel CLI
- Next.js

## Usage

1. Save the script as `update_packages.ps1`.
2. Open a PowerShell terminal.
3. Navigate to the folder containing the script.
4. Run the script by entering `.\update_packages.ps1`.
5. You will see a list of available packages to update. Enter the names of the packages you want to update, separated by commas.
6. The script will update the selected packages, if available. If a package is not found, it will skip the package and continue with the next one.

## Example

```powershell
.\update_packages.ps1
```

Output:

```
Available packages to update:
npm
pnpm
yarn
Firebase CLI
Vercel CLI
Next.js
Enter the names of the packages to update, separated by commas: npm, yarn
Updating npm...
Updating yarn...
Update complete
```

## Notes

- The script checks if the provided package names are valid before attempting an update.
- Git CLI updates are only supported for Git for Windows on Windows systems. If the OS is not supported, a message will be displayed to update manually.