import 'package:json_annotation/json_annotation.dart';
import 'package:nutrobo/features/meals/model/food_unit.dart';
import 'package:nutrobo/features/meals/model/nutrients.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  final String id;
  final String foodName;
  final String brandName;
  final String source;
  final String barcode;
  final FoodUnit servingSize;
  final Nutrients nutrients;

  Food({
    required this.id,
    required this.foodName,
    required this.brandName,
    required this.source,
    required this.barcode,
    required this.servingSize,
    required this.nutrients
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}