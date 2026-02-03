import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppSnackbar {
  static void success(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }

  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static void info(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }
}
