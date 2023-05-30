//                                            Deus seja louvado !!!

// ignore_for_file: file_names, unnecessary_getters_setters

import 'package:sqldroid/Models/RowsModel.dart';

class TablesModel{

  String? _tableName;
  List<RowsModel?> _listRows = [];


  TablesModel(this._tableName, this._listRows);

  String returnModelStatus() {
    return "Deus obrigado, Table-name: $_tableName | Rows: $_listRows";
  }

  String? get tableName => _tableName;

  set tableName(String? value) {
    _tableName = value;
  }

  List<RowsModel?> get listRows => _listRows;

  set listRows(List<RowsModel?> value) {
    _listRows = value;
  }
}