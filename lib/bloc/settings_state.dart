part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable{
  const SettingsState();

  @override
  List<Object> get props=>[];
}

class SettingsLoadingState extends SettingsState{}

class SettingsUpdatingState extends SettingsState{
  final SettingsModel newSettings;
  SettingsUpdatingState({this.newSettings});
}

class SettingsUpdatedState extends SettingsState{
  final SettingsModel settings;
  SettingsUpdatedState({this.settings});
}

class SettingsLoadedState extends SettingsState{
  final SettingsModel settings;
  const SettingsLoadedState({this.settings});
}




