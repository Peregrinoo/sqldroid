//                                          Deus seja louvado !!!

// ignore_for_file: file_names, unnecessary_getters_setters

import 'package:sqldroid/Models/TablesModel.dart';

class RowsModel{

  // How the user will create the sql commands ? with INSERT INTO [ActualTable] VALUES([Rows.getDataType]);

  String? _rowDataType;
  String? _rowAddedDate;
  TablesModel? _rowTable;
  // ignore: prefer_typing_uninitialized_variables
  var _rowInformation;


  RowsModel(this._rowDataType, this._rowAddedDate, this._rowTable,
      this._rowInformation);

  String? get rowDataType => _rowDataType;

  set rowDataType(String? value) {
    _rowDataType = value;
  }

  String? get rowAddedDate => _rowAddedDate;

  set rowAddedDate(String? value) {
    _rowAddedDate = value;
  }

  TablesModel? get rowTable => _rowTable;

  set rowTable(TablesModel? value) {
    _rowTable = value;
  }

  get rowInformation => _rowInformation;

  set rowInformation(value) {
    _rowInformation = value;
  }
}
