import 'package:eve/eve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n/i18n.dart';
import 'package:navigator/navigator.dart';

class EveApp extends StatelessWidget {
  final EveRouter router;
  final String eveName;

  static void run({
    required BaseApp baseApp,
    String eveName = 'default',
  }) {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(EveApp._(baseApp: baseApp, eveName: eveName));
  }

  EveApp._({
    required BaseApp baseApp,
    this.eveName = 'default',
    Key? key,
  })  : router = EveRouter(navigationModules: [
          baseApp.navigatorModule,
          ...baseApp.packages
              .where((package) => package is MicroApp)
              .map((microApp) => (microApp as MicroApp).navigatorModule)
              .toList()
        ]),
        super(key: key) {
    EveManager.initialize(
      app: baseApp,
      name: eveName,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
    ]);
    return AnimatedBuilder(
      animation: EveManager(),
      builder: (context, child) {
        final i18nDelegate = EveI18nDelegate(
          i18nModules: [
            EveManager().app.i18nModule,
            ...EveManager()
                .app
                .packages
                .where((package) => package is MicroApp)
                .map((microApp) => (microApp as MicroApp).i18nModule)
                .toList()
          ],
          defaultLanguage: EveManager().app.defaultLanguage,
          supportedLanguages: EveManager().app.supportedLanguages,
        );
        return FutureBuilder<void>(
          future: EveManager().eveInitialization,
          builder: (context, snapshot) {
            if (!EveManager().isEveInitialized) {
              return const EmptyWidget();
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: EveManager().app.defaultTheme.themeData,
                darkTheme: EveManager().app.darkTheme?.themeData,
                themeMode:
                    EveManager().isDarkMode ? ThemeMode.dark : ThemeMode.light,
                onGenerateRoute: router.onGenerateRoute,
                navigatorKey: router.key,
                navigatorObservers: [router.observer],
                localizationsDelegates: [
                  i18nDelegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: i18nDelegate.supportedLanguages,
                locale: EveManager().currentLanguage,
              );
            }
          },
        );
      },
    );
  }
}
