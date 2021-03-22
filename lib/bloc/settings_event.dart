part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable{}

class SettingsReadEvent extends SettingsEvent{
  @override
  List<Object> get props =>[];
}

class SettingsUpdateEvent extends SettingsEvent{
  SettingsUpdateEvent(this.settings);
  final SettingsModel settings;

  @override
  List<Object> get props => [settings.themeName, settings.languageCode];
}