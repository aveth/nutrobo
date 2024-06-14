import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/core/routes.dart';

class AddMealDialog extends StatelessWidget {

  const AddMealDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Wrap(spacing: 10, children: [
            IconButton(icon: const Icon(Icons.camera), onPressed: () => _navigateToCamera(context)),
            IconButton(icon: const Icon(Icons.edit), onPressed: _navigateToForm)
          ])
        ],
      ),
    );
  }

  void _navigateToCamera(BuildContext context) async {
    var result = await Routes.toBarcodeScanner(context);
    if (result != null && result is BarcodeCapture) {

    }
  }

  void _navigateToForm() {

  }

}