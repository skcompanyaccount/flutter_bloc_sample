import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../models/project_models/settings_model.dart';
import '../models/ui_models/ui_model.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context)=>BlocBuilder<SettingsBloc, SettingsState>(
    buildWhen: (previousState, currentState)=>currentState.runtimeType != previousState.runtimeType,
    builder: (context, state)=>getPage(state: state, context: context, bloc: BlocProvider.of<SettingsBloc>(context)),
  );

  Widget getPage({SettingsState state, BuildContext context, SettingsBloc bloc}){
    final SettingsModel settings=bloc.stateToSettings(state: state);
    final ui=UiModel(themeName: settings.themeName, languageCode: settings.languageCode, context: context, pageRouteName: "settingsPage");

    return ui.getPage(
        title: ui.language.languageMap["title"],
        pageButtonList: [
          ui.getIconButton(icon: Icons.arrow_back, onPressed: ()=>Navigator.pop(context))
        ],
        pageSubElements: getPageSubElements(ui: ui, settings: settings, bloc: bloc),
        isPageLoading: isPageNeedsToLoadingScreen(state)
    );
  }

  List<Widget> getPageSubElements({UiModel ui, SettingsModel settings, SettingsBloc bloc})=>[
    SizedBox(height: 10.0),
    ui.getPageElementsFrameSubTextElement(text: ui.language.languageMap['themeTitle'], fontSize: 17.0),
    ui.subTextElementDivider,
    getSwitchContainer(
      ui: ui,
      value: (settings.themeName=="dark"),
      trueOption: ui.language.languageMap["dark"],
      falseOption: ui.language.languageMap["light"],
      onChanged: (bool newValue){
        bloc.add(SettingsUpdateEvent(SettingsModel(themeName: newValue?"dark":"light", languageCode: settings.languageCode)));
      }
    ),
    ui.getPageElementsFrameSubTextElement(text: ui.language.languageMap['languageTitle'], fontSize: 17.0),
    ui.subTextElementDivider,
    getSwitchContainer(
        ui: ui,
        value: (settings.languageCode=="en"),
        trueOption: ui.language.languageMap["en"],
        falseOption: ui.language.languageMap["tr"],
        onChanged: (bool newValue){
          bloc.add(SettingsUpdateEvent(SettingsModel(themeName: settings.themeName, languageCode: newValue?"en":"tr")));
        }
    ),
  ];

  Widget getSwitchContainer({UiModel ui, String trueOption, String falseOption, bool value, Function onChanged})=>Container(
    child: Row(
      children: [
        getSwitchOptionText(option:falseOption, ui: ui),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: ui.theme.colors['switchActiveColor'],
          inactiveThumbColor: ui.theme.colors['bodyContentSecondaryColor'],
          activeTrackColor: ui.theme.colors['switchTrackColor'],
          inactiveTrackColor: ui.theme.colors['switchTrackColor'],
        ),
        getSwitchOptionText(option:trueOption, ui: ui),
      ],
      mainAxisAlignment: MainAxisAlignment.center
    ),
    width: double.infinity,
  );

  Widget getSwitchOptionText({UiModel ui, String option})=>Container(
    child: Text(option, style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: ui.theme.colors['bodyContentColor'])),
  );


  bool isPageNeedsToLoadingScreen(SettingsState state)=>(state is SettingsLoadingState)||(state is SettingsUpdatingState);
  UiModel getUi({SettingsModel settings, BuildContext context})=>UiModel(pageRouteName: 'settingsViewPage', themeName: settings.themeName, languageCode: settings.languageCode, context: context);

}
