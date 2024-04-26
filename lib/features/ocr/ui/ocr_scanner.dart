import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrobo/features/ocr/ui/scan_all_module.dart';
import 'package:ocr_scan_text/ocr_scan/widget/live_scan_widget.dart';

class OcrScanner extends StatefulWidget {
  const OcrScanner({super.key});

  @override
  State<OcrScanner> createState() => _OcrScannerState();
}

class _OcrScannerState extends State<OcrScanner> {

  final _scanModule = ScanAllModule()..start();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 40,
          child: _buildLiveScan(),
        ),
      ),
    );
  }

  Widget _buildLiveScan() {
    var lastLength = 0;
    return LiveScanWidget(
      ocrTextResult: (ocrTextResult) {
        ocrTextResult.mapResult.forEach((module, result) {
          var content = result.map((e) => e.text).join(' ');
          var mustContain = [
            'Nutrition Facts',
            'Carbohydrate',
            'Fibre',
            'Protein'
          ];

          var hasAllData = true;
          for (var s in mustContain) {
            if (!content.contains(s)) {
              hasAllData = false;
              break;
            }
          }

          if (hasAllData && lastLength > content.length) {
            _scanModule.stop();
            Navigator.of(context).maybePop(content);
          }
          lastLength = content.length;
        });
      },
      scanModules: [_scanModule],
    );
  }
}