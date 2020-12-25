import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' show Directory;

import 'models/theme_model.dart';

class DBProviderbase{
  static const themeTable = 'theme';
  static const themeId = 'id';
  static const themeDark = 'themedark';
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
    }, version: 1);
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
      print('consult database teme result ${result[0]['themedark']}');
      return result[0]['themedark'];
    }else
      print('database no create');
      return 3;
  }
}