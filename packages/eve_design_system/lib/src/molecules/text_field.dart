import 'package:eve_design_system/src/molecules/keyboard_auto_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EveTextField extends StatefulWidget {
  final TextFieldCaptureContent content;
  final void Function(String maskedValue, String rawValue) onValueChanged;
  final bool autoFocus;

  const EveTextField({
    required this.content,
    required this.onValueChanged,
    this.autoFocus = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldState();
}

class _TextFieldState extends State<EveTextField> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(
        text: widget.content.toMaskedValue(widget.content.initialValue));
  }

  Widget _buildTextField(FocusNode? node) => TextField(
        maxLength: widget.content.maxLength,
        controller: textEditingController,
        focusNode: node,
        autofocus: widget.autoFocus,
        keyboardType: widget.content.textInputType,
        textAlign: TextAlign.start,
        textCapitalization:
            widget.content.textCapitalization ?? TextCapitalization.sentences,
        inputFormatters: widget.content.textInputFormatters,
        autocorrect: false,
        enableSuggestions: true,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          labelText: widget.content.label,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          isDense: true,
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 0)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 0)),
        ),
        onChanged: (String text) {
          widget.onValueChanged(
            widget.content.toMaskedValue(text),
            widget.content.toRawValue(text),
          );
        },
      );

  @override
  Widget build(BuildContext context) => widget.autoFocus
      ? KeyboardAutofocus(child: (FocusNode node) => _buildTextField(node))
      : _buildTextField(null);
}

abstract class TextFieldCaptureContent extends _CaptureContent {
  int? maxLength;
  List<TextInputFormatter> textInputFormatters = [];
  TextCapitalization? textCapitalization = TextCapitalization.none;
  TextInputType? textInputType = TextInputType.text;

  TextFieldCaptureContent({
    required String label,
    String? initialValue,
    this.maxLength,
  }) : super(label: label, initialValue: initialValue);
}

abstract class _CaptureContent {
  final String initialValue;
  final String label;

  String toRawValue(String? value) => value ?? '';
  String toMaskedValue(String? value) => value ?? '';

  _CaptureContent({required this.label, String? initialValue})
      : initialValue = initialValue ?? '';
}
