//                                            Deus seja louvado !!!

// ignore_for_file: file_names

import 'package:file_picker/file_picker.dart';

class InstancesPathHelper{

  static Future<FilePickerResult?> selectIcon() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image
    );
    return result;
  }

  static Future<String?> viewFolders() async{
    final result2 = await FilePicker.platform.getDirectoryPath();
    print("Deus tenha piedade de mim $result2");
    return result2;
  }


}