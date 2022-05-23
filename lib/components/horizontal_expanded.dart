import 'package:flutter/material.dart';

class HorizontaExpanded extends StatelessWidget {
  final Widget child;
  const HorizontaExpanded({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
