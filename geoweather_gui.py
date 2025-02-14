import tkinter as tk
import requests

# OpenWeatherMap API Key (Replace with your own)
API_KEY = "7d1db2870e8bfedee83b01b538b4d782"

# Function to get location details based on public IP
def get_ip_location():
    try:
        ip_response = requests.get("https://api64.ipify.org?format=json")
        ip_data = ip_response.json()
        ip = ip_data['ip']
        
        loc_response = requests.get(f"https://ipwhois.app/json/{ip}")
        loc_data = loc_response.json()
        
        location_details = (
            f"IP: {loc_data['ip']}\n"
            f"Country: {loc_data['country']}\n"
            f"Region: {loc_data['region']}\n"
            f"City: {loc_data['city']}\n"
            f"Latitude: {loc_data['latitude']}\n"
            f"Longitude: {loc_data['longitude']}\n"
        )
    except Exception as e:
        location_details = f"Error: {e}"
    
    output_text.delete(1.0, tk.END)
    output_text.insert(tk.END, location_details)

# Function to get weather forecast using latitude and longitude
def get_weather():
    lat = lat_entry.get()
    lon = lon_entry.get()
    try:
        weather_url = (
            f"http://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}"
            f"&units=metric&appid={API_KEY}"
        )
        weather_response = requests.get(weather_url)
        weather_data = weather_response.json()
        
        location_name = weather_data.get('name', 'Unknown Location')
        temp = weather_data['main']['temp']
        feels_like = weather_data['main']['feels_like']
        humidity = weather_data['main']['humidity']
        weather_desc = weather_data['weather'][0]['description']
        wind_speed = weather_data['wind']['speed']
        pressure = weather_data['main']['pressure']
        
        weather_details = (
            f"Location: {location_name}\n"
            f"Temperature: {temp}°C\n"
            f"Feels like: {feels_like}°C\n"
            f"Humidity: {humidity}%\n"
            f"Weather: {weather_desc.capitalize()}\n"
            f"Wind Speed: {wind_speed} m/s\n"
            f"Pressure: {pressure} hPa\n"
        )
    except Exception as e:
        weather_details = f"Error: {e}"
    
    output_text.delete(1.0, tk.END)
    output_text.insert(tk.END, weather_details)

# Create the main window
root = tk.Tk()
root.title("GeoWeather")
root.geometry("400x600")

# Title label
title_label = tk.Label(root, text="GeoWeather", font=("Helvetica", 24))
title_label.pack(pady=10)

# IP Details Button
ip_button = tk.Button(root, text="Display Public IP Details", bg="lightblue", command=get_ip_location)
ip_button.pack(pady=5)

# Latitude input
lat_label = tk.Label(root, text="Enter Latitude:")
lat_label.pack()
lat_entry = tk.Entry(root)
lat_entry.pack()

# Longitude input
lon_label = tk.Label(root, text="Enter Longitude:")
lon_label.pack()
lon_entry = tk.Entry(root)
lon_entry.pack()

# Get Weather Button
weather_button = tk.Button(root, text="Get Weather Forecast", bg="lightgreen", command=get_weather)
weather_button.pack(pady=10)

# Footer Label (Moved above the output box)
footer_label = tk.Label(root, text="Creator & Writer: Pejman Morovat", font=("Helvetica", 10))
footer_label.pack()

# Output Text Box
output_text = tk.Text(root, height=15, width=40)
output_text.pack(pady=10)

# Run the application
root.mainloop()
