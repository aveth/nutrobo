import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';

abstract class _BarcodeEvent { }
abstract class BarcodeState { }

class _InitialEvent extends _BarcodeEvent { }
class _ScanEvent extends _BarcodeEvent { }
class _BarcodeFoundEvent extends _BarcodeEvent {
  final String barcode;
  _BarcodeFoundEvent({required this.barcode});
}
class _NutritionInfoFoundEvent extends _BarcodeEvent {
  final String info;
  _NutritionInfoFoundEvent({required this.info});
}

class InitialState extends BarcodeState { }
class BarcodeFoundState extends BarcodeState {
  final String barcode;
  BarcodeFoundState({required this.barcode});
}
class NutritionInfoFoundState extends BarcodeState {
  final String info;
  NutritionInfoFoundState({required this.info});
}

class NotFoundState extends BarcodeState { }

class BarcodeBloc extends Bloc<_BarcodeEvent, BarcodeState> {

  final FlutterSecureStorage storage;
  final NutroboApi api;

  BarcodeBloc({
    required this.storage,
    required this.api
  }) : super(InitialState()) {

    on<_InitialEvent>((event, emit) async {

    });

    on<_ScanEvent>((event, emit) async {

    });

    on<_NutritionInfoFoundEvent>((event, emit) async {
      emit(NutritionInfoFoundState(info: event.info));
    });

    on<_BarcodeFoundEvent>((event, emit) async {
      emit(BarcodeFoundState(barcode: event.barcode));
    });

    add(_InitialEvent());
  }

  void startScanning() {
    add(_ScanEvent());
  }

  void barcodeFound(BarcodeCapture capture) {
    if (capture.barcodes.isNotEmpty) {
      add(_BarcodeFoundEvent(barcode: capture.barcodes.first.displayValue!));
    }
  }

  void nutritionInfoFound(String info) {
    if (info.isNotEmpty) {
      add(_NutritionInfoFoundEvent(info: info));
    }
  }

}
