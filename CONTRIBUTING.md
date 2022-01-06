# Contributing to eve

## 1. Things you will need

- Linux, Mac OS X, or Windows.
- [git](https://git-scm.com) (used for source version control).
- An ssh client (used to authenticate with GitHub).
- [Flutter](https://flutter.dev/docs/get-started/install) installed.
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/).
- [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html) (available via brew on macOS, apt on Ubuntu, maybe via llvm on chocolatey for Windows)

## 2. Cloning the repository

- Ensure all the dependencies described in the previous section are installed.
- If you haven't configured your machine with an SSH key that's known to github, then
  follow [GitHub's directions](https://help.github.com/articles/generating-ssh-keys/)
  to generate an SSH key.
- Clone the repository
  ```shell
  git clone git@github.com:lucasselani/eve.git
  cd eve
  ```

## 3. Environment Setup

unico | you uses [Melos](https://github.com/invertase/melos) to manage the project and dependencies, [tuneup](https://pub.dev/packages/tuneup) to analyze the code and [flutter_plugin_tools](https://pub.dev/packages/flutter_plugin_tools) to format the code.

First, make sure you have `.pub-cache/bin` in your PATH, this folder contains all the global packages that we'll be using:

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

To install Melos, run the following command from your SSH client:

```bash
pub global activate melos
```

Next, at the root of your locally cloned repository bootstrap the projects dependencies:

```bash
melos bootstrap
```

The bootstrap command locally links all dependencies within the project without having to
provide manual [`dependency_overrides`](https://dart.dev/tools/pub/pubspec). This allows all
plugins, examples and tests to build from the local clone project.

> You do not need to run `flutter pub get` once bootstrap has been completed.

To install the `tuneup` and `flutter_pluging_tools`, you can run a custom command on melos (or follow the instructions on each of the websites):

```bash
melos run setup
```

The project also uses git hooks to ensure some requirements on your code and commit. Enable it with the following commands:

```shell
git config core.hooksPath .githooks/
sudo chmod 755 .githooks/
```

## 4. Running the app

Since each package are linked to the `app` package, all you need to do is run the main application in the `app` folder

To run the app, you need to select the main file and the flavor you want to use in the `flutter run` command.

```bash
cd packages/base_app
```

To run:
```bash
flutter run
```

Using Melos (installed in step 3), any changes made to the plugins locally will also be reflected within all applications code automatically.

## 4. Contributing code

Please peruse the
[Flutter style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo) and
[design principles](https://flutter.io/design-principles/) before
working on anything non-trivial. These guidelines are intended to
keep the code consistent and avoid common pitfalls.

To start working on a patch:

1. `git fetch origin main:main`
2. `git checkout -b <name_of_your_branch>`
3. Hack away!

Once you have made your changes, commit your code. 

```bash
git commit -m 'feat/fix/build/docs/refactor/test/metrics(eve#123): Create login screen'
```
 
The hook will ensure that it passes the internal analyzer, formatting checks and local tests.

> The analyzer, formatter and tests will also be run when your PR opens, in case you haven't enabled your git hooks

Assuming all is successful, rebase your local copy to ensure that you have the lastest code and push your code.

```bash
git fetch origin main:main && git rebase main
git push origin HEAD
```

You're all set to open your Pull Request on GitHub!

## 5. Create Generated Classes With build_runner

If your newly code uses generated classes, such as: injectable, mobx, etc, run the following command to generate these classes

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```
