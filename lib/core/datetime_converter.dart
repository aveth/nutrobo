import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();

  static const int millisInSecond = 1000;

  @override
  DateTime fromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * millisInSecond);

  @override
  int toJson(DateTime json) =>
      json.millisecondsSinceEpoch ~/ millisInSecond;
}