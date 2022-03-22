import 'package:eve_core/eve_core.dart';
import 'package:eve_design_system/eve_design_system.dart';
import 'package:example/micro_app_counter/presentation/counter_view_model.dart';
import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CounterView> {
  final _viewModel = Injector().get<CounterViewModel>();

  @override
  Widget build(BuildContext context) => EveScaffold(
        appBarConfig: EveAppBarConfig(
            leadingButtonType: EveLeadingBarButtonType.back,
            title: EveTranslator.translate(key: 'counter_title'),
            trailing: [
              EveIconButton(
                icon: Icons.navigation_rounded,
                onTap: () =>
                    EveNavigator().go(mode: NavMode.push, name: '/counter'),
              ),
              EveIconButton(
                icon: Icons.catching_pokemon,
                onTap: () => EveManager().isDarkMode = !EveManager().isDarkMode,
              ),
              EveIconButton(
                  icon: Icons.translate,
                  onTap: () {
                    final supportedLanguages =
                        EveManager().app.supportedLanguages;
                    final defaultLanguage = EveManager().app.defaultLanguage;

                    var currentIndex = supportedLanguages
                        .indexOf(EveManager().currentLanguage);
                    if (currentIndex == -1) {
                      currentIndex =
                          supportedLanguages.indexOf(defaultLanguage);
                    }

                    EveManager().currentLanguage = supportedLanguages.elementAt(
                        (currentIndex + 1) % supportedLanguages.length);
                  })
            ]),
        body: EveScrollWidget(
          children: [
            EveText.title(text: EveTranslator.translate(key: 'button_pushed')),
            ObserverWidget<int>(
              listenable: _viewModel.count,
              onSuccess: (count, child) => EveText.paragraph(text: '$count'),
            )
          ],
          bottomWidgets: [
            EveButton.solid(
              onTap: () => _viewModel.increment(),
              text: EveTranslator.translate(key: 'increment'),
            ),
          ],
        ),
      );
}
