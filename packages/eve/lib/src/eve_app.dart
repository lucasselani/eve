import 'package:eve/eve.dart';
import 'package:eve/src/eve_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class EveApp extends StatelessWidget {
  final I18nDelegate delegate;
  final EveNavigator navigator;
  final ThemeData? themeData;
  final Color? systemNavigationBarColor;

  EveApp({
    required BaseApp baseApp,
    this.systemNavigationBarColor,
    this.themeData,
    List<Locale>? supportedLanguages,
    required Locale defaultLanguage,
    Key? key,
    String eveName = 'default',
  })  : navigator = EveNavigator(navigatorModules: [
          baseApp.navigatorModule,
          ...baseApp.packages
              .where((package) =>
                  package is MicroApp && package.navigatorModule != null)
              .map((microApp) => (microApp as MicroApp).navigatorModule!)
              .toList()
        ]),
        delegate = I18nDelegate(
          i18nModules: [
            baseApp.i18nModule,
            ...baseApp.packages
                .where((package) =>
                    package is MicroApp && package.i18nModule != null)
                .map((microApp) => (microApp as MicroApp).i18nModule!)
                .toList()
          ],
          defaultLanguage: defaultLanguage,
          supportedLanguages: supportedLanguages ?? [defaultLanguage],
        ),
        super(key: key) {
    EveManager.initialize(app: baseApp, name: eveName);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
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
