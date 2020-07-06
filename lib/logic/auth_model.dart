import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthModel with ChangeNotifier {
  AuthModel();

  var _loginStatus;
  var _signup;
  var _dbStatus;
  Database _dbInstance;

  bool get signup => _signup ?? false;
  bool get dbStatus => _dbStatus ?? false;
  Database get dbInstance => _dbInstance;

  set setDbStatus(status) => _dbStatus = status;
  set setDbInstance(instance) => _dbInstance = instance;

  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loginStatus = prefs.getBool('loginStatus');
    notifyListeners();
  }

  bool getLoginStatus() {
    checkLoginStatus();
    return _loginStatus ?? false;
  }

  setSignupState(bool state) {
    _signup = state;
    notifyListeners();
  }

  setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loginStatus', status);
    _loginStatus = status;
    notifyListeners();
  }

  Future<Database> openDbConnection() async {
    return !dbStatus && _dbInstance == null
        ? openDatabase(
            join(await getDatabasesPath(), 'to_do_da.db'),
            onCreate: (db, version) {
              db.execute(
                  'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(255), created_by VARCHAR(255), created_at DATETIME, updated_at DATETIME)');
              db.execute(
                  'CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, todo_id INTEGER, content VARCHAR(255), status BOOLEAN, created_at DATETIME, updated_at DATETIME, FOREIGN KEY (todo_id) REFERENCES todos (id))');
            },
            version: 1,
            onOpen: (db) {
              setDbStatus = true;
              setDbInstance = db;
              notifyListeners();
            },
          )
        : getDbInstance();
  }

  Future<Database> getDbInstance() async {
    return openDatabase(
      join(await getDatabasesPath(), 'to_do_da.db'),
      onOpen: (db) {
        setDbStatus = true;
        setDbInstance = db;
        notifyListeners();
      },
    );
  }

  Future logIn() {
    setLoginStatus(true);
    setSignupState(false);
    return openDbConnection();
  }

  Future signUp() {
    setLoginStatus(true);
    setSignupState(false);
    return openDbConnection();
  }

  Future logOut() async {
    setLoginStatus(false);
    setSignupState(false);
    if (dbInstance != null) {
      dbInstance.close();
      setDbInstance = null;
    }
    deleteDatabase(join(await getDatabasesPath(), 'to_do_da.db'));
    return Future.value(_loginStatus);
  }
}
