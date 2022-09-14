import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/models/error_model.dart';

class DialogAction {
  final String label;
  final Function(BuildContext)? action;

  const DialogAction(this.label, [this.action]);
}

class AppDialog {
  static error(
    BuildContext context, {
    String? title,
    ErrorModel? error,
  }) {
    var message = error?.message ?? Strings.DEFAULT_ERROR_MESSAGE;
    if (error?.errors != null && error!.errors!.isNotEmpty) {
      error.errors?.forEach((key, value) {
        message += '\n${value[0]}';
      });
    }
    show(context, title ?? 'Error', message);
  }

  static show(BuildContext context, String title, String message,
      {List<DialogAction> actions = const [DialogAction('Close')]}) {
    var t = Text(title);
    var b = Text(message);
    showDialog(
        context: context,
        builder: (c) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: t,
                content: b,
                actions: [
                  for (var item in actions)
                    TextButton(
                        onPressed: () {
                          Navigator.of(c).pop();
                          if (item.action != null) item.action!(c);
                        },
                        child: Text(item.label))
                ],
              )
            : AlertDialog(
                content: b,
                title: t,
                actions: [
                  for (var item in actions)
                    TextButton(
                        onPressed: () {
                          Navigator.of(c).pop();
                          if (item.action != null) item.action!(c);
                        },
                        child: Text(item.label))
                ],
              ));
  }

  static showLoadingDialog(BuildContext context, [Widget? indicator]) {
    showDialog(
        useSafeArea: false,
        barrierDismissible: false,
        context: context,
        builder: (c) => Center(
            child: indicator ??
                Card(
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(30),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoActivityIndicator()
                            // CircularProgressIndicator(
                            //     valueColor: AlwaysStoppedAnimation(Colors.black),
                            //     strokeWidth: 2,
                            //     color: Colors.black),
                            )))));
  }
}
