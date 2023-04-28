import tkinter as tk
import tkinter.simpledialog as simpledialog
import tkinter.font as font
import subprocess
import time
import picamera
import dht22

def camera(remote_user, remote_host, remote_password):
    subprocess.call(f"chmod +x runpiconfig.sh && ./runpiconfig.sh {remote_user} {remote_host} {remote_password}", shell=True)
    # Create a new PiCamera instance
    print("Initializing the camera module...")
    camera = picamera.PiCamera()

    # Configure camera settings
    print("Configuring camera settings...")
    camera.resolution = (1920, 1080)
    camera.framerate = 30

    # Warm up the camera
    print("Warming up the camera...")
    time.sleep(2)

    # Capture a photo
    print("Capturing a photo...")
    photo_filename = "photo.jpg"
    camera.capture(photo_filename)

    # Clean up the camera instance
    print("Closing the camera...")
    camera.close()

    print(f"Photo saved as {photo_filename}")

    

def read_dht22(remote_user, remote_host, remote_password):
    subprocess.call(f"chmod +x runpiconfig.sh && ./runpiconfig.sh {remote_user} {remote_host} {remote_password}", shell=True)
    try:
        temperature = dht22_sensor.temperature
        humidity = dht22_sensor.humidity
        return temperature, humidity
    except RuntimeError as error:
        print("Error reading from DHT22 sensor:", error.args[0])
        return None, None

    while True:
        # Read temperature and humidity from the DHT22 sensor
        temperature, humidity = read_dht22()

        if temperature is not None and humidity is not None:
            print(f"Temperature: {temperature}°C, Humidity: {humidity}%")

            # Blink the LED if the temperature is above a certain threshold
            if temperature > 25:
                print("Temperature is above 25°C, blinking LED")
                led.blink(on_time=1, off_time=1, n=3)

            # Wait before taking another reading
            time.sleep(2)
        else:
            print("Failed to read sensor data, retrying in 5 seconds")
            time.sleep(5)


def run_script_1(remote_user, remote_host, remote_password):
    subprocess.call(f"chmod +x runpiconfig.sh && ./runpiconfig.sh {remote_user} {remote_host} {remote_password}", shell=True)

def run_script_2(remote_user, remote_host, remote_password):
    output = subprocess.check_output(f"sudo chmod +x ./raspihealth.sh && sudo ./raspihealth.sh {remote_user} {remote_host} {remote_password}", shell=True)
    print(output.decode('utf-8'))

def run_enablepi(remote_user, remote_host, remote_password):
    subprocess.call(f"chmod +x enablepi.sh && ./enablepi.sh {remote_user} {remote_host} {remote_password}", shell=True)


root = tk.Tk()
root.title("Script Launcher")
root.geometry("500x350")

custom_font = font.nametofont("TkDefaultFont")
custom_font.configure(size=16)

frame = tk.Frame(root, bg="lightgrey")
frame.pack(fill=tk.X, padx=20, pady=20)

remote_user = simpledialog.askstring("Remote User", "Enter the remote user:")
remote_host = simpledialog.askstring("Remote Host", "Enter the remote host IP address:")
remote_password = simpledialog.askstring("Remote Password", "Enter the remote password:", show='*')

button_1 = tk.Button(frame, text="Run Script 1", command=lambda: run_script_1(remote_user, remote_host, remote_password), bg="lightblue", font=("Comic Sans MS", 16))
button_1.pack(pady=10)

button_2 = tk.Button(frame, text="Run Script 2", command=lambda: run_script_2(remote_user, remote_host, remote_password), bg="lightblue", font=("Comic Sans MS", 16))
button_2.pack(pady=10)

button_enablepi = tk.Button(frame, text="Run Enable Pi", command=lambda: run_enablepi(remote_user, remote_host, remote_password), bg="lightblue", font=("Comic Sans MS", 16))
button_enablepi.pack(pady=10)

quit_button = tk.Button(frame, text="Quit", command=root.quit, bg="red", font=("Arial", 16))
quit_button.pack(pady=10)

root.mainloop()
