import mysql.connector
import sys

try:
    import bcrypt
except ImportError:
    print("Installing missing bcrypt package...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "bcrypt"])
    import bcrypt

def update_credentials():
    db = mysql.connector.connect(
        host="localhost",
        user="root",      # Replace with your MySQL username
        password="ktom2005",  # Replace with your MySQL password
        database="farmmanagement_dpsk"   # Replace with your database name
    )
    cursor = db.cursor()
    
    try:
        # Get all farmers
        cursor.execute("SELECT Farmer_ID, Name FROM farmer")
        farmers = cursor.fetchall()
        
        for farmer_id, name in farmers:
            # Generate simple username (first 4 letters of first name + ID)
            first_name = name.split()[0].lower()
            username = f"{first_name[:4]}{farmer_id}"
            
            # Generate simple password
            plain_password = f"Farm{farmer_id}!"
            hashed_password = bcrypt.hashpw(plain_password.encode(), bcrypt.gensalt())
            
            # Update record
            cursor.execute(
                "UPDATE farmer SET username = %s, password = %s WHERE Farmer_ID = %s",
                (username, hashed_password.decode(), farmer_id)
            )
        
        db.commit()
        print(f"Successfully updated {len(farmers)} farmer credentials")
        print("Sample credentials (first 5 farmers):")
        
        # Display sample results
        cursor.execute("""
            SELECT Farmer_ID, Name, username, CONCAT('Farm', Farmer_ID, '!') AS temp_password 
            FROM farmer 
            ORDER BY Farmer_ID 
            LIMIT 5
        """)
        for row in cursor:
            print(f"ID: {row[0]}, Name: {row[1]}, Username: {row[2]}, Temp Password: {row[3]}")
        
    except Exception as e:
        db.rollback()
        print(f"Error: {e}")
    finally:
        cursor.close()
        db.close()

if __name__ == "__main__":
    update_credentials()