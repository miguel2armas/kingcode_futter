import 'package:flutter/material.dart';
import 'package:kingcode/State/login_state.dart';
import 'package:provider/provider.dart';

class InicioAppcode extends StatefulWidget {
  @override
  _InicioAppcodeState createState() => _InicioAppcodeState();
}

class _InicioAppcodeState extends State<InicioAppcode> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
        ),
        Container(
          child: GestureDetector(
            onTap: (){
              context.read<LoginIn>().deslogingoogle();
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
        ),
      ],
    );
  }
}
