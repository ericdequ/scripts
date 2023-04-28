import tkinter as tk
import subprocess

class SecurityEnhancerGUI:
    def __init__(self, master):
        self.master = master
        master.title("Cybersecurity & Anonymity Enhancer")

        self.features = {
            "ProtonVPN": "choco install protonvpn -y",
            "Tor Browser": "choco install tor-browser -y",
            "ZoneAlarm Firewall": "choco install zonealarm-free-firewall -y",
            "Avast Free Antivirus": "choco install avast-free-antivirus -y",
            "Privacy Badger": "choco install privacy-badger -y",
            "HTTPS Everywhere": "choco install https-everywhere-chrome -y",
            "uBlock Origin": "choco install ublock-origin-chrome -y",
            "Malwarebytes": "choco install malwarebytes -y",
            "Bitwarden": "choco install bitwarden -y",
            "DuckDuckGo Privacy Essentials": "choco install duckduckgo-privacy-essentials-chrome -y"
        }

        self.selected_features = {}

        self.checkbox_vars = {}
        row_num = 0
        for feature, command in self.features.items():
            self.checkbox_vars[feature] = tk.BooleanVar()
            self.checkbox_vars[feature].set(False)
            checkbox = tk.Checkbutton(master, text=feature, variable=self.checkbox_vars[feature], command=self.checkbox_changed)
            checkbox.grid(row=row_num, column=0, sticky="w")
            row_num += 1

        self.install_button = tk.Button(master, text="Install Selected Features", command=self.install_selected_features)
        self.install_button.grid(row=row_num, column=0, pady=(10,0))

        self.status_label = tk.Label(master, text="")
        self.status_label.grid(row=row_num+1, column=0)

    def checkbox_changed(self):
        self.selected_features = {feature: command for feature, command in self.features.items() if self.checkbox_vars[feature].get()}

    def install_selected_features(self):
        if not self.selected_features:
            self.status_label.config(text="No features selected")
            return

        self.status_label.config(text="Installing selected features...")

        for feature, command in self.selected_features.items():
            subprocess.call(["powershell", "-Command", command])

        self.status_label.config(text="All selected features installed")

root = tk.Tk()
gui = SecurityEnhancerGUI(root)
root.mainloop()
