# 🌤️ Weather App - Bash Script

A simple yet powerful Bash script for retrieving weather forecasts and public IP details, designed for use with Termux on Android. This script utilizes OpenWeatherMap API and Termux's location service to provide real-time weather data.

---

## 📌 Features

✅ Fetch public IP and ISP details using `ip-api.com`\
✅ Retrieve precise latitude and longitude using `termux-location`\
✅ Get weather forecasts based on latitude & longitude\
✅ Display location details using OpenStreetMap's Nominatim API\
✅ Beautiful and interactive command-line interface with colors & emojis\
✅ Generates a Google Maps link for easy navigation\
✅ Lightweight, fast, and easy to use

---

## 🛠️ Requirements

Ensure you have the following installed in Termux:

- **Termux App** (Android)
- `curl` (for making API requests)
- `jq` (for parsing JSON responses)
- `termux-api` (for accessing location services)

Install dependencies using:

```bash
pkg update && pkg upgrade
pkg install curl jq termux-api
```

---

## 🔧 Setup

### 1️⃣ Get an OpenWeatherMap API Key

This script requires an API key from [OpenWeatherMap](https://home.openweathermap.org/api_keys):

1. Sign up at [OpenWeatherMap](https://home.openweathermap.org/users/sign_up)
2. Go to the [API Keys](https://home.openweathermap.org/api_keys) section
3. Copy your API key

### 2️⃣ Save the API Key

Edit the script and replace `YOUR_API_KEY_HERE`:

```bash
API_KEY="YOUR_API_KEY_HERE"
```

Alternatively, set it as an environment variable:

```bash
echo 'export WEATHER_API_KEY="YOUR_API_KEY_HERE"' >> ~/.bashrc
source ~/.bashrc
```

---

## 🚀 Usage

Run the script using:

```bash
bash weather.sh
```

You will see a menu with options:

```
==============================================
          🌤️  Locate & Forecast   🌤️          
==============================================
Please choose an option:
1) Display Public IP Details
2) Display my Latitude & Longitude
3) Forecast weather by Latitude and Longitude
4) Exit
```

### 🏠 Option 1: Public IP Details

Fetches your IP, ISP, city, and country details, along with a Google Maps link.

### 📍 Option 2: Precise Location

Uses Termux's GPS service to get accurate latitude and longitude.

### 🌦️ Option 3: Weather Forecast

1. Enter latitude and longitude manually.
2. The script fetches the location name and current weather details.

---

## ❗ Error Handling

- **API Key Errors:** Ensure your OpenWeatherMap API key is valid.
- **GPS Issues:** Enable location services and grant Termux location permission.
- **Internet Issues:** Check your connection before running the script.
- **Missing Dependencies:** Ensure `curl`, `jq`, and `termux-api` are installed.

---

## 🔄 Future Improvements

🚀 Planned updates:
- Auto-detect city based on IP when GPS is unavailable
- Support weather lookup by city name
- Additional weather details (e.g., UV index, air quality)

---

## 📝 License

This script is open-source and free to use.

🚀 Created by **Pejman Morovat**

