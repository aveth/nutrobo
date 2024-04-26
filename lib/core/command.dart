import 'package:flutter/material.dart';


class Command {
  final String title;
  final String description;
  final IconData icon;

  Command({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory Command.barcodeScanner(BuildContext context) =>
      Command(
          title: "Scan Barcode",
          description: "Scan the barcode of a packaged food item. This allows me to finds it's nutritional values!",
          icon: Icons.barcode_reader,
      );

  factory Command.ocrScanner(BuildContext context) =>
      Command(
        title: "Capture Nutrition Label",
        description: "Photograph the nutrition label of a packaged food item. This allows me to finds it's nutritional values!",
        icon: Icons.photo_camera,
      );

}