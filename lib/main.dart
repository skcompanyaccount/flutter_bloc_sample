import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/settings_bloc.dart';
import 'views/settings_view_page.dart';
import 'views/settings_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context)=>BlocProvider<SettingsBloc>(
    create: (context)=>SettingsBloc()..add(SettingsReadEvent()),
    lazy: false,
    child: MaterialApp(
      title: "flutter_bloc Sample",
      initialRoute: 'settingsViewPage',
      routes: routes,
    )
  );


  Map<String, WidgetBuilder> get routes=>{
    'settingsViewPage':(context)=>SettingsViewPage(),
    'settingsPage':(context)=>SettingsPage()
  };
}
