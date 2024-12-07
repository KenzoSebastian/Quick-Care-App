import 'package:flutter/material.dart';

class ItemSelect extends StatelessWidget {
  const ItemSelect(
      {super.key,
      this.isDisabled = false,
      this.color = const Color.fromARGB(255, 209, 221, 239),
      required this.child});
  final bool isDisabled;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDisabled ? 0 : 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
