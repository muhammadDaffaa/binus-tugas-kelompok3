# Dependencies
from flask import Flask, jsonify, request, make_response
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# MySQL configuration
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "12345678"
app.config["MYSQL_DB"] = "employee_db"
mysql = MySQL(app)


# Register a new user
@app.route("/register", methods=["POST"])
def register():
    name = request.json["name"]
    address = request.json["address"]
    inputGender = request.json["inputGender"]
    phoneNumber = request.json["phoneNumber"]
    userName = request.json["username"]
    password = request.json["password"]
    # Input angka 1 atau 2, untuk memilih divisi yang tersedia yaitu Engineer atau Sales
    inputDivision = request.json["inputDivision"]
    # Input angka 1 atau 2, Role yang tersedia [Admin & User/Karyawan]
    inputRole = request.json["inputRole"]

    cur = mysql.connection.cursor()
    cur.execute(
        "INSERT INTO karyawan VALUES (NULL,%s,%s,%s,%s,%s,%s,%s,%s)",
        (
            name,
            address,
            inputGender,
            phoneNumber,
            userName,
            password,
            inputDivision,
            inputRole,
        ),
    )
    mysql.connection.commit()
    cur.close()

    return jsonify({"message": "User registered successfully"})


# Login as existing user registered
@app.route("/login", methods=["POST"])
def loginAdmin():
    username = request.json["username"]
    password = request.json["password"]
    cur = mysql.connection.cursor()
    cur.execute(
        "SELECT * FROM karyawan WHERE username_karyawan=%s AND password_karyawan=%s",
        (
            username,
            password,
        ),
    )
    result = cur.fetchone()
    cur.close()

    if not result:
        return jsonify({"message": "Invalid username or password"}), 401

    users = {
        "Id": result[0],
        "Name": result[1],
        "Address": result[2],
        "Gender": result[3],
        "No Telephone": result[4],
        "Username": result[5],
        "Password": result[6],
        "Id Divisi": result[7],
        "Id Role": result[8],
    }

    return jsonify({"Users": users}), 200


# Run Application Commmand
if __name__ == "__main__":
    app.run()
