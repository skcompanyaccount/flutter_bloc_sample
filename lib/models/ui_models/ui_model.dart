import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UiModel{
  final BuildContext context;
  final ThemeModel theme;
  final LanguageModel language;

  UiModel({String themeName, String languageCode, String pageRouteName, this.context})
      :theme=ThemeModel(themeName: themeName), language=LanguageModel(pageRouteName: pageRouteName, languageCode: languageCode);

  double get screenWidth=>MediaQuery.of(context).size.width;
  double get screenHeight=>MediaQuery.of(context).size.height;
  double get frameWidthSizeFactor=>(screenWidth<=screenHeight)?0.8:0.65;
  double get frameHeightSizeFactor=>(screenHeight>=screenWidth)?0.65:0.8;
  double get pageFrameWidth=>screenWidth*frameWidthSizeFactor;
  double get pageFrameHeight=>screenHeight*frameHeightSizeFactor;
  double get pageFrameButtonsContainerHeight=>(pageFrameHeight*0.15)-1.0;
  double get pageFrameTitleContainerHeight=>(pageFrameHeight*0.25)-1.0;
  double get pageFrameSubElementsContainerHeight=>pageFrameHeight*0.6;

  Scaffold getPage({String title, List<Widget> pageButtonList, List<Widget> pageSubElements, bool isPageLoading})=>Scaffold(
    body: isPageLoading?loadingScreen:getPageFrame(
      title: title,
      buttons: pageButtonList,
      subElements: pageSubElements
    ),
    backgroundColor: theme.colors["bodyBackgroundColor"],
  );

  Widget get loadingScreen=>Container(
    child: Container(
      child: Theme(
        child: CircularProgressIndicator(),
        data: ThemeData(accentColor: theme.colors["bodyContentColor"]),
      ),
      width: 50.0,
      height: 50.0,
    ),
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity
  );

  BoxDecoration get pageFrameBoxDecoration=>BoxDecoration(
      color: theme.colors["bodySubBackgroundColor"],
      border: Border.all(color: theme.colors["bodyShadowColor"]),
      boxShadow: [
        BoxShadow(
            color: theme.colors["bodyShadowColor"],
            offset: Offset(0,3),
            blurRadius: 15,
            spreadRadius: 2
        )
      ]
  );

  Widget getPageFrame({String title, List<Widget> buttons, List<Widget> subElements})=>Container(
    child: Container(
        child: Column(
          children: [
            getPageButtons(buttons: buttons),
            Divider(height: 0.0),
            getPageFrameElementsTitle(title: title),
            Divider(height: 0.0),
            getPageFrameSubContainer(subElements: subElements),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        ),
        width: pageFrameWidth,
        height: pageFrameHeight,
        decoration: pageFrameBoxDecoration
    ),
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity
  );


  Widget getPageButtons({List<Widget> buttons})=>buttons==null?SizedBox(height: pageFrameButtonsContainerHeight*0.4):Container(
      child: Row(
          children: [SizedBox(width: pageFrameWidth*0.05)]..addAll(buttons),
          mainAxisAlignment: MainAxisAlignment.start
      ),
      width: double.infinity,
      height: pageFrameButtonsContainerHeight
  );

  Widget getPageFrameSubContainer({List<Widget> subElements})=>Container(
    child: ScrollConfiguration(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
              children: subElements,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center
          ),
        ),
      ),
      behavior: ScrollBehavior(),
    ),
    width: double.infinity,
    height: pageFrameSubElementsContainerHeight,
  );

  Widget getPageFrameElementsTitle({String title})=>Container(
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.9, color: theme.colors["bodyContentColor"], fontSize: 24.0), textAlign: TextAlign.center),
      alignment: Alignment.center,
      width: double.infinity,
      height: pageFrameTitleContainerHeight,
      color: theme.colors['bodyBackgroundColor'],
  );

  Widget getPageElementsFrameSubTextElement({String text, double fontSize})=>Container(
    child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: theme.colors['bodyContentSecondaryColor']), textAlign: TextAlign.start),
    width: double.infinity,
    height: 35,
    alignment: Alignment.center,
  );

  Widget get subTextElementDivider=>Divider(height:0.0, indent: pageFrameWidth*0.3, endIndent: pageFrameWidth*0.3, color: theme.colors['bodyContentSecondaryColor'],);

  Widget getFrameMainButton({String buttonText, Function onPressed})=>Align(
    child: FlatButton(
      child: Text(buttonText, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: theme.colors['bodyContentSecondaryColor'])),
      onPressed: onPressed,
      color: theme.colors["bodyBackgroundColor"],
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
    ),
    alignment: Alignment.centerRight,
  );

  IconButton getIconButton({IconData icon, Function onPressed})=>IconButton(
    icon: Icon(icon, color: theme.colors["bodyContentColor"]),
    onPressed: onPressed,
  );
}

class ThemeModel{
  final Map<String, Color> colors;

  ThemeModel({String themeName}):colors=getColors(themeName: themeName);

  static Map<String, Color> getColors({String themeName})=>{
    "dark":{
      "bodyBackgroundColor":Colors.blueGrey[800],
      "bodySubBackgroundColor":Colors.blueGrey[600],
      "bodyContentColor":Colors.blueGrey[200],
      "bodyContentSecondaryColor":Colors.blueGrey[100],
      "bodyShadowColor":Colors.blueGrey[600],
      "switchActiveColor":Colors.blueGrey[300],
      "switchTrackColor":Colors.blueGrey[200]

    },
    "light":{
      "bodyBackgroundColor":Colors.grey[100],
      "bodySubBackgroundColor":Colors.grey[50],
      "bodyContentColor":Colors.blueGrey[600],
      "bodyContentSecondaryColor":Colors.blueGrey[400],
      "bodyShadowColor":Colors.grey[400],
      "switchActiveColor":Colors.blueGrey[300],
      "switchTrackColor":Colors.blueGrey[100]
    }
  }[themeName];
}

class LanguageModel{
  final Map<String, String> languageMap;
  LanguageModel({String pageRouteName, String languageCode}):languageMap=getLanguageMap(pageRouteName: pageRouteName, languageCode: languageCode);

  static Map<String, String> getLanguageMap({String pageRouteName, String languageCode})=>{
    "settingsViewPage":{
      "tr":{
        "title":"Seçili Ayarlar",
        "themeTitle":"Tema",
        "languageTitle":"Dil",
        "dark":"Karanlık Tema",
        "light":"Aydınlık Tema",
        "tr":"Türkçe",
        "en":"İngilizce",
        "editButtonText":"Düzenle"
      },
      "en":{
        "title":"Selected Settings",
        "themeTitle":"Theme",
        "languageTitle":"Language",
        "dark":"Dark Theme",
        "light":"Light Theme",
        "tr":"Turkish",
        "en":"English",
        "editButtonText":"Edit"
      }
    },
    "settingsPage":{
      "tr":{
        "title":"Ayarları Düzenle",
        "themeTitle":"Tema",
        "languageTitle":"Dil",
        "dark":"Karanlık",
        "light":"Aydınlık",
        "tr":"Türkçe",
        "en":"İngilizce",
      },
      "en":{
        "title":"Edit Settings",
        "themeTitle":"Theme",
        "languageTitle":"Language",
        "dark":"Dark",
        "light":"Light",
        "tr":"Turkish",
        "en":"English",
      }
    }
  }[pageRouteName][languageCode];
}
