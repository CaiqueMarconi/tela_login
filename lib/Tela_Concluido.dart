import 'package:flutter/material.dart';

class Tela_concluido extends StatelessWidget {
  const Tela_concluido({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bom Trabalho",
            style: TextStyle(
              fontSize: 40
            ),)
          ],
        ),
      ),
    );
  }
}
