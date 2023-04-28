import tkinter as tk
import subprocess
import json
from tkinter import ttk

class SecurityInstallerGUI:
    def __init__(self, master):
        self.master = master
        master.title("Cybersecurity Software Installer")

        # Add a font and font size to the title
        self.title_font = ("Helvetica", 18, "bold")
        master.title("Cybersecurity Software Installer")

        self.packages = {
            "Nmap": "choco install nmap -y",
            "Wireshark": "choco install wireshark -y",
            "Burp Suite": "choco install burpsuite -y",
            "Kali Linux": "choco install kali-linux -y",
            "Metasploit": "choco install metasploit-framework -y",
            "Snort": "choco install snort -y",
            "OpenVAS": "choco install openvas -y",
            "Gpg4win": "choco install gpg4win -y",
            "ClamAV": "choco install clamav -y",
            "Tor Browser": "choco install tor-browser -y",
            "Nessus": "choco install nessus -y",
            "Aircrack-ng": "choco install aircrack-ng -y",
            "Ettercap": "choco install ettercap -y",
            "Suricata": "choco install suricata -y"
        }

        self.selected_packages = {}

        self.checkbox_vars = {}
        row_num = 0
        for package, command in self.packages.items():
            self.checkbox_vars[package] = tk.BooleanVar()
            self.checkbox_vars[package].set(False)
            checkbox = tk.Checkbutton(master, text=package, font=("Helvetica", 12), variable=self.checkbox_vars[package], command=self.checkbox_changed)
            checkbox.grid(row=row_num, column=0, sticky="w")
            row_num += 1

        self.install_button = tk.Button(master, text="Install Selected Packages", font=("Helvetica", 12), command=self.install_selected_packages)
        self.install_button.grid(row=row_num, column=0, pady=(10,0))

        self.status_label = tk.Label(master, text="", font=("Helvetica", 12))
        self.status_label.grid(row=row_num+1, column=0)

        self.progress_bar = ttk.Progressbar(master, length=200, mode='indeterminate')
        self.progress_bar.grid(row=row_num+2, column=0, pady=(10,0))

        # Add padding to the window
        for i in range(3):
            master.grid_columnconfigure(i, pad=10)
            master.grid_rowconfigure(i, pad=10)

    def checkbox_changed(self):
        self.selected_packages = {package:command for package, command in self.packages.items() if self.checkbox_vars[package].get()}
        print(self.selected_packages)
    
    def check_choco_installed(self):
        result = subprocess.run(["powershell", "-Command", "choco --version"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result.returncode == 0

    def install_chocolatey(self):
        subprocess.call(["powershell", "-Command", "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"])

    def install_selected_packages(self):
        if not self.selected_packages:
            self.status_label.config(text="No packages selected", font=("Helvetica", 12))
            return

        if not self.check_choco_installed():
            self.status_label.config(text="Installing Chocolatey...", font=("Helvetica", 12))
            self.progress_bar.start()
            self.install_chocolatey()
            self.progress_bar.stop()

        self.status_label.config(text="Installing selected packages...", font=("Helvetica", 12))
        self.progress_bar.start()

        installed_packages = []
        for package, command in self.selected_packages.items():
            subprocess.call(["powershell", "-Command", command])
            installed_packages.append(package)

        with open('installed_packages.json', 'w') as f:
            json.dump(installed_packages, f)

        self.progress_bar.stop()
        self.status_label.config(text="All selected packages installed", font=("Helvetica", 12))

root = tk.Tk()
my_gui = SecurityInstallerGUI(root)
root.mainloop()
