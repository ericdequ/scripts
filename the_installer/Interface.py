import json
import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import sys
import platform

input_json_file = "C:/Users/ericd/Desktop/scripts/the_installer/data/data.json"  # Path to the input JSON file
export_json_file = "C:/Users/ericd/Desktop/scripts/the_installer/data/installed.json"  # Path to the export JSON file


def get_system_data():
    system_data = {
        "current_os": platform.system(),
        "powershell_path": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
        "choco_install_url": "https://chocolatey.org/install.ps1",
        "homebrew_install_url": "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
    }
    return system_data

system_data = get_system_data()

# Load JSON data from the file
with open(input_json_file, 'r') as f:
    software_data = json.load(f)

def check_and_install_chocolatey():
    if get_system_data["current_os"] == "Windows":
        try:
            subprocess.check_output("choco", shell=True)
        except subprocess.CalledProcessError:
            if messagebox.askyesno("Install Chocolatey", "Chocolatey is not installed. Do you want to install it?"):
                install_command = f'@"{system_data["powershell_path"]}" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString(\'{system_data["choco_install_url"]}\'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin"'
                subprocess.call(install_command, shell=True)
                messagebox.showinfo("Chocolatey Installed", "Chocolatey has been installed. Please restart the application.")
                sys.exit()

def check_and_install_homebrew():
    if system_data["current_os"] == "Darwin":
        try:
            subprocess.check_output("brew", shell=True)
        except subprocess.CalledProcessError:
            if messagebox.askyesno("Install Homebrew", "Homebrew is not installed. Do you want to install it?"):
                install_command = f'/bin/bash -c "$(curl -fsSL {system_data["homebrew_install_url"]})"'
                subprocess.call(install_command, shell=True)
                messagebox.showinfo("Homebrew Installed", "Homebrew has been installed. Please restart the application.")
                sys.exit()

#check_and_install_chocolatey()
#check_and_install_homebrew()

def install_software(software):
    if get_system_data()["current_os"] in software_data[software]["AllowedOS"]:
        install_command = software_data[software].get(f'install_commands_{get_system_data()["current_os"].lower()}')
        if install_command:
            subprocess.call(install_command, shell=True)
        else:
            print(f'No install command found for {get_system_data()["current_os"]}.')
    else:
        print(f'{get_system_data()["current_os"]} is not supported for {software}.')

def on_install_button_click():
    selected_software = software_combobox.get()
    install_software(selected_software)

# Create the main window
root = tk.Tk()
root.title("Software Installer")

# Create and add widgets
software_label = ttk.Label(root, text="Select Software:")
software_label.grid(column=0, row=0)

software_combobox = ttk.Combobox(root, values=list(software_data.keys()))
software_combobox.grid(column=1, row=0)

install_button = ttk.Button(root, text="Install", command=on_install_button_click)
install_button.grid(column=2, row=0)

software_details_label = ttk.Label(root, text="Software Details:")
software_details_label.grid(column=0, row=1)

software_details = tk.Text(root, wrap=tk.WORD, width=80, height=20)
software_details.grid(column=1, row=1, columnspan=2)

def on_software_selection(event):
    selected_software = software_combobox.get()
    details = json.dumps(software_data[selected_software], indent=2)
    software_details.delete(1.0, tk.END)
    software_details.insert(tk.INSERT, details)

software_combobox.bind("<<ComboboxSelected>>", on_software_selection)

# Run the application
root.mainloop()
