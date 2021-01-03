import 'package:flutter/material.dart';
import 'package:kingcode/database/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' show Directory;

import 'models/theme_model.dart';

class DBProviderbase{
  static const themeTable = 'theme';
  static const themeId = 'id';
  static const themeDark = 'themedark';
  static const loginTable = 'login';
  static const loginId = 'id';
  static const loginMail = 'mail';
  static const loginToken = 'token';
  static const loginName = 'name';
  static const loginPicture = 'picture';
  DBProviderbase._();
  static final DBProviderbase db = DBProviderbase._();
  static Database _database;
  Future<Database>get database async{
    if(_database!=null)
      return _database;
    _database = await initDB();
    return _database;
  }
  initDB()async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'kingcode.db');
    print('create database theme');
    return await openDatabase(path, onCreate: (db, version) async{
      await db.execute('''CREATE TABLE $themeTable(
      $themeId INTEGER PRIMARY KEY,
      $themeDark INTEGER
      )''');
      await db.execute('''CREATE TABLE $loginTable(
      $loginId INTEGER PRIMARY KEY,
      $loginToken TEXT,
      $loginMail TEXT,
      $loginName TEXT,
      $loginPicture TEXT
      )''');
    }, version: 1);
  }
  createDatabaseLogion(UserLogin userLogin)async{
    final db = await database;
    var result = await db.rawInsert('''
    INSERT INTO $loginTable(
    $loginId,
    $loginToken,
    $loginMail,
    $loginName,
    $loginPicture
    )VALUES(?, ?, ?, ?, ?)
    ''', [userLogin.id,
      userLogin.token,
      userLogin.mail,
      userLogin.name,
      userLogin.picture
    ]);
    print('create database login result $result');
    return result;
  }
  createDatabaseTheme(ThemeSelect themeSelect ) async{
    final db = await database;
    var result = await db.rawInsert('''
    INSERT INTO $themeTable(
    $themeId,
    $themeDark
    )VALUES(?,?)
    ''', [themeSelect.id,
      themeSelect.themedark
    ]);
    print('create database theme result $result');
    return result;
  }
  Future<String> consultDatabaseUserDeslogeo()async{
    final db = await database;
    var id = "1";
    var res = await db.rawDelete('''DELETE FROM $loginTable WHERE $loginId = $id''');
    print('respuesta de deslogeo $res');
    return res.toString();
  }
  Future<int> consultDatabaseUser() async{
    final db = await database;
    var result = await db.query('$loginTable');
    if(result.length!=0){
      print('consult database login result ${result[0]['$loginId']}');
      return result[0]['$loginId'];
    }else
      print('database login no create');
    return 3;
  }
  changeDatabaseTheme(ThemeSelect themeSelect) async{
    final db = await database;
    var result = await db.rawUpdate('''
    UPDATE $themeTable
    SET $themeDark = ?
    WHERE $themeId = ?
    ''',
      [themeSelect.themedark, themeSelect.id]
    );
    print('chage database theme result $result');
    return result;
  }
  Future<int> consultDatabaseTheme() async{
    final db = await database;
    var result = await db.query('$themeTable');
    if(result.length!=0){
      print('consult database teme result ${result[0]['$themeDark']}');
      return result[0]['$themeDark'];
    }else
      print('database theme no create');
      return 3;
  }
}