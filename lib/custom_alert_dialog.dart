import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget contentWidget;
  final String? cancelActionText;
  final Function? cancelAction;
  final String defaultActionText;
  final Function? action;

  CustomAlertDialog({
    required this.title,
    required this.contentWidget,
    this.cancelActionText,
    this.cancelAction,
    required this.defaultActionText,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: contentWidget,
      actions: [
        if (cancelActionText != null)
          TextButton(
            onPressed: () {
              if (cancelAction != null) cancelAction!();
              Navigator.of(context).pop(false);
            },
            child: Text(cancelActionText!),
          ),
        TextButton(
          onPressed: () {
            if (action != null) action!();
            Navigator.of(context).pop(true);
          },
          child: Text(defaultActionText),
        )
      ],
    );
  }
}
