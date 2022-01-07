import 'package:eve/eve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

class EveApp extends StatelessWidget {
  final EveI18nDelegate delegate;
  final EveRouter router;
  final ThemeData? themeData;

  EveApp({
    required BaseApp baseApp,
    this.themeData,
    List<Locale>? supportedLanguages,
    required Locale defaultLanguage,
    Key? key,
    String eveName = 'default',
  })  : router = EveRouter(navigatorModules: [
          if (baseApp.navigatorModule != null) baseApp.navigatorModule!,
          ...baseApp.packages
              .where((package) =>
                  package is MicroApp && package.navigatorModule != null)
              .map((microApp) => (microApp as MicroApp).navigatorModule!)
              .toList()
        ]),
        delegate = EveI18nDelegate(
          i18nModules: [
            if (baseApp.i18nModule != null) baseApp.i18nModule!,
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
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateRoute: router.onGenerateRoute,
      navigatorKey: router.key,
      navigatorObservers: [router.observer],
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
