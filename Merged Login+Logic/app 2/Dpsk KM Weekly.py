import requests
import mysql.connector
from tabulate import tabulate

def get_db_connection():
    """Establish connection to MySQL database"""
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="ktom2005",
        database="farmmanagement_dpsk"
    )

def get_coordinates(district_name):
    """Fetch coordinates using Open-Meteo Geocoding API"""
    geo_url = f"https://geocoding-api.open-meteo.com/v1/search?name={district_name}&count=1"
    try:
        response = requests.get(geo_url)
        response.raise_for_status()
        data = response.json()
        if data.get("results"):
            return {
                "Latitude": data["results"][0]["latitude"],
                "Longitude": data["results"][0]["longitude"]
            }
    except requests.exceptions.RequestException:
        pass
    # Fallback to Jaipur if API fails
    return {"Latitude": 26.9124, "Longitude": 75.7873}

def display_available_crops(crops):
    """Show available crops as numbered list"""
    print("\n🌾 Available crops for your district:")
    for i, crop in enumerate(crops, 1):
        print(f"{i}. {crop}")
    
    while True:
        try:
            choice = int(input("Select crop (number): "))
            if 1 <= choice <= len(crops):
                return crops[choice-1]
            print(f"Please enter a number between 1 and {len(crops)}")
        except ValueError:
            print("Please enter a valid number")

def get_weather_forecast(latitude, longitude):
    """Fetch 7-day weather forecast from Open-Meteo"""
    weather_url = (
        f"https://api.open-meteo.com/v1/forecast?"
        f"latitude={latitude}&longitude={longitude}"
        f"&daily=weathercode,temperature_2m_max,precipitation_sum"
        f"&timezone=auto"
    )
    try:
        response = requests.get(weather_url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"⚠️ Weather API error: {e}")
        return None

def generate_plan(agro_data, weather_data):
    """Generate weekly farming plan based on weather and crop data"""
    plan = []
    for i in range(7):
        date = weather_data["daily"]["time"][i]
        max_temp = weather_data["daily"]["temperature_2m_max"][i]
        rain = weather_data["daily"]["precipitation_sum"][i]
        
        # Irrigation recommendation
        if rain > 10 or agro_data.get('Irrigation_Requirement') == 'Low':
            irrigate = "❌ No"
        elif rain > 5:
            irrigate = "⚠️ Partial"
        else:
            irrigate = "✅ Yes"
        
        # Disease alert
        disease_alert = ""
        if agro_data.get('crop_disease') and (rain > 5 or max_temp > 30):
            disease_alert = f"🚨 {agro_data['crop_disease']} - {agro_data.get('Treatment', 'Apply fungicide')}"

        plan.append([
            date,
            f"{max_temp}°C",
            f"{rain}mm",
            agro_data['Soil_Type'],
            agro_data.get('Irrigation_Requirement', 'Moderate'),
            irrigate,
            disease_alert if disease_alert else "✅ Normal"
        ])
    return plan

def main():
    # --- District Selection ---
    district = input("Enter your district name (e.g. Patna): ").strip().title()
    
    # Verify district exists
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT d.District_ID, s.State_Name 
        FROM districts d
        JOIN states s ON d.State_ID = s.State_ID
        WHERE d.District_Name = %s
    """, (district,))
    district_data = cursor.fetchone()
    
    if not district_data:
        print(f"❌ District '{district}' not found. Try: Indore, Bhopal, Pune etc.")
        db.close()
        return

    # --- Crop Selection ---
    cursor.execute("""
        SELECT DISTINCT c.Name 
        FROM crop c
        WHERE c.District_ID = %s OR c.District_ID IS NULL
        ORDER BY c.Name
    """, (district_data['District_ID'],))
    available_crops = [row['Name'] for row in cursor.fetchall()]
    
    if not available_crops:
        print(f"❌ No crops registered for {district}. Contact admin.")
        db.close()
        return
    
    # Show crop selection
    crop = display_available_crops(available_crops)

    # --- Get Agro Data ---
    cursor.execute("""
        SELECT 
            s.Soil_Type, s.Nutrient_Level,
            c.Yield_Estimate, cir.Irrigation_Requirement,
            cd.Name AS crop_disease, cd.Treatment
        FROM crop c
        JOIN soil s ON c.Soil_ID = s.Soil_ID
        LEFT JOIN crop_irrigation_requirements cir ON c.Crop_ID = cir.Crop_ID
        LEFT JOIN crop_disease cd ON c.Crop_ID = cd.Crop_ID
        WHERE c.Name = %s AND (c.District_ID = %s OR c.District_ID IS NULL)
        LIMIT 1
    """, (crop, district_data['District_ID']))
    agro_data = cursor.fetchone()
    cursor.close()
    
    if not agro_data:
        print(f"❌ No data available for {crop} in {district}")
        db.close()
        return

    # --- Weather Data ---
    coords = get_coordinates(district)
    weather_data = get_weather_forecast(coords['Latitude'], coords['Longitude'])
    
    if not weather_data:
        print("❌ Failed to get weather data")
        db.close()
        return

    # --- Generate Plan ---
    plan = generate_plan(agro_data, weather_data)

    # --- Display Results ---
    print(f"\n🌱 Weekly Plan for {crop} in {district}, {district_data['State_Name']}\n")
    print(tabulate(
        plan,
        headers=["Date", "Max Temp", "Rain", "Soil", "Water Need", "Irrigate?", "Alerts"],
        tablefmt="pretty"
    ))
    db.close()

if __name__ == "__main__":
    main()