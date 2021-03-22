import '../models/project_models/settings_model.dart';
import '../controllers/settings_controller.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc():super(SettingsLoadingState());

  final SettingsController settingsController=SettingsController();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if(event is SettingsReadEvent){
      await Future.delayed(Duration(seconds: 1));
      final SettingsModel settings=await settingsController.getSettings();
      yield SettingsLoadedState(settings: settings);
    }if(event is SettingsUpdateEvent){
      yield SettingsUpdatingState(newSettings: event.settings);
      await settingsController.saveSettings(settings: event.settings);
      yield SettingsUpdatedState(settings: event.settings);
    }
  }

  SettingsModel stateToSettings({SettingsState state}){
    if(state is SettingsLoadingState){
      return SettingsModel.fromEmpty();
    }else if(state is SettingsLoadedState){
      return state.settings;
    }else if(state is SettingsUpdatingState){
      return state.newSettings;
    }else{
      return (state as SettingsUpdatedState).settings;
    }
  }

}
