import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class AppDialogs {
  const AppDialogs._();

  static Future<void> showOkDialog(
    BuildContext context, {
    Text? title,
    Text? buttonTitle,
    Widget? content,
    void Function()? onOkPressed,
  }) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null
          ? DefaultTextStyle.merge(
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              child: title,
            )
          : title,
      content: content,
      actionsPadding: EdgeInsets.only(bottom: 16.0),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(onPressed: onOkPressed ?? context.pop, child: buttonTitle ?? Text('OK')),
      ],
    ),
  );
}
