import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FileController{
  Directory directory;
  String appPath, fileName;
  File file;

  FileController({String fileName, String fileType}){
    this.fileName=fileName+'.'+fileType;
  }

  prepareJsonFile() async{
    directory=await getApplicationDocumentsDirectory().then((appDirectory){return appDirectory;});
    appPath=directory.path;
    this.file=File(appPath+'/'+fileName);
  }

  Future<bool> saveFile({Map<String, dynamic> fileMap})async{
    try{
      await prepareJsonFile();
      ///Future for circularProgressIndicator
      await Future.delayed(Duration(milliseconds: 500));
      await file.writeAsString(jsonEncode(fileMap));
      return true;
    }catch(e){
      return false;
    }
  }

  Future<Object> getFileAsMap() async{
    try {
      await prepareJsonFile();
      ///Future for circularProgressIndicator
      await Future.delayed(Duration(milliseconds: 500));
      return jsonDecode(await file.readAsString());
    }catch(e){
      return false;
    }
  }

  Future<bool> isFileExist()async{
    try {
      await prepareJsonFile();
      return await file.exists();
    }catch(e){
      return false;
    }
  }
}