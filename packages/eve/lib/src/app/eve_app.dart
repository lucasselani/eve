import 'package:eve/eve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n/i18n.dart';

class EveApp extends StatelessWidget {
  final EveI18nDelegate delegate;
  final EveNavigator navigator;
  final ThemeData? themeData;
  final Color? systemNavigationBarColor;

  EveApp({
    Key? key,
    List<MicroApp> microApps = const [],
    required EveNavigatorModule baseAppNavigatorModule,
    required EveI18nModule baseAppI18nModule,
    this.systemNavigationBarColor,
    this.themeData,
    List<Locale>? supportedLanguages,
    required Locale defaultLanguage,
  })  : navigator = EveNavigator(navigatorModules: [
          baseAppNavigatorModule,
          ...microApps
              .where((microApp) => microApp.navigatorModule != null)
              .map((microApp) => microApp.navigatorModule!)
              .toList()
        ]),
        delegate = EveI18nDelegate(
          i18nModules: [
            baseAppI18nModule,
            ...microApps
                .where((microApp) => microApp.i18nModule != null)
                .map((microApp) => microApp.i18nModule!)
                .toList()
          ],
          defaultLanguage: defaultLanguage,
          supportedLanguages: supportedLanguages ?? [defaultLanguage],
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavigationBarColor,
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateRoute: navigator.onGenerateRoute,
      navigatorKey: Admiral(navigator.name).key,
      navigatorObservers: [Admiral(navigator.name).observer],
      localizationsDelegates: [
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: delegate.supportedLanguages,
    );
  }
}
