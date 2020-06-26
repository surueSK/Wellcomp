from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
  title = 'タイトル'
  message = '本メッセージ及びリスト、辞書型配列はapp.pyからindex.htmlに反映させています。'
  shikoku_list = ['愛媛県', '高知県', '徳島県', '香川県']
  fruit_dict = {'orange':100, 'apple':200}

  return render_template(
  'index.html',
  title=title,
  message=message,
  shikoku=shikoku_list,
  fruit=fruit_dict
  )

if __name__ == '__main__':
  app.run(debug=True)
