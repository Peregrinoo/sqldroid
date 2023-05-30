//                                              Deus seja louvado !!!


// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sqldroid/Helpers/InstancesHelper.dart';
import 'package:sqldroid/Helpers/InstancesUIHelper.dart';
import 'package:sqldroid/Models/ConnectionType.dart';
import 'package:sqldroid/Models/DatabasesModel.dart';

class InstancesMain extends StatefulWidget {
  DatabasesModel dbModel = DatabasesModel("", "", "", []);

  InstancesMain(this.dbModel, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<InstancesMain> createState() => _InstancesMainState(dbModel);

}

class _InstancesMainState extends State<InstancesMain> {

  DatabasesModel dbModel = DatabasesModel("", "", "", []);
  ValueNotifier _choice = ValueNotifier("");

  _InstancesMainState(this.dbModel);


  @override
  void initState() {
    InstancesUIHelper.getInstance.machineStatus = "Start";
    for(int i = 0; i < 100; i++) {
      InstancesUIHelper.getInstance.addTextToLogControl("Deus bendito seja !");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(dbModel.databaseInstanceName!, style: const TextStyle(fontSize: 18)),
        ),
        body: Column(
          children: [

            const SizedBox(height: 35),
            //Image.asset("") -> Status atual da maquina;
            //Deve exibir os ultimos request's feitos para esta maquina; Fazendo claro um grafico de donuts tanto porcentos de 100%(que por acaso é infinito, então apenas vai mostrar o numero de requests ou outra coisa;)

            const SizedBox(height: 15),

            /*
              ->
             */

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -> Criar três botões os quais serão: [View Logs] | [Start/Stop] | [Show data]
                const SizedBox(width: 15),
                ElevatedButton(onPressed: (){

                  if(InstancesUIHelper.getInstance.getConnection() == null) {

                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.custom,
                      customAsset: "assets/question.gif",
                      title: "Select the type of connection",
                      widget:
                          /*
                        ValueListenableBuilder(
                          valueListenable: dropValue,
                          builder: (context, value, _){
                            return  DropdownButton(items: choices., onChanged: onChanged)
                          },
                        ),

                                                  DropdownButton(

                              onChanged: (choice) {
                                print("Deus bendito seja ! ${choice}");
                                setState(() {
                                  _choice = choice.toString();
                                });
                              },
                            elevation: 9,
                              value: _choice,
                            items: ["Wifi","Bluetooth","Radio"].map<DropdownMenuItem<String>>((_value) =>
                                  DropdownMenuItem<String>(value: _value, child: Text(_value)
                              )).toList(),

                      ),


                           */
                      ValueListenableBuilder(valueListenable: _choice, builder: (context, value, _) {
                        return DropdownButton<String>(

                          onChanged: (choice) {
                            print("Deus bendito seja ! $choice");
                            _choice = ValueNotifier(choice);
                          },
                          elevation: 9,
                          value: value.toString().isEmpty ? null : value,
                          items: InstancesUIHelper.getInstance.selectItems.map((e) =>
                              DropdownMenuItem(value: e, child: Text(e))).toList()

                        );
                      }),
                      confirmBtnText: "Select",
                      onConfirmBtnTap: (){
                        InstancesUIHelper.getInstance.setConnection(Connection(ConnectionType.wifi));
                      },
                      cancelBtnText: "Cancel"
                    );
                  } else {
                    print("Deus bendito seja !");
                    InstancesHelper.getInstance.startServer(dbModel);
                  }

                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple)), child:
                Text(InstancesUIHelper.getInstance.machineStatus,
                  style: GoogleFonts.robotoMono(fontSize: 18, color: Colors.white),),),
                const SizedBox(width: 15),
                ElevatedButton(onPressed: (){

                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple)), child:
                Text("Show Data", style: GoogleFonts.robotoMono(fontSize: 18, color: Colors.white))),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: TextField(
                decoration: InputDecoration(
                  label: const Text("Logs"),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey)
                  )
                ),
                expands: true,
                maxLines: null,
                enabled: true,
                controller: InstancesUIHelper.getInstance.logController,
                onChanged: (String text) {
                  InstancesUIHelper.getInstance.logController.text = InstancesUIHelper.getInstance.logControllerText;
                },

              ),
            )



          ],
        ),
      ),

    );
  }
}

