import 'package:json_annotation/json_annotation.dart';

part 'food_unit.g.dart';

@JsonSerializable()
class FoodUnit {
  final String id;
  final String name;
  final int value;
  final String unit;

  FoodUnit({
    required this.id,
    required this.name,
    required this.value,
    required this.unit
  });

  factory FoodUnit.fromJson(Map<String, dynamic> json) => _$FoodUnitFromJson(json);
  Map<String, dynamic> toJson() => _$FoodUnitToJson(this);

}