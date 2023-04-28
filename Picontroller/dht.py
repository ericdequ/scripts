import Adafruit_DHT

def read_dht22():
    sensor = Adafruit_DHT.DHT22
    pin = 4  # Assuming the DHT22 is connected to GPIO4
    humidity, temperature = Adafruit_DHT
