//                                            Deus seja louvado !!!

// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sqldroid/Helpers/InstancesHelper.dart';
import 'package:sqldroid/Helpers/InstancesPathHelper.dart';
import 'package:sqldroid/Screens/Instances/InstanceConfigure.dart';

class InstancesCreate extends StatefulWidget {
  const InstancesCreate({Key? key}) : super(key: key);

  @override
  State<InstancesCreate> createState() => _InstancesCreateState();
}

class _InstancesCreateState extends State<InstancesCreate> {

  final TextEditingController InstanceName = TextEditingController();
  final TextEditingController InstancePath = TextEditingController();
  final TextEditingController InstanceColumnsNumber = TextEditingController();
  final TextEditingController InstancePassword  = TextEditingController();
  final TextEditingController InstanceConfirmPassword = TextEditingController();
  final TextEditingController InstanceTableName = TextEditingController();



  @override
  void initState() {
    super.initState();
    InstancesHelper.getInstance.clearAll();

  }

  @override
  Widget build(BuildContext context) {
    //Obrigado Deus, meu problema foi resolvido, bendito seja o Pai o Filho é ao Espirito Santo !!!

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    File icon = File("");
    String _pathLocation = "";



    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Instance Create",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white),
          ),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(children: [

            const SizedBox(height: 35),

            InkWell(
              onTap: () async {

                  try{
                    FilePickerResult? picker = await InstancesPathHelper.selectIcon();
                    icon = File(picker!.files.first.path.toString());
                    print("Deus me ajude !!! ${icon.path}");
                  } catch(e) {
                    print("Deus me perdoe !!! icone não selecionado");
                  }
              },
              child: Container(
                width: deviceWidth/1.5,
                height: deviceHeight / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 5)
                ),
                child: const Center(child:
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text("Click here to select the database icon", style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600
                    ),))),
              ),
            ),

            const SizedBox(height: 30),
            TextFormField(
              controller: InstanceName,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Name of database",
                labelText: "Name of database",
                labelStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: InstancePath,
              autocorrect: true,
              onTap: () async{
                print("Deus tenha piedade de minha alma");
                print("Deus me ajude !!! $_pathLocation");

                },
              decoration: InputDecoration(
                enabled: false,
                hintText: "Path of database",
                labelText: "Path of database",
                labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(onPressed: () async {

              final result2 = await FilePicker.platform.getDirectoryPath();
              InstancePath.text = result2.toString();

              print("obrigado meu Deus !!! ${_pathLocation.toString()}");
              print("Deus me ajuda !!! ${InstancePath.text}");
              print("obrigado meu Deus !!! $_pathLocation");
            }, child: const Text("Select path folder")),

            const SizedBox(height: 15),

            TextFormField(
              controller: InstanceTableName,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: "Table name",
                labelText: "Table name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey)
                )
              ),

            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: InstanceColumnsNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number of columns",
                labelText: "Number of columns",
                labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: InstancePassword,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Password",
                labelText: "Enter password",
                labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: InstanceConfirmPassword,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                labelText: "Confirm your password",
                labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {
                  print("Deus me ajude !!! $_pathLocation");
                  print("Deus me perdoe !!! ${InstancePath.text}");


                  if(InstanceName.text.isNotEmpty && InstancePath.text.isNotEmpty && InstanceColumnsNumber.text.isNotEmpty
                  && InstancePassword.text == InstanceConfirmPassword.text && InstanceTableName.value.text.isNotEmpty) {
                          
                      if(InstanceTableName.text.contains(" ")) {
                              
                        showDialog(context: context, builder: (context) {

                          return AlertDialog(

                            title: const Text("The table name cannot have spaces"),
                            content: const Text("So, we can't create the database"),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("Close")),
                            ],

                          );

                        });

                      } else {
                          String ps = InstancesHelper.getInstance.hashPassword(InstancePassword.text);

                        //Finalizar o sistema de rows, realizar o sistema de criação de database, dica:
                        //Creio que problema possa ser resolvido usando como parametro uma lista de rows("info": f, "info2:": f + f, entendeu, adicione o antecessor ao sucessor é entaõ terá uma linha evolutiva da qual poderá usufurir)
                        for(int i = 0; i < int.parse(InstanceColumnsNumber.text); i++) {
                          InstancesHelper.getInstance.getHeaders.add({
                            "title": "Col_$i",
                            "index": "$i",
                            "key":  "random_$i",
                          });
                          print("Deus me ajude !!! ${InstancesHelper.getInstance.getRows}");
                          InstancesHelper.getInstance.getTextControllers.add(TextEditingController());
                        }

                        print("Gloria a Deus !!! $ps");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InstanceConfigure(
                            int.parse(InstanceColumnsNumber.text),
                            InstancePath.text,
                            InstanceName.text,
                            InstancesHelper.getInstance.getHeaders,
                            InstancesHelper.getInstance.getRows,
                            InstancesHelper.getInstance.getTextControllers,
                            [InstanceTableName.text],
                            icon,
                            ps
                        )));
                      }

                  } else {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "Some field is empty",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        content: const Text("Some field is empty or your password isn't confirmed correctly"),
                        alignment: Alignment.center,
                        actions: <Widget>[
                          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))
                        ],

                      );
                    });
                  }

                },
                child: const Text("Configure the Columns")
            ),




          ]),
        ),
      ),





    );
  }
}


