import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Show a red snackbar with the error information.
class ErrorSnackbar extends GetSnackBar {
  const ErrorSnackbar(String message, {Key? key}) : super(message: message, key: key);

  @override
  Color get backgroundColor => Colors.redAccent;

  @override
  Widget? get icon => const Icon(Icons.error_outline, color: Colors.white);

  @override
  Widget? get mainButton {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.close_outlined),
    );
  }

  @override
  Duration? get duration => const Duration(seconds: 3);

  @override
  Widget? get messageText {
    return SelectableText(
      message!,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  @override
  SnackPosition get snackPosition => SnackPosition.TOP;
}
