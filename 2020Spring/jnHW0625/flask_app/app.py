from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
  title = 'タイトル'
  message = '本メッセージ及び下記のリストはapp.pyからindex.htmlに反映させています。'
  return render_template('index.html', title=title, message=message)

if __name__ == '__main__':
  app.run(debug=True)
