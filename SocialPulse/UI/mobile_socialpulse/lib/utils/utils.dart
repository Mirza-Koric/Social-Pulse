import 'dart:convert';

import 'package:flutter/material.dart';

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

Image imageFromBase64String(String base64Image) {
  return Image.memory(
    base64Decode(base64Image),
    height: 250,
    width: 250,
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
      builder: (BuildContext context) =>
          AlertDialog(
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