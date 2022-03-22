import 'package:eve_design_system/src/utils/typedef.dart';
import 'package:flutter/material.dart';

class KeyboardAutofocus extends StatefulWidget {
  final KeyboardChild child;

  const KeyboardAutofocus({required this.child, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeyboardState();
}

class _KeyboardState extends State<KeyboardAutofocus> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(_focusNode));
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child(_focusNode);
}
