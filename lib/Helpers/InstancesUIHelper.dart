//                                                Deus seja louvado !!!


// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqldroid/Models/ConnectionType.dart';

class InstancesUIHelper{

  InstancesUIHelper._();

  static final _instance = InstancesUIHelper._();

  String _machineStatus = "";
  String _logControllerText = "";
  TextEditingController _logController = TextEditingController();

  final List<String> _selectItems = ["Wifi","Bluetooth","Radio"];

  Connection? _connection;

  addTextToLogControl(String text) {
    _logController.text = "${_logController.text} \n $text";
    _logControllerText = _logController.text;
  }

  setConnection(Connection cn) {
    _connection = cn;
  }
  getConnection() {
    return _connection;
  }



  TextEditingController get logController => _logController;

  set logController(TextEditingController value) {
    _logController = value;
  }

    String get logControllerText => _logControllerText;

  set logControllerText(String value) {
    _logControllerText = value;
  }

  String get machineStatus => _machineStatus;

  set machineStatus(String value) {
    _machineStatus = value;
  }


  List<String> get selectItems => _selectItems;


  static InstancesUIHelper get getInstance => _instance;

}


