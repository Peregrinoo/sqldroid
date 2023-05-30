//                                        Deus seja louvado !!!

// ignore_for_file: file_names, prefer_final_fields

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_server/mini_server.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqldroid/Helpers/InstancesUIHelper.dart';
import 'package:sqldroid/Models/ConnectionType.dart';
import 'package:sqldroid/Models/DatabasesModel.dart';
import 'package:sqldroid/Models/TablesModel.dart';

class InstancesHelper{

  InstancesHelper._();

  static InstancesHelper _instance = InstancesHelper._();

  //Instances configuration;

   List _headers = [];
   List<Map<String, String>> _rows    = [];
   List<TextEditingController> _textControllers = [];

   bool _isPrimary = false; // Variavel de controle da key primaria;


  //Função de busca no banco de dados da instância do usuario;
  Future<List<Map>> readDatabaseinfo(String path, String query) async {

    final db = await openDatabase(path);
    print("Deus me ajude ! A datbase está: ${db.isOpen}");

    List<Map> result = await db.query(query);

    for (var element in result) {

      print("Deus me ajude !!! $element");
      //Select * from dbinfo where
      //{id: 1, icon: , password: 1713738bd1e3b9190d5465baf4e8820a75488ca2, databasename: Deus me ajude, databasepath: /storage/emulated/0/Download/Gloria}

    }

    return result;


  }





  clearAll() {
    _headers = [];
    _rows    = [];
    _isPrimary = false;
    _textControllers = [];
  }

  headersSetValue(int index, String value) {
    _headers[index]["title"] = value;
  }

  headersAddValue(String value) {
    _headers.add({"title": value});
  }

  headersRemoveValue(int index) {
    _headers.removeAt(index);
    _textControllers.removeAt(index);
  }

  textcontrollerAdd() {
    _textControllers.add(TextEditingController());
  }

  setPrimaryKey() {
    _isPrimary = true;
    /*
    _rows = [
      {"1", "banana@gmail.com", "abc"},
      {"2", "banana@gmail.com", "abc"},
    ];
     */
  }

  List<DatabasesModel> _listDatabase = [];

    addDatabase(String dbInstance, dbIcon, dbPath, List<String> dbTables) {

      List<TablesModel?> list = [];

      for (var element in dbTables) {
        list.add(TablesModel(element, []));
      } //Nome das tabelas;


      _listDatabase.add(DatabasesModel(dbInstance, dbIcon, dbPath, list));
    }

  clearDB() {
    _listDatabase = [];
  }

  //Funções para o funcionamento do servidor;

  String hashPassword(String password) {

      return sha1.convert(utf8.encode(password)).toString().split('').reversed.join();
  }

  _serverStart(Connection cn, DatabasesModel dbModel) async {

      print("Deus me ajude ! o tipo de conexão do usuario é: ${cn.connectionType}");

      if(cn.connectionType?.index == 0) { // Wifi

        //Para abrir o nosso servidor usando o Wifi, nós precisaremos do endereço IP e uma porta disponivel;
        await Permission.location.request(); // Pede a permissão para conseguir o ip do usuario;
        final network = NetworkInfo(); // Instanciação do objeto 'network' que abre todos os metodos para conseguir o endereço IP;
        final host = await network.getWifiIP(); // IP do usuario;

        /*
          -> Regras para a conexão com o banco de dados;
          
          - O cliente deve ter nos cookies a senha e o usuario da instancia para poder conectar corretamente,
          - caso não será sinalizado para ele o erro 407(Erro nas credenciais)
          - O cliente deve
        */

        final server = MiniServer(host: host.toString(), port: 7777); // A porta padrão será 7777, caso o usuario não tenha selecionado a porta padrão

        server.get("/", (clientRequest) {
          print("Glorias te dou Pai, pois tu meu Deus é meu baluarte !");
          clientRequest.response.writeln("Wrong request type.");
          print("Response: ${clientRequest.response}");
          print("Headers: ${clientRequest.headers}");
          print("Cookies: ${clientRequest.cookies}");
          print("Url requested: ${clientRequest.requestedUri}");
          print("Session: ${clientRequest.session}");
          print("Connection info: ${clientRequest.connectionInfo}");

        });
        /*
            String content = await utf8.decoder.bind(httpRequest).join();
    Map<String, dynamic> data =
        await jsonDecode(content) as Map<String, dynamic>;

    _parameters = httpRequest.uri.queryParameters;

         */
        /*

          -> Post url: {ip}:{porta}/post?instance=Deusbendito&password=obrigadoDeus@1&insert=INSERT INTO column VALUES(1.2.3)

         */

        server.post("/post", (clientPost) {

          //Capturar os parametros do usuario;

          Map<String, List<String>> parameters = clientPost.uri.queryParametersAll;

          if(parameters.containsKey("instance") && parameters.containsKey("password") && parameters.containsKey("insert"))  {

            

          } else {
            clientPost.response.write("Wrong parameters");
          }




        });


        return [host,"7777"];



      } else if(cn.connectionType?.index == 1) { // bluetooth

      } else { // Radio

      }
  }

  //Metodo responsavel por fechar o servidor;
  _serverClose() {

  }
  //INicia o servidor e e envia as devidas informações;
  startServer(DatabasesModel dbModel) async{
      List<String?> addressPack = await _serverStart(InstancesUIHelper.getInstance.getConnection(), dbModel);
      InstancesUIHelper.getInstance.addTextToLogControl("Starting server at ${addressPack[0]} port ${addressPack[1]}");

  }





   static InstancesHelper get getInstance => _instance;
   List get getHeaders                                                     => _headers;
   List<Map<String, String>> get getRows                                   => _rows;
   List<TextEditingController> get getTextControllers                      => _textControllers;

   bool get getPrimaryKey                             => _isPrimary;

  List<DatabasesModel> get listDatabase => _listDatabase;




}
