from flask import Flask, request, jsonify, render_template
import requests
import mysql.connector
from datetime import datetime, timedelta
import time

app = Flask(__name__)

# Configuration
API_TIMEOUT = 10
MAX_RETRIES = 3
FALLBACK_COORDS = {"Latitude": 26.9124, "Longitude": 75.7873}  # Jaipur coordinates

def get_db_connection():
    try:
        return mysql.connector.connect(
            host="localhost",
            user="root",
            password="*****",
            database="database",
            connect_timeout=5
        )
    except mysql.connector.Error as err:
        print(f"Database connection error: {err}")
        raise

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_states', methods=['GET'])
def get_states():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT State_ID, State_Name FROM states ORDER BY State_Name")
        states = [{'id': row['State_ID'], 'name': row['State_Name']} for row in cursor.fetchall()]
        return jsonify({"success": True, "states": states})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/get_districts_by_state', methods=['POST'])
def get_districts_by_state():
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    state_id = request.json.get('state_id')
    if not state_id:
        return jsonify({"error": "State ID parameter missing"}), 400

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT District_ID, District_Name FROM districts WHERE State_ID = %s ORDER BY District_Name", (state_id,))
        districts = [{'id': row['District_ID'], 'name': row['District_Name']} for row in cursor.fetchall()]
        return jsonify({"success": True, "districts": districts})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/get_crops', methods=['POST'])
def get_crops():
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    district = request.json.get('district')
    if not district:
        return jsonify({"error": "District parameter missing"}), 400

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT District_ID FROM districts WHERE District_Name = %s", (district,))
        district_data = cursor.fetchone()
        if not district_data:
            return jsonify({"error": "District not found"}), 404

        cursor.execute("""
            SELECT DISTINCT c.Name, c.District_ID IS NULL AS is_general
            FROM crop c
            WHERE c.District_ID = %s OR c.District_ID IS NULL
            ORDER BY is_general, c.Name
        """, (district_data['District_ID'],))
        crops = [row['Name'] for row in cursor.fetchall()]
        return jsonify({"success": True, "crops": crops, "count": len(crops)})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/get_yearly_plan', methods=['POST'])
def get_yearly_plan():
    print("\n=== /get_yearly_plan endpoint called ===")
    try:
        if not request.is_json:
            return jsonify({"error": "Request must be JSON"}), 400
        data = request.get_json()
        district_id = data.get('district_id')
        print(f"Received district_id: {district_id}")

        if not district_id:
            return jsonify({"error": "District ID parameter missing"}), 400

        db = get_db_connection()
        cursor = db.cursor(dictionary=True)

        # Get district name
        cursor.execute("SELECT District_ID, District_Name FROM districts WHERE District_ID = %s", (district_id,))
        district = cursor.fetchone()
        if not district:
            return jsonify({"error": "District not found"}), 404

        # Actual beefed-up query
        cursor.execute("""
            SELECT 
                s.Name AS season,
                c.Name AS crop,
                CONCAT(cp.Expected_Yield, ' kg/ha') AS yield,
                IFNULL(soil.Soil_Type, 'Various') AS soil,
                IFNULL(cir.Irrigation_Requirement, 'Moderate') AS irrigation,
                IFNULL(cp.Disease_Risk, 'None') AS disease,
                IFNULL(cp.Recommended_Treatment, 'Regular monitoring') AS treatment,
                yfp.Sowing_Month AS sowing_month,
                yfp.Harvest_Month AS harvest_month,
                yfp.Avg_Growth_Days AS growth_duration
            FROM crop c
            JOIN crop_plan cp ON c.Crop_ID = cp.Crop_ID
            JOIN yearly_farming_plan yfp ON c.Crop_ID = yfp.Crop_ID
            JOIN season s ON c.Season_ID = s.Season_ID
            LEFT JOIN soil ON c.Soil_ID = soil.Soil_ID
            LEFT JOIN crop_irrigation_requirements cir ON c.Crop_ID = cir.Crop_ID
            WHERE (cp.District_ID = %s OR cp.District_ID IS NULL)
            ORDER BY s.Season_ID, cp.Expected_Yield DESC
            LIMIT 6
        """, (district_id,))

        crops = cursor.fetchall()
        seasons = {"Kharif": [], "Rabi": [], "Zaid": []}

        for row in crops:
            season_name = row.get('season')
            if season_name in seasons:
                seasons[season_name].append({
                    "crop": row.get('crop', 'Unknown'),
                    "yield": row.get('yield', 'N/A'),
                    "planting": row.get('sowing_month', 'Not specified'),
                    "harvest": row.get('harvest_month', 'Seasonal'),
                    "growth": f"{row.get('growth_duration', 'Varies')} days",
                    "soil": row.get('soil', 'Various'),
                    "irrigation": row.get('irrigation', 'Moderate'),
                    "disease": row.get('disease', 'None'),
                    "treatment": row.get('treatment', 'Regular monitoring')
                })

        return jsonify({
            "success": True,
            "district": district['District_Name'],
            "seasons": seasons
        })

    except Exception as e:
        print(f"ERROR: {str(e)}")
        return jsonify({"error": str(e), "message": "Failed to generate yearly plan"}), 500
    finally:
        if 'cursor' in locals(): cursor.close()
        if 'db' in locals(): db.close()


@app.route('/generate_plan', methods=['POST'])
def generate_plan_api():
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    data = request.get_json()
    required_fields = ['district', 'crop', 'mode']
    if not all(field in data for field in required_fields):
        return jsonify({"error": f"Missing required fields: {required_fields}"}), 400

    district = data['district']
    crop = data['crop']
    mode = data['mode']

    try:
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
            return jsonify({"error": "District not found"}), 404

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
        if not agro_data:
            return jsonify({"error": "No data for this crop in district"}), 404

    except mysql.connector.Error as err:
        return jsonify({"error": f"Database error: {err}"}), 500
    finally:
        cursor.close()
        db.close()

    if mode == "weather":
        try:
            coords = get_coordinates(district)
            weather_data = get_weather_forecast(coords['Latitude'], coords['Longitude'])
            plan = generate_plan(agro_data, weather_data)
            return jsonify({
                "type": "weather",
                "plan": plan,
                "location": f"{district}, {district_data['State_Name']}",
                "coordinates": coords,
                "crop": crop,
                "timestamp": datetime.now().isoformat()
            })
        except Exception as e:
            return jsonify({"error": f"Weather processing failed: {str(e)}"}), 500
    else:
        return jsonify({
            "type": "manual",
            "soil_info": {
                "type": agro_data.get('Soil_Type'),
                "nutrients": agro_data.get('Nutrient_Level')
            },
            "irrigation": {
                "requirement": agro_data.get('Irrigation_Requirement', 'Moderate'),
                "advice": get_irrigation_advice(agro_data)
            },
            "disease_risk": {
                "name": agro_data.get('crop_disease'),
                "treatment": agro_data.get('Treatment')
            },
            "location": f"{district}, {district_data['State_Name']}",
            "crop": crop,
            "weeks": [
                "Week 1: Soil preparation, light irrigation",
                "Week 2: Fertilizer application, monitor moisture",
                "Week 3: Increase irrigation due to heat rise",
                "Week 4: Pest control and moderate irrigation"
            ]
        })

def get_coordinates(district_name):
    geo_url = f"https://geocoding-api.open-meteo.com/v1/search?name={district_name}&count=1"
    for attempt in range(MAX_RETRIES):
        try:
            response = requests.get(geo_url, timeout=API_TIMEOUT)
            response.raise_for_status()
            data = response.json()
            if data.get("results"):
                return {
                    "Latitude": data["results"][0]["latitude"],
                    "Longitude": data["results"][0]["longitude"]
                }
        except requests.exceptions.RequestException as e:
            print(f"Geocoding attempt {attempt + 1} failed: {e}")
            if attempt == MAX_RETRIES - 1:
                return FALLBACK_COORDS
            time.sleep(1)
    return FALLBACK_COORDS

def get_weather_forecast(latitude, longitude):
    weather_url = (
        f"https://api.open-meteo.com/v1/forecast?"
        f"latitude={latitude}&longitude={longitude}"
        f"&daily=weathercode,temperature_2m_max,precipitation_sum"
        f"&timezone=auto"
    )
    for attempt in range(MAX_RETRIES):
        try:
            response = requests.get(weather_url, timeout=API_TIMEOUT)
            if response.status_code == 200:
                return response.json()
        except requests.exceptions.RequestException:
            pass
        time.sleep(1)
    today = datetime.now().date()
    return {
        "daily": {
            "time": [(today + timedelta(days=i)).isoformat() for i in range(7)],
            "temperature_2m_max": [30 + i for i in range(7)],
            "precipitation_sum": [0, 0, 2.5, 0, 5, 0, 0]
        }
    }

def generate_plan(agro_data, weather_data):
    plan = []
    for i in range(min(7, len(weather_data["daily"]["time"]))):
        date = weather_data["daily"]["time"][i]
        max_temp = weather_data["daily"]["temperature_2m_max"][i]
        rain = weather_data["daily"]["precipitation_sum"][i]
        irrigation_req = agro_data.get('Irrigation_Requirement', 'Moderate')
        if irrigation_req == 'Low':
            irrigate = "❌ No" if rain > 5 else "⚠️ Minimal"
        elif irrigation_req == 'High':
            irrigate = "✅ Yes" if rain < 15 else "⚠️ Reduced"
        else:
            irrigate = "✅ Yes" if rain < 5 else ("⚠️ Partial" if rain < 10 else "❌ No")
        disease_alert = ""
        if agro_data.get('crop_disease'):
            if rain > 5 and max_temp > 25:
                disease_alert = f"🚨 Fungal risk: {agro_data['crop_disease']}"
            elif max_temp > 35:
                disease_alert = f"🚨 Heat stress: {agro_data['crop_disease']}"
        plan.append([
            date,
            f"{max_temp}°C",
            f"{rain}mm",
            agro_data.get('Soil_Type', 'Unknown'),
            irrigation_req,
            irrigate,
            disease_alert if disease_alert else "✅ Normal"
        ])
    return plan

def get_irrigation_advice(agro_data):
    req = agro_data.get('Irrigation_Requirement', 'Moderate')
    if req == 'High':
        return "Water every 2-3 days, ensure good drainage"
    elif req == 'Low':
        return "Water sparingly, only when topsoil is dry"
    return "Water every 4-5 days, monitor soil moisture"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
