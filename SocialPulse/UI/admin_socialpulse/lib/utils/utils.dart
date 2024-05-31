import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Authentification {
  static String? token;
  static Map? tokenDecoded;
}

dynamic dateEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

Widget imageFromBase64String(String base64Image) {
  return FullScreenWidget(
    disposeLevel: DisposeLevel.Medium,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.memory(
        base64Decode(base64Image),
        height: 250,
        width: 250,
      ),
    ),
  );
}

Widget imageFromBase64String2(String base64Image) {
  return FullScreenWidget(
    disposeLevel: DisposeLevel.Medium,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.memory(
        base64Decode(base64Image),
        height: 150,
        width: 150,
      ),
    ),
  );
}

void alertBox(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          ));
}

void alertBoxMoveBack(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          ));
}

OutlineInputBorder kEnabledTextFieldBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(15));

InputDecoration customInputDecoration({String? hint}) {
  return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0x15FFFFFF),
      border: kEnabledTextFieldBorder,
      errorBorder: kEnabledTextFieldBorder,
      enabledBorder: kEnabledTextFieldBorder,
      focusedBorder: kEnabledTextFieldBorder,
      errorMaxLines: 3);
}

class CustomHeightSpacer extends StatelessWidget {
  const CustomHeightSpacer({
    Key? key,
    this.size = 0.015,
  }) : super(key: key);

  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * MediaQuery.of(context).size.height,
    );
  }
}

class CustomWidthSpacer extends StatelessWidget {
  const CustomWidthSpacer({
    Key? key,
    this.size = 0.015,
  }) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * MediaQuery.of(context).size.width,
    );
  }
}
