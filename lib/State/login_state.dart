import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kingcode/database/models/user_model.dart';
import 'package:kingcode/database/sqflite.dart';

class LoginIn with ChangeNotifier {
final GoogleSignIn _googleSignIn = GoogleSignIn();
static final FacebookLogin facebookSignIn = new FacebookLogin();
final FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignInAccount _currentUser;
  bool _loggedIn = false;

  void loginValueInitApp()async{
    int usercurrent = await DBProviderbase.db.consultDatabaseUser();
    print('consult current user result $usercurrent');
    if(usercurrent==3) _logout();
    usercurrent==1? _login():_logout();
  }
  bool isLoggedIn()=>_loggedIn;
  void startlogingoogle(){
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
        _currentUser = account;
      if (_currentUser != null) {
        var userLogin = UserLogin(
            id: 1,
            mail : _currentUser.email,
            name: _currentUser.displayName,
            picture: _currentUser.photoUrl,
            token: _currentUser.id
        );
        DBProviderbase.db.createDatabaseLogion(userLogin);
        print('new database user create');
        _login();
      }
    });
    _googleSignIn.signInSilently();
  }
  void logingoogle() async{
    await _handleSignIn();
  }
  void loginfacebook()async{
    await _loginFacebook();
  }
  void desloginfacebook()async{
    await _logOutFacebook();
  }
  void deslogingoogle() async{
    await _handleSignOut();
  }
  _login(){
    _loggedIn = true;
    notifyListeners();
  }
  _logout(){
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
  Future<void> _handleSignOut() {
    _googleSignIn.disconnect();
    DBProviderbase.db.consultDatabaseUserDeslogeo();
    _logout();
  }


Future<Null> _loginFacebook() async {
  facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;//cambiar cuando seste en desarrollo
  final FacebookLoginResult result =
  await facebookSignIn.logIn(['email']);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final FacebookAccessToken accessToken = result.accessToken;
      print('Token: ${accessToken.token}');
      print('User id: ${accessToken.userId}');
      print('Expires: ${accessToken.expires}');
      print('Permissions: ${accessToken.permissions}');
      print('Declined permissions: ${accessToken.declinedPermissions}');
      break;
    case FacebookLoginStatus.cancelledByUser:
      print('Login cancelled by the user.');
      break;
    case FacebookLoginStatus.error:
      print('error Facebook gave us: ${result.errorMessage}');
      break;
  }
}

Future<Null> _logOutFacebook() async {
  await facebookSignIn.logOut();
  print('Logged out.');
}
}
