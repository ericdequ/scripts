import json
import os
import subprocess
import tkinter as tk
from tkinter import ttk
from tkinter import messagebox

export_json_path = "C:/Users/ericd/Desktop/scripts/the_installer/guis/desktop/installed.json"
input_json_path = "C:/Users/ericd/Desktop/scripts/the_installer/guis/desktop/desktop.json"

# Load software data from input JSON file
with open(input_json_path, "r") as f:
    software_data = json.load(f)


def install_update_software(selected_software, update=False):
    action = "update" if update else "install"
    command = software_data[selected_software]["windows"][action]

    try:
        subprocess.Popen(command, shell=True)
    except Exception as e:
        print(f"Error: {e}")


def on_install_update_click(selected_software, update=False):
    if not selected_software:
        messagebox.showinfo("Info", "Please select a software package first.")
        return

    install_update_software(selected_software, update)
    export_installed_software(selected_software)


def export_installed_software(selected_software):
    installed_software = {}
    if os.path.exists(export_json_path):
        with open(export_json_path, "r") as f:
            installed_software = json.load(f)

    installed_software[selected_software] = software_data[selected_software]
    with open(export_json_path, "w") as f:
        json.dump(installed_software, f, indent=4)


def on_software_selected(event, description_var):
    selected_software = event.widget.get()
    description = software_data[selected_software]["description"]
    description_var.set(description)

def create_gui():
    root = tk.Tk()
    root.title("Software Installer")
    root.geometry("800x500")

    style = ttk.Style()
    style.configure("TLabel", font=("Arial", 14))
    style.configure("TButton", font=("Arial", 14), background="skyblue")
    style.configure("TCombobox", font=("Arial", 14))

    software_names = list(software_data.keys())
    selected_software = tk.StringVar(value=software_names[0])
    description_var = tk.StringVar(value=software_data[software_names[0]]["description"])

    label_title = ttk.Label(root, text="Select Software to Install or Update")
    label_title.grid(row=0, column=0, pady=10, padx=20, sticky="W")

    combo_software = ttk.Combobox(root, textvariable=selected_software, values=software_names, state="readonly")
    combo_software.grid(row=1, column=0, pady=10, padx=20, sticky="W")
    combo_software.bind("<<ComboboxSelected>>", lambda event: on_software_selected(event, description_var))

    description_label = ttk.Label(root, text="Description:")
    description_label.grid(row=2, column=0, pady=10, padx=20, sticky="W")

    description_text = ttk.Label(root, textvariable=description_var, wraplength=700, justify="left")
    description_text.grid(row=3, column=0, pady=10, padx=20, sticky="W")

    button_install = ttk.Button(root, text="Install", command=lambda: on_install_update_click(selected_software.get(), update=False))
    button_install.grid(row=4, column=0, pady=10, padx=20, sticky="W")

    button_update = ttk.Button(root, text="Update", command=lambda: on_install_update_click(selected_software.get(), update=True))
    button_update.grid(row=4, column=0, pady=10, padx=150, sticky="W")

    root.mainloop()

if __name__ == "__main__":
    create_gui()
