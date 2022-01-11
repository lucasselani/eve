import 'package:eve/eve.dart';
import 'package:example/micro_app_counter/presentation/counter_view_model.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  final _viewModel = Injector().get<CounterViewModel>();

  CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => EveScaffold(
        appBarConfig: EveAppBarConfig(
            leadingButtonType: EveLeadingBarButtonType.back,
            title: EveTranslator.translate(key: 'counter_title'),
            trailing: [
              EveIconButton(
                icon: Icons.catching_pokemon,
                onTap: () => EveManager().isDarkMode = !EveManager().isDarkMode,
              )
            ]),
        body: EveScrollWidget(
          children: [
            EveText.title(text: EveTranslator.translate(key: 'button_pushed')),
            ObservableWidget<int>(
              listenable: _viewModel.count,
              onSuccess: (count, child) => EveText.paragraph(text: '$count'),
            )
          ],
          bottomWidget: EveButton.solid(
            onTap: () => _viewModel.increment(),
            text: EveTranslator.translate(key: 'increment'),
          ),
        ),
      );
}
