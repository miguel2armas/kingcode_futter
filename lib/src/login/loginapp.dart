import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kingcode/State/login_state.dart';
import 'package:kingcode/State/theme_state.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import "package:http/http.dart" as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LogInApp extends StatefulWidget {
  LogInApp({Key key}) : super(key: key);

  @override
  _LogInAppState createState() => _LogInAppState();
}

class _LogInAppState extends State<LogInApp> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  Artboard _riveArtboard;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;

      });
      if (_currentUser != null) {
        print('logeado ${_currentUser.displayName}');
        print('logeado ${_currentUser.id}');
        print('logeado ${_currentUser.email}');
        print('logeado ${_currentUser.photoUrl}');
      }
    });
    _googleSignIn.signInSilently();
    rootBundle.load('assets/images/code2.riv').then(
      (data) async {
        var file = RiveFile();
        var success = file.import(data);
        if (success) {
          var artboard = file.mainArtboard;
          artboard.addController(
            SimpleAnimation('main'),
          );
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }


  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white24,
        child: Column(
          children: [
            Container( margin: EdgeInsets.all(20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    color: Colors.black26,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text('Tema oscuro',
                            style: TextStyle(
                              fontSize: 18,
                              color: context.watch<ThemeState>().currentTheme? Colors.white: Colors.black,
                            ),),
                        ),
                        Switch(
                          value: context.watch<ThemeState>().currentTheme,
                          onChanged: (value) {
                              context.read<ThemeState>().themechage(value);
                          },
                          activeTrackColor: Colors.black26,
                          activeColor: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              width: 300,
              height: 300,
              child: Center(
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: _riveArtboard),
              ),
            ),
            _currentUser != null? Text('Logeado', style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            )):Text(_contactText ?? '', style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            )),
            GestureDetector(
              onTap: (){
                _handleSignOut();
              },
              child: Card(
                margin: EdgeInsets.only(right: 40, left: 40),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 30,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          "deslogear con google",
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                context.read<LoginIn>().login;
              },
              child: Card(
                margin: EdgeInsets.only(right: 40, left: 40),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 30,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          "Iniciar session con google",
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
            ),
            Card(
              color: Color.fromRGBO(59, 89, 152, 1),
              margin: EdgeInsets.only(right: 40, left: 40),
              child: Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/facebookb.png',
                      width: 30,
                    ),
                    Expanded(child: Container()),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        "Iniciar session con facebook",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
            ),
            Card(
              color: Colors.red,
              margin: EdgeInsets.only(right: 40, left: 40),
              child: Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/correo2.png',
                      width: 30,
                    ),
                    Expanded(child: Container()),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        "Iniciar session con Correo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),Container(
              margin: EdgeInsets.all(5),
            ),
            GestureDetector(
              onTap: (){
                context.read<LoginIn>().login();
              },
              child: Card(
                color: Color.fromRGBO(15, 172, 21, 1),
                margin: EdgeInsets.only(right: 40, left: 40),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/noacount.png',
                        width: 30,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          "Continuar sin cuenta",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
