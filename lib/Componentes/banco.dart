import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

criarBancodeDados()async{

  final caminhoBancoDados = await getDatabasesPath();
  final localBancoDados = join(caminhoBancoDados, "banco.db");

  var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersionRecente){
        String sql = "CREATE TABLE usuarios (nome VARCHAR,email VARCHAR PRIMARY KEY, cep INTEGER, cidade VARCHAR, "
            "bairro VARCHAR, numero INTEGER, senha VARCHAR, senha2 VARCHAR)";
        db.execute(sql);
      }
  );
    return bd;

  //print("aberto: " + bd.isOpen.toString());
}

