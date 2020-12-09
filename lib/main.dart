import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kingcode/src/inicio/inicio.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'State/login_state.dart';
import 'src/login/loginapp.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginIn()),
      ],
      child: MaterialApp(
          theme: ThemeData(primaryColor: Color.fromRGBO(24, 24, 24, 1)),
          localizationsDelegates: [],
          supportedLocales: [
            const Locale('es', 'CO'), // Colombia
            const Locale('en', 'US'), // English
          ],
          debugShowCheckedModeBanner: false,
          home: SplashScreen()),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initlogin();
    super.initState();
  }

  initlogin() {
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => InicioApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(24, 24, 24, 1)),
          ),
          Container(
            margin: EdgeInsets.all(50),
            child: Center(

              child: Image.asset('assets/images/kingcode.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
