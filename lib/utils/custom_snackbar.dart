import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../configuration/app_colors.dart';

void toast(
  String text, {
  ToastGravity gravity = ToastGravity.BOTTOM,
  bool isSuccess = true,
}) {
  Fluttertoast.showToast(
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    msg: text,
    backgroundColor: isSuccess ? AppColors.primaryColor : AppColors.warning,
  );
}

void snackBarMsg(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
