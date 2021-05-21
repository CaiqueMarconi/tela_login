import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'Componentes/TextFields.dart';
import 'Componentes/banco.dart';

class Tela_cadastro extends StatefulWidget {
  @override
  _Tela_cadastroState createState() => _Tela_cadastroState();
}

class _Tela_cadastroState extends State<Tela_cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerCep = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerSenha2 = TextEditingController();

  String texto = "";

  _recuperarCep() async {
    String cepDigitados = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitados}/json/";

    http.Response response;
    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _controllerCidade.text = retorno["localidade"];
      _controllerBairro.text = retorno["bairro"];
    });
  }

  String textEmail = "";

  _recuperarEmail() async {
    Database bd = await criarBancodeDados();

    var email = _controllerEmail.text;
    String sql = "SELECT * FROM usuarios WHERE email = '$email'";
    List usuarios = await bd.rawQuery(sql);

    for (var emailUser in usuarios) {
      if (_controllerEmail.text == emailUser['email']) {
        setState(() {
          return textEmail = "Email existente, tente outro!";
        });
      }
    }
    if(_controllerEmail.text == ""){
      setState(() {
        return textEmail = "";
      });
    }
  }

  alterTexto(){
    setState(() {
      if(_controllerSenha2.text == ""){
        texto = "";
      }else if(_controllerSenha.text == ""){
        texto = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(08, 30, 08, 0),
              child: Text(
                "Cadastro",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            textFieldok((c) {}, "Nome", _controllerNome),
            textFieldok((c) {
              _recuperarEmail();
            }, "Digite o Email", _controllerEmail),
            if (textEmail != "")
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 05, 0, 0),
                child: Text(
                  textEmail,
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ),
            textFieldok((c) {
              _recuperarCep();
              setState(() {
                if (_controllerCep.text == "") {
                  _controllerCidade.text = "";
                  _controllerBairro.text = "";
                }
              });
            }, "Digite o Cep", _controllerCep),
            textFieldok((c) {}, "Digite a Cidade", _controllerCidade),
            textFieldok((c) {}, "Digite o Bairro", _controllerBairro),
            textFieldok((c) {}, "Digite o Numero", _controllerNumero),
            if (_controllerSenha.text != _controllerSenha2.text)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 05, 0, 0),
                child: Text(
                  texto,
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ),
            textFieldok((c) { alterTexto();}, "Digite a Senha", _controllerSenha),
            textFieldok((c) {alterTexto();}, "Repita a Senha", _controllerSenha2),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_controllerSenha.text != _controllerSenha2.text){
                      texto = "As senhas não são iguais";
                    }
                  });
                  if(texto == "" && textEmail == ""){
                     salvar();
                     Navigator.pop(context);
                   }
                },
                child: Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  salvar() async {
    Database bd = await criarBancodeDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": _controllerNome.text,
      "email": _controllerEmail.text,
      "cep": _controllerCep.text,
      "cidade": _controllerCidade.text,
      "bairro": _controllerBairro.text,
      "numero": _controllerNumero.text,
      "senha": _controllerSenha.text,
      "senha2": _controllerSenha2.text
    };
    var id = await bd.insert("usuarios", dadosUsuario);
    print("salvo ? $id");
  }
}
