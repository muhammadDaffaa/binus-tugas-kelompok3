from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re


app = Flask(__name__)


app.secret_key = "xyzsdfg"

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "12345678"
app.config["MYSQL_DB"] = "employee_db"

mysql = MySQL(app)


@app.route("/")
@app.route("/login", methods=["GET", "POST"])
def login():
    message = ""
    if (
        request.method == "POST"
        and "username" in request.form
        and "password" in request.form
        and "inputRole" in request.form
    ):
        username = request.form["username"]
        password = request.form["password"]
        inputRole = request.form["inputRole"]
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(
            "SELECT * FROM karyawan WHERE username_karyawan = %s AND password_karyawan = %s AND id_role = %s",
            (username, password, inputRole),
        )
        user = cursor.fetchone()
        if user:
            if inputRole == 2:
                session["loggedin"] = True
                session["id_karyawan"] = user["id_karyawan"]
                session["username"] = user["username_karyawan"]
                message = "Logged in successfully !"
                return redirect(url_for("user"))
            elif inputRole == 1:
                session["loggedin"] = True
                session["id_karyawan"] = user["id_karyawan"]
                session["username"] = user["username_karyawan"]
                message = "Logged in successfully !"
                return redirect(url_for("manager"))
        else:
            message = "Please enter correct your account !"
    return render_template("login.html", message=message)


@app.route("/user", methods=["GET", "POST"])
def user():
    all_data = get_data_user()
    return render_template("user.html", all_data=all_data)


@app.route("/manager", methods=["GET", "POST"])
def user():
    all_data = get_data_user()
    return render_template("manager.html", all_data=all_data)


def get_data_user():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM karyawan")
    rows = cursor.fetchall()
    return rows


@app.route("/logout")
def logout():
    session.pop("loggedin", None)
    session.pop("id_karyawan", None)
    session.pop("username", None)
    return redirect(url_for("login"))


@app.route("/register", methods=["GET", "POST"])
def register():
    message = ""
    if (
        request.method == "POST"
        and "name" in request.form
        and "address" in request.form
        and "inputGender" in request.form
        and "phoneNumber" in request.form
        and "username" in request.form
        and "password" in request.form
        and "inputDivision" in request.form
        and "inputRole" in request.form
    ):
        name = request.form["name"]
        address = request.form["address"]
        inputGender = request.form["inputGender"]
        phoneNumber = request.form["phoneNumber"]
        userName = request.form["username"]
        password = request.form["password"]
        inputDivision = request.form["inputDivision"]
        inputRole = request.form["inputRole"]
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(
            "SELECT * FROM karyawan WHERE username_karyawan = % s", (userName,)
        )
        account = cursor.fetchone()
        if account:
            message = "Account already exists !"
        else:
            cursor.execute(
                "INSERT INTO karyawan VALUES (NULL, %s,%s,%s,%s, %s,%s,%s,%s)",
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
            message = "You have successfully registered !"
    elif request.method == "POST":
        message = "Please fill out the form !"
    return render_template("register.html", message=message)


if __name__ == "__main__":
    app.run()
