import 'package:eve/eve.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateAfterInit();
  }

  @override
  Widget build(BuildContext context) => EveScaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EveText.header(
                text: EveTranslator.translate(key: 'splash_screen_text'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );

  Future<void> _navigateAfterInit() async {
    await Future.delayed(const Duration(seconds: 2));
    await EveManager().appInitialization;
    EveNavigator().go(mode: NavMode.replace, name: '/counter');
  }
}
