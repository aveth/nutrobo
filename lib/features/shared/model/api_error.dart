import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  final int code;
  final String message;

  ApiError({
    required this.code,
    required this.message
  });
}