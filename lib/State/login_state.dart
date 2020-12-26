import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginIn with ChangeNotifier {
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loggedIn = false;
  bool isLoggedIn()=>_loggedIn;
   void login() async{
    await _handleSignIn();
  }
   logout(){
    _loggedIn = false;
    notifyListeners();
  }
  bool get loggedIn => _loggedIn;
  //context.read<LoginIn>().src.login();
Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}
}
