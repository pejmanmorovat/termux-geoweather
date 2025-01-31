#!/data/data/com.termux/files/usr/bin/bash

# Weather App Script with Beautiful Design
API_KEY="7d1db2870e8bfedee83b01b538b4d782"  # Replace with your OpenWeatherMap API key
BASE_URL="http://api.openweathermap.org/data/2.5/weather"
NOMINATIM_URL="https://nominatim.openstreetmap.org/reverse?format=json"

# ANSI Escape Codes for Colors and Styles
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"
BOLD="\033[1m"
UNDERLINE="\033[4m"

# Function to display a header
display_header() {
    echo -e "${CYAN}"
    echo "=============================================="
    echo "          🌤️  Locate & Forecast   🌤️          "
    echo "=============================================="
    echo -e "${RESET}"
}

# Function to display a footer
display_footer() {
    echo -e "${CYAN}"
    echo "=============================================="
    echo "  Creator $ Writer: Pejman Morovat"
    echo "=============================================="
    echo -e "${RESET}"
}

# Function to display public IP and location details
display_public_ip_details() {
    # Fetch public IP and location details using ip-api.com
    response=$(curl -s http://ip-api.com/json/)

    # Check if the API request was successful
    if [[ $response == *"status\":\"success\""* ]]; then
        # Extract details from the JSON response
        public_ip=$(echo "$response" | jq -r '.query')
        city=$(echo "$response" | jq -r '.city')
        region=$(echo "$response" | jq -r '.regionName')
        country=$(echo "$response" | jq -r '.country')
        latitude=$(echo "$response" | jq -r '.lat')
        longitude=$(echo "$response" | jq -r '.lon')
        isp=$(echo "$response" | jq -r '.isp')
        organization=$(echo "$response" | jq -r '.org')
        timezone=$(echo "$response" | jq -r '.timezone')

        # Display public IP and location details
        echo -e "${CYAN}"
        echo "=============================================="
        echo "== Public IP Details =="
        echo "=============================================="
        echo -e "${RESET}"
        echo "Public IP: $public_ip"
        echo "City: $city"
        echo "Region: $region"
        echo "Country: $country"
        echo "Latitude: $latitude"
        echo "Longitude: $longitude"
        echo "ISP: $isp"
        echo "Organization: $organization"
        echo "Timezone: $timezone"

        # Generate and display Google Maps link
        google_maps_link="https://www.google.com/maps?q=${latitude},${longitude}"
        echo "Google Maps Location: $google_maps_link"
    else
        # Display error message if the API request fails
        echo -e "${RED}Failed to fetch public IP details. Please check your internet connection.${RESET}"
    fi
}

# Function to fetch precise location using termux-location
get_precise_location() {
    LOCATION_DATA=$(termux-location)

    # Check if termux-location succeeded
    if [ -z "$LOCATION_DATA" ]; then
        echo -e "${RED}Failed to retrieve location. Ensure GPS is enabled and Termux has location permissions.${RESET}"
        exit 1
    fi

    # Extract latitude and longitude from the JSON output
    LATITUDE=$(echo "$LOCATION_DATA" | grep -o '"latitude":[^,]*' | cut -d':' -f2)
    LONGITUDE=$(echo "$LOCATION_DATA" | grep -o '"longitude":[^,]*' | cut -d':' -f2)

    # Display the results
    echo -e "${GREEN}Your precise location:${RESET}"
    echo -e "${BLUE}Latitude: ${BOLD}$LATITUDE${RESET}"
    echo -e "${BLUE}Longitude: ${BOLD}$LONGITUDE${RESET}"
    echo ""
}

# Function to fetch location information
get_location() {
    local lat=$1
    local lon=$2
    # Make API request using coordinates
    response=$(curl -s "${NOMINATIM_URL}&lat=${lat}&lon=${lon}")
    # Check if a location is returned
    if [[ $response == *"display_name"* ]]; then
        location=$(echo "$response" | jq -r '.display_name')
        echo -e "${GREEN}Location: ${BOLD}$location${RESET}"
        echo ""
    else
        echo -e "${RED}Error: Could not fetch location data.${RESET}"
        exit 1
    fi
}

# Function to fetch weather information
get_weather() {
    local lat=$1
    local lon=$2
    # Make API request using coordinates
    response=$(curl -s "${BASE_URL}?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric")
    # Check HTTP response
    if [[ $(echo "$response" | jq -r '.cod') == "200" ]]; then
        local temperature=$(echo "$response" | jq -r '.main.temp')
        local feels_like=$(echo "$response" | jq -r '.main.feels_like')
        local humidity=$(echo "$response" | jq -r '.main.humidity')
        local weather=$(echo "$response" | jq -r '.weather[0].description' | awk '{print toupper(substr($0, 1, 1)) substr($0, 2)}')
        local wind_speed=$(echo "$response" | jq -r '.wind.speed')
        local pressure=$(echo "$response" | jq -r '.main.pressure')
        # Print weather information with colors and styles
        echo -e "${YELLOW}🌡️  Temperature: ${BOLD}${temperature}°C${RESET}"
        echo -e "${YELLOW}🤔 Feels like: ${BOLD}${feels_like}°C${RESET}"
        echo -e "${YELLOW}💧 Humidity: ${BOLD}${humidity}%${RESET}"
        echo -e "${YELLOW}☁️  Weather: ${BOLD}${weather}${RESET}"
        echo -e "${YELLOW}🌬️  Wind Speed: ${BOLD}${wind_speed} m/s${RESET}"
        echo -e "${YELLOW}📊 Pressure: ${BOLD}${pressure} hPa${RESET}"
    else
        echo -e "${RED}Error: Could not fetch weather data. $(echo "$response" | jq -r '.message')${RESET}"
    fi
}

# Clear the screen and display the header
clear
display_header

# Main loop for user interaction
while true; do
    # Display menu options
    echo -e "${MAGENTA}Please choose an option:${RESET}"
    echo -e "${GREEN}1) Display Public IP Details${RESET}"
    echo -e "${GREEN}2) Display my Latitude & Longitude${RESET}"
    echo -e "${BLUE}3) Forecast weather by Latitude and Longitude${RESET}"
    echo -e "${RED}4) Exit${RESET}"
    read -p "> " choice

    case $choice in
        1)
            display_public_ip_details
            ;;
        2)
            get_precise_location
            ;;
        3)
            echo -e "${MAGENTA}Enter latitude:${RESET}"
            read -p "> " lat
            echo -e "${MAGENTA}Enter longitude:${RESET}"
            read -p "> " lon
            if [[ "$lat" =~ ^-?[0-9]+\.?[0-9]*$ ]] && [[ "$lon" =~ ^-?[0-9]+\.?[0-9]*$ ]]; then
                get_location "$lat" "$lon"
                get_weather "$lat" "$lon"
            else
                echo -e "${RED}Invalid latitude or longitude. Please enter numeric values.${RESET}"
            fi
            ;;
        4)
            echo -e "${RED}Exiting...${RESET}"
            break
            ;;
        *)
            echo -e "${RED}Invalid option selected. Please try again.${RESET}"
            ;;
    esac
done

# Display the footer
display_footer
