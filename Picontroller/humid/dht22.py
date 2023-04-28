#!/usr/bin/env python3
import time
from gpiozero import LED
from board import D4
import adafruit_dht

# Set up the DHT22 sensor
dht22_sensor = adafruit_dht.DHT22(D4)

# Set up the GPIO pin for an LED
led = LED(17)

print("Setup complete")

def read_dht22():
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
