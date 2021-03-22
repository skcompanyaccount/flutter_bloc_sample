import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../models/project_models/settings_model.dart';
import '../models/ui_models/ui_model.dart';

class SettingsViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context)=>BlocBuilder<SettingsBloc, SettingsState>(
    buildWhen: (previousState, currentState)=>currentState.runtimeType != previousState.runtimeType,
    builder: (context, state)=>getPage(state: state, context: context, bloc: BlocProvider.of<SettingsBloc>(context))
  );

  UiModel getUi({SettingsModel settings, BuildContext context})=>UiModel(pageRouteName: 'settingsViewPage', themeName: settings.themeName, languageCode: settings.languageCode, context: context);

  Widget getPage({SettingsState state, BuildContext context, SettingsBloc bloc}){
    final SettingsModel settings=bloc.stateToSettings(state: state);
    final ui=UiModel(themeName: settings.themeName, languageCode: settings.languageCode, context: context, pageRouteName: "settingsViewPage");

    return ui.getPage(
        title: ui.language.languageMap["title"],
        pageSubElements: getPageSubElements(ui: ui, settings: settings),
        isPageLoading: isPageNeedsToLoadingScreen(state)
    );
  }

  List<Widget> getPageSubElements({UiModel ui, SettingsModel settings})=>[
    SizedBox(height: 10.0),
    ui.getPageElementsFrameSubTextElement(text: ui.language.languageMap['themeTitle'], fontSize: 17.0),
    ui.subTextElementDivider,
    ui.getPageElementsFrameSubTextElement(text: ui.language.languageMap[settings.themeName], fontSize: 25.0),
    SizedBox(height: 30.0),
    ui.getPageElementsFrameSubTextElement(text: ui.language.languageMap['languageTitle'], fontSize: 17.0),
    ui.subTextElementDivider,
    ui.getPageElementsFrameSubTextElement(text: ui.language.languageMap[settings.languageCode], fontSize: 25.0),
    SizedBox(height: 20.0),
    ui.getFrameMainButton(buttonText: ui.language.languageMap['editButtonText'], onPressed: ()=>Navigator.pushNamed(ui.context, "settingsPage")),
  ];

  bool isPageNeedsToLoadingScreen(SettingsState state)=>(state is SettingsLoadingState)||(state is SettingsUpdatingState);
}
