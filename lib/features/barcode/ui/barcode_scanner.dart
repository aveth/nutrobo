
import 'dart:async';

import 'package:flutter/foundation.dart';
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

class _BarcodeScannerState extends State<BarcodeScanner> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
  );

  StreamSubscription<BarcodeCapture>? _subscription;
  Function(BarcodeCapture)? _handleBarcode;

  double _zoomFactor = 0.0;

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

  Widget _buildZoomScaleSlider() {
    return ValueListenableBuilder(
      valueListenable: ValueNotifier(controller),
      builder: (context, state, child) {
        if (!state.isStarting) {
          return const SizedBox.shrink();
        }

        final TextStyle labelStyle = Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.white);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text(
                '0%',
                overflow: TextOverflow.fade,
                style: labelStyle,
              ),
              Expanded(
                child: Slider(
                  value: _zoomFactor,
                  onChanged: (value) {
                    setState(() {
                      _zoomFactor = value;
                      controller.setZoomScale(value);
                    });
                  },
                ),
              ),
              Text(
                '100%',
                overflow: TextOverflow.fade,
                style: labelStyle,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            fit: BoxFit.contain,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            onDetect: (BarcodeCapture barcodes) {

            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Column(
                children: [
                  if (!kIsWeb) _buildZoomScaleSlider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToggleFlashlightButton(controller: controller),
                      StartStopMobileScannerButton(controller: controller),
                      Expanded(
                        child: Center(
                          child: ScannedBarcodeLabel(
                            barcodes: controller.barcodes,
                          ),
                        ),
                      ),
                      SwitchCameraButton(controller: controller),
                      AnalyzeImageFromGalleryButton(controller: controller),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
