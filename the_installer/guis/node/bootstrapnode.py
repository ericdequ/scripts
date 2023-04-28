import os
import subprocess
import tkinter as tk
from tkinter import messagebox, ttk

def check_node():
    try:
        subprocess.run(["node", "--version"], check=True, capture_output=True, text=True)
        return True
    except subprocess.CalledProcessError:
        return False

def install_node():
    messagebox.showinfo("Info", "Please download and install Node.js from https://nodejs.org/en/download/")

def handle_install():
    if not check_node():
        install_node()
    else:
        messagebox.showinfo("Info", "Node.js/npm is already installed.")

def install_packages():
    selected_package_managers = [pm.get() for pm in package_manager_vars if pm.get()]
    selected_packages = [pkg.get() for pkg in package_vars if pkg.get()]

    if not selected_package_managers:
        messagebox.showwarning("Warning", "No package manager selected.")
        return
    if not selected_packages:
        messagebox.showwarning("Warning", "No packages selected.")
        return

    for pm in selected_package_managers:
        for pkg in selected_packages:
            subprocess.run([pm, "install", "-g", pkg])

    messagebox.showinfo("Info", f"Selected packages installed with {', '.join(selected_package_managers)}")

app = tk.Tk()
app.title("Node.js Package Manager")

frame = ttk.Frame(app, padding="10")
frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

check_btn = ttk.Button(frame, text="Check Node.js/npm Installation", command=handle_install)
check_btn.grid(column=0, row=0, padx=5, pady=5, sticky=(tk.W, tk.E))

package_manager_label = ttk.Label(frame, text="Select package manager(s):")
package_manager_label.grid(column=0, row=1, padx=5, pady=5, sticky=(tk.W, tk.E))

package_manager_list = ["npm", "yarn", "pnpm"]
package_manager_vars = [tk.StringVar() for _ in package_manager_list]

col_span = len(package_manager_list) // 3
for i, pm in enumerate(package_manager_list):
    chk = ttk.Checkbutton(frame, text=pm, variable=package_manager_vars[i], onvalue=pm, offvalue="")
    chk.grid(column=i//col_span, row=2, columnspan=col_span, padx=5, pady=2, sticky=(tk.W, tk.E))


package_label = ttk.Label(frame, text="Select packages to install:")
package_label.grid(column=0, row=5, padx=5, pady=5, sticky=(tk.W, tk.E))

package_list = [
    "react",
    "typescript",
    "firebase",
    "vercel",
    "express",
    "next",
    "gatsby",
    "graphql",
    "apollo-server",
    "mongodb",
    "mongoose",
    "passport",
    "jest",
    "enzyme",
    "eslint",
    "prettier",
    "webpack",
    "sass",
    "socket.io",
    "axios",
]

package_vars = [tk.StringVar() for _ in package_list]

package_frame = ttk.Frame(frame)
package_frame.grid(column=0, row=6, padx=5, pady=5, sticky=(tk.W, tk.E))

package_canvas = tk.Canvas(package_frame)
package_scrollbar = ttk.Scrollbar(package_frame, orient="vertical", command=package_canvas.yview)
package_list_frame = ttk.Frame(package_canvas)

package_canvas.configure(yscrollcommand=package_scrollbar.set)
package_canvas.pack(side="right", fill="y")

package_canvas.create_window(0, 0, window=package_list_frame, anchor='nw')

for i, pkg in enumerate(package_list):
    chk = ttk.Checkbutton(package_list_frame, text=pkg, variable=package_vars[i], onvalue=pkg, offvalue="")
    chk.grid(column=0, row=i, padx=5, pady=2, sticky=(tk.W, tk.E))

    package_list_frame.bind('<Configure>', lambda e: package_canvas.configure(scrollregion=package_canvas.bbox("all")))

install_btn = ttk.Button(frame, text="Install Packages", command=install_packages)
install_btn.grid(column=0, row=7, padx=5, pady=5, sticky=(tk.W, tk.E))

app.mainloop()

