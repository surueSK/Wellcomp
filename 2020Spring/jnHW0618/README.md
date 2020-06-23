# jn-lecture 06/18 説明
* 必要に応じてMySQL, Python(flask, pymysql)を使える状態にする事
* app.pyのパスワードは自分のパスワードに変更する事

## MySQL側の準備
以下実行

    CREATE DATABASE test;
    USE test;
    create table members (id int, login_name varchar(255),kg varchar(255));    
    INSERT INTO members (id, login_name, kg) VALUES (1,"suke","WellComp" );

## 出力結果 (http://127.0.0.1:3000/ )

`{"id": 1,"login_name": "suke","kg": "WellComp"}`
