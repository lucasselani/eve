# Eve

This is your unique repository for the eve

## How to use

Import this repository in your Flutter application, using the eve path (you can chose the ref between main and tags)

```dart
  eve:
    git:
      url: git@github.com:lucasselani/eve.git
      ref: main
      path: packages/eve/
```

## What Eve has

- SoulKeeper: A class to save and read your data in the FlutterSecureStorage
- Invoker: A global pubsub using Stream broadcast
- Admiral: A global contextless navigator
- Silenecer: A global String translator
- Tinker: A global DI class with singleton/factory options
- Observable/ObservableWidget: A simple implementation of ValueListener and ValueListenableBuilder
- Either/UseCases/Failure: To create the base of clean arch
- BaseApp/MicroApp/CommonPackage: To create the base of modularization and micro front end
- EveApp: A base app on the top of MaterialApp

## Environment version

This section should always be up to date with the environment that everyone on the team is using.

Make sure that your workstation uses at least the same versions of environment to the ones listed here, for example the Flutter/Dart and Xcode versions.

Take care of bugs and breaking changes when updating your environment for versions beyond these.

- **Flutter**

  | Environment              | Version |
  | ------------------------ | ------- |
  | Flutter (channel Stable) | 2.8.1   |
  | Dart                     | 2.15.1  |
