import 'package:flutter/material.dart';
import 'package:kingcode/src/login/loginapp.dart';
import 'package:provider/provider.dart';
import 'package:kingcode/State/login_state.dart';

import 'inicio_app.dart';

class InicioApp extends StatefulWidget {
  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  @override
  Widget build(BuildContext context) {

    return context.watch<LoginIn>().loggedIn==true?InicioAppcode():LogInApp();
  }
}
