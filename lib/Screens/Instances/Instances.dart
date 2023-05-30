//                                            Deus seja louvado !!!

// ignore_for_file: file_names


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqldroid/Helpers/InstancesHelper.dart';
import 'package:sqldroid/Helpers/InstancesPathHelper.dart';
import 'package:sqldroid/Models/DatabasesModel.dart';
import 'package:sqldroid/Screens/Instances/InstancesCreate.dart';
import 'package:sqldroid/Screens/Instances/Screens/InstancesMain.dart';

class Instances extends StatefulWidget {
  const Instances({Key? key}) : super(key: key);

  @override
  State<Instances> createState() => _InstancesState();
}

class _InstancesState extends State<Instances> {

  //Mensagem da ElevatedButton;
  String buttonStats = "Select the database folders";

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Instances"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          actions: [

              IconButton(onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InstancesCreate())),
                  icon: const Icon(Icons.add)),

          ],

        ),
      body: Column(children: [

        ElevatedButton(onPressed: () async {
           String? path = await InstancesPathHelper.viewFolders();

           if(path != null) {

             Directory dir = Directory(path);
             print("Obrigado Deus !!! ${dir.listSync()} ");
             List<FileSystemEntity> listFiles = dir.listSync();
              listFiles.removeWhere((element) {
                return element.path.contains(".db-journal");
              });

              print("Deus me ajude !!! $listFiles");
              List<List<Map>> dbMap = [];
             for(int i = 0; i < listFiles.length; i++) {
               //InstancesHelper.getInstance.listDatabase[i].databaseIcon = "";

               /*
                  Crud -> Create, Read, Update and Delete
                */

               dbMap.add(await InstancesHelper.getInstance.readDatabaseinfo(listFiles.elementAt(i).path, "dbinfo"));
             }

             print("Deus me ajude !!! Dados coletados: $dbMap");
             setState(() {
               buttonStats = path;

               InstancesHelper.getInstance.clearDB();
                
               for(int i = 0; i < dbMap.length; i++) {

                 // dbMap[i][0]["tablelist"] // [amem].... tipo texto, então eu preciso de um array;

                 List<String> listinha = [dbMap[i][0]["tablelist"]];


                 print("Deus me ajude !!! ${dbMap[i][0]}");
                 InstancesHelper.getInstance.addDatabase(
                     dbMap[i][0]["databasename"],
                     dbMap[i][0]["icon"],
                     dbMap[i][0]["databasepath"],
                     listinha

                 );
               }


             });

           }





           },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size?>(const Size.fromHeight(50)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(bottom: 20))
            ),

            child: Text("\n$buttonStats", style: const TextStyle(
              fontSize: 16,
              wordSpacing: 4.0
            ),
            textAlign: TextAlign.center,)),


        const SizedBox(height: 15),

        Expanded(child: ListView.builder(itemCount: InstancesHelper.getInstance.listDatabase.length,
            itemBuilder: (context, index) {

              double deviceHeight = MediaQuery.of(context).size.height;

              Widget photo;
              String? instanceName = InstancesHelper.getInstance.listDatabase[index].databaseInstanceName;
              String? instanceIp   = InstancesHelper.getInstance.listDatabase[index].databaseIp;
              int? instancePort = InstancesHelper.getInstance.listDatabase[index].databasePort;
              String? instanceIcon = InstancesHelper.getInstance.listDatabase[index].databaseIcon;

              String? lastAddress;

              if(instanceIp == null || instancePort == null) {
                lastAddress = "Never opened";
              } else {
                lastAddress = "$instanceIp:$instancePort";
              }



              if(instanceIcon == "" || instanceIcon == null) {
                //Image.asset("assets/notfound.jpg", fit: BoxFit.cover, height: 128, width: 128,);
                photo = CircleAvatar(
                    maxRadius: 40,
                    child: Image.asset(
                      "assets/notfound.jpg",
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      height: 128,
                      width: 128,
                    ));
              } else {
                photo = Image.asset(instanceIcon.toString(),
                  fit: BoxFit.cover,
                  height: 128,
                  width: 128,);
              }

              return Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 15),
                  child:
                  Card(
                    elevation: 10,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // 1/2 = 0.50 1/4 = 0.25 1/8 = 0.125
                        height: deviceHeight * 0.090,
                      child: ListTile(
                        leading: photo,
                        title: Text("$instanceName"),
                        subtitle: Text("Last address: $lastAddress"),
                        onTap: () {
                          DatabasesModel dbModel = InstancesHelper.getInstance.listDatabase[index];
                          print("Deus me perdoe !!! dados da database: ${
                          dbModel.returnDatabaseStatus()}");

                          Navigator.push(context, MaterialPageRoute(builder: (context) => InstancesMain(dbModel)));
                        },
                      )


                    ),
                  ));

            }),
        ),
      ],)
      ),
    );
  }
}
