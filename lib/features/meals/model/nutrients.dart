import 'package:json_annotation/json_annotation.dart';
import 'package:nutrobo/features/meals/model/food_unit.dart';

part 'nutrients.g.dart';

@JsonSerializable()
class Nutrients {
  final FoodUnit protein;
  final FoodUnit carbohydrate;
  final FoodUnit fiber;

  Nutrients({
    required this.protein,
    required this.carbohydrate,
    required this.fiber
  });

  factory Nutrients.fromJson(Map<String, dynamic> json) => _$NutrientsFromJson(json);
  Map<String, dynamic> toJson() => _$NutrientsToJson(this);

}