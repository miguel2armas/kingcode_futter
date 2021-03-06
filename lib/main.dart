import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kingcode/src/inicio/inicio.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'State/login_state.dart';
import 'State/theme_state.dart';
import 'src/login/loginapp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginIn()),
        ChangeNotifierProvider(create: (_) => ThemeState()),

      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        /*localizationsDelegates: [],
        supportedLocales: [
          const Locale('es', 'CO'), // Colombia
          const Locale('en', 'US'), // English
        ],*/
        theme: context.watch<ThemeState>().currentTheme ? ThemeData.dark() : ThemeData.light(),
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<LoginIn>().startlogingoogle();
    context.read<LoginIn>().loginValueInitApp();
    context.read<ThemeState>().themeValueInitApp();
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
