import pandas as pd
import mysql.connector
from mysql.connector import Error

# Database config
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'ktom2005',
    'database': 'farmmanagement_dpsk'
}

# Complete India district-state mapping
CORRECT_MAPPINGS = {
    # North
    'Srinagar': 'Jammu and Kashmir',
    'Leh': 'Ladakh',
    'Shimla': 'Himachal Pradesh',
    # East
    'Patna': 'Bihar',
    'Kolkata': 'West Bengal',
    'Bhubaneswar': 'Odisha',
    'Ranchi': 'Jharkhand',
    # West
    'Jaipur': 'Rajasthan',
    'Ahmedabad': 'Gujarat',
    'Panaji': 'Goa',
    # South
    'Bengaluru': 'Karnataka',
    'Chennai': 'Tamil Nadu',
    'Thiruvananthapuram': 'Kerala',
    'Hyderabad': 'Telangana',
    # Central
    'Bhopal': 'Madhya Pradesh',
    'Raipur': 'Chhattisgarh',
    # Northeast
    'Guwahati': 'Assam',
    'Kohima': 'Nagaland',
    # Union Territories
    'Chandigarh': 'Chandigarh',
    'Puducherry': 'Puducherry'
}

def fix_all_inconsistencies():
    try:
        # Connect to database
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor(dictionary=True)
        
        # Disable safe updates
        cursor.execute("SET SQL_SAFE_UPDATES = 0")
        
        # Fix districts in batches
        for district, state in CORRECT_MAPPINGS.items():
            # Get correct state_id
            cursor.execute(f"SELECT State_ID FROM states WHERE State_Name = '{state}'")
            state_id = cursor.fetchone()
            
            if state_id:
                # Update all matching districts
                update_query = f"""
                UPDATE districts 
                SET State_ID = {state_id['State_ID']} 
                WHERE District_Name = '{district}'
                """
                cursor.execute(update_query)
                print(f"✅ Fixed {district} → {state}")
        
        # Remove duplicates (keep lowest ID)
        cursor.execute("""
        DELETE d1 FROM districts d1
        INNER JOIN districts d2 
        WHERE d1.District_ID > d2.District_ID 
        AND d1.District_Name = d2.District_Name
        """)
        
        # Re-enable safety
        cursor.execute("SET SQL_SAFE_UPDATES = 1")
        conn.commit()
        
        print("\n🔥 All fixes completed!")
        
    except Error as e:
        print(f"❌ Error: {e}")
    finally:
        if conn.is_connected():
            conn.close()

if __name__ == "__main__":
    print("🚀 Starting automated district fixing...")
    fix_all_inconsistencies()