import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/features/barcode/ui/scanned_barcode_label.dart';
import 'package:nutrobo/features/barcode/ui/scanner_button_widgets.dart';
import 'package:nutrobo/features/barcode/ui/scanner_error_widget.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  StreamSubscription<BarcodeCapture>? _subscription;
  Function(BarcodeCapture)? _handleBarcode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _handleBarcode = (BarcodeCapture capture) {
      Navigator.of(context).maybePop(capture);
    };

    _subscribe();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _subscribe();
        break;
      case AppLifecycleState.inactive:
        _unsubscribe();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      backgroundColor: Colors.black,
      body: Column(
        children: [_cameraSettingsContainer(), _cameraContainer()],
      ),
    );
  }

  Widget _cameraContainer() {
    return SizedBox(
      height: 200,
      child: MobileScanner(
        controller: controller,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, child) {
          return ScannerErrorWidget(error: error);
        },
        onDetect: (BarcodeCapture barcodes) {
          print(barcodes.toString());
          // Not needed since we listen to the barcode stream
        },
      ),
    );
  }

  Widget _cameraSettingsContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ToggleFlashlightButton(controller: controller),
        ScannedBarcodeLabel(
          barcodes: controller.barcodes,
          title: 'Scan',
        ),
        AnalyzeImageFromGalleryButton(controller: controller),
      ],
    );
  }

  void _subscribe() {
    _subscription = controller.barcodes.listen(_handleBarcode);
    unawaited(controller.start());
  }

  void _unsubscribe() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    controller.dispose();
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _unsubscribe();
    super.dispose();
  }
}
