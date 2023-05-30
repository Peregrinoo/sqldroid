//                                        Deus seja louvado !!!

// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:sqldroid/Database/DatabaseInstance.dart';
import 'package:sqldroid/Helpers/InstancesHelper.dart';
import 'package:sqldroid/Screens/Instances/Configure/InstanceHeadersConfigure.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqldroid/Screens/Instances/Instances.dart';

class InstanceConfigure extends StatefulWidget {

  int columns = 0;
  String folderPath = "";
  String InstanceName = "";
  List<String> InstanceTable = [];
  File   InstanceIcon;
  String InstanceHashedPassword = "";

  List headers = [];
  List<Map<dynamic, dynamic>> rows    = [];
  List<TextEditingController> txtControllers = [];

  InstanceConfigure(this.columns, this.folderPath, this.InstanceName, this.headers, this.rows, this.txtControllers,
  this.InstanceTable, this.InstanceIcon, this.InstanceHashedPassword, {super.key});

  @override
  State<InstanceConfigure> createState() => _InstanceConfigureState(columns,folderPath,InstanceName, headers,
  rows, txtControllers, InstanceTable, InstanceIcon, InstanceHashedPassword);
}

class _InstanceConfigureState extends State<InstanceConfigure> {

  int columns = 0;
  String InstancePath = "";
  String InstanceName = "";
  List<String> InstanceTable = [];
  File InstanceIcon;
  String InstanceHashedPassword = "";


  List headers = InstancesHelper.getInstance.getHeaders;
  List<Map<dynamic, dynamic>> rows = [];
  // ignore: prefer_final_fields
  List<TextEditingController>  _textControllers = [];

  //Editable Widget controller;
  final _editKey = GlobalKey<EditableState>();

  _InstanceConfigureState(this.columns,this.InstancePath,this.InstanceName,
      this.headers, this.rows,this._textControllers, this.InstanceTable, this.InstanceIcon, this.InstanceHashedPassword);

  //Edit tool;

  @override
  void initState() {
    if(InstancePath.contains(" ")) {
      String newPath = InstancePath;
      InstancePath = newPath.replaceAll(" ", "_");
      print("Deus me ajude !!! ${InstanceIcon.path}");
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;





    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          InstancesHelper.getInstance.clearAll();
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_sharp),),
        actions: [

          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  InstanceHeadersConfigure(
                InstancesHelper.getInstance.getHeaders,
                InstancesHelper.getInstance.getTextControllers,


            )));

            print("Deus me ajude !!!");
          }, icon: const Icon(Icons.edit) ),

          IconButton(onPressed: () {

            headers = InstancesHelper.getInstance.getHeaders;

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InstanceConfigure(
                columns,
                InstancePath,
                InstanceName,
                headers,
                rows,
                _textControllers,
                InstanceTable,
                InstanceIcon,
                InstanceHashedPassword
            )));

          }, icon: const Icon(Icons.refresh)),


        ],
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Configure Instance"),
        centerTitle: true,
      ),

      body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 25)),
          Expanded(
            child: Editable(
              //Deus tenha piedade de minha alma, por tudo de errado que eu tenho feito;
              key: _editKey,
              columns: headers,
              rows: rows,
              showSaveIcon: true,
              tdStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),

              onRowSaved: (value) {
                print("Deus me ajude !!! $value");

              },
              onSubmitted: (value) {
                print("Deus tenha piedade de minha alma $value");
              },


            ),
          ),
            SizedBox(height: height/4),
            Center(
              child: SizedBox(
                width: width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {

                      print("Deus me ajude !!! dados da db: $InstancePath ||| $InstanceIcon");

                      if(InstancesHelper.getInstance.getPrimaryKey) {

                        final dbLocation = "${InstancePath.replaceAll(" ", "")}/$InstanceName.db";

                        await QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            title: "Are you sure of the database location ?",
                            confirmBtnText: "Yes, i am !",
                            cancelBtnText: "No, cancel",
                            confirmBtnColor: Colors.deepPurpleAccent
                        );

                        var db = await openDatabase(
                          dbLocation,
                          version: 1,
                          onCreate: (db, newVersion) async {

                              String sql = DatabaseInstance.instance.createTables(headers, InstanceTable.first);
                              await db.execute(sql);
                              print("Deus me ajude !!! tabela: $InstanceTable");

                          });


                        print("Deus me perdoe, pois por muitas vezes não fiz o que me foi mandado ${db.database.isOpen}");
                        print("Deus por favor me perdoe pela forma que eu agi${db.path}");
                        print("obrigado meu Deus por tudo !!! ${db.database.toString()}");

                        await db.execute("CREATE TABLE dbinfo("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                            " icon TEXT,"
                            " password TEXT,"
                            " databasename TEXT,"
                            " databasepath TEXT,"
                            " tablelist TEXT)");

                        await db.insert("dbinfo", {
                          "icon": InstanceIcon.path,
                          "password": InstanceHashedPassword,
                          "databasename": InstanceName,
                          "databasepath": InstancePath,
                          "tablelist": "$InstanceTable,"
                        });

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Instances()));


                        /*
                                        columns,
                InstancePath,
                InstanceName,
                headers,
                rows,
                _textControllers,
                InstanceTable,
                InstanceIcon,
                InstanceHashedPassword
                         */


                      } else {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: "We can't create the database",
                            text: "The primary key isn't defined",
                            confirmBtnText: "Okay",
                            showCancelBtn: false,
                            onConfirmBtnTap: () => Navigator.pop(context)
                        );
                      }


                    },
                    child: Text("Create $InstanceName.db")),
              ),
            )
    ]),
    );
  }
}
