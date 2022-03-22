import 'package:flutter/material.dart';

class EveSearchWidget extends StatelessWidget {
  final void Function(String text) onTextChanged;

  const EveSearchWidget({required this.onTextChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        autofocus: false,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.overline,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 15),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          fillColor: Colors.black.withOpacity(0.05),
          filled: true,
          hintText: 'O que você procura?',
          hintStyle: Theme.of(context).textTheme.overline,
        ),
        maxLines: 1,
        onChanged: onTextChanged,
      );
}
