import 'package:json_annotation/json_annotation.dart';
import 'package:nutrobo/core/datetime_converter.dart';

part 'message.g.dart';

@JsonSerializable()
@DateTimeConverter()
class Message {
  final String id;
  final String content;
  final DateTime createdAt;
  final String sentBy;

  Message({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.sentBy,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}