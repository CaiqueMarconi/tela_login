import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tela_login/Tela_Concluido.dart';
import 'package:tela_login/tela_cadastro.dart';

import 'Componentes/banco.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  String text = "";

  recuperarUsuario() async {
    Database bd = await criarBancodeDados();
    var login = _controllerLogin.text;
    var senha = _controllerSenha.text;
    var x = await bd.rawQuery(
        "SELECT COUNT (*) FROM usuarios WHERE email = '$login' AND senha = '$senha'");
    int count = Sqflite.firstIntValue(x);
    if (count == 0) {
      setState(() {
        return text = "Login ou Senha invalidos";
      });
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Tela_concluido()));
      _controllerLogin.text = "";
      _controllerSenha.text = "";
      text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 80),
                height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .80,
                child: Image.asset(
                  "images/fotinha.jpg",
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(08, 10, 08, 08),
              child: TextField(
                controller: _controllerLogin,
                decoration: InputDecoration(
                  labelText: "Digite o login/email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _controllerSenha,
                decoration: InputDecoration(
                  labelText: "Digite a senha",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(_controllerLogin.text == "" && _controllerSenha.text == ""){
                    setState(() {
                      text = "Por favor digite o login e a senha";
                    });
                  }else {
                    recuperarUsuario();
                  }
                },
                child: Text("Entrar"),
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("não possui uma conta?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Tela_cadastro()));
                  },
                  child: Text("Cadastrar-se!"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
