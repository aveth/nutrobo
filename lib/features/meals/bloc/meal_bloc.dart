import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';
import 'package:nutrobo/features/meals/model/food.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';

class MealItem {
  final Food food;
  final int size;
  final int unit;
  MealItem({
    required this.food,
    required this.size,
    required this.unit
  });
}

class MealState extends SuccessState {
  final List<MealItem> items;
  MealState({required this.items});
}

class _BarcodeEvent extends UpdateEvent {
  final Food? food;
  _BarcodeEvent(this.food);
}

class MealsBloc extends BaseBloc {

  final NutroboApi api;

  MealsBloc({required this.api}) : super(LoadingState()) {

    on<InitEvent>((event, emit) {
      emit(MealState(items: []));
    });

    on<_BarcodeEvent>((event, emit) {
      if (event.food != null) {

      }
    });

    add(InitEvent());
  }

  void fetchFood(BarcodeCapture capture) async {
    final barcode = capture.barcodes.firstOrNull?.displayValue;
    if (barcode != null) {
      final response = await api.getByBarcode(barcode);
      _BarcodeEvent(response.body);
    } else {
      _BarcodeEvent(null);
    }
  }

}