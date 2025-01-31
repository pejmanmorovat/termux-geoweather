# Locate & Forecast 🌤️

A powerful and user-friendly Termux script to display your **public IP details**, **precise location (latitude and longitude)**, and **weather forecasts** based on your coordinates. Perfect for Termux users who want quick access to location and weather information.

---

## Features ✨

- **Display Public IP Details**: Get your public IP address, location (city, region, country), ISP, organization, and more.
- **Display My Latitude & Longitude**: Fetch and display your precise location using Termux's GPS capabilities.
- **Forecast Weather by Latitude and Longitude**: Enter latitude and longitude to get real-time weather forecasts, including temperature, humidity, wind speed, and more.
- **Beautiful Design**: Colorful and organized output for a great user experience.
- **Easy to Use**: Simple menu-driven interface for seamless navigation.

---

## Installation 🛠️

### Prerequisites
- **Termux**: Ensure you have Termux installed on your Android device.
- **Dependencies**: Install the following dependencies in Termux:
  ```bash
  pkg update && pkg upgrade
  pkg install curl jq
  ```

### Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/pejmanmorovat/termux-geoweather.git
   ```
2. Navigate to the repository:
   ```bash
   cd termux-geoweather
   ```
3. Make the script executable:
   ```bash
   chmod +x geoweather.sh
   ```

---

## Usage 🚀

Run the script in Termux:
```bash
bash termux-geoweather.sh
```

### Menu Options
1. **Display Public IP Details**: Shows your public IP address, location, ISP, and more.
2. **Display My Latitude & Longitude**: Fetches and displays your precise location using GPS.
3. **Forecast Weather by Latitude and Longitude**: Enter latitude and longitude to get weather forecasts.
4. **Exit**: Exit the script.

---

## Example Outputs 📄

### Option 1: Display Public IP Details
```
==============================================
== Public IP Details ==
==============================================
Public IP: 123.45.67.89
City: New York
Region: New York
Country: United States
Latitude: 40.7128
Longitude: -74.0060
ISP: Example ISP
Organization: Example Organization
Timezone: America/New_York
Google Maps Location: https://www.google.com/maps?q=40.7128,-74.0060
```

### Option 2: Display My Latitude & Longitude
```
Your precise location:
Latitude: 40.7128
Longitude: -74.0060
```

### Option 3: Forecast Weather by Latitude and Longitude
```
Enter latitude: 40.7128
Enter longitude: -74.0060
Location: New York, NY, USA

🌡️  Temperature: 15°C
🤔 Feels like: 14°C
💧 Humidity: 60%
☁️  Weather: Clear
🌬️  Wind Speed: 5 m/s
📊 Pressure: 1013 hPa
```

---

## Contributing 🤝

Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your message here"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

---

## License 📜

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Author 👨‍💻

- **Pejman Morovat**
- GitHub: [pejmanmorovat](https://github.com/pejmanmorovat)
- Email: pejmanmorovat@yahoo.com 

---

## Acknowledgments 🙏

- Thanks to [OpenWeatherMap](https://openweathermap.org/) for providing the weather API.
- Thanks to [ip-api.com](http://ip-api.com/) for providing the IP details API.

---

Enjoy using **Termux GeoWeather**! If you find this script helpful, don't forget to give it a ⭐ on GitHub!
