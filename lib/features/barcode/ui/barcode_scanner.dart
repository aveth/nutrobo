import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/core/routes.dart';
import 'package:nutrobo/features/barcode/bloc/barcode_bloc.dart';
import 'package:nutrobo/features/barcode/ui/scanner_error_widget.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';
import 'package:nutrobo/features/shared/ui/ui_builder.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return UiBuilder<BarcodeBloc>((context, state) {
      return Column(
        children: [
          _cameraSettingsContainer(context),
          if (state is BarcodeSuccessState) _barcodeLabel(context, state),
          if (state is FailureState) _barcodeLabel(context, state),
          if (state is LoadingState) _cameraContainer(context),
          _productInfo(context, state),
        ],
      );
    });
  }

  Widget _productInfo(BuildContext context, UiState state) {
    final Widget child;
    switch (state.runtimeType) {
      case BarcodeSuccessState:
        state as BarcodeSuccessState;
        child = _nutritionFacts(context, state);
        break;
      case FailureState:
        state as FailureState;
        child = _notFound(context, state);
        break;
      default:
        child = const LoadingIndicator();
        break;
    }

    return Expanded(child: child);
  }

  Widget _rescanButton(BuildContext context) {
    return Center(
        child: ElevatedButton(
            child: const Text('Scan again'),
            onPressed: () => context.read<BarcodeBloc>().startScanning()));
  }

  Widget _continueButton(BuildContext context, BarcodeSuccessState state) {
    return Center(
        child: ElevatedButton(
      child: const Text('Continue'),
      onPressed: () => Navigator.pop(
          context,
          BarcodeScannerResult(
            message: state.toString(),
            food: state.rawFood,
          )),
    ));
  }

  Widget _nutritionFacts(BuildContext context, BarcodeSuccessState state) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(state.name),
            Container(height: 10),
            _nutrientTable(state),
            Container(height: 10),
            Expanded(child: _continueButton(context, state)),
            Expanded(child: _rescanButton(context))
          ],
        ),
      ),
    );
  }

  Widget _notFound(BuildContext context, FailureState state) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Unable to find nutrition data for this barcode.'),
            Container(height: 10),
            Expanded(child: _rescanButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _nutrientTable(BarcodeSuccessState state) {
    return Table(
      children: [
        _nutrientRow('Carbohydrate', state.carbs),
        _nutrientRow('Fiber', state.fiber),
        _nutrientRow('Protein', state.protein),
        _nutrientRow('Data source:', state.source),
      ],
    );
  }

  TableRow _nutrientRow(String name, String value) {
    return TableRow(
      children: [Text(name), Text(value)],
    );
  }

  Widget _barcodeLabel(BuildContext context, UiState state) {
    String? code;
    switch (state.runtimeType) {
      case BarcodeSuccessState:
        state as BarcodeSuccessState;
        code = state.code;
      case FailureState:
        state as FailureState;
        code = state.message;
    }
    final style =
        Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white);
    return Container(
        color: Colors.black,
        height: 200,
        child: Align(
          alignment: Alignment.center,
          child: code != null
              ? Text(code, style: style)
              : Text('Unable to scan barcode', style: style),
        ));
  }

  Widget _cameraContainer(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        color: Colors.black,
        child: MobileScanner(
          controller: context.read<BarcodeBloc>().controller,
          fit: BoxFit.fitWidth,
          errorBuilder: (context, error, child) {
            return ScannerErrorWidget(error: error);
          },
          onDetect: (BarcodeCapture barcodes) {
            // Not needed since we listen to the barcode stream
          },
        ),
      ),
    );
  }

  Widget _cameraSettingsContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Scan a barcode label.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
