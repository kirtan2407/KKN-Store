import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  // --------------------------
  // COLOR MATCHER
  // --------------------------
  static Color? getColor(String value) {
    switch (value) {
      case 'Green':
        return Colors.green;
      case 'Red':
        return Colors.red;
      case 'Blue':
        return Colors.blue;
      case 'Pink':
        return Colors.pink;
      case 'Grey':
        return Colors.grey;
      case 'Purple':
        return Colors.purple;
      case 'Black':
        return Colors.black;
      case 'White':
        return Colors.white;
      case 'Yellow':
        return Colors.yellow;
      case 'Orange':
        return Colors.deepOrange;
      case 'Brown':
        return Colors.brown;
      case 'Teal':
        return Colors.teal;
      case 'Gold':
        return const Color(0xFFFFD700);
      case 'Indigo':
        return Colors.indigo;
      default:
        return null;
    }
  }

  // --------------------------
  // TOAST / SNACK
  // --------------------------
  static void showToast({required String message}) {
    Get.rawSnackbar(
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      animationDuration: const Duration(milliseconds: 250),
      duration: const Duration(seconds: 2),
    );
  }

  // --------------------------
  // Snackbar (Material)
  // --------------------------
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // --------------------------
  // ALERT DIALOG
  // --------------------------
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // --------------------------
  // NAVIGATION
  // --------------------------
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // --------------------------
  // TEXT SHORTENER
  // --------------------------
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return "${text.substring(0, maxLength)}...";
  }

  // --------------------------
  // DARK MODE CHECK
  // --------------------------
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // --------------------------
  // SCREEN SIZE HELPERS
  // --------------------------
  static Size screenSize() => MediaQuery.of(Get.context!).size;

  static double screenWidth() => MediaQuery.of(Get.context!).size.width;

  static double screenHeight() => MediaQuery.of(Get.context!).size.height;

  // --------------------------
  // DATE FORMATTER
  // --------------------------
  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MM yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  // --------------------------
  // REMOVE DUPLICATES
  // --------------------------
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  // --------------------------
  // WRAP WIDGETS INTO ROWS
  // --------------------------
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrapped = <Widget>[];

    for (int i = 0; i < widgets.length; i += rowSize) {
      wrapped.add(
        Row(
          children: widgets.sublist(
            i,
            (i + rowSize > widgets.length)
                ? widgets.length
                : i + rowSize,
          ),
        ),
      );
    }
    return wrapped;
  }
}
