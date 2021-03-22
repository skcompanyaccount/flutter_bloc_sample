import 'package:equatable/equatable.dart';
class SettingsModel extends Equatable{
  final String themeName, languageCode;
  SettingsModel({this.themeName, this.languageCode});

  SettingsModel.fromMap({Map<String,dynamic> settingsMap}):themeName=settingsMap["themeName"],languageCode=settingsMap["languageCode"];

  SettingsModel.fromEmpty():themeName="light",languageCode="en";

  Map<String, dynamic> get settingsMap=>{
    'themeName':themeName,
    'languageCode':languageCode
  };

  @override
  List<Object> get props => [themeName, languageCode];
}