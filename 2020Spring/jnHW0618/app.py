from flask import *

import pymysql

pymysql.install_as_MySQLdb()


app = Flask(__name__)

conn = pymysql.connect(host="localhost", user="root",
                       passwd="Password", db="user")
cursor = conn.cursor()
# 'select Name, Continent, Population, LifeExpectancy, GNP from Country');
cursor.execute(
    'SELECT * FROM members;')
result = cursor.fetchall()


@app.route("/")
def index():
    return jsonify({cursor.description[i][0]: result[0][i]
                    for i in range(0, len(result[0]))})


if __name__ == "__main__":
    app.run(port=8888)
