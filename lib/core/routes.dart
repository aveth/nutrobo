import 'package:flutter/material.dart';
import 'package:nutrobo/features/barcode/ui/barcode_scanner.dart';
import 'package:nutrobo/features/ocr/ui/ocr_scanner.dart';

class Routes {

  static Future<dynamic> toBarcodeScanner(BuildContext context) async {
    return await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => const BarcodeScanner())
    );
  }

  static Future<dynamic> toOcrScanner(BuildContext context) async {
    return await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => const OcrScanner())
    );
  }

}