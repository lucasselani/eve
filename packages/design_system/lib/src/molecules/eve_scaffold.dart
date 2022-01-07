import 'package:design_system/src/atoms/leading_bar_button.dart';
import 'package:design_system/src/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EveScaffold {
  final Widget body;
  final Widget? fab;
  final Color backgroundColor;
  final Color appBarColor;
  final SystemUiOverlayStyle overlayStyle;
  bool _centerTitle = true;
  Widget? _title;
  Widget? _leading;
  PreferredSizeWidget? _appBarBottom;
  List<Widget>? _trailing;

  EveScaffold(
      {required this.body,
      this.fab,
      this.backgroundColor = Colors.white,
      this.appBarColor = Colors.transparent,
      this.overlayStyle = SystemUiOverlayStyle.light});

  EveScaffold withTitle({
    required String title,
    Color textColor = Colors.black,
    bool centerTitle = true,
  }) {
    _centerTitle = centerTitle;
    _title = Text(title, style: TextStyle(color: textColor, fontSize: 18));
    return this;
  }

  EveScaffold withBackButton({OnTap? onTap, Color? color}) {
    _leading = LeadingBarButton.back(onTap: onTap, color: color);
    return this;
  }

  EveScaffold withCloseButton({OnTap? onTap, Color? color}) {
    _leading = LeadingBarButton.close(onTap: onTap, color: color);
    return this;
  }

  EveScaffold withTrailing(List<Widget> trailing) {
    _trailing = trailing;
    return this;
  }

  Widget build() => _Scaffold(
      body: body,
      fab: fab,
      backgroundColor: backgroundColor,
      appBarColor: appBarColor,
      overlayStyle: overlayStyle,
      centerTitle: _centerTitle,
      title: _title,
      leading: _leading,
      trailing: _trailing,
      appBarBottom: _appBarBottom);
}

class _Scaffold extends StatelessWidget {
  final Widget body;
  final Widget? fab;
  final Color backgroundColor;
  final Color appBarColor;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? trailing;
  final SystemUiOverlayStyle overlayStyle;
  final bool centerTitle;
  final PreferredSizeWidget? appBarBottom;

  _Scaffold(
      {required this.body,
      this.fab,
      this.backgroundColor = Colors.white,
      this.appBarColor = Colors.transparent,
      this.overlayStyle = SystemUiOverlayStyle.light,
      this.trailing = const [],
      this.centerTitle = true,
      this.title,
      this.leading,
      this.appBarBottom});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: body,
        backgroundColor: backgroundColor,
        floatingActionButton: fab,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          systemOverlayStyle: overlayStyle,
          title: title,
          centerTitle: centerTitle,
          leading: leading,
          actions: trailing,
          automaticallyImplyLeading: false,
          bottom: appBarBottom,
        ),
      );
}
