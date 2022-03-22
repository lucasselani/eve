import 'package:eve_design_system/eve_design_system.dart';
import 'package:eve_design_system/src/utils/typedef.dart';
import 'package:flutter/material.dart';

enum EveLeadingBarButtonType {
  back,
  close,
}

class EveAppBarConfig {
  final String? title;
  final EveLeadingBarButtonType? leadingButtonType;
  final List<Widget>? trailing;
  final OnTap? onLeadingButtonTap;

  EveAppBarConfig({
    this.title,
    this.leadingButtonType,
    this.trailing,
    this.onLeadingButtonTap,
  });
}

class EveScaffold extends StatelessWidget {
  final Widget body;
  final EveAppBarConfig? appBarConfig;

  const EveScaffold({
    required this.body,
    this.appBarConfig,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _Scaffold(
        body: body,
        context: context,
        appBarConfig: appBarConfig,
      );
}

class _Scaffold extends StatelessWidget {
  final Widget body;
  final BuildContext context;
  final EveAppBarConfig? appBarConfig;

  const _Scaffold({
    required this.body,
    required this.context,
    required this.appBarConfig,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: body,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: _buildTitle(title: appBarConfig?.title),
          centerTitle: true,
          leading: _buildLeadingButton(
            type: appBarConfig?.leadingButtonType,
            onTap: appBarConfig?.onLeadingButtonTap,
          ),
          actions: appBarConfig?.trailing,
          automaticallyImplyLeading: false,
          bottom: appBarConfig != null ? const _AppBarDivider() : null,
        ),
      );

  Widget? _buildTitle({
    required String? title,
  }) {
    return title != null
        ? Text(title, style: Theme.of(context).textTheme.headline1)
        : null;
  }

  Widget? _buildLeadingButton(
      {required EveLeadingBarButtonType? type, required OnTap? onTap}) {
    if (type == EveLeadingBarButtonType.back) {
      return _LeadingBarButton.back(onTap: onTap);
    }
    if (type == EveLeadingBarButtonType.close) {
      return _LeadingBarButton.close(onTap: onTap);
    }
    return null;
  }
}

class _AppBarDivider extends StatelessWidget implements PreferredSizeWidget {
  static const double _height = 1;

  const _AppBarDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Divider(height: _height);

  @override
  Size get preferredSize => const Size.fromHeight(_height);
}

class _LeadingBarButton extends StatelessWidget {
  final OnTap? onTap;
  final IconData _leading;

  const _LeadingBarButton.close({this.onTap, Key? key})
      : _leading = Icons.close,
        super(key: key);

  const _LeadingBarButton.back({this.onTap, Key? key})
      : _leading = Icons.chevron_left,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return EveIconButton(
        onTap: onTap ??
            () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            },
        icon: _leading);
  }
}
