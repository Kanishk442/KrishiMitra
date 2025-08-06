from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import pymysql

app = Flask(__name__)
app.secret_key = "supersecretkey"  # Keep this in production but store in environment variables later

# MySQL Configuration (unchanged)
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:ktom2005@localhost/farmmanagement_dpsk"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

# User Model (only added __tablename__ for explicit naming)
class User(db.Model):
    __tablename__ = 'users'
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    contact = db.Column(db.String(15), nullable=False)

# Routes (unchanged structure, just added minor protections)
@app.route("/")
def home():
    return render_template("index.html",app_name="App 1",other_app_url="http://localhost:5001")

@app.route("/schemes")
def schemes():
    return render_template("schemes.html")

@app.route("/support")
def support():
    return render_template("support.html")

@app.route("/about")
def about():
    return render_template("about.html")

# Protected route - only change is adding session check
@app.route("/model")
def model():
    if 'user_id' not in session:
        flash('Please login first', 'danger')
        return redirect(url_for('login'))
    # Redirect to the other Flask app
    return redirect("http://localhost:5001")

# Login - only added input stripping and next-page redirect
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"].strip()
        password = request.form["password"].strip()

        user = User.query.filter_by(username=username).first()

        if not user or not check_password_hash(user.password, password):
            flash("Invalid credentials", "danger")  # Generic message
            return redirect(url_for("login"))

        session["user_id"] = user.id
        session["username"] = user.username
        flash(f"Welcome back, {username}!", "success")
        return redirect(request.args.get('next') or url_for('model'))

    return render_template("Login-Page.html")

# Registration - only added password length check
@app.route("/register", methods=["POST"])
def register():
    username = request.form["username"].strip()
    password = request.form["password"].strip()
    confirm_password = request.form["confirm-password"].strip()
    contact = request.form["contact"].strip()

    if len(password) < 6:  # Minimum password length
        flash("Password must be at least 6 characters", "danger")
        return redirect(url_for("login"))

    if password != confirm_password:
        flash("Passwords do not match!", "danger")
        return redirect(url_for("login"))

    if User.query.filter_by(username=username).first():
        flash("Username already exists!", "warning")
        return redirect(url_for("login"))

    try:
        hashed_password = generate_password_hash(password)
        new_user = User(username=username, password=hashed_password, contact=contact)
        db.session.add(new_user)
        db.session.commit()
        flash("Account created! Please login", "success")
        return redirect(url_for("login"))
    except:
        db.session.rollback()
        flash("Registration failed. Please try again.", "danger")
        return redirect(url_for("login"))

# Logout (unchanged)
@app.route("/logout")
def logout():
    session.clear()  # More thorough than individual pops
    flash("Logged out successfully!", "info")
    return redirect(url_for("home"))

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(port=5000,debug=True)