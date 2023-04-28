import os
import subprocess

def main():
    os_choice = get_os_choice()
    packages = {
        "node": {"linux": "curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs",
                 "mac": "brew install node@lts",
                 "windows": "choco install nodejs-lts"},
        "npm": {"linux": "sudo apt install npm",
                "mac": "brew install npm",
                "windows": "choco install npm"},
        "pnpm": {"all": "npm install -g pnpm"},
        "yarn": {"linux": "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg && echo \"deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null && sudo apt update && sudo apt install yarn",
                 "mac": "brew install yarn",
                 "windows": "choco install yarn"},
        "git": {"linux": "sudo apt-get install git",
                "mac": "brew install git",
                "windows": "choco install git"},
        "firebase": {"all": "npm install -g firebase-tools"},
        "vercel": {"all": "npm install -g vercel"},
        "python": {"linux": "sudo apt-get install python3",
                   "mac": "brew install python",
                   "windows": "choco install python"},
        "vscode": {"linux": "sudo snap install --classic code",
                   "mac": "brew install --cask visual-studio-code",
                   "windows": "choco install vscode"}
    }

    selected_packages = get_package_choices(packages)
    install_packages(os_choice, packages, selected_packages)

def get_os_choice():
    print("Select your operating system:")
    print("1. Linux")
    print("2. Mac")
    print("3. Windows")
    choice = input("Enter the number of your choice: ")

    if choice == "1":
        return "linux"
    elif choice == "2":
        return "mac"
    elif choice == "3":
        return "windows"
    else:
        print("Invalid choice. Please try again.")
        return get_os_choice()

def get_package_choices(packages):
    print("\nSelect the packages you want to install:")
    for idx, package in enumerate(packages, start=1):
        print(f"{idx}. {package}")

    choices = input("Enter the numbers of your choices separated by spaces: ")
    selected_packages = [package for idx, package in enumerate(packages, start=1) if str(idx) in choices.split()]
    return selected_packages

def install_packages(os_choice, packages, selected_packages):
    for package in selected_packages:
        print(f"\nInstalling {package}...")

        if os_choice in packages[package]:
            command = packages[package][os_choice]
        elif "all" in packages[package]:
            command = packages[package]["all"]
        else:
            print(f"Installation command for {package} on {os_choice} is not available.")
            continue

        try:
            subprocess.run(command, shell=True, check=True)
            print(f"{package} installed successfully.")
        except subprocess.CalledProcessError:
            print(f"Error installing {package}. Please check the installation command.")

    print("\nInstallation of selected packages completed.")

if __name__ == "__main__":
    main()



