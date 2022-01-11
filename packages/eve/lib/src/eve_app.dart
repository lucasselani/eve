import 'package:eve/eve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

class EveApp extends StatelessWidget {
  final EveI18nDelegate delegate;
  final EveRouter router;

  EveApp({
    required BaseApp baseApp,
    required EveTheme theme,
    EveTheme? darkTheme,
    required Locale defaultLanguage,
    List<Locale>? supportedLanguages,
    String eveName = 'default',
    Key? key,
  })  : router = EveRouter(navigationModules: [
          baseApp.navigatorModule,
          ...baseApp.packages
              .where((package) => package is MicroApp)
              .map((microApp) => (microApp as MicroApp).navigatorModule)
              .toList()
        ]),
        delegate = EveI18nDelegate(
          i18nModules: [
            baseApp.i18nModule,
            ...baseApp.packages
                .where((package) => package is MicroApp)
                .map((microApp) => (microApp as MicroApp).i18nModule)
                .toList()
          ],
          defaultLanguage: defaultLanguage,
          supportedLanguages: supportedLanguages ?? [defaultLanguage],
        ),
        super(key: key) {
    EveManager.initialize(
      app: baseApp,
      name: eveName,
      defaultTheme: theme,
      darkTheme: darkTheme,
    );
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
    return AnimatedBuilder(
        animation: EveManager(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: EveManager().defaultTheme.themeData,
            darkTheme: EveManager().darkTheme?.themeData,
            themeMode:
                EveManager().isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
        });
  }
}
