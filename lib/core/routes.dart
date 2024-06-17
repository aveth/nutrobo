import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/core/di.dart';
import 'package:nutrobo/features/barcode/bloc/barcode_bloc.dart';
import 'package:nutrobo/features/barcode/ui/barcode_scanner.dart';
import 'package:nutrobo/features/ocr/ui/ocr_scanner.dart';
import 'package:nutrobo/features/shared/ui/utils.dart';

class Routes {
  static Future<dynamic> toBarcodeScanner(BuildContext context) async {
    return await Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => getIt.get<BarcodeBloc>(),
                child: Scaffold(
                  body: const BarcodeScanner(),
                  appBar: buildAppBar(context),
                ))));
  }

  static Future<dynamic> toOcrScanner(BuildContext context) async {
    return await Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => const OcrScanner()));
  }
}
