import 'package:eve/eve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class EveApp extends StatefulWidget {
  final BaseApp baseApp;
  final EveI18nDelegate delegate;
  final EveNavigator navigator;
  final ThemeData? themeData;
  final Color? systemNavigationBarColor;

  EveApp({
    Key? key,
    required this.baseApp,
    this.systemNavigationBarColor,
    this.themeData,
    List<Locale>? supportedLanguages,
    required Locale defaultLanguage,
  })  : navigator = EveNavigator(navigatorModules: [
          baseApp.navigatorModule,
          ...baseApp.packages
              .where((package) =>
                  package is MicroApp && package.navigatorModule != null)
              .map((microApp) => (microApp as MicroApp).navigatorModule!)
              .toList()
        ]),
        delegate = EveI18nDelegate(
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
        super(key: key);

  @override
  State<StatefulWidget> createState() => _EveState();
}

class _EveState extends State<EveApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (!_isInitialized) _initialize();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: widget.systemNavigationBarColor,
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget.themeData,
      onGenerateRoute: widget.navigator.onGenerateRoute,
      navigatorKey: Admiral(widget.navigator.name).key,
      navigatorObservers: [Admiral(widget.navigator.name).observer],
      localizationsDelegates: [
        widget.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: widget.delegate.supportedLanguages,
    );
  }

  Future<void> _initialize() async {
    await widget.baseApp.initialize();
    for (final package in widget.baseApp.packages) {
      await package.initialize();
    }
    setState(() {
      _isInitialized = true;
    });
    widget.baseApp.onInitialized();
  }

  Future<void> _dispose() async {
    await widget.baseApp.dispose();
    for (final package in widget.baseApp.packages) {
      await package.dispose();
    }
  }
}
