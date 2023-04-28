import os
import tkinter as tk
from tkinter import filedialog, messagebox
from tkinter.ttk import Progressbar

import pystig


class AssessmentTools(tk.Frame):
    def __init__(self, master=None, **kwargs):
        super().__init__(master, **kwargs)
        self.master = master
        self.tool = None
        self.file_path = None
        self.create_widgets()

    def create_widgets(self):
        openscap_button = tk.Button(self, text="OpenSCAP Assessment", command=lambda: self.show_file_selection_popup("openscap"))
        openscap_button.grid(row=0, column=0, padx=10, pady=10)

        pystig_button = tk.Button(self, text="pySTIG Assessment", command=lambda: self.show_file_selection_popup("pystig"))
        pystig_button.grid(row=0, column=1, padx=10, pady=10)

    def show_file_selection_popup(self, tool):
        self.tool = tool
        self.file_path = filedialog.askopenfilename(initialdir=os.path.expanduser("~"))

        if self.file_path:
            if self.tool == "openscap":
                self.assess_with_openscap()
            elif self.tool == "pystig":
                self.assess_with_pystig()

    def assess_with_openscap(self):
        # Perform the OpenSCAP assessment
        result = "OpenSCAP assessment completed.\n\n"
        result += "Replace this line with the actual assessment results."

        # Display the results in a popup
        self.show_results_popup("OpenSCAP Assessment Results", result)

    def assess_with_pystig(self):
        progress_popup = tk.Toplevel(self.master)
        progress_popup.title("Assessing with pySTIG")
        progress_label = tk.Label(progress_popup, text="Assessing with pySTIG...")
        progress_label.pack(padx=10, pady=10)
        progress = Progressbar(progress_popup, orient=tk.HORIZONTAL, length=300, mode='indeterminate')
        progress.pack(padx=10, pady=10)
        progress.start()

        # Perform the pySTIG assessment
        # Simulate the time-consuming task with after method
        self.after(3000, progress.stop)
        self.after(3000, progress_popup.destroy)

        result = "pySTIG assessment completed.\n\n"
        result += "Replace this line with the actual assessment results."

        # Display the results in a popup
        self.show_results_popup("pySTIG Assessment Results", result)

    def show_results_popup(self, title, result):
        results_popup = tk.Toplevel(self.master)
        results_popup.title(title)
        results_text = tk.Text(results_popup, wrap=tk.WORD, width=80, height=20)
        results_text.insert(tk.END, result)
        results_text.configure(state='disabled')
        results_text.pack(padx=10, pady=10)
        close_button = tk.Button(results_popup, text="Close", command=results_popup.destroy)
        close_button.pack(padx=10, pady=10)

class AssessmentToolsApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Assessment Tools")
        self.geometry("400x200")
       
