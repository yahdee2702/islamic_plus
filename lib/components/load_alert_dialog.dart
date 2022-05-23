import 'package:flutter/material.dart';

class LoadAlertDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String description;
  const LoadAlertDialog(
    this.context, {
    Key? key,
    this.title = "Error when loading!",
    this.description = "There was an error while trying to load!",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Ok!"),
        ),
      ],
    );
  }
}
