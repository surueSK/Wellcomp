# kadai08

## MariaDB(or MySQL) setup

    install MariaDB or MySQL then excute commands bellow
    
    create table members (id int, name varchar(255),kg varchar(255));
    
    create table members (id int, name varchar(255),kg varchar(255));
    
    INSERT INTO members (name, kg) VALUES ("tatsuru","d-hacks" );
    
    UPDATE members SET id=1 WHERE name="tatsuru";

## Installation

1.Install flask and pyMySQL on pip3

2.Download the file and excute

3.Change MySQL name and password on python file

## Result

send get request to http://127.0.0.1:8888/ then you'll get

`{"id": 1,"login_name": "suke","kg": "WellComp"}`
