import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
class ThemeState with ChangeNotifier, DiagnosticableTreeMixin {
  bool _themeState = false;
  get currentTheme =>_themeState;
  void themechage(bool value){
    _themeState= value;
    notifyListeners();
  }
  //cambiar color de texto
//context.watch<ThemeState>().currentTheme? Colors.white: Colors.black,
}