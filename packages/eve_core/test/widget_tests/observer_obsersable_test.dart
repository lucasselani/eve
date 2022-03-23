import 'package:eve_core/eve_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/eve_tester.dart';

class _Test {}

class _ViewModel {
  Observable<bool> boolean = Observable();
  Observable<int> integer = Observable();
  Observable<String> string = Observable();
  Observable<_Test> test = Observable();

  void toSuccess() {
    boolean.toSuccess(true);
    integer.toSuccess(1);
    string.toSuccess('data');
    test.toSuccess(_Test());
  }

  void toEmpty() {
    boolean.toEmpty();
    integer.toEmpty();
    string.toEmpty();
    test.toEmpty();
  }

  void toError() {
    boolean.toError();
    integer.toError();
    string.toError();
    test.toError();
  }

  void toLoading() {
    boolean.toLoading();
    integer.toLoading();
    string.toLoading();
    test.toLoading();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Should only find empty keys when screen is created',
      (WidgetTester tester) async {
    await _createScreen(tester, _ViewModel());
    expect(find.byKey(const ValueKey('boolean_empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('string_empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('integer_empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('test_empty')), findsOneWidget);

    expect(find.byKey(const ValueKey('boolean_success')), findsNothing);
    expect(find.byKey(const ValueKey('string_success')), findsNothing);
    expect(find.byKey(const ValueKey('integer_success')), findsNothing);
    expect(find.byKey(const ValueKey('test_success')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_error')), findsNothing);
    expect(find.byKey(const ValueKey('string_error')), findsNothing);
    expect(find.byKey(const ValueKey('integer_error')), findsNothing);
    expect(find.byKey(const ValueKey('test_error')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_loading')), findsNothing);
    expect(find.byKey(const ValueKey('string_loading')), findsNothing);
    expect(find.byKey(const ValueKey('integer_loading')), findsNothing);
    expect(find.byKey(const ValueKey('test_loading')), findsNothing);
  });

  testWidgets('Should only find success keys when viewModel changes to success',
      (WidgetTester tester) async {
    final viewModel = _ViewModel();
    await _createScreen(tester, viewModel);
    viewModel.toSuccess();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('boolean_empty')), findsNothing);
    expect(find.byKey(const ValueKey('string_empty')), findsNothing);
    expect(find.byKey(const ValueKey('integer_empty')), findsNothing);
    expect(find.byKey(const ValueKey('test_empty')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_success')), findsOneWidget);
    expect(find.byKey(const ValueKey('string_success')), findsOneWidget);
    expect(find.byKey(const ValueKey('integer_success')), findsOneWidget);
    expect(find.byKey(const ValueKey('test_success')), findsOneWidget);

    expect(find.byKey(const ValueKey('boolean_error')), findsNothing);
    expect(find.byKey(const ValueKey('string_error')), findsNothing);
    expect(find.byKey(const ValueKey('integer_error')), findsNothing);
    expect(find.byKey(const ValueKey('test_error')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_loading')), findsNothing);
    expect(find.byKey(const ValueKey('string_loading')), findsNothing);
    expect(find.byKey(const ValueKey('integer_loading')), findsNothing);
    expect(find.byKey(const ValueKey('test_loading')), findsNothing);
  });

  testWidgets('Should only find error keys when viewModel changes to error',
      (WidgetTester tester) async {
    final viewModel = _ViewModel();
    await _createScreen(tester, viewModel);
    viewModel.toError();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('boolean_empty')), findsNothing);
    expect(find.byKey(const ValueKey('string_empty')), findsNothing);
    expect(find.byKey(const ValueKey('integer_empty')), findsNothing);
    expect(find.byKey(const ValueKey('test_empty')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_success')), findsNothing);
    expect(find.byKey(const ValueKey('string_success')), findsNothing);
    expect(find.byKey(const ValueKey('integer_success')), findsNothing);
    expect(find.byKey(const ValueKey('test_success')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_error')), findsOneWidget);
    expect(find.byKey(const ValueKey('string_error')), findsOneWidget);
    expect(find.byKey(const ValueKey('integer_error')), findsOneWidget);
    expect(find.byKey(const ValueKey('test_error')), findsOneWidget);

    expect(find.byKey(const ValueKey('boolean_loading')), findsNothing);
    expect(find.byKey(const ValueKey('string_loading')), findsNothing);
    expect(find.byKey(const ValueKey('integer_loading')), findsNothing);
    expect(find.byKey(const ValueKey('test_loading')), findsNothing);
  });

  testWidgets('Should only find loading keys when viewModel changes to loading',
      (WidgetTester tester) async {
    final viewModel = _ViewModel();
    await _createScreen(tester, viewModel);
    viewModel.toLoading();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('boolean_empty')), findsNothing);
    expect(find.byKey(const ValueKey('string_empty')), findsNothing);
    expect(find.byKey(const ValueKey('integer_empty')), findsNothing);
    expect(find.byKey(const ValueKey('test_empty')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_success')), findsNothing);
    expect(find.byKey(const ValueKey('string_success')), findsNothing);
    expect(find.byKey(const ValueKey('integer_success')), findsNothing);
    expect(find.byKey(const ValueKey('test_success')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_error')), findsNothing);
    expect(find.byKey(const ValueKey('string_error')), findsNothing);
    expect(find.byKey(const ValueKey('integer_error')), findsNothing);
    expect(find.byKey(const ValueKey('test_error')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_loading')), findsOneWidget);
    expect(find.byKey(const ValueKey('string_loading')), findsOneWidget);
    expect(find.byKey(const ValueKey('integer_loading')), findsOneWidget);
    expect(find.byKey(const ValueKey('test_loading')), findsOneWidget);
  });

  testWidgets('Should return empty keys after change between several states',
      (WidgetTester tester) async {
    final viewModel = _ViewModel();
    await _createScreen(tester, viewModel);
    viewModel.toError();
    await tester.pumpAndSettle();
    viewModel.toSuccess();
    await tester.pumpAndSettle();
    viewModel.toLoading();
    await tester.pumpAndSettle();
    viewModel.toEmpty();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('boolean_empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('string_empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('integer_empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('test_empty')), findsOneWidget);

    expect(find.byKey(const ValueKey('boolean_success')), findsNothing);
    expect(find.byKey(const ValueKey('string_success')), findsNothing);
    expect(find.byKey(const ValueKey('integer_success')), findsNothing);
    expect(find.byKey(const ValueKey('test_success')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_error')), findsNothing);
    expect(find.byKey(const ValueKey('string_error')), findsNothing);
    expect(find.byKey(const ValueKey('integer_error')), findsNothing);
    expect(find.byKey(const ValueKey('test_error')), findsNothing);

    expect(find.byKey(const ValueKey('boolean_loading')), findsNothing);
    expect(find.byKey(const ValueKey('string_loading')), findsNothing);
    expect(find.byKey(const ValueKey('integer_loading')), findsNothing);
    expect(find.byKey(const ValueKey('test_loading')), findsNothing);
  });

  testWidgets('Should return empty Containers when no listener were given',
      (WidgetTester tester) async {
    final viewModel = _ViewModel();
    await EveTester.createWidget(
      tester,
      ObserverWidget(
        listenable: viewModel.test,
        onSuccess: (value, child) {
          return const Text('success');
        },
      ),
    );

    viewModel.test.toError();
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsOneWidget);
    expect(EveTester.findByText('success'), findsNothing);

    viewModel.test.toLoading();
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsOneWidget);
    expect(EveTester.findByText('success'), findsNothing);

    viewModel.test.toEmpty();
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsOneWidget);
    expect(EveTester.findByText('success'), findsNothing);

    viewModel.test.toSuccess(_Test());
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsNothing);
    expect(EveTester.findByText('success'), findsOneWidget);
  });

  testWidgets('Should keep child alive between changes of state',
      (WidgetTester tester) async {
    final viewModel = _ViewModel();
    await EveTester.createWidget(
      tester,
      ObserverWidget(
        listenable: viewModel.test,
        onSuccess: (value, child) {
          return Column(
            children: [
              Container(key: const ValueKey('success')),
              child!,
            ],
          );
        },
        onEmpty: (child) {
          return Column(
            children: [
              Container(key: const ValueKey('empty')),
              child!,
            ],
          );
        },
        onError: (failure, child) {
          return Column(
            children: [
              Container(key: const ValueKey('error')),
              child!,
            ],
          );
        },
        onLoading: (child) {
          return Column(
            children: [
              Container(key: const ValueKey('loading')),
              child!,
            ],
          );
        },
        child: Container(
          key: const ValueKey('fixed_child'),
        ),
      ),
    );

    viewModel.test.toError();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('error')), findsOneWidget);
    expect(find.byKey(const ValueKey('fixed_child')), findsOneWidget);
    expect(find.byKey(const ValueKey('success')), findsNothing);
    expect(find.byKey(const ValueKey('loading')), findsNothing);
    expect(find.byKey(const ValueKey('empty')), findsNothing);

    viewModel.test.toLoading();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('loading')), findsOneWidget);
    expect(find.byKey(const ValueKey('fixed_child')), findsOneWidget);
    expect(find.byKey(const ValueKey('error')), findsNothing);
    expect(find.byKey(const ValueKey('success')), findsNothing);
    expect(find.byKey(const ValueKey('empty')), findsNothing);

    viewModel.test.toEmpty();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('fixed_child')), findsOneWidget);
    expect(find.byKey(const ValueKey('error')), findsNothing);
    expect(find.byKey(const ValueKey('loading')), findsNothing);
    expect(find.byKey(const ValueKey('success')), findsNothing);

    viewModel.test.toSuccess(_Test());
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('success')), findsOneWidget);
    expect(find.byKey(const ValueKey('fixed_child')), findsOneWidget);
    expect(find.byKey(const ValueKey('error')), findsNothing);
    expect(find.byKey(const ValueKey('loading')), findsNothing);
    expect(find.byKey(const ValueKey('empty')), findsNothing);
  });
}

Future<void> _createScreen(WidgetTester tester, _ViewModel viewModel) async {
  await EveTester.createWidget(
    tester,
    Column(
      children: [
        ObserverWidget(
          listenable: viewModel.boolean,
          onSuccess: (value, child) {
            return Container(
              key: const ValueKey('boolean_success'),
            );
          },
          onEmpty: (child) {
            return Container(
              key: const ValueKey('boolean_empty'),
            );
          },
          onError: (error, child) {
            return Container(
              key: const ValueKey('boolean_error'),
            );
          },
          onLoading: (child) {
            return Container(
              key: const ValueKey('boolean_loading'),
            );
          },
        ),
        ObserverWidget(
          listenable: viewModel.integer,
          onSuccess: (value, child) {
            return Container(
              key: const ValueKey('integer_success'),
            );
          },
          onEmpty: (child) {
            return Container(
              key: const ValueKey('integer_empty'),
            );
          },
          onError: (error, child) {
            return Container(
              key: const ValueKey('integer_error'),
            );
          },
          onLoading: (child) {
            return Container(
              key: const ValueKey('integer_loading'),
            );
          },
        ),
        ObserverWidget(
          listenable: viewModel.string,
          onSuccess: (value, child) {
            return Container(
              key: const ValueKey('string_success'),
            );
          },
          onEmpty: (child) {
            return Container(
              key: const ValueKey('string_empty'),
            );
          },
          onError: (error, child) {
            return Container(
              key: const ValueKey('string_error'),
            );
          },
          onLoading: (child) {
            return Container(
              key: const ValueKey('string_loading'),
            );
          },
        ),
        ObserverWidget(
          listenable: viewModel.test,
          onSuccess: (value, child) {
            return Container(
              key: const ValueKey('test_success'),
            );
          },
          onEmpty: (child) {
            return Container(
              key: const ValueKey('test_empty'),
            );
          },
          onError: (error, child) {
            return Container(
              key: const ValueKey('test_error'),
            );
          },
          onLoading: (child) {
            return Container(
              key: const ValueKey('test_loading'),
            );
          },
        ),
      ],
    ),
  );
}
