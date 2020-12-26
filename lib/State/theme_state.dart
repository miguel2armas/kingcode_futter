import 'dart:async';
import 'package:kingcode/database/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../database/models/theme_model.dart';
class ThemeState with ChangeNotifier {
  bool _themeState = false;
  void themeValueInitApp()async{
    int themecurrent = await DBProviderbase.db.consultDatabaseTheme();
    print('consult current theme result $themecurrent');
    if(themecurrent==3) initthemedatabase();
    themecurrent==1? _themeState = true :_themeState = false;
    notifyListeners();
  }
  initthemedatabase(){
    var themeinit = ThemeSelect(
      id: 1,
      themedark: 0
    );
    DBProviderbase.db.createDatabaseTheme(themeinit);
    print('new database them create');
  }


  get currentTheme =>_themeState;
  void themechage(bool value){
    _themeState= value;
    var dbtheme;
    _themeState? dbtheme = 1:dbtheme = 0;
    var themeModel = ThemeSelect(
        id: 1,
        themedark: dbtheme
    );
    DBProviderbase.db.changeDatabaseTheme(themeModel);
    notifyListeners();
  }
  //cambiar color de texto
//context.watch<ThemeState>().currentTheme? Colors.white: Colors.black,
}