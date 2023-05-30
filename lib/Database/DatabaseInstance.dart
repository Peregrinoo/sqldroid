//                                              Deus seja louvado !!!


import 'package:sqflite/sqflite.dart';

class DatabaseInstance {

  DatabaseInstance._(); //Singleton

  static final DatabaseInstance _instance = DatabaseInstance._();
  static Database? _database;

  // ignore: non_constant_identifier_names
  //Cria as tabelas que o usuario quiser;
  String createTables(List headers, String InstanceTableName) {

    //Variaveis temporarias;
    String completeString = "";
    String tmp;

    for(int i = 0; i < headers.length; i++) {
      if(i == 0) {
        completeString = "CREATE TABLE $InstanceTableName(${headers[i]["title"]} INTEGER PRIMARY KEY AUTOINCREMENT, %)";
      } else {
        if(i == headers.length - 1) {
          tmp = completeString.replaceAll("%", "${headers[i]["title"]} VARCHAR NOT NULL");
          completeString = tmp;
        } else {
          tmp = completeString.replaceAll("%","${headers[i]["title"]} VARCHAR NOT NULL, %");
          completeString = tmp;
        }
      }
    }
    return completeString;
  }

  //Getters;
  static DatabaseInstance get instance => _instance;
  static Database? get databaseSystem => _database;


}

