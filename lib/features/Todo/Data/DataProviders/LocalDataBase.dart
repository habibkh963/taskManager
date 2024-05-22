import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

const String tableTodos = 'todos';
const String todoIdAuto = 't_id';
const String todoId = 'id';
const String todoContent = 'todo';
const String todoState = 'completed';
const String todoUserID = 'userId';

// {
//   "id": 15,
//   "username": "kminchelle",
//   "email": "kminchelle@qq.com",
//   "firstName": "Jeanne",
//   "lastName": "Halvorson",
//   "gender": "female",
//   "image": "https://robohash.org/Jeanne.png?set=set4",
//   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxMTIwOTAwMSwiZXhwIjoxNzExMjEyNjAxfQ.F_ZCpi2qdv97grmWiT3h7HcT1prRJasQXjUR4Nk1yo8"
// }

const String tableUser = 'user';
const String userIdAuto = 'user_id';
const String userId = 'id';
const String userName = 'username';
const String email = 'email';
const String firstName = 'firstName';
const String lastName = 'lastName';
const String gender = 'gender';
const String image = 'image';
const String token = 'token';

class TodosLocalDataSource {
  static TodosLocalDataSource instance = TodosLocalDataSource();
  Database? _dbe;

  Future<Database?> get dbe async {
    if (_dbe == null) {
      _dbe = await initializeDb();
      return _dbe;
    } else {
      return _dbe;
    }
  }

  initializeDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'todos.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (kDebugMode) {
      //  print("onUpgrade =====================================");
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
create table $tableTodos ( 
  $todoIdAuto INTEGER PRIMARY KEY  AUTOINCREMENT,
  $todoId INT NOT NULL , 
  $todoContent TEXT NOT NULL,
  $todoState INT, 
  $todoUserID INT
  )
''');
    await db.execute('''
create table $tableUser ( 
  $userIdAuto INTEGER PRIMARY KEY  AUTOINCREMENT,
  $userId INT NOT NULL , 
  $firstName TEXT  ,
  $lastName TEXT, 
  $email TEXT,
  $gender TEXT ,
  $userName TEXT , 
  $token TEXT , 
  $image TEXT 
  )
''');
//######################################################
  }

//######################################################
}
