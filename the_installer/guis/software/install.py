import tkinter as tk
import subprocess
import threading
import time
import tkinter as tk
import tkinter.ttk as ttk
import subprocess

class PackageInstallerGUI:
    def __init__(self, master):
        self.master = master
        master.title("Package Installer")

        self.packages = {
            "npm": "npm install -g npm",
            "pnpm": "npm install -g pnpm",
            "yarn": "npm install -g yarn",
            "Firebase CLI": "npm install -g firebase-tools",
            "Git CLI": "",
            "nvm": "",
            "Vercel CLI": "npm install -g vercel",
            "Next.js": "npm install -g next",
            "Go": self.install_go,
            "GitHub CLI": self.install_github_cli,
            "Git CLI for Windows": self.install_git_cli_for_windows,
            "Python": self.install_python,
            "Docker": self.install_docker,
            "postgreSQL": self.install_postgresql,
            "MongoDB": self.install_mongodb,
            "Redis": self.install_redis,
            "node.js": self.install_nodejs,
            "vscode": self.install_vscode,
            "chrome": self.install_chrome,
            "firefox": self.install_firefox, 
        }

        self.selected_packages = {}

        self.checkbox_vars = {}
        row_num = 0
        for package, command in self.packages.items():
            self.checkbox_vars[package] = tk.BooleanVar()
            self.checkbox_vars[package].set(False)
            checkbox = tk.Checkbutton(master, text=package, variable=self.checkbox_vars[package], command=self.checkbox_changed)
            checkbox.grid(row=row_num, column=0, sticky="w")
            row_num += 1

        self.install_button = tk.Button(master, text="Install Selected Packages", command=self.install_selected_packages)
        self.install_button.grid(row=row_num, column=0, pady=(10,0))

        self.progress_bar = ttk.Progressbar(master, orient="horizontal", mode="indeterminate")
        self.status_label = tk.Label(master, text="")
        self.status_label.grid(row=row_num+1, column=0)

    def checkbox_changed(self):
        self.selected_packages = {package:command for package, command in self.packages.items() if self.checkbox_vars[package].get()}

    def install_selected_packages(self):
        if not self.selected_packages:
            self.status_label.config(text="No packages selected")
            return

        self.progress_bar.grid(row=4, column=0, pady=(10,0))
        self.progress_bar.start()

        for package, command in self.selected_packages.items():
            if command:
                subprocess.call(command, shell=True)
            else:
                method_name = package.lower().replace(' ', '_')
                getattr(self, method_name)()

        self.progress_bar.stop()
        self.progress_bar.grid_forget()

        self.status_label.config(text="All selected packages installed")

    def install_go(self):
        install_go_command = "powershell -Command \"& {Install-Package -PackageName 'go' -Scope CurrentUser}\""
        subprocess.call(install_go_command, shell=True)

        set_gopath_command = 'powershell -Command "& {[Environment]::SetEnvironmentVariable(\'GOPATH\', (Join-Path (Get-EnvironmentVariable(\'USERPROFILE\', \'User\') ) \'go\'), \'User\')}'
        subprocess.call(set_gopath_command, shell=True)
        print("GOPATH set to %USERPROFILE%\\go")

    def install_github_cli(self):
        install_github_cli_command = "powershell -Command \"& {Install-Package -PackageName 'gh' -Scope CurrentUser}\""
        subprocess.call(install_github_cli_command, shell=True)

    def install_git_cli_for_windows(self):
        install_git_cli_command = "powershell -Command \"& {choco install git -y}\""
        subprocess.call(install_git_cli_command, shell=True)

    def install_python(self):
        subprocess.call(["powershell", "-Command", "& {Invoke-WebRequest https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe -OutFile python-installer.exe; Start-Process python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1'; Remove-Item python-installer.exe}"])
        
    def install_docker(self):
        subprocess.call(["powershell", "-Command", "& {Install-Module -Name DockerMsftProvider -Repository PSGallery -Force; Install-Package -Name docker -ProviderName DockerMsftProvider}]"])

    def install_postgresql(self):
        subprocess.call(["powershell", "-Command", "& {choco install postgresql -y}"])

    def install_redis(self):
        subprocess.call(["powershell", "-Command", "& {choco install redis-64 -y}"])

    def install_mongodb(self):
        subprocess.call(["powershell", "-Command", "& {choco install mongodb -y}"])

    def install_nodejs(self):
        subprocess.call(["powershell", "-Command", "& {choco install nodejs-lts -y}"])

    def install_vscode(self):
        subprocess.call(["powershell", "-Command", "& {choco install vscode -y}"])

    def install_chrome(self):
        subprocess.call(["powershell", "-Command", "& {choco install googlechrome -y}"])

    def install_firefox(self):
        subprocess.call(["powershell", "-Command", "& {choco install firefox -y}"])
    
    def install_java(self):
        subprocess.call(["powershell", "-Command", "& {choco install jdk8 -y}"])

    def install_ruby(self):
        subprocess.call(["powershell", "-Command", "& {choco install ruby -y}"])

    def install_rust(self):
        subprocess.call(["powershell", "-Command", "& {choco install rust -y}"])

    def install_golangci_lint(self):
        subprocess.call(["powershell", "-Command", "& {choco install golangci-lint -y}"])

    def install_terraform(self):
        subprocess.call(["powershell", "-Command", "& {choco install terraform -y}"])

    def install_deno(self):
        subprocess.call(["powershell", "-Command", "& {iwr https://deno.land/x/install/install.ps1 -useb | iex}"])

    def install_nmap(self):
        subprocess.call(["powershell", "-Command", "& {choco install nmap -y}"])

    def install_powershell_core(self):
        subprocess.call(["powershell", "-Command", "& {choco install powershell-core -y}"])

    def install_virtualbox(self):
        subprocess.call(["powershell", "-Command", "& {choco install virtualbox -y}"])

    def install_vlc(self):
        subprocess.call(["powershell", "-Command", "& {choco install vlc -y}"])


root = tk.Tk()
gui = PackageInstallerGUI(root)
root.mainloop()
