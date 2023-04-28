import tkinter as tk
import tkinter.simpledialog as simpledialog
import tkinter.font as font
import paramiko
import time

def execute_command(remote_user, remote_host, remote_password, command):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(remote_host, username=remote_user, password=remote_password)
    _, stdout, _ = ssh.exec_command(command)
    output = stdout.read().decode('utf-8')
    ssh.close()
    return output

def camera(remote_user, remote_host, remote_password):
    output = execute_command(remote_user, remote_host, remote_password, 'python3 camera.py')
    print(output)

def read_dht22(remote_user, remote_host, remote_password):
    output = execute_command(remote_user, remote_host, remote_password, 'python3 dht22.py')
    print(output)

def get_raspi_info(remote_user, remote_host, remote_password):
    command = "vcgencmd measure_temp && top -b -n 1 | head -n 10 && netstat -tun"
    output = execute_command(remote_user, remote_host, remote_password, command)
    print(output)

root = tk.Tk()
root.title("Raspberry Pi Remote Control")
root.geometry("600x400")
root.configure(bg="lightgrey")

custom_font = font.nametofont("TkDefaultFont")
custom_font.configure(size=16)

frame = tk.Frame(root, bg="lightgrey", padx=30, pady=30)
frame.pack(fill=tk.X)

remote_user = simpledialog.askstring("Remote User", "Enter the remote user:")
remote_host = simpledialog.askstring("Remote Host", "Enter the remote host IP address:")
remote_password = simpledialog.askstring("Remote Password", "Enter the remote password:", show='*')

button_1 = tk.Button(frame, text="Camera", command=lambda: camera(remote_user, remote_host, remote_password), bg="lightblue", font=("Comic Sans MS", 16), width=20, height=2)
button_1.grid(row=0, column=0, padx=10, pady=10)

button_2 = tk.Button(frame, text="Read DHT22", command=lambda: read_dht22(remote_user, remote_host, remote_password), bg="lightblue", font=("Comic Sans MS", 16), width=20, height=2)
button_2.grid(row=0, column=1, padx=10, pady=10)

button_3 = tk.Button(frame, text="Raspi Info", command=lambda: get_raspi_info(remote_user, remote_host, remote_password), bg="lightblue", font=("Comic Sans MS", 16), width=20, height=2)
button_3.grid(row=1, column=0, padx=10, pady=10)

quit_button = tk.Button(frame, text="Quit", command=root.quit, bg="red", font=("Arial", 16), width=20, height=2)
quit_button.grid(row=1, column=1, padx=10, pady=10)

root.mainloop()
