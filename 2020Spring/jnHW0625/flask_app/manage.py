from flask import *
import pymysql.cursors

pymysql.install_as_MySQLdb()
app = Flask(__name__)
#デバッグ
app.config['DEBUG'] = True

#データベースを指定
cursor = pymysql.connect(host="localhost", user="root",
                       passwd="Mysql123", db="test").cursor()

@app.route("/")
def hello():
    return render_template("index.html")
    
if __name__ == "__main__":
    manager.run()
