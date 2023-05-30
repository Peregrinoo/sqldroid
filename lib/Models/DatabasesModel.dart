//                                         Deus seja louvado !!!

// ignore: file_names

// ignore_for_file: file_names, duplicate_ignore, unnecessary_getters_setters

import 'package:sqldroid/Models/TablesModel.dart';

class DatabasesModel{

  String? _databaseInstanceName;
  String? _databaseIp;
  String? _databaseIcon;
  String? _databasePath;

  List<TablesModel?> _listTables;

  int? _databasePort;


  //Voltar a fazer esse sistema de recuperação de dados e realizar o processo de

  DatabasesModel(this._databaseInstanceName,
      this._databaseIcon, this._databasePath, this._listTables);

  String returnDatabaseStatus() {
    return "Instance-name: $_databaseInstanceName\nInstance-Ip: $_databaseIp\n InstanceIcon: $_databaseIcon\n InstancePath: $_databasePath\n InstanceTables: ${_listTables.first!.returnModelStatus()}";
  }


  String? get databaseIp => _databaseIp;

  set databaseIp(String? value) {
    _databaseIp = value;
  }

  int? get databasePort => _databasePort;

  set databasePort(int? value) {
    _databasePort = value;
  }

  String? get databaseIcon => _databaseIcon;

  set databaseIcon(String? value) {
    _databaseIcon = value;
  }

  String? get databaseInstanceName => _databaseInstanceName;

  set databaseInstanceName(String? value) {
    _databaseInstanceName = value;
  }

  String? get databasePath => _databasePath;

  set databasePath(String? value) {
    _databasePath = value;
  }


}
