//                                            Deus seja louvado !!!

import 'package:flutter/material.dart';
import 'package:sqldroid/Screens/Instances/Instances.dart';

//Função Main
void main() async{

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepPurpleAccent,

    ),
    title: "SQLdroid",
    //Inicializa na Home;
    home: const Instances(),
  ));
}
