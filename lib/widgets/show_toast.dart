import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast({
  required String message,
  Color? backgroundColor,
  Color? textColor,
  int? timeInSecForIosWeb = 3,
}) {
  Get.showSnackbar(
    GetSnackBar(
      duration: Duration(seconds: timeInSecForIosWeb!),
      borderRadius: 12,
      margin: const EdgeInsets.all(40),
      messageText: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.blue[100]!,
    ),
  );
}
