import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
class LoginIn with ChangeNotifier, DiagnosticableTreeMixin {
  bool _loggedIn = false;
  bool isLoggedIn()=>_loggedIn;
  void login(){
    _loggedIn = true;
    notifyListeners();
  }
  void logout(){
    _loggedIn = false;
    notifyListeners();
  }
  bool get loggedIn => _loggedIn;
  //context.read<LoginIn>().src.login();
}
