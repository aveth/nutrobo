import 'dart:async';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';
import 'package:nutrobo/features/meals/model/food.dart';
import 'package:nutrobo/features/meals/model/food_unit.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';

class BarcodeSuccessState extends SuccessState {
  final String code;
  final String name;
  final String carbs;
  final String protein;
  final String fiber;
  final String source;

  BarcodeSuccessState({
    required this.code,
    required this.name,
    required this.carbs,
    required this.protein,
    required this.fiber,
    required this.source
  });
}

class _BarcodeFoundEvent extends UpdateEvent {
  final Food food;

  _BarcodeFoundEvent({required this.food});
}

class BarcodeBloc extends BaseBloc {
  final NutroboApi api;
  StreamSubscription<BarcodeCapture>? _subscription;
  final controller = MobileScannerController();

  bool _isStarted = false;

  BarcodeBloc({required this.api}) : super(LoadingState()) {
    on<InitEvent>((event, emit) {
      _start();
      emit(LoadingState());
    });

    on<_BarcodeFoundEvent>((event, emit) {
      emit(BarcodeSuccessState(
          code: event.food.barcode,
          name: '${event.food.brandName} ${event.food.foodName}',
          carbs: _nutrientText(event.food.nutrients.carbohydrate),
          protein: _nutrientText(event.food.nutrients.protein),
          fiber: _nutrientText(event.food.nutrients.fiber),
          source: event.food.source));
    });

    on<ErrorEvent>((event, emit) {
      emit(FailureState(message: event.message));
    });

    add(InitEvent());
  }

  String _nutrientText(FoodUnit nutrient) =>
      '${nutrient.value} ${nutrient.unit}';

  void startScanning() {
    add(InitEvent());
  }

  void _start() {
    _subscription ??= controller.barcodes.listen((BarcodeCapture capture) async {
      //final barcode = '0380003560011';
      final barcode = capture.barcodes.firstOrNull?.displayValue;
      if (barcode != null) {
        controller.stop();
        _isStarted = false;
        final response = await api.getByBarcode(barcode);
        final food = response.body;
        if (response.isSuccessful && food != null) {
          add(_BarcodeFoundEvent(food: food));
        } else {
          add(ErrorEvent(message: barcode));
        }
      }
    });

    if (!_isStarted) {
      controller.start();
      _isStarted = true;
    }
  }

  @override
  Future<void> close() {
    controller.stop();
    controller.dispose();
    _subscription?.cancel();
    return super.close();
  }
}
