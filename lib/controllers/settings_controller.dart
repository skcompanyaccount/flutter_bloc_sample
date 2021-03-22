import 'file_controller.dart';
import '../models/project_models/settings_model.dart';

class SettingsController{
  Future<bool> saveSettings({SettingsModel settings})async=>await FileController(fileName: "settings", fileType: "json").saveFile(fileMap: settings.settingsMap);

  Future<SettingsModel> getSettings()async{
    Object object=await FileController(fileName: "settings", fileType: "json").getFileAsMap();
    return (object is Map<String, dynamic>)?SettingsModel.fromMap(settingsMap: object):SettingsModel.fromEmpty();
  }
}