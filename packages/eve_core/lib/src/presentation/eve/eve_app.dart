import 'package:eve_core/src/presentation/eve/eve_manager.dart';
import 'package:eve_core/src/presentation/i18n/eve_i18n_delegate.dart';
import 'package:eve_core/src/presentation/navigator/eve_router.dart';
import 'package:eve_core/src/presentation/package/packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class EveApp extends StatelessWidget {
  final EveRouter router;
  final Widget? splashScreen;

  static void run({
    required BaseApp baseApp,
    Widget? splashScreen,
  }) {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(EveApp._(baseApp: baseApp));
  }

  EveApp._({
    required BaseApp baseApp,
    this.splashScreen,
    Key? key,
  })  : router = EveRouter(navigationModules: [
          baseApp.navigatorModule,
          ...baseApp.packages
              .whereType<MicroApp>()
              .map((microApp) => microApp.navigatorModule)
              .toList()
        ]),
        super(key: key) {
    EveManager.initialize(app: baseApp);
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
                .whereType<MicroApp>()
                .map((microApp) => microApp.i18nModule)
                .toList()
          ],
          defaultLanguage: EveManager().app.defaultLanguage,
          supportedLanguages: EveManager().app.supportedLanguages,
        );
        return FutureBuilder<void>(
          future: EveManager().eveInitialization,
          builder: (context, snapshot) {
            if (!EveManager().isEveInitialized) {
              return splashScreen ?? Container();
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: EveManager().app.defaultTheme,
                darkTheme: EveManager().app.darkTheme,
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
