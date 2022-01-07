import 'package:flutter/material.dart';

class EveSearchWidget extends StatelessWidget {
  final int Function(String text) filterItems;

  const EveSearchWidget({required this.filterItems, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        autofocus: false,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
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
            hintStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
        maxLines: 1,
        onChanged: (text) => filterItems(text),
      );
}
