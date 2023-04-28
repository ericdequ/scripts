import time
import picamera

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
